<%@ page import="data.User" %>
<%@ page import="db.MysqlDB" %>
<%@ page import="static db.MysqlDB.findUserById" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="static db.MysqlDB.searchAllBookByUserId" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="static db.MysqlDB.findBookById" %>
<%@ page import="data.Book" %>
<%@ page import="static data.RandomData.random" %><%--
  Created by IntelliJ IDEA.
  User: L
  Date: 2016/12/19
  Time: 23:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>图书商城--个人信息</title>
    <meta name="author" content="饭饭">
    <meta name="keywords" content="关键字，关键词">
    <meta name="description" content="描述信息">
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        a {
            text-decoration: none;
        }

        ul li {
            list-style: none;
        }

        .wrap {
            width: 100%;
            height: 250px;
            background: url("images/personalbg.webp.jpg");
            background-size: cover;

        }

        .wrap .header {
            width: 800px;
            height: 250px;
            margin: 0 auto;
            position: relative;
        }

        .wrap .header .title {
            color: #FFFFFF;
            width: 300px;
            position: absolute;
            bottom: 40px;
        }

        .content {
            width: 800px;
            margin: 0 auto;
        }

        .content .book-box {
            width: 100%;
            background: #ffcf64;
        }

        .content .book-mess {
            width: 186px;
            height: 270px;
            float: left;
            margin: 3px 7px;
        }

        .content .book-mess a img {
            width: 184px;
            height: 184px;
            border-bottom: 1px solid #e6e6e6;
            transition: 1s;
            transform: scale(0.9);
        }
        .content .book-mess a img:hover{
            transform: scale(1);
            transition: 1s;
        }
        .content .book-mess .img-text p {
            height: 35px;
            text-align: center;
        }

        .content .book-mess .img-text p.book-name {
            font-size: 14px;
            line-height: 35px;
        }

        .content .book-mess .img-text p.book-price {
            color: red;
            font-weight: bold;
            line-height: 35px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="header">
        <%
            String userId = request.getParameter("userId");
            User user = null;
            try {
                user = findUserById(userId);

            } catch (SQLException e) {
                e.printStackTrace();
            }

        %>

        <div class="title">
            <h2><%=user.name%>的个人主页</h2>
            <p>登录邮箱：<span><%=user.email%></span></p>
            <p>手机号：<span><%=user.phone%></span></p>
            <p>书币余额：<span><%=user.getMoney()%></span></p>
        </div>
    </div>
</div>

        <%
            int bookNumbers = 0;
            double value = 0;
            StringBuilder builder = new StringBuilder();
            try {

                ResultSet set = searchAllBookByUserId(userId);
                while (set.next()) {
                    String bookId = set.getString(3);
                    int number = Integer.parseInt(set.getString(4));
                    Book book = findBookById(bookId);
                    value += number * book.price;
                    bookNumbers += number;
                    String url = "ProductDetails2.jsp?id=" + book.id;
                    int which = random.nextInt(10) + 1;
                    builder.append("<div class=\"book-box\">")
                            .append("<div class=\"book-mess\">")
                            .append("<a href=\"")
                            .append(url)
                            .append("\" class=\"book-img\">")
                            .append("<img src=\"images/")
                            .append(book.type).append("/").append(which).append(".jpg")
                            .append("\" alt=\"暂无相关书籍图片信息\">")
                            .append("</a>")
                            .append("<div class=\"img-text\">")
                            .append("<p class=\"book-name\">")
                            .append(book.name)
                            .append("</p>")
                            .append("<p class=\"book-price\">")
                            .append(number)
                            .append("</p>")
                            .append("</div>")
                            .append("</div>")
                            .append("</div>");

                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        %>
<div class="content">
    <h2 class="result">
        您当前拥有<span style="font-size: 32px;color: red; font-family:'楷体';"> <%=bookNumbers%> </span>本书，其价值相当于 <span
            style="font-size: 32px;color: red; font-family:'楷体';"> <%=String.format("%.2f", value)%> </span> 书币 ≈<span
            style="font-size: 32px;color: red; font-family:'楷体';"> <%=(int)(value*2)%> </span>RMB

    </h2>



            <%
                out.println(builder);
            %>








</div>


            <script type="text/javascript">

            </script>
</body>
</html>