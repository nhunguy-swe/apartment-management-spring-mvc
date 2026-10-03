<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm Kiếm Hợp Đồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<jsp:include page="header.jsp" />
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-success"><i class="fa-solid fa-magnifying-glass"></i> Tra Cứu Hợp Đồng Thuê Nhà</h2>
        <a href="${pageContext.request.contextPath}/hop-dong/them" class="btn btn-primary">
            <i class="fa-solid fa-plus"></i> Tạo hợp đồng mới
        </a>
    </div>

    <c:if test="${param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-circle-check"></i> Lưu hợp đồng thành công vào hệ thống dữ liệu!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card p-4 shadow-sm mb-4">
        <form action="${pageContext.request.contextPath}/hop-dong/tim-kiem" method="GET">
            <div class="input-group input-group-lg">
                <span class="input-group-text bg-white"><i class="fa-solid fa-keyboard text-muted"></i></span>
                <input type="text" name="keyword" value="${keyword}" class="form-control"
                       placeholder="Nhập Số CCCD của khách hàng hoặc Tên căn hộ để tìm kiếm..." required>
                <button class="btn btn-success" type="submit">
                    <i class="fa-solid fa-magnifying-glass-chart"></i> Tìm Kiếm
                </button>
            </div>
        </form>
    </div>

    <div class="card shadow-sm p-3">
        <h5 class="text-secondary border-bottom pb-2 mb-3">Kết quả tìm kiếm</h5>
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle">
                <thead class="table-dark">
                <tr>
                    <th>Mã HĐ</th>
                    <th>Tên Khách Hàng</th>
                    <th>Số Điện Thoại</th>
                    <th>Tên Căn Hộ</th>
                    <th>Ngày Bắt Đầu</th>
                    <th>Giá Thuê</th>
                    <th>Tiền Đặt Cọc</th>
                    <th>Trạng Thái</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <%-- Kiểm tra xem danh sách 'ketQua' có dữ liệu hay không --%>
                    <c:when test="${not empty ketQua}">
                        <c:forEach items="${ketQua}" var="hd">
                            <tr>
                                <td class="fw-bold text-primary">#${hd.maHopDong}</td>
                                <td><c:out value="${hd.khachHang.hoTen}" /></td>
                                <td><c:out value="${hd.khachHang.soDT}" /></td>
                                <td><span class="badge bg-info text-dark"><c:out value="${hd.canHo.tenCanHo}" /></span></td>
                                <td><fmt:formatDate value="${hd.ngayBatDau}" pattern="dd/MM/yyyy"/></td>
                                <td class="fw-semibold text-danger">
                                    <fmt:formatNumber value="${hd.canHo.giaThuePhong}" type="number" maxFractionDigits="0"/>đ
                                </td>
                                <td class="fw-semibold text-success">
                                    <fmt:formatNumber value="${hd.tienDatCoc}" type="number" maxFractionDigits="0"/>đ
                                </td>
                                <td>
                        <span class="badge ${hd.trangThai eq 'Còn hiệu lực' ? 'bg-success' : 'bg-secondary'}">
                            <c:out value="${hd.trangThai}" />
                        </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">
                                <i class="fa-solid fa-folder-open fa-2x mb-2 d-block"></i>
                                Không tìm thấy dữ liệu hợp đồng nào khớp với từ khóa "${keyword}".
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>