<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container mt-5" style="max-width: 600px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="text-primary"><i class="fa-solid fa-user-plus"></i> Thêm Khách Hàng Mới</h3>
        <a href="${pageContext.request.contextPath}/hop-dong/them" class="btn btn-secondary btn-sm">Quay lại</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card shadow-sm p-4">
        <form:form action="${pageContext.request.contextPath}/khach-hang/luu" method="POST" modelAttribute="khachHang">
            <div class="mb-3">
                <label class="form-label fw-bold">Họ và Tên</label>
                <form:input path="hoTen" class="form-control" required="required" placeholder="Nguyễn Văn A"/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Số CCCD</label>
                <form:input path="soCCCD" class="form-control" required="required" placeholder="Điền 12 số"/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Số Điện Thoại</label>
                <form:input path="soDT" class="form-control" required="required" placeholder="0905xxxxxx"/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Email</label>
                <form:input path="email" type="email" class="form-control" required="required" placeholder="nguyenva@gmail.com"/>
            </div>
            <button type="submit" class="btn btn-primary w-100"><i class="fa-solid fa-floppy-disk"></i> Lưu Khách Hàng</button>
        </form:form>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>