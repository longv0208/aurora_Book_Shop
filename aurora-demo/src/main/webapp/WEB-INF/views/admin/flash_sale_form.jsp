<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${fs == null ? 'Tạo Flash sale' : 'Cập nhật Flash sale'} - Aurora Admin</title>
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
                    <a class="nav-link" href="<c:url value='/admin/shop'/>"><div class="sb-nav-link-icon"><i class="bi bi-shop"></i></div>Quản lý shop</a>
                    <a class="nav-link" href="productManagement.html"><div class="sb-nav-link-icon"><i class="bi bi-box-seam"></i></div>Sản phẩm</a>
                    <a class="nav-link" href="#"><div class="sb-nav-link-icon"><i class="bi bi-cart3"></i></div>Đơn hàng</a>
                    <a class="nav-link" href="#"><div class="sb-nav-link-icon"><i class="bi bi-ticket-perforated"></i></div>Khuyến mãi</a>
                    <a class="nav-link" href="<c:url value='/admin/users'/>"><div class="sb-nav-link-icon"><i class="bi bi-people"></i></div>Tài khoản</a>
                    <a class="nav-link active" href="<c:url value='/admin/flash-sales'/>"><div class="sb-nav-link-icon"><i class="bi bi-lightning-charge"></i></div>Flash sales</a>
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
                    <h1 class="mt-4 promotion-title">${fs == null ? 'Tạo Flash sale' : 'Cập nhật Flash sale'}</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<c:url value='/'/>">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="<c:url value='/admin/flash-sales'/>">Flash sale</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${fs == null ? 'Tạo mới' : 'Cập nhật'}</li>
                        </ol>
                    </nav>
                </div>

                <div class="card mt-4">
                    <div class="card-body">
                        <form method="post" action="<c:url value='${fs == null ? "/admin/flash-sales/create" : "/admin/flash-sales/edit"}'/>">
                            <c:if test="${fs != null}">
                                <input type="hidden" name="id" value="${fs.flashSaleId}">
                            </c:if>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Tên chương trình</label>
                                    <input type="text" name="name" class="form-control" required value="<c:out value='${fs.name}'/>">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Trạng thái</label>
                                    <select name="status" class="form-select">
                                        <c:forEach items="${statuses}" var="st">
                                            <c:choose>
                                                <c:when test="${fs != null && st == fs.status}"><option value="${st}" selected="selected">${st}</option></c:when>
                                                <c:otherwise><option value="${st}">${st}</option></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Bắt đầu</label>
                                    <input type="datetime-local" name="startAt" class="form-control" required value="<c:out value='${startAtLocal}'/>">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Kết thúc</label>
                                    <input type="datetime-local" name="endAt" class="form-control" required value="<c:out value='${endAtLocal}'/>">
                                </div>
                            </div>
                            <div class="mt-4">
                                <button class="btn btn-success" type="submit"><i class="bi bi-save me-1"></i>Lưu</button>
                                <a class="btn btn-outline-secondary ms-2" href="<c:url value='/admin/flash-sales'/>">Hủy</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layouts/_scripts.jsp" />
</body>
</html>


