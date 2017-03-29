<%@ page import="data.DataManager" %>
<%@ page import="data.RandomData" %>
<%@ page import="static data.RandomData.types" %>
<%@ page import="static data.DataManager.dataManager" %>
<%@ page import="java.util.function.Consumer" %>
<%@ page import="data.Book" %>
<%@ page import="data.BookType" %>
<%@ page import="static data.RandomData.bookTypes" %>
<%@ page import="db.MysqlDB" %>
<%@ page import="static db.MysqlDB.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="servlet.Login" %>

<%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2016/12/16
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>图书商城--首页</title>
    <meta name="keywords" content="关键字，关键词">
    <meta name="description" content="描述信息">
    <link href="css/index.css" type="text/css" rel="stylesheet"/>
    <link href="images/logo.ico" rel="shortcut icon" type="image/x-icon"/>
    <style type="text/css" id="css">

    </style>
</head>
<body>
<div class="header">
    <%
        if (
                Login.lastUser != null) {
            out.println("<a href=\"Out\" id=\"login\">nihao</a>");
        } else {
            out.println("<a href=\"login.html\" id=\"login\">登录/login</a>");
        }
    %>
</div>
<div class="wrap">
    <!--banner-->
    <div class="banner floor" name="top">
        <div class="box">
            <ul id="pic_ul"></ul>
            <ol>
                <li>一</li>
                <li>二</li>
                <li>三</li>
                <li>四</li>
            </ol>
        </div>
    </div>


    <%
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < bookTypes.length; i++) {
            builder.append("<div class=\"floor\">");
            try {
                ResultSet set = MysqlDB.selectDataByType(bookTypes[i]);
                for (int j = 0; j < 10 && set.next(); j++) {
                    int id = Integer.parseInt(set.getString(1));
                    String name = set.getString(2);
                    double price = Double.parseDouble(set.getString(3));
                    int number = Integer.parseInt(set.getString(4));
                    BookType type = BookType.valueOf(set.getString(5));
                    String author = set.getString(6);
                    String src = set.getString(7);
                    String publishTime = set.getString(8);
                    Book book = new Book(id, name, price, number, type, author, src, publishTime);
                    String url = "ProductDetails2.jsp?id=" + book.id;
                    builder.append("<div class=\"img-box\">")
                            .append("<a href=\"")
                            .append(url)//url
                            .append("\">")
                            .append("<img src=\"images/")
                            .append(bookTypes[i].toString())
                            .append("/" + (j + 1) + ".jpg")//add img path
                            .append("\">")
                            .append("</a>")
                            .append("<div class=\"img-text\">")
                            .append("<p>")
                            .append("<a href=\"")
                            .append(url)//url
                            .append("\" class=\"book-name\">")
                            .append(book.name)//book name
                            .append("</a>")
                            .append("</p>")
                            .append("<p>")
                            .append("<span class=\"price\">￥")
                            .append(book.getPrice())//book price
                            .append("</span>")
                            .append("</p>")
                            .append("<p>")
                            .append("<a href=\"")
                            .append(url)//url
                            .append("\" class=\"book-buy\">订购</a>")
                            .append("</p>")
                            .append("</div>")
                            .append("</div>");
                }
                set.close();
                builder.append("</div>");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        out.println(builder);
    %>


    <%--wrap--%>
</div>
<!--侧边导航-->
<div class="slide-bar">
    <ul>
        <li style="display: none"></li>
        <%
            for (int i = 0; i < types.length; i++) {
                out.println("<li>" + types[i] + "</li>");
            }
        %>

        <li id="returnTop"><a href="#top">返回顶部</a></li>
    </ul>
</div>
<!--右边查询-->
<div class="right-slider-bar">
    <div id="polling">查询</div>
    <div class="content">
        <form id="form" action="SearchResult.jsp" method="get">
            <p class="content-text">
                <span class="left">图书名称</span>
                <span class="right">
                    <input type="text" placeholder="请输入查询关键字" name="name"></span>
            </p>
            <p class="content-text">
                <span class="left">出版社</span>
                <span class="right">
                    <input type="text" placeholder="请输入精确的出版社" name="src"></span>
            </p>
            <p class="content-text">
                <span class="left">作者</span>
                <span class="right">
                    <input type="text" placeholder="请输入作者信息" name="author"></span>
            </p>
            <p class="content-text">
                <span class="left">类别</span>
                <span class="right">
                    <input type="text" placeholder="请输入图书所属类别" name="type"></span>
            </p>
            <p class="content-text">
                <span class="left">价格范围</span>
                <span class="right">
                    <input type="text" placeholder="最低价格" style="width:125px;" name="minPrice">
                    <input type="text" placeholder="最高价格" style="width:125px;" name="maxPrice">
                </span>
            </p>
            <p class="content-text">
                <span class="left">出版时间</span>
                <span class="right">
                    <input type="text" placeholder="开始时间" style="width:125px;" name="startTime">
                    <input type="text" placeholder="结束时间" style="width:125px;" name="endTime">
                </span>
            </p>


            <p class="content-text">
                <span class="left">查找类别</span>
                <span class="right">
                    <span class="radio-box">
                        <input type="radio" class="radio up" name="sort" value="price" checked="checked">价格
					</span>
                    <span class="radio-box">
                        <input type="radio" class="radio up" name="sort" value="time">时间
					</span>
                </span>
            </p>
            <p class="content-text">
                <span class="left">查找方式</span>
                <span class="right">
                    <span class="radio-box">
                        <input class="radio up" type="radio" name="order" value="up" checked="checked">升序
                    </span>
                    <span class="radio-box">
                        <input class="radio down" type="radio" name="order" value="down">降序
                    </span>
                </span>
            </p>


            <%--  <p class="content-text">
                <span class="right" id="price-radio-box">
                  <input id="price-up" type="radio" value="price" name="sort" checked="checked">价格
                  <input id="price-down" type="radio" value="time" name="sort">时间
                </span>
              </p>
              <p class="content-text">
                <span class="right" id="time-radio-box">

                  <input id="time-up" type="radio" value="up" name="order" checked="checked">升序
                  <input id="time-down" type="radio" value="down" name="order">降序
                </span>
              </p>--%>


            <p class="submit">
                <input type="submit" value="查询" id="sub-btn">
            </p>
        </form>
    </div>
</div>
<!--页脚版权-->
<div class="footer">
    <div class="footer-content">
        <span>Copyright © 2016-2017  图书管理系统</span>
    </div>
</div>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/index.js"></script>
</body>
</html>
