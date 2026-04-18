/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;
import java.sql.*;
import java.util.*;
/**
 *
 * @author lttru
 */
public class DBConnection {
    public static Connection getConnection() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/decorlampdb";
        String user = "root";
        String pass = "";
        return DriverManager.getConnection(url, user, pass);
    }
}
