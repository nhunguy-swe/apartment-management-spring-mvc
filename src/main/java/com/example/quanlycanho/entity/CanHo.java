package com.example.quanlycanho.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "CAN_HO")
public class CanHo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int maCanHo;

    private String tenCanHo;
    private String loaiPhong;
    private double giaThuePhong;
    private String diaChi;

//    @OneToMany(mappedBy = "canHo", fetch = FetchType.LAZY)
    @OneToMany(mappedBy = "canHo", fetch = FetchType.EAGER)
    private List<HopDong> danhSachHopDong;

    // Getters và Setters
    public int getMaCanHo() { return maCanHo; }
    public void setMaCanHo(int maCanHo) { this.maCanHo = maCanHo; }
    public String getTenCanHo() { return tenCanHo; }
    public void setTenCanHo(String tenCanHo) { this.tenCanHo = tenCanHo; }
    public String getLoaiPhong() { return loaiPhong; }
    public void setLoaiPhong(String loaiPhong) { this.loaiPhong = loaiPhong; }
    public double getGiaThuePhong() { return giaThuePhong; }
    public void setGiaThuePhong(double giaThuePhong) { this.giaThuePhong = giaThuePhong; }
    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

    public List<HopDong> getDanhSachHopDong() {
        return this.danhSachHopDong;
    }

    public void setDanhSachHopDong(List<HopDong> danhSachHopDong) {
        this.danhSachHopDong = danhSachHopDong;
    }
}