<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Flash Sale - Aurora Admin</title>
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
                    <a class="nav-link" href="<c:url value='/admin/dashboard'/>">
                        <div class="sb-nav-link-icon"><i class="bi bi-speedometer2"></i></div>Dashboard
                    </a>
                    <div class="sb-sidenav-menu-heading">Quản lý</div>
                    <a class="nav-link" href="<c:url value='/admin/shop'/>">
                        <div class="sb-nav-link-icon"><i class="bi bi-shop"></i></div>Quản lý shop
                    </a>
                    <a class="nav-link" href="productManagement.html">
                        <div class="sb-nav-link-icon"><i class="bi bi-box-seam"></i></div>Sản phẩm
                    </a>
                    <a class="nav-link" href="#">
                        <div class="sb-nav-link-icon"><i class="bi bi-cart3"></i></div>Đơn hàng
                    </a>
                    <a class="nav-link" href="#">
                        <div class="sb-nav-link-icon"><i class="bi bi-ticket-perforated"></i></div>Khuyến mãi
                    </a>
                    <a class="nav-link" href="<c:url value='/admin/users'/>">
                        <div class="sb-nav-link-icon"><i class="bi bi-people"></i></div>Tài khoản
                    </a>
                    <a class="nav-link active" href="<c:url value='/admin/flash-sales'/>">
                        <div class="sb-nav-link-icon"><i class="bi bi-lightning-charge"></i></div>Flash sales
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
                    <h1 class="mt-4 promotion-title">Chi tiết Flash sale</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<c:url value='/'/>">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="<c:url value='/admin/flash-sales'/>">Flash sale</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Chi tiết</li>
                        </ol>
                    </nav>
                </div>

                <div class="card mt-4 mb-3">
                    <div class="card-body row g-3">
                        <div class="col-md-3"><strong>ID:</strong> ${fs.flashSaleId}</div>
                        <div class="col-md-5"><strong>Tên:</strong> ${fs.name}</div>
                        <div class="col-md-2"><span class="badge bg-secondary">${fs.status}</span></div>
                        <div class="col-md-12"><strong>Thời gian:</strong> ${fs.startAt} → ${fs.endAt}</div>
                        <div class="col-md-12 text-muted"><small>Tạo lúc: ${fs.createdAt}</small></div>
                    </div>
                </div>

                <form class="card mb-3" method="get">
                    <input type="hidden" name="id" value="${fs.flashSaleId}">
                    <div class="card-body d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <div class="input-group" style="max-width: 360px;">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input class="form-control" name="name" value="${name}" placeholder="Tìm theo tên sản phẩm">
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <input class="form-control" name="publisher" value="${publisher}" placeholder="Nhà xuất bản" style="min-width: 180px;">
                            <input class="form-control" name="price" placeholder="Giá min-max" value="${price}" style="min-width: 180px;">
                            <button class="btn btn-primary"><i class="bi bi-funnel me-1"></i>Lọc</button>
                        </div>
                    </div>
                </form>

                <div class="card">
                    <div class="card-body table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>NXB</th>
                                <th>Giá Flash</th>
                                <th>Tồn FS</th>
                                <th>Giá gốc</th>
                                <th>Giá bán</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${items}" var="p">
                                <tr>
                                    <td>${p.productId}</td>
                                    <td>${p.title}</td>
                                    <td>${p.publisherName}</td>
                                    <td>${p.flashPrice}</td>
                                    <td>${p.fsStock}</td>
                                    <td>${p.originalPrice}</td>
                                    <td>${p.salePrice}</td>
                                    <td>
                                        <a class="btn btn-sm btn-outline-secondary" href="<c:url value='/admin/product/detail'><c:param name='id' value='${p.productId}'/></c:url>"><i class="bi bi-eye"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <c:set var="totalPages" value="${(total + pageSize - 1) / pageSize}"/>
                <nav aria-label="pagination" class="mt-3">
                    <ul class="pagination">
                        <li class="page-item ${page==1?'disabled':''}">
                            <a class="page-link" href="?id=${fs.flashSaleId}&name=${name}&publisher=${publisher}&price=${price}&page=${page-1}&pageSize=${pageSize}">«</a>
                        </li>
                        <c:forEach var="pnum" begin="1" end="${totalPages}">
                            <li class="page-item ${pnum==page?'active':''}">
                                <a class="page-link" href="?id=${fs.flashSaleId}&name=${name}&publisher=${publisher}&price=${price}&page=${pnum}&pageSize=${pageSize}">${pnum}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${page>=totalPages?'disabled':''}">
                            <a class="page-link" href="?id=${fs.flashSaleId}&name=${name}&publisher=${publisher}&price=${price}&page=${page+1}&pageSize=${pageSize}">»</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/_scripts.jsp" />
<script src="<c:url value='/assets/js/adminDashboard.js'/>"></script>
</body>
</html>


