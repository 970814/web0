<%@ page import="db.MysqlDB" %>
<%@ page import="static db.MysqlDB.search" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="data.BookType" %>
<%@ page import="data.Book" %>
<%@ page import="static data.RandomData.random" %>
<%@ page import="javax.swing.*" %><%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2016/12/18
  Time: 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>图书商城--图书查询结果</title>
    <meta name="author" content="饭饭">
    <meta name="keywords" content="关键字，关键词">
    <meta name="description" content="描述信息">
    <link href="css/searchResult.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
//    name=&src=&author=&type=&minPrice=&maxPrice=&startTime=&endTime=&sort=price&order=up
%>
<div class="wrap">
    <div class="content">
    <%
        String name = request.getParameter("name");
        String src = request.getParameter("src");
        String author = request.getParameter("author");
        String type = request.getParameter("type");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String sort = request.getParameter("sort");
        String order = request.getParameter("order");
        ResultSet set = null;
        int count = 0;
        StringBuilder builder = new StringBuilder();
        try {
            set = search(name, src, author, type, minPrice, maxPrice, startTime, endTime, sort, order);
            while (set.next()) {
                String id = set.getString(1);
                name = set.getString(2);
                double price = Double.parseDouble(set.getString(3));
                int number = Integer.parseInt(set.getString(4));
                BookType bookType = BookType.valueOf(set.getString(5));
                author = set.getString(6);
                src = set.getString(7);
                String publishTime = set.getString(8);
                Book book = new Book(Integer.parseInt(id), name, price, number, bookType, author, src, publishTime);
                int which = random.nextInt(10) + 1;
                String url = "ProductDetails2.jsp?id=" + book.id;
                builder.append("<div class=\"book-result\">")
                        .append("<a href=\"")
                        .append(url)
                        .append("\">")
                        .append("<img src=\"images/")
                        .append(book.type).append("/").append(which).append(".jpg")
                        .append("\" alt=\"暂无相关书籍图片信息\">")
                        .append("</a>")
                        .append("<p class=\"book-name\">")
                        .append("<a href=\"")
                        .append(url)
                        .append("\">")
                        .append(book.name)
                        .append("</a>")
                        .append("</p>")
                        .append("<p class=\"book-price\">")
                        .append("<span>￥")
                        .append(book.getPrice())
                        .append("</span>")
                        .append("</p>")
                        .append("<p class=\"book-buy\">")
                        .append("<a href=\"")
                        .append(url)
                        .append("\">订购</a>")
                        .append("</p>")
                        .append("</div>");
                count++;
            }
        } catch (Throwable e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
            e.printStackTrace();
        }
    %>

        <h2>共搜索到相关书籍<span id="book-count">  <%=count%> </span>本</h2>

        <%
            out.println(builder);
            try {
                set.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>
</div>
<script type="text/javascript">

</script>
</body>
</html>
