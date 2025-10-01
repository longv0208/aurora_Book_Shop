<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khuyến mãi - Aurora Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
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
                        <a class="nav-link" href="adminDashboard.html">
                            <div class="sb-nav-link-icon"><i class="bi bi-speedometer2"></i></div>
                            Dashboard
                        </a>
                        
                        <div class="sb-sidenav-menu-heading">Quản lý</div>
                        <a class="nav-link" href="shopInfo.html">
                            <div class="sb-nav-link-icon"><i class="bi bi-shop"></i></div>
                            Quản lý shop
                        </a>
                        <a class="nav-link" href="productManagement.html">
                            <div class="sb-nav-link-icon"><i class="bi bi-box-seam"></i></div>
                            Sản phẩm
                        </a>
                        <a class="nav-link" href="orderManagement.html">
                            <div class="sb-nav-link-icon"><i class="bi bi-cart3"></i></div>
                            Đơn hàng
                        </a>
                        <a class="nav-link active" href="promotionManagement.html">
                            <div class="sb-nav-link-icon"><i class="bi bi-ticket-perforated"></i></div>
                            Khuyến mãi
                        </a>
                        <a class="nav-link" href="#!">
                            <div class="sb-nav-link-icon"><i class="bi bi-people"></i></div>
                            Tài khoản
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
                    <!-- Page Header -->
                    <div class="d-flex justify-content-between align-items-center">
                        <h1 class="mt-4 promotion-title">Quản lý Khuyến mãi</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="home.html">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="adminDashboard.html">Dashboard</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Khuyến mãi</li>
                            </ol>
                        </nav>
                    </div>
                    
                    <!-- Statistics Cards -->
                    <div class="row mt-4">
                        <div class="col-md-3">
                            <div class="card stats-card stats-card-blue">
                                <div class="card-body">
                                    <div class="stats-content">
                                        <div class="stats-number">2</div>
                                        <div class="stats-label">Voucher hoạt động</div>
                                    </div>
                                    <div class="stats-icon">
                                        <i class="bi bi-ticket-perforated"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card stats-card stats-card-orange">
                                <div class="card-body">
                                    <div class="stats-content">
                                        <div class="stats-number">1</div>
                                        <div class="stats-label">Voucher chờ</div>
                                    </div>
                                    <div class="stats-icon">
                                        <i class="bi bi-clock"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card stats-card stats-card-red">
                                <div class="card-body">
                                    <div class="stats-content">
                                        <div class="stats-number">1</div>
                                        <div class="stats-label">Voucher hết hạn</div>
                                    </div>
                                    <div class="stats-icon">
                                        <i class="bi bi-x-circle"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card stats-card stats-card-green">
                                <div class="card-body">
                                    <div class="stats-content">
                                        <div class="stats-number">312</div>
                                        <div class="stats-label">Lượt sử dụng</div>
                                    </div>
                                    <div class="stats-icon">
                                        <i class="bi bi-graph-up"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Bar -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center gap-3">
                                            <button class="btn btn-success" id="createVoucherBtn">
                                                <i class="bi bi-plus-circle me-2"></i>Tạo voucher mới
                                            </button>
                                            <div class="input-group" style="width: 300px;">
                                                <span class="input-group-text">
                                                    <i class="bi bi-search"></i>
                                                </span>
                                                <input type="text" class="form-control" placeholder="Tìm kiếm mã voucher..." id="searchVoucher">
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center gap-2">
                                            <select class="form-select" id="statusFilter" style="width: 150px;">
                                                <option value="">Tất cả</option>
                                                <option value="active">Hoạt động</option>
                                                <option value="pending">Chờ kích hoạt</option>
                                                <option value="expired">Hết hạn</option>
                                                <option value="inactive">Ngừng hoạt động</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Voucher List -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">
                                        <i class="bi bi-list-ul me-2"></i>Danh sách voucher (4)
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover voucher-table">
                                            <thead>
                                                <tr>
                                                    <th>Mã Code</th>
                                                    <th>Loại</th>
                                                    <th>Giá trị</th>
                                                    <th>Đơn tối thiểu</th>
                                                    <th>Thời gian</th>
                                                    <th>Số dùng</th>
                                                    <th>Trạng thái</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div class="voucher-code">
                                                            <strong>NEWUSER50</strong>
                                                            <small class="text-muted d-block">Voucher cho người dùng mới</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">%</span>
                                                    </td>
                                                    <td>
                                                        <span class="discount-value">50%</span>
                                                        <small class="text-muted d-block">200.000 VNĐ</small>
                                                    </td>
                                                    <td>
                                                        <span class="min-order">200.000 VNĐ</span>
                                                    </td>
                                                    <td>
                                                        <div class="date-range">
                                                            <small>2024-01-01 00:00</small>
                                                            <small>2024-01-31 23:59</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="usage-info">
                                                            <span class="used">240</span>/<span class="total">1000</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-success status-badge">Hoạt động</span>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <button class="btn btn-sm btn-outline-primary" onclick="viewVoucher('NEWUSER50')" title="Xem chi tiết">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-warning" onclick="editVoucher('NEWUSER50')" title="Chỉnh sửa">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteVoucher('NEWUSER50')" title="Xóa">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="voucher-code">
                                                            <strong>SAVE100K</strong>
                                                            <small class="text-muted d-block">Giảm giá cố định</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-warning">VNĐ</span>
                                                    </td>
                                                    <td>
                                                        <span class="discount-value">100.000 VNĐ</span>
                                                        <small class="text-muted d-block">500.000 VNĐ</small>
                                                    </td>
                                                    <td>
                                                        <span class="min-order">500.000 VNĐ</span>
                                                    </td>
                                                    <td>
                                                        <div class="date-range">
                                                            <small>2024-02-15 00:00</small>
                                                            <small>2024-02-15 23:59</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="usage-info">
                                                            <span class="used">67</span>/<span class="total">500</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-success status-badge">Hoạt động</span>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <button class="btn btn-sm btn-outline-primary" onclick="viewVoucher('SAVE100K')" title="Xem chi tiết">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-warning" onclick="editVoucher('SAVE100K')" title="Chỉnh sửa">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteVoucher('SAVE100K')" title="Xóa">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="voucher-code">
                                                            <strong>FLASH10</strong>
                                                            <small class="text-muted d-block">Flash sale cuối tuần</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">%</span>
                                                    </td>
                                                    <td>
                                                        <span class="discount-value">10%</span>
                                                        <small class="text-muted d-block">100.000 VNĐ</small>
                                                    </td>
                                                    <td>
                                                        <span class="min-order">100.000 VNĐ</span>
                                                    </td>
                                                    <td>
                                                        <div class="date-range">
                                                            <small>2024-02-01 00:00</small>
                                                            <small>2024-02-29 23:59</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="usage-info">
                                                            <span class="used">300</span>/<span class="total">300</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-danger status-badge">Hết hạn</span>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <button class="btn btn-sm btn-outline-primary" onclick="viewVoucher('FLASH10')" title="Xem chi tiết">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-warning" onclick="editVoucher('FLASH10')" title="Chỉnh sửa">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteVoucher('FLASH10')" title="Xóa">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="voucher-code">
                                                            <strong>BOOK2024</strong>
                                                            <small class="text-muted d-block">Khuyến mãi sách năm 2024</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">%</span>
                                                    </td>
                                                    <td>
                                                        <span class="discount-value">25%</span>
                                                        <small class="text-muted d-block">300.000 VNĐ</small>
                                                    </td>
                                                    <td>
                                                        <span class="min-order">300.000 VNĐ</span>
                                                    </td>
                                                    <td>
                                                        <div class="date-range">
                                                            <small>2024-04-01 00:00</small>
                                                            <small>2024-04-30 23:59</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="usage-info">
                                                            <span class="used">0</span>/<span class="total">200</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary status-badge">Nhập</span>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <button class="btn btn-sm btn-outline-primary" onclick="viewVoucher('BOOK2024')" title="Xem chi tiết">
                                                                <i class="bi bi-eye"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-warning" onclick="editVoucher('BOOK2024')" title="Chỉnh sửa">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-sm btn-outline-danger" onclick="deleteVoucher('BOOK2024')" title="Xóa">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            
            <footer class="footer text-white pt-5 pb-3 mt-4">
                <div class="container">
                    <div class="row gy-4">
                        <div class="col-6 col-md-3">
                            <a href="#" class="d-flex align-items-center">
                                <img src="./assets/images/logo-footer.png" alt="Logo" class="footer-logo">
                            </a>
                            <p>Your ultimate destination for books. Discover, explore, and purchase from our vast collection of
                                books across all genres.</p>
                            <div class="d-flex gap-3">
                                <i class="bi bi-facebook"></i>
                                <i class="bi bi-twitter"></i>
                                <i class="bi bi-instagram"></i>
                                <i class="bi bi-youtube"></i>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <h6 class="fw-bold fs-5">Quick Links</h6>
                            <ul class="list-unstyled">
                                <li><a href="#" class="text-white">Browse Books</a></li>
                                <li><a href="#" class="text-white">New Arrivals</a></li>
                                <li><a href="#" class="text-white">Best Sellers</a></li>
                                <li><a href="#" class="text-white">Special Offers</a></li>
                                <li><a href="#" class="text-white">Gift Cards</a></li>
                            </ul>
                        </div>

                        <div class="col-6 col-md-3">
                            <h6 class="fw-bold fs-5">Categories</h6>
                            <ul class="list-unstyled">
                                <li><a href="#" class="text-white">Fiction</a></li>
                                <li><a href="#" class="text-white">Non-Fiction</a></li>
                                <li><a href="#" class="text-white">Science & Technology</a></li>
                                <li><a href="#" class="text-white">Children's Books</a></li>
                                <li><a href="#" class="text-white">Educational</a></li>
                            </ul>
                        </div>

                        <div class="col-6 col-md-3">
                            <h6 class="fw-bold fs-5">Contact Us</h6>
                            <p class="mb-1">📍 123 Book Street, Reading City</p>
                            <p class="mb-1">📞 +1 (555) 123-BOOK</p>
                            <p>✉️ support@aurora.com</p>
                        </div>
                    </div>

                    <!-- Bottom Footer -->
                    <div class="row border-top border-light mt-4 pt-3">
                        <div class="col-md-6 text-center text-md-start">
                            <small>© 2024 Aurora. All rights reserved.</small>
                        </div>
                        <div class="col-md-6 text-center text-md-end">
                            <a href="#" class="text-white me-3">Privacy Policy</a>
                            <a href="#" class="text-white">Terms of Service</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${ctx}assets/js/promotionManagement.js"></script>
</body>
</html>
