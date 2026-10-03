<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Căn Hộ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container mt-5" style="max-width: 600px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="text-success"><i class="fa-solid fa-building"></i> Thêm Căn Hộ Mới</h3>
        <a href="${pageContext.request.contextPath}/hop-dong/them" class="btn btn-secondary btn-sm">Quay lại</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card shadow-sm p-4">
        <form:form action="${pageContext.request.contextPath}/can-ho/luu" method="POST" modelAttribute="canHo">
            <div class="mb-3">
                <label class="form-label fw-bold">Tên Căn Hộ</label>
                <form:input path="tenCanHo" class="form-control" required="required" placeholder="Căn hộ Luxury A1"/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Loại Phòng</label>
                <form:select path="loaiPhong" class="form-select">
                    <form:option value="Studio" label="Studio"/>
                    <form:option value="1PN" label="1PN"/>
                    <form:option value="2PN" label="2PN"/>
                </form:select>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Giá Thuê Phòng (VNĐ/Tháng)</label>
                <form:input path="giaThuePhong" type="number" class="form-control" required="required" placeholder="5000000"/>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Địa Chỉ</label>
                <form:input path="diaChi" class="form-control" required="required" placeholder="Số 123 Nguyễn Huệ, Quy Nhơn"/>
            </div>
            <button type="submit" class="btn btn-success w-100"><i class="fa-solid fa-floppy-disk"></i> Lưu Căn Hộ</button>
        </form:form>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>