package com.example.quanlycanho.controller;

import com.example.quanlycanho.entity.CanHo;
import com.example.quanlycanho.entity.HopDong;
import com.example.quanlycanho.entity.KhachHang;
import com.example.quanlycanho.service.CanHoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/")
public class CanHoController {

    @Autowired
    private CanHoService canHoService;

    @GetMapping
    public String index(Model model) {
        return "index"; // Trả về view index.jsp thay vì redirect
    }

    // Hiển thị Form Thêm mới Hợp Đồng
    @GetMapping("/hop-dong/them")
    public String showFormThem(Model model) {
        model.addAttribute("hopDong", new HopDong());
        model.addAttribute("danhSachKhachHang", canHoService.getAllKhachHang());
        model.addAttribute("danhSachCanHo", canHoService.getAllCanHo());
        return "form-hop-dong";
    }

    // Xử lý lưu Hợp Đồng & Thực hiện kiểm tra ràng buộc nghiệp vụ
    @PostMapping("/hop-dong/luu")
    public String luuHopDong(@ModelAttribute("hopDong") HopDong hopDong,
                             @RequestParam("maKhachHangSelect") int maKhachHang,
                             @RequestParam("maCanHoSelect") int maCanHo,
                             Model model) {

        // Khởi tạo biến lưu trữ thông báo lỗi
        String error = null;

        // 1. Kiểm tra bắt buộc nhập (Kiểm tra null hoặc trống căn bản)
        if (hopDong.getNgayBatDau() == null || hopDong.getNgayKetThuc() == null ||
                hopDong.getTienDatCoc() <= 0 || hopDong.getTrangThai().trim().isEmpty() ||
                maKhachHang == 0 || maCanHo == 0) {
            error = "Vui lòng nhập đầy đủ và chính xác tất cả các trường dữ liệu!";
        }
        // 2. Kiểm tra logic ngày: ngayKetThuc phải sau ngayBatDau
        else if (!hopDong.getNgayKetThuc().after(hopDong.getNgayBatDau())) {
            error = "Ngày kết thúc hợp đồng bắt buộc phải sau ngày bắt đầu!";
        }
        // 3. Kiểm tra tiền đặt cọc: Số nguyên dương chia hết cho 500,000đ
        else if (hopDong.getTienDatCoc() % 500000 != 0) {
            error = "Số tiền đặt cọc phải là một số nguyên dương chia hết cho 500,000đ!";
        }
        // 4. KIỂM TRA LỖI LOGIC: Căn hộ đã có người khác thuê và hợp đồng vẫn "Còn hiệu lực"
        else {
            // Lấy thông tin căn hộ sắp thuê từ database lên để kiểm tra danh sách hợp đồng của nó
            CanHo canHoSapThue = canHoService.getCanHoById(maCanHo);

            if (canHoSapThue != null && canHoSapThue.getDanhSachHopDong() != null) {
                for (HopDong hdCu : canHoSapThue.getDanhSachHopDong()) {
                    // Nếu trạng thái trùng với chuỗi "Còn hiệu lực" (hoặc chuỗi lỗi font tương ứng nếu có)
                    if (hdCu.getTrangThai() != null &&
                            (hdCu.getTrangThai().equals("Còn hiệu lực") || hdCu.getTrangThai().contains("hiá»‡u lá»±c"))) {
                        error = "Căn hộ này hiện đang được thuê bởi khách hàng khác và hợp đồng vẫn còn hiệu lực!";
                        break; // Phát hiện trùng thì dừng vòng lặp ngay lập tức
                    }
                }
            }
        }

        // Nếu có lỗi (bao gồm cả lỗi trùng căn hộ), reload lại form cùng thông báo lỗi trực quan
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("danhSachKhachHang", canHoService.getAllKhachHang());
            model.addAttribute("danhSachCanHo", canHoService.getAllCanHo());
            return "form-hop-dong";
        }

