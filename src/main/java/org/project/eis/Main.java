package org.project.eis;

import java.sql.*;

public class Main {
    public static void main(String[] args) {
//        DBConnection con = new DBConnection();
//        con.AutoConnection();

        try {
            Connection conn = DriverManager.getConnection(
                    "server_address",
                    "user",
                    "password"
            );

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(
                    "EXEC SP_FIN_BalRatio_Query1  '202112', 'X'"
            );

            while (rs.next()) {
                System.out.println(rs.getString(4));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}