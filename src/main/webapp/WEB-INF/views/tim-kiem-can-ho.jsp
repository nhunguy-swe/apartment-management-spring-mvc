<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="header.jsp" />

<div class="container my-4">
    <h3 class="text-success mb-4"><i class="fa-solid fa-building-circle-check"></i> Kiểm Tra Trạng Thái Trống / Thuê Của Căn Hộ</h3>

    <div class="card p-4 shadow-sm mb-4">
        <form action="${pageContext.request.contextPath}/can-ho/tim-kiem" method="GET">
            <div class="input-group">
                <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Nhập tên căn hộ hoặc loại phòng (Studio, 1PN...)...">
                <button class="btn btn-success" type="submit"><i class="fa-solid fa-magnifying-glass"></i> Tra Cứu</button>
            </div>
        </form>
    </div>

    <div class="card shadow-sm p-3">
        <table class="table table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th>Tên Căn Hộ</th>
                <th>Loại Phòng</th>
                <th>Giá Thuê / Tháng</th>
                <th>Địa Chỉ</th>
                <th>Trạng Thái Hiện Tại</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty ketQua}">
                    <c:forEach items="${ketQua}" var="ch">
                        <tr>
                            <td class="fw-bold text-success">${ch.tenCanHo}</td>
                            <td><span class="badge bg-secondary">${ch.loaiPhong}</span></td>
                            <td class="fw-bold text-danger"><fmt:formatNumber value="${ch.giaThuePhong}" type="number" maxFractionDigits="0"/>đ</td>
                            <td>${ch.diaChi}</td>
                            <td>
                                <c:set var="isRented" value="false" />
                                <c:forEach items="${ch.danhSachHopDong}" var="hd">
                                    <%-- Dùng fn:contains quét chuỗi để an toàn tuyệt đối --%>
                                    <c:if test="${fn:contains(hd.trangThai, 'hiệu lực') or fn:contains(hd.trangThai, 'hiá»‡u lÃ¡Â»Â±c')}">
                                        <c:set var="isRented" value="true" />
                                    </c:if>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${isRented}">
                                        <span class="badge bg-danger p-2"><i class="fa-solid fa-lock"></i> Đang Cho Thuê</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success p-2"><i class="fa-solid fa-unlock"></i> Còn Trống</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="5" class="text-center text-muted">Không có dữ liệu hiển thị.</td></tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="footer.jsp" />