        // Thiết lập mối quan hệ từ ID được chọn và lưu vào CSDL
        hopDong.setKhachHang(canHoService.getKhachHangById(maKhachHang));
        hopDong.setCanHo(canHoService.getCanHoById(maCanHo));

        canHoService.saveHopDong(hopDong);
        return "redirect:/hop-dong/tim-kiem?success=true";
    }

    // Tính năng tìm kiếm thông tin sử dụng JOIN [2.5 Điểm]
    @GetMapping("/hop-dong/tim-kiem")
    public String timKiemHopDong(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<HopDong> ketQua;

        // Nếu có từ khóa thì lọc, không có thì load sạch danh sách lên
        if (keyword != null && !keyword.trim().isEmpty()) {
            ketQua = canHoService.searchHopDong(keyword.trim());
        } else {
            ketQua = canHoService.getAllHopDong(); // Tự động load hết danh sách khi vừa vào trang
        }

        model.addAttribute("ketQua", ketQua);
        model.addAttribute("keyword", keyword);
        return "tim-kiem-hop-dong";
    }

    // ================= THÊM KHÁCH HÀNG =================
    @GetMapping("/khach-hang/them")
    public String showFormKhachHang(Model model) {
        model.addAttribute("khachHang", new KhachHang());
        return "form-khach-hang";
    }

    @PostMapping("/khach-hang/luu")
    public String luuKhachHang(@ModelAttribute("khachHang") KhachHang khachHang, Model model) {
        if (khachHang.getHoTen().trim().isEmpty() || khachHang.getSoCCCD().trim().isEmpty() ||
                khachHang.getSoDT().trim().isEmpty() || khachHang.getEmail().trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập đầy đủ thông tin khách hàng!");
            return "form-khach-hang";
        }
        canHoService.saveKhachHang(khachHang);
        return "redirect:/hop-dong/them?successKH=true";
    }

    // ================= THÊM CĂN HỘ =================
    @GetMapping("/can-ho/them")
    public String showFormCanHo(Model model) {
        model.addAttribute("canHo", new CanHo());
        return "form-can-ho";
    }

    @PostMapping("/can-ho/luu")
    public String luuCanHo(@ModelAttribute("canHo") CanHo canHo, Model model) {
        if (canHo.getTenCanHo().trim().isEmpty() || canHo.getDiaChi().trim().isEmpty() ||
                canHo.getGiaThuePhong() <= 0) {
            model.addAttribute("error", "Vui lòng nhập đầy đủ và chính xác thông tin căn hộ!");
            return "form-can-ho";
        }
        canHoService.saveCanHo(canHo);
        return "redirect:/hop-dong/them?successCH=true";
    }

    // Giao diện tra cứu khách hàng
    @GetMapping("/khach-hang/tim-kiem")
    public String timKiemKhachHang(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<KhachHang> ketQua;

        if (keyword != null && !keyword.trim().isEmpty()) {
            ketQua = canHoService.searchKhachHangNangCao(keyword.trim());
        } else {
            ketQua = canHoService.searchKhachHangNangCao(""); // Load toàn bộ danh sách Entity
        }

        model.addAttribute("ketQua", ketQua); // Truyền trực tiếp danh sách Entity
        model.addAttribute("keyword", keyword);
        return "tim-kiem-khach-hang";
    }

    // Giao diện tra cứu căn hộ
    @GetMapping("/can-ho/tim-kiem")
    public String timKiemCanHo(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<CanHo> ketQua;

        if (keyword != null && !keyword.trim().isEmpty()) {
            ketQua = canHoService.searchCanHoNangCao(keyword.trim());
        } else {
            // Truyền chuỗi rỗng "" vào câu lệnh LIKE '%%' để Hibernate load hết toàn bộ căn hộ
            ketQua = canHoService.searchCanHoNangCao("");
        }

        model.addAttribute("ketQua", ketQua);
        model.addAttribute("keyword", keyword);
        return "tim-kiem-can-ho";
    }
}
