package servlet;

import data.User;
import db.MysqlDB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import static db.MysqlDB.findUserByName;

/**
 * Created by L on 2016/12/20.
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
    public static User lastUser;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            lastUser = findUserByName(name);
            if (lastUser == null || !lastUser.password.equals(password)) {
                request.setAttribute("msg", "user isnot exist or password is incorrect!");
                request.getRequestDispatcher("login.html").forward(request, response);

            } else {
                request.getRequestDispatcher("index.jsp?userId=" + lastUser.id).forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
