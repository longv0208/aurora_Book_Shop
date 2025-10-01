<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - Aurora Admin</title>
    <jsp:include page="/WEB-INF/views/layouts/_head.jsp" />
</head>
<body class="sb-nav-fixed">
<jsp:include page="/WEB-INF/views/layouts/_header.jsp" />

<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading">Tổng quan</div>
                    <a class="nav-link" href="<c:url value='/admin'/>">
                        <div class="sb-nav-link-icon"><i class="bi bi-speedometer2"></i></div>Dashboard
                    </a>
                    <div class="sb-sidenav-menu-heading">Quản lý</div>
                    <a class="nav-link" href="<c:url value='/admin/shop'/>">
                        <div class="sb-nav-link-icon"><i class="bi bi-shop"></i></div>Quản lý shop
                    </a>
                    <a class="nav-link active" href="<c:url value='/admin/users'/>">
                        <div class="sb-nav-link-icon"><i class="bi bi-people"></i></div>Người dùng
                    </a>
                </div>
            </div>
            <div class="sb-sidenav-footer">
                <div class="small">Đăng nhập với:</div>
                Aurora Admin
            </div>
        </nav>
    </div>

    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div class="d-flex justify-content-between align-items-center">
                    <button id="sidebarToggle" class="btn btn-outline-secondary btn-sm me-3" type="button">
                        <i class="bi bi-list"></i>
                    </button>
                    <h1 class="mt-4 dashboard-title">Quản lý người dùng</h1>
                </div>

                <div class="card mt-4">
                    <div class="card-body table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Điện thoại</th>
                                <th>Điểm</th>
                                <th>CMND/CCCD</th>
                                <th>Vai trò</th>
                                <th>Nhà cung cấp</th>
                                <th>Tạo lúc</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${users}" var="u">
                                <tr>
                                    <td>${u.userID}</td>
                                    <td>${u.fullName}</td>
                                    <td>${u.email}</td>
                                    <td>${u.phone}</td>
                                    <td>${u.points}</td>
                                    <td>${u.nationalId}</td>
                                    <td>${u.roles}</td>
                                    <td>${u.authProvider}</td>
                                    <td>${u.createdAt}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/_scripts.jsp" />
<script src="<c:url value='/assets/js/adminDashboard.js'/>"></script>
</body>
</html>


