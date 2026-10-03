package com.example.quanlycanho.dao;

import com.example.quanlycanho.entity.CanHo;
import com.example.quanlycanho.entity.HopDong;
import com.example.quanlycanho.entity.KhachHang;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

// @Repository: Đánh dấu lớp này là một tầng DAO (Data Access Object), giúp Spring quản lý và tương tác với DB
@Repository
public class CanHoDAO {

    // @Autowired: Tự động tiêm (inject) SessionFactory của Hibernate vào đây để sử dụng
    @Autowired
    private SessionFactory sessionFactory;

    /**
     * Lấy toàn bộ danh sách khách hàng có trong cơ sở dữ liệu.
     * Sử dụng HQL (Hibernate Query Language) dạng rút gọn "from KhachHang".
     */
    public List<KhachHang> getAllKhachHang() {
        return sessionFactory.getCurrentSession() // Lấy Session hiện tại đang chạy trong Transaction
                .createQuery("from KhachHang", KhachHang.class) // Tạo câu lệnh truy vấn thực thể KhachHang
                .list(); // Thực thi và trả về kết quả dạng List
    }

    /**
     * Lấy toàn bộ danh sách căn hộ có trong cơ sở dữ liệu.
     */
    public List<CanHo> getAllCanHo() {
        return sessionFactory.getCurrentSession().createQuery("from CanHo", CanHo.class).list();
    }

    /**
     * Tìm một khách hàng cụ thể dựa vào ID (Khóa chính).
     */
    public KhachHang getKhachHangById(int id) {
        // .get(): Hàm build-in của Hibernate, tự động tìm theo khóa chính, nếu không thấy trả về null
        return sessionFactory.getCurrentSession().get(KhachHang.class, id);
    }

    /**
     * Tìm một căn hộ cụ thể dựa vào ID (Khóa chính).
     */
    public CanHo getCanHoById(int id) {
        return sessionFactory.getCurrentSession().get(CanHo.class, id);
    }

    /**
     * Lưu mới (hoặc thêm mới) một hợp đồng vào database.
     */
    public void saveHopDong(HopDong hopDong) {
        // .save(): Lưu thực thể xuống database thông qua Hibernate
        sessionFactory.getCurrentSession().save(hopDong);
    }

    /**
     * TÍNH NĂNG: Tìm kiếm hợp đồng nâng cao bằng từ khóa (Keyword)
     * Thỏa mãn: Số CCCD khách hàng HOẶC Tên căn hộ chứa từ khóa cần tìm.
     */
    public List<HopDong> searchHopDong(String keyword) {
        Session session = sessionFactory.getCurrentSession();

        // HQL: Sử dụng JOIN FETCH để giải quyết vấn đề N+1 (nạp luôn Khách hàng và Căn hộ cùng lúc)
        // DISTINCT: Tránh việc trả về các dòng trùng lặp khi thực hiện JOIN dữ liệu quan hệ
        String hql = "SELECT DISTINCT hd FROM HopDong hd " +
                "JOIN FETCH hd.khachHang kh " + // INNER JOIN và nạp ngay thông tin khách hàng liên quan
                "JOIN FETCH hd.canHo ch " +     // INNER JOIN và nạp ngay thông tin căn hộ liên quan
                "WHERE LOWER(kh.soCCCD) LIKE LOWER(:keyword) " + // Tìm không phân biệt hoa thường theo CCCD
                "OR LOWER(ch.tenCanHo) LIKE LOWER(:keyword)";    // Hoặc tìm theo Tên căn hộ

        Query<HopDong> query = session.createQuery(hql, HopDong.class);

        // Gán giá trị vào tham số :keyword, sử dụng toán tử % để tìm kiếm tương đối (chứa từ khóa)
        // .trim() để loại bỏ các khoảng trắng thừa ở 2 đầu từ khóa
        query.setParameter("keyword", "%" + keyword.trim() + "%");

        return query.list();
    }

    /**
     * Lưu mới thông tin khách hàng.
     */
    public void saveKhachHang(KhachHang khachHang) {
        sessionFactory.getCurrentSession().save(khachHang);
    }

    /**
     * Lưu mới thông tin căn hộ.
     */
    public void saveCanHo(CanHo canHo) {
        sessionFactory.getCurrentSession().save(canHo);
    }

    /**
     * TÍNH NĂNG: Tìm kiếm khách hàng nâng cao theo Tên hoặc CCCD
     * Ưu điểm: Hiển thị kèm danh sách căn hộ họ đang thuê (nếu có).
     */
    public List<KhachHang> searchKhachHangNangCao(String keyword) {
        Session session = sessionFactory.getCurrentSession();

        // Sử dụng LEFT JOIN FETCH kép: Khách hàng -> Hợp đồng -> Căn hộ
        // Dùng LEFT JOIN vì nếu khách hàng mới, CHƯA THUÊ căn hộ nào (chưa có hợp đồng) thì vẫn hiển thị ra khách hàng đó.
        String hql = "SELECT DISTINCT kh FROM KhachHang kh " +
                "LEFT JOIN FETCH kh.danhSachHopDong hd " + // Nạp danh sách hợp đồng (nếu có)
                "LEFT JOIN FETCH hd.canHo ch " +          // Từ hợp đồng nạp tiếp thông tin căn hộ (nếu có)
                "WHERE LOWER(kh.hoTen) LIKE LOWER(:keyword) " +
                "OR LOWER(kh.soCCCD) LIKE LOWER(:keyword)";

        Query<KhachHang> query = session.createQuery(hql, KhachHang.class);
        query.setParameter("keyword", "%" + keyword.trim() + "%");
        return query.list();
    }

    /**
     * TÍNH NĂNG: Tìm kiếm căn hộ nâng cao theo Tên căn hộ hoặc Loại phòng
     * Ưu điểm: Đi kèm danh sách hợp đồng để tầng logic check xem căn hộ này Đang trống hay Đang được thuê.
     */
    public List<CanHo> searchCanHoNangCao(String keyword) {
        Session session = sessionFactory.getCurrentSession();

        // Dùng LEFT JOIN FETCH để căn hộ chưa có ai thuê (danh sách hợp đồng trống) vẫn được tìm thấy.
        String hql = "SELECT DISTINCT ch FROM CanHo ch " +
                "LEFT JOIN FETCH ch.danhSachHopDong hd " +
                "WHERE LOWER(ch.tenCanHo) LIKE LOWER(:keyword) " +
                "OR LOWER(ch.loaiPhong) LIKE LOWER(:keyword)";

        Query<CanHo> query = session.createQuery(hql, CanHo.class);
        query.setParameter("keyword", "%" + keyword.trim() + "%");
        return query.list();
    }

    /**
     * Lấy toàn bộ danh sách hợp đồng hiện có, đi kèm đầy đủ thông tin Khách hàng và Căn hộ.
     */
    public List<HopDong> getAllHopDong() {
        Session session = sessionFactory.getCurrentSession();

        // Sử dụng JOIN FETCH để ép Hibernate lấy tất cả data liên quan trong 1 câu Query duy nhất (tối ưu hiệu năng)
        String hql = "SELECT DISTINCT hd FROM HopDong hd " +
                "JOIN FETCH hd.khachHang kh " +
                "JOIN FETCH hd.canHo ch";

        return session.createQuery(hql, HopDong.class).list();
    }
}