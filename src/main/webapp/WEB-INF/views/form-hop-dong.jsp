<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Khai Báo Hợp Đồng Thuê Nhà</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary"><i class="fa-solid fa-file-signature"></i> Thêm Mới Hợp Đồng Thuê Căn Hộ</h2>
        <a href="${pageContext.request.contextPath}/hop-dong/tim-kiem" class="btn btn-secondary">
            <i class="fa-solid fa-magnifying-glass"></i> Đi đến tìm kiếm
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-triangle-exclamation"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card shadow-sm p-4">
        <div class="mb-4 text-start">
            <a href="${pageContext.request.contextPath}/khach-hang/them" class="btn btn-outline-primary me-2">
                <i class="fa-solid fa-user-plus"></i> Thêm nhanh khách hàng
            </a>
            <a href="${pageContext.request.contextPath}/can-ho/them" class="btn btn-outline-success">
                <i class="fa-solid fa-building-user"></i> Thêm nhanh căn hộ
            </a>
        </div>

        <c:if test="${param.successKH}">
            <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Đã thêm khách hàng mới vào danh sách thành công!</div>
        </c:if>
        <c:if test="${param.successCH}">
            <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> Đã thêm căn hộ mới vào danh sách thành công!</div>
        </c:if>

        <%-- Kiểm tra nếu Controller có gửi lỗi 'error' qua thì hiển thị alert đỏ --%>
<%--        <c:if test="${not empty error}">--%>
<%--            <div class="alert alert-danger alert-dismissible fade show" role="alert">--%>
<%--                <i class="fa-solid fa-triangle-exclamation me-2"></i> ${error}--%>
<%--                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>--%>
<%--            </div>--%>
<%--        </c:if>--%>

        <form:form action="${pageContext.request.contextPath}/hop-dong/luu" method="POST" modelAttribute="hopDong">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Khách hàng <span class="text-danger">*</span></label>
                    <select name="maKhachHangSelect" class="form-select" required>
                        <option value="">-- Chọn khách hàng ký hợp đồng --</option>
                        <c:forEach items="${danhSachKhachHang}" var="kh">
                            <option value="${kh.maKhachHang}">${kh.hoTen} (CCCD: ${kh.soCCCD})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Căn hộ <span class="text-danger">*</span></label>
                    <select name="maCanHoSelect" class="form-select" required>
                        <option value="">-- Chọn căn hộ cho thuê --</option>
                        <c:forEach items="${danhSachCanHo}" var="ch">
                            <option value="${ch.maCanHo}">${ch.tenCanHo} - ${ch.loaiPhong} (${ch.giaThuePhong}đ/tháng)</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Ngày bắt đầu <span class="text-danger">*</span></label>
                    <form:input path="ngayBatDau" type="date" class="form-select form-control" required="required" />
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Ngày kết thúc <span class="text-danger">*</span></label>
                    <form:input path="ngayKetThuc" type="date" class="form-select form-control" required="required" />
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Tiền đặt cọc (VNĐ) <span class="text-danger">*</span></label>
                    <form:input path="tienDatCoc" type="number" class="form-control" placeholder="Ví dụ: 1500000, 2000000..." required="required"/>
                    <div class="form-text text-muted">Số tiền phải chia hết cho 500,000đ.</div>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label fw-bold">Trạng thái <span class="text-danger">*</span></label>
                    <form:select path="trangThai" class="form-select" required="required">
                        <form:option value="Còn hiệu lực" label="Còn hiệu lực"/>
                        <form:option value="Hết hạn" label="Hết hạn"/>
                    </form:select>
                </div>
            </div>

            <div class="text-end mt-4">
                <button type="reset" class="btn btn-warning text-white me-2"><i class="fa-solid fa-rotate-left"></i> Nhập lại</button>
                <button type="submit" class="btn btn-success"><i class="fa-solid fa-floppy-disk"></i> Lưu Hợp Đồng</button>
            </div>
        </form:form>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>