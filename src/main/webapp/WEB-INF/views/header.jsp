<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .main-content {
            flex: 1;
        }
        .navbar-brand fw-bold {
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold text-info" href="${pageContext.request.contextPath}/">
            <i class="fa-solid fa-city me-2"></i>APARTMENT MANAGER
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/hop-dong/them">
                        <i class="fa-solid fa-file-contract me-1"></i> Lập Hợp Đồng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/hop-dong/tim-kiem">
                        <i class="fa-solid fa-magnifying-glass me-1"></i> Tra Cứu Hợp Đồng
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-magnifying-glass-chart me-1"></i> Trung Tâm Tra Cứu
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="searchDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/hop-dong/tim-kiem">
                                <i class="fa-solid fa-file-invoice text-primary me-2"></i>Tìm Hợp Đồng (JOIN)
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/khach-hang/tim-kiem">
                                <i class="fa-solid fa-user-check text-success me-2"></i>Tìm Khách Hàng (Xem Căn Hộ)
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/can-ho/tim-kiem">
                                <i class="fa-solid fa-building-circle-exclamation text-warning me-2"></i>Tìm Căn Hộ (Xem Trạng Thái)
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="main-content"/>