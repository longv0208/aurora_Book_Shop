package com.group01.aurora_demo.admin.dao;

import com.group01.aurora_demo.admin.model.FlashSale;
import com.group01.aurora_demo.admin.model.FlashSaleItemView;
import com.group01.aurora_demo.common.config.DataSourceProvider;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FlashSaleDAO {

    public List<FlashSale> findAll(String keyword, String status, int page, int pageSize, int[] outTotalRows) throws SQLException {
        if (page < 1) page = 1;
        if (pageSize < 1) pageSize = 10;

        String where = " WHERE 1=1" +
                (keyword != null && !keyword.isEmpty() ? " AND Name LIKE ?" : "") +
                (status != null && !status.isEmpty() ? " AND Status = ?" : "");

        String countSql = "SELECT COUNT(*) FROM FlashSales" + where;
        String dataSql = "SELECT * FROM FlashSales" + where + " ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection cn = DataSourceProvider.get().getConnection()) {
            int total = 0;
            try (PreparedStatement ps = cn.prepareStatement(countSql)) {
                int i = 1;
                if (keyword != null && !keyword.isEmpty()) ps.setString(i++, "%" + keyword + "%");
                if (status != null && !status.isEmpty()) ps.setString(i++, status);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) total = rs.getInt(1);
            }
            if (outTotalRows != null && outTotalRows.length > 0) outTotalRows[0] = total;

            List<FlashSale> list = new ArrayList<>();
            try (PreparedStatement ps = cn.prepareStatement(dataSql)) {
                int i = 1;
                if (keyword != null && !keyword.isEmpty()) ps.setString(i++, "%" + keyword + "%");
                if (status != null && !status.isEmpty()) ps.setString(i++, status);
                ps.setInt(i++, (page - 1) * pageSize);
                ps.setInt(i, pageSize);

                ResultSet rs = ps.executeQuery();
                while (rs.next()) list.add(new FlashSale(rs));
            }
            return list;
        }
    }

    public List<String> loadStatuses() throws SQLException {
        List<String> statuses = new ArrayList<>();
        try (Connection cn = DataSourceProvider.get().getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT StatusCode FROM FlashSaleStatus ORDER BY StatusCode")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) statuses.add(rs.getString(1));
        }
        return statuses;
    }

    public FlashSale findById(long id) throws SQLException {
        try (Connection cn = DataSourceProvider.get().getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT * FROM FlashSales WHERE FlashSaleID=?")) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return new FlashSale(rs);
            return null;
        }
    }

    public List<FlashSaleItemView> findItems(long flashSaleId, String name, String publisher, String priceRange,
                                             int page, int pageSize, int[] outTotalRows) throws SQLException {
        if (page < 1) page = 1;
        if (pageSize < 1) pageSize = 10;

        String where = " WHERE fsi.FlashSaleID = ?" +
                (name != null && !name.isEmpty() ? " AND p.Title LIKE ?" : "") +
                (publisher != null && !publisher.isEmpty() ? " AND pub.Name LIKE ?" : "") +
                (priceRange != null && !priceRange.isEmpty() ? " AND fsi.FlashPrice BETWEEN ? AND ?" : "");

        String base = " FROM FlashSaleItems fsi JOIN Products p ON p.ProductID = fsi.ProductID " +
                " LEFT JOIN Publishers pub ON pub.PublisherID = p.PublisherID " + where;

        String countSql = "SELECT COUNT(*)" + base;
        String dataSql = "SELECT p.ProductID, p.Title, pub.Name AS PublisherName, fsi.FlashPrice, fsi.FsStock, p.OriginalPrice, p.SalePrice "
                + base + " ORDER BY p.ProductID DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection cn = DataSourceProvider.get().getConnection()) {
            // count
            int total = 0; int i;
            try (PreparedStatement ps = cn.prepareStatement(countSql)) {
                i = 1; ps.setLong(i++, flashSaleId);
                if (name != null && !name.isEmpty()) ps.setString(i++, "%" + name + "%");
                if (publisher != null && !publisher.isEmpty()) ps.setString(i++, "%" + publisher + "%");
                if (priceRange != null && !priceRange.isEmpty()) {
                    String[] parts = priceRange.split("-");
                    ps.setBigDecimal(i++, new java.math.BigDecimal(parts[0]));
                    ps.setBigDecimal(i++, new java.math.BigDecimal(parts[1]));
                }
                ResultSet rs = ps.executeQuery();
                if (rs.next()) total = rs.getInt(1);
            }
            if (outTotalRows != null && outTotalRows.length > 0) outTotalRows[0] = total;

            List<FlashSaleItemView> list = new ArrayList<>();
            try (PreparedStatement ps = cn.prepareStatement(dataSql)) {
                i = 1; ps.setLong(i++, flashSaleId);
                if (name != null && !name.isEmpty()) ps.setString(i++, "%" + name + "%");
                if (publisher != null && !publisher.isEmpty()) ps.setString(i++, "%" + publisher + "%");
                if (priceRange != null && !priceRange.isEmpty()) {
                    String[] parts = priceRange.split("-");
                    ps.setBigDecimal(i++, new java.math.BigDecimal(parts[0]));
                    ps.setBigDecimal(i++, new java.math.BigDecimal(parts[1]));
                }
                ps.setInt(i++, (page - 1) * pageSize);
                ps.setInt(i, pageSize);

                ResultSet rs = ps.executeQuery();
                while (rs.next()) list.add(new FlashSaleItemView(rs));
            }
            return list;
        }
    }

    public long insert(String name, java.sql.Timestamp startAt, java.sql.Timestamp endAt, String status) throws SQLException {
        String sql = "INSERT INTO FlashSales (Name, StartAt, EndAt, Status, CreatedAt) VALUES (?,?,?,?, SYSUTCDATETIME()); SELECT SCOPE_IDENTITY();";
        try (Connection cn = DataSourceProvider.get().getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setTimestamp(2, startAt);
            ps.setTimestamp(3, endAt);
            ps.setString(4, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getLong(1);
            return 0L;
        }
    }

    public int update(long id, String name, java.sql.Timestamp startAt, java.sql.Timestamp endAt, String status) throws SQLException {
        String sql = "UPDATE FlashSales SET Name=?, StartAt=?, EndAt=?, Status=? WHERE FlashSaleID=?";
        try (Connection cn = DataSourceProvider.get().getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setTimestamp(2, startAt);
            ps.setTimestamp(3, endAt);
            ps.setString(4, status);
            ps.setLong(5, id);
            return ps.executeUpdate();
        }
    }
}
