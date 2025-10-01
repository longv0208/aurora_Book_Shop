// package com.group01.aurora_demo.admin.controller;

// import com.group01.aurora_demo.common.config.DataSourceProvider;
// import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.WebServlet;
// import jakarta.servlet.http.HttpServlet;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;

// import java.io.IOException;
// import java.sql.*;
// import java.util.ArrayList;
// import java.util.List;

// @WebServlet(name = "UserManagementServlet", urlPatterns = {"/admin/users"})
// public class UserManagementServlet extends HttpServlet {

//     @Override
//     protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//         List<UserDTO> users = new ArrayList<>();
//         try (Connection cn = DataSourceProvider.get().getConnection();
//              PreparedStatement ps = cn.prepareStatement("SELECT TOP 100 u.*, STRING_AGG(ur.RoleCode, ',') WITHIN GROUP (ORDER BY ur.RoleCode) AS Roles FROM Users u LEFT JOIN UserRoles ur ON u.UserID = ur.UserID GROUP BY u.UserID, u.Email, u.Password, u.FullName, u.Phone, u.Points, u.NationalID, u.AvatarUrl, u.CreatedAt, u.AuthProvider ORDER BY u.UserID DESC")) {
//             ResultSet rs = ps.executeQuery();
//             while (rs.next()) users.add(new UserDTO(rs));
//         } catch (SQLException e) {
//             throw new ServletException(e);
//         }
//         req.setAttribute("users", users);
//         req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
//     }

//     // Simple DTO for JSP
//     public static class UserDTO {
//         public long userID; public String email; public String fullName; public String phone; public int points; public String nationalId; public String avatarUrl; public Timestamp createdAt; public String authProvider; public String roles;
//         public UserDTO(ResultSet rs) throws SQLException {
//             userID = rs.getLong("UserID");
//             email = rs.getString("Email");
//             fullName = rs.getString("FullName");
//             phone = rs.getString("Phone");
//             points = rs.getInt("Points");
//             nationalId = rs.getString("NationalID");
//             avatarUrl = rs.getString("AvatarUrl");
//             createdAt = rs.getTimestamp("CreatedAt");
//             authProvider = rs.getString("AuthProvider");
//             roles = rs.getString("Roles");
//         }
//     }
// }


