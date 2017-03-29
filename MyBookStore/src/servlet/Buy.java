package servlet;

import data.Book;
import db.MysqlDB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

import static db.MysqlDB.buyBook;
import static db.MysqlDB.connection;
import static db.MysqlDB.findUserById;
import static servlet.Login.lastUser;

/**
 * Created by L on 2016/12/20.
 */
@WebServlet("/Buy")
public class Buy extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (lastUser != null) {
            String number = request.getParameter("buyNumber");
            System.out.println(number);
            int n = Integer.parseInt(number);
            System.out.println(n);
            Book book = (Book) request.getSession().getAttribute("book");
            double cost = n * book.price;
            lastUser.money -= cost;
            try {
                String update = "update bookUser set money = money - " + cost + " where id =" + lastUser.id;
                Statement statement = connection.createStatement();
                statement.executeUpdate(update);
                buyBook(book.id, lastUser.id + "", statement, n);
                lastUser = findUserById(lastUser.id + "");
            } catch (SQLException e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("personalMessage.jsp?userId=" + lastUser.id).forward(request, response);
        } else {
            request.getRequestDispatcher("login.html").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
