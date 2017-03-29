<%@ page import="data.Book" %>
<%@ page import="data.DataManager" %>
<%@ page import="static data.DataManager.findBookByName" %>
<%@ page import="java.io.File" %>
<%@ page import="static data.RandomData.random" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="db.MysqlDB" %>
<%@ page import="static db.MysqlDB.findBookById" %>
<%@ page import="javax.swing.*" %><%--
  Created by IntelliJ IDEA.
  User: pc
  Date: 2016/12/16
  Time: 19:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>图书商城--商品详情</title>
    <meta name="author" content="饭饭">
    <link href="images/logo.ico" rel="shortcut icon" type="image/x-icon"/>
    <link href="css/productDetails.css" rel="stylesheet" type='text/css'/>
</head>
<body>

<div class="content">
    <!--图片区-->

    <%
        String id = request.getParameter("id");
        Book book = findBookById(id);
        StringBuilder builder = new StringBuilder();
        int which = random.nextInt(10) + 1;
        builder.append("<div id=\"wrap\">")
                .append("<div class=\"pic\">")
                .append("<div class=\"pic_cover\">")
                .append("<img src=\"images/")
                .append(book.type.toString())//book type
                .append("/")
                .append(which)
                .append("/1.jpg\" width=\"400\" height=\"400\"/>")
                .append("<div class=\"cover\"></div>")
                .append("<div class=\"show\"></div>")
                .append("</div>")
                .append("</div>");
        builder.append("<div class=\"tab\">")
                .append(" <ul>")
                .append("<li class=\"on\"><img src=\"images/")
                .append(book.type.toString())
                .append("/")
                .append(which)
                .append("/1.jpg\"/></li>");
//        JOptionPane.showMessageDialog(null, new File("images/" + book.type.toString() + "/" + which + "/").getAbsolutePath());
        File[] files = new File("images/" + book.type.toString() + "/" + which + "/").listFiles();
        for (int i = 1; i < files.length; i++) {
            builder.append("<li><img src=\"")
                    .append(files[i].toString())
                    .append("\"/></li>");
        }
        builder.append("</ul>")
                .append("</div>")
                .append("</div>");
        out.println(builder);
    %>





    <!--购买区-->
    <div id="list">
        <form>
            <div>
                <span>类别:</span>
                <%=
                book.type
                %>
            </div>
            <div>
                <span>出版时间:</span>
                <%=
                book.publishTime
                %>
            </div>
            <div>
                <span>出版社:</span>
                <%=
                book.src
                %>
            </div>
            <div>
                <span>作者:</span>
                <%=
                    book.author
                %>
            </div>
            <div>
                <span>库存:</span>
                <%=
                    book.number
                %>
            </div>
            <div>
                <span>书名:</span>
                <%=
                    book.name
                %>
            </div>
            <div class="price">
                <span>价格:</span>
                <%=
                book.getPrice()
                %>
            </div>
            <div class="counter">
                <span>数量：</span>
                <div class="box">
                    <input type="number" value="1" name="counter-number" id="counter-number" min="1">
                </div>
            </div>
            <div class="pay">
                <input type="submit" value="购买" id="pay-btn"/>
            </div>
        </form>

    </div>
    <!--评论区-->
    <div id="slide-bar">
        <a href="javascript:;" id="discuss">评论</a>
    </div>
</div>
<!--弹幕区-->
<div id="barrage">
    <!--关闭按钮-->
    <span id="close-barrage">×</span>
    <!--弹幕显示区-->
    <div class="barrage-wrap">

    </div>
    <!--弹幕内容-->
    <div class="discuss-text-content">
        <form>
            <!--输入内容-->
            <input type="text" name="barrage-text" class="barrage-text-input" id="barrage-text-input">
            <!--弹幕发送按钮-->
            <input type="button" value="发送" id="barrage-send-btn">
        </form>
    </div>
</div>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/productDetail.js" type="text/javascript"></script>
</body>
</html>
