package com.example.quanlycanho.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "KHACH_HANG")
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int maKhachHang;

    private String hoTen;
    private String soCCCD;
    private String soDT;
    private String email;

//    @OneToMany(mappedBy = "khachHang", fetch = FetchType.LAZY)
    @OneToMany(mappedBy = "khachHang", fetch = FetchType.EAGER)
    private List<HopDong> danhSachHopDong;

    // Getters và Setters
    public int getMaKhachHang() { return maKhachHang; }
    public void setMaKhachHang(int maKhachHang) { this.maKhachHang = maKhachHang; }
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    public String getSoCCCD() { return soCCCD; }
    public void setSoCCCD(String soCCCD) { this.soCCCD = soCCCD; }
    public String getSoDT() { return soDT; }
    public void setSoDT(String soDT) { this.soDT = soDT; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    // Bắt buộc phải viết đúng chuẩn CamelCase để JSTL có thể tự gọi qua cấu trúc ${kh.danhSachHopDong}
    public List<HopDong> getDanhSachHopDong() {
        return this.danhSachHopDong;
    }

    public void setDanhSachHopDong(List<HopDong> danhSachHopDong) {
        this.danhSachHopDong = danhSachHopDong;
    }
}
