package servlet;

import db.MysqlDB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by L on 2016/12/21.
 */
@WebServlet("/Send")
public class Send extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String bookId = request.getParameter("bookId");
        String userId = request.getParameter("userId");
        String comment = request.getParameter("data");




//        System.out.println(bookId);
//        System.out.println(userId);
//        System.out.println(comment);

        if (userId.equals("")) {
            request.getRequestDispatcher("login.html").forward(request, response);
        } else {
            try {
                MysqlDB.insertComment(bookId, userId, comment);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
