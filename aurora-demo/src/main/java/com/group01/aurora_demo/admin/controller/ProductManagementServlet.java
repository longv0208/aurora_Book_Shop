package com.group01.aurora_demo.admin.controller;

import com.group01.aurora_demo.catalog.dao.ProductDAO;
import com.group01.aurora_demo.catalog.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * ProductManagementServlet handles admin operations for products
 * - List all products with pagination
 * - View detailed product information
 */
@WebServlet(name = "ProductManagementServlet", urlPatterns = {"/admin/products", "/admin/products/detail"})
public class ProductManagementServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Determine action from param or path
        String action = param(req, "action");
        if (action.isEmpty()) {
            String path = req.getServletPath();
            if (path != null && path.endsWith("/detail")) {
                action = "detail";
            } else {
                action = "list";
            }
        }

        switch (action) {
            case "detail":
                showDetail(req, resp);
                break;
            case "list":
            default:
                showList(req, resp);
                break;
        }
    }

    /**
     * Show list of products with pagination
     */
    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = parseInt(req.getParameter("page"), 1);
        int pageSize = parseInt(req.getParameter("pageSize"), 10);

        // Get total count for pagination
        int totalProducts = productDAO.countProducts();
        
        // Fetch products for the current page
        List<Product> products = productDAO.getProductsByPage(page, pageSize);

        // Set attributes for JSP
        req.setAttribute("products", products);
        req.setAttribute("page", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("total", totalProducts);

        req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);
    }

    /**
     * Show detailed information for a single product
     */
    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = parseLong(req.getParameter("id"), -1);
        if (id <= 0) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid product ID");
            return;
        }

        Product product = productDAO.getProductById(id);
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
        }

        req.setAttribute("product", product);
        req.getRequestDispatcher("/WEB-INF/views/admin/productDetail.jsp").forward(req, resp);
    }

    // Helper methods
    private static String param(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return v == null ? "" : v.trim();
    }

    private static int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }

    private static long parseLong(String s, long def) {
        try { return Long.parseLong(s); } catch (Exception e) { return def; }
    }
}
