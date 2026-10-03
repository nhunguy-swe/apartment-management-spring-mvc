<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="header.jsp" />

<div class="container my-5">
    <div class="p-5 mb-4 bg-white border rounded-3 shadow-sm position-relative overflow-hidden">
        <div class="container-fluid py-3">
            <h1 class="display-5 fw-bold text-dark mb-3">Hệ thống Quản lý Căn hộ Cho thuê</h1>
            <p class="col-md-10 fs-5 text-muted">Chào mừng bạn đến với trang quản trị nội bộ. Hệ thống giúp lưu trữ, giám sát vòng đời hợp đồng, kết nối thông tin giữa căn hộ hiện trạng và danh sách khách hàng thuê một cách chính xác.</p>
            <a href="${pageContext.request.contextPath}/hop-dong/tim-kiem" class="btn btn-primary btn-lg px-4 mt-2">
                <i class="fa-solid fa-chart-line me-2"></i>Xem dữ liệu thống kê ngay
            </a>
        </div>
    </div>

    <div class="row g-4 mt-2">
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm text-center p-3">
                <div class="card-body">
                    <div class="text-primary fs-1 mb-3">
                        <i class="fa-solid fa-file-signature"></i>
                    </div>
                    <h5 class="card-title fw-bold">Lập Hợp Đồng</h5>
                    <p class="card-text text-muted small">Tạo mới hợp đồng thuê, kiểm tra tính hợp lệ số tiền đặt cọc và thời hạn.</p>
                </div>
                <div class="card-footer bg-transparent border-0 pb-3">
                    <a href="${pageContext.request.contextPath}/hop-dong/them" class="btn btn-outline-primary btn-sm w-100">Bắt đầu nhập</a>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm text-center p-3">
                <div class="card-body">
                    <div class="text-success fs-1 mb-3">
                        <i class="fa-solid fa-magnifying-glass-chart"></i>
                    </div>
                    <h5 class="card-title fw-bold">Tìm Kiếm & JOIN</h5>
                    <p class="card-text text-muted small">Tìm hợp đồng dựa trên CCCD khách hàng hoặc theo Tên căn hộ cụ thể.</p>
                </div>
                <div class="card-footer bg-transparent border-0 pb-3">
                    <a href="${pageContext.request.contextPath}/hop-dong/tim-kiem" class="btn btn-outline-success btn-sm w-100">Tìm kiếm ngay</a>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm text-center p-3">
                <div class="card-body">
                    <div class="text-warning fs-1 mb-3">
                        <i class="fa-solid fa-users-gear"></i>
                    </div>
                    <h5 class="card-title fw-bold">Khách Thuê</h5>
                    <p class="card-text text-muted small">Đăng ký mới hồ sơ thông tin khách hàng, số CCCD, Email liên hệ.</p>
                </div>
                <div class="card-footer bg-transparent border-0 pb-3">
                    <a href="${pageContext.request.contextPath}/khach-hang/them" class="btn btn-outline-warning btn-sm w-100">Cập nhật hồ sơ</a>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm text-center p-3">
                <div class="card-body">
                    <div class="text-info fs-1 mb-3">
                        <i class="fa-solid fa-house-laptop"></i>
                    </div>
                    <h5 class="card-title fw-bold">Danh Mục Căn Hộ</h5>
                    <p class="card-text text-muted small">Phân loại phòng Studio, 1PN, 2PN đi kèm thông tin định giá thuê.</p>
                </div>
                <div class="card-footer bg-transparent border-0 pb-3">
                    <a href="${pageContext.request.contextPath}/can-ho/them" class="btn btn-outline-info btn-sm w-100">Thêm cơ sở</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />