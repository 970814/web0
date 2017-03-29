package servlet;

import data.User;
import db.MysqlDB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static db.MysqlDB.connection;
import static db.MysqlDB.findUserById;
import static db.MysqlDB.insert;
import static servlet.Login.lastUser;

/**
 * Created by L on 2016/12/19.
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
    //email=1421053434%40qq.com&pwd=123456789&confirmPwd=123456789&nick=lmx
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("nick");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("pwd");
        double money = 1000.0;//base
        User user = new User(name, email, phone, password, money);
        try {
            insert(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String id = null;
        try {
            Statement statement = connection.createStatement();
            ResultSet set = statement.executeQuery("SELECT LAST_INSERT_ID() AS id FROM bookUser");
            if (set.next()) {
                id = set.getString(1);

            }
            set.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("login.html").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
