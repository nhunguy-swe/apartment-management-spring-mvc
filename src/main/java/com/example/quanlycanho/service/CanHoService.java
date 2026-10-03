package com.example.quanlycanho.service;

import com.example.quanlycanho.dao.CanHoDAO;
import com.example.quanlycanho.entity.CanHo;
import com.example.quanlycanho.entity.HopDong;
import com.example.quanlycanho.entity.KhachHang;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class CanHoService {

    @Autowired
    private CanHoDAO canHoDAO ;

    public List<KhachHang> getAllKhachHang() { return canHoDAO.getAllKhachHang(); }
    public List<CanHo> getAllCanHo() { return canHoDAO.getAllCanHo(); }
    public KhachHang getKhachHangById(int id) { return canHoDAO.getKhachHangById(id); }
    public CanHo getCanHoById(int id) { return canHoDAO.getCanHoById(id); }
    public void saveHopDong(HopDong hopDong) { canHoDAO.saveHopDong(hopDong); }
    public List<HopDong> searchHopDong(String keyword) { return canHoDAO.searchHopDong(keyword); }
    public void saveKhachHang(KhachHang khachHang) { canHoDAO.saveKhachHang(khachHang); }
    public void saveCanHo(CanHo canHo) { canHoDAO.saveCanHo(canHo); }
    public List<KhachHang> searchKhachHangNangCao(String keyword) { return canHoDAO.searchKhachHangNangCao(keyword); }
    public List<CanHo> searchCanHoNangCao(String keyword) { return canHoDAO.searchCanHoNangCao(keyword); }
    public List<HopDong> getAllHopDong() { return canHoDAO.getAllHopDong(); }
}