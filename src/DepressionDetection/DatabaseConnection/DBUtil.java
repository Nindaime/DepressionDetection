/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.DatabaseConnection;
import java.sql.Connection;
import java.sql.DriverManager;


import java.sql.SQLException;

/**
 *
 * @author PETER-PC
 */
public class DBUtil {

    private static Connection connection;
    public static String url, password, username;

    //make a db class private
    private DBUtil() {
    }

    public static synchronized Connection getConnection() throws Exception {
        if (connection != null) {
            return connection;
        } else {
            try {
                url = "Enter jdbc url";
                username = "Enter jdbc username";
                password = "Enter jdbc password";

                connection = DriverManager.getConnection(url, username, password);

                return connection;
            } catch (SQLException exception) {
                throw new Exception(exception.getMessage());
            }
        }
    }

    public static synchronized void closeConnection() throws Exception {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new Exception(e.getMessage());
            } finally {
                connection = null;
            }
        }
    }

}
