<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="header.jsp" />

<div class="container my-4">
    <h3 class="text-primary mb-4"><i class="fa-solid fa-address-book"></i> Tra Cứu Khách Thuê & Căn Hộ Hiện Tại</h3>

    <div class="card p-4 shadow-sm mb-4">
        <form action="${pageContext.request.contextPath}/khach-hang/tim-kiem" method="GET">
            <div class="input-group">
                <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Nhập tên khách hàng hoặc số CCCD...">
                <button class="btn btn-primary" type="submit"><i class="fa-solid fa-magnifying-glass"></i> Tìm Kiếm</button>
            </div>
        </form>
    </div>

    <div class="card shadow-sm p-3">
        <table class="table table-hover align-middle">
            <thead class="table-dark">
            <tr>
                <th>Họ Tên</th>
                <th>Số CCCD</th>
                <th>Số Điện Thoại</th>
                <th>Email</th>
                <th>Căn Hộ Đang Thuê</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty ketQua}">
                    <c:forEach items="${ketQua}" var="kh">
                        <tr>
                            <td class="fw-bold"><c:out value="${kh.hoTen}"/></td>
                            <td><c:out value="${kh.soCCCD}"/></td>
                            <td><c:out value="${kh.soDT}"/></td>
                            <td><c:out value="${kh.email}"/></td>
                            <td>
                                <c:set var="dangThue" value="false" />
                                <c:set var="tenCanHo" value="" />

                                <c:forEach items="${kh.danhSachHopDong}" var="hd">
                                    <%-- Kiểm tra nếu trạng thái chứa chữ 'hiệu lực' (bất kể lỗi font hiển thị) --%>
                                    <c:if test="${fn:contains(hd.trangThai, 'hiệu lực') or fn:contains(hd.trangThai, 'hiá»‡u lÃ¡Â»Â±c')}">
                                        <c:set var="dangThue" value="true" />
                                        <c:set var="tenCanHo" value="${hd.canHo.tenCanHo}" />
                                    </c:if>
                                </c:forEach>

                                <c:choose>
                                    <c:when test="${dangThue}">
                                <span class="badge bg-success fs-6">
                                    <i class="fa-solid fa-house-user"></i> <c:out value="${tenCanHo}"/>
                                </span>
                                    </c:when>
                                    <c:otherwise>
                                <span class="text-muted small">
                                    <em><i class="fa-solid fa-user-slash"></i> Hiện đang trống (Chưa thuê)</em>
                                </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" class="text-center text-muted py-4">
                            <i class="fa-solid fa-database mb-2 d-block fa-2x"></i>
                            Không có dữ liệu hiển thị.
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="footer.jsp" />