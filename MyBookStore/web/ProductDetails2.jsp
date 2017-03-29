<%@ page import="java.io.File" %>
<%@ page import="data.Book" %>
<%@ page import="static db.MysqlDB.findBookById" %>
<%@ page import="static data.RandomData.random" %>
<%@ page import="javax.swing.*" %>
<%@ page import="java.util.Queue" %>
<%@ page import="db.MysqlDB" %>
<%@ page import="static db.MysqlDB.getAllComments" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="static db.MysqlDB.randomInsertComment" %>
<%@ page import="static db.MysqlDB.*" %>
<%@ page import="servlet.Login" %>
<%@ page import="static servlet.Login.lastUser" %><%--
  Created by IntelliJ IDEA.
  User: L
  Date: 2016/12/19
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<<html lang="en">
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
        request.getSession().setAttribute("book", book);
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
        <form action="Buy" method="get">
            <div>
                <span>类别:</span>
                <%=
                book.type
                %>
            </div>
            <div>
                <span>出版时间:</span>
                <%=
                book.getPublishTime()
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
                <span>书币</span>
            </div>
            <div class="counter">
                <span>数量：</span>
                <div class="box">
                    <input type="number" value="1" name="buyNumber" id="counter-number" min="1">
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
        <div id="barrage-switch">
            <span>弹幕</span>
            <p style="width: 100%;height: 25px;display: inline;text-align: left">
                <span id="open" style="display: inline;padding-left: 10px">On</span>
                <span id="close" style="display: none;padding-left: 50px">Off</span>
            </p>
        </div>
    </div>
</div>
<form id="send-barrage">
    <input type="text" name="barrage-text" class="barrage-text-input" id="barrage-text-input">
    <!--弹幕发送按钮-->
    <input type="button" value="发送" id="barrage-send-btn">
</form>
<!--弹幕区-->
<div id="barrage">
    <!--弹幕显示区-->
    <div class="barrage-wrap">

    </div>
</div>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
    $('#barrage-send-btn').click(function () {
        var oInputText = $('#barrage-text-input').val();


        var  URL =<%String userId ="";if (lastUser!=null){userId = lastUser.id+"";}
         out.println("'Send?bookId="+id+"&userId="+userId+"&data='+");
                %>oInputText;

        $.ajax({
            type:"POST",
            url:URL,
            data:null,
            dataType:"html",
            success:function () {

            }
        });

        var _label = $("<div class='barrage-see-text'>" + oInputText + "</div>");
        $("#barrage .barrage-wrap").append(_label);
        maskContentStyle();
    });
    function maskContentStyle() {
        var _top = 0;
        $("#barrage .barrage-wrap").find("div").each(function () {
            var _left = $(".barrage-wrap").width() - $(this).width();
            var _height = $(".barrage-wrap").height();
            _top += 40;
            if (_top > _height - 100) {
                _top = 0;
            }
            $(this).css({left: _left, top: _top, color: randomColor()});
            $(this).animate({left: "-" + _left + "px"}, 10000, function () {
                $(this).remove();
            });
        });
    }

    function randomColor() {
        var r = Math.floor(Math.random() * 256);
        var g = Math.floor(Math.random() * 256);
        var b = Math.floor(Math.random() * 256);
        return "rgb(" + r + "," + g + "," + b + ")";
    }

    var a = 0;
    $('#discuss').click(function () {
        if (a == 0) {
            $('#send-barrage').slideDown();
            a = 1;
            return;
        }
        if (a == 1) {
            $('#send-barrage').slideUp();
            a = 0;
            return
        }
    });
    var barrage_open_close = 0;
    $('#barrage-switch').click(function () {
        if (barrage_open_close == 1) {
            $('#open').css("display", "inline");
            $('#close').css("display", "none");
            barrage_open_close = 0;
            $('#barrage').hide();
            return;
        }
        if (barrage_open_close == 0) {
            $('#close').css("display", "inline");
            $('#open').css("display", "none");
            barrage_open_close = 1;
            $('#barrage').show();
            $.ajax({
                type:"POST",
                url:"",
                data:null,
                dataType:"html",
                success:function () {
                    <%

                        Queue<String> msgs =getAllComments(book.id+"");
                        while (!msgs.isEmpty()){
                            out.println("$(\"#barrage .barrage-wrap\").append($(\"<div class='barrage-see-text'>\"+\"" + msgs.poll()+ "\"+\"</div>\"))");
                            out.println("maskContentStyle()");

                        }











                    %>
                }
            });
            return;
        }
    });

    var $tabLi = $('.tab ul li');
    var $picImg = $('.pic img');
    var $tabLiImg = $('.tab li img');
    var $picCover = $('.pic_cover');
    var $cover = $('.cover');
    var $show = $('.show');
    var imgArr = [];
    var index = 0;
    init();
    $tabLi.hover(function () {
        index = $(this).index();
        $(this).addClass('on').siblings().removeClass('on');
        var src = $(this).find('img').prop('src');
        $show.css('backgroundImage', 'url(' + src + ')');
        $picImg.prop({
            src: src,
            width: imgArr[index].width * 400,
            height: imgArr[index].height * 400
        });
        $picCover.css({
            top: (400 - imgArr[index].height * 400 ) / 2,
            left: (400 - imgArr[index].width * 400 ) / 2
        });
        var a = 400 * $picCover.width() / imgArr[index].imgW + 'px';
        $cover.css({
            width: a,
            height: a
        });
    });

    $picCover.mousemove(function (ev) {
        $cover.show();
        $show.show();
        var pX = ev.pageX,
                pY = ev.pageY;
        var picCoverX = $picCover.offset().left,
                picCoverY = $picCover.offset().top;
        var minusX = pX - picCoverX - $cover.width() / 2,
                minusY = pY - picCoverY - $cover.height() / 2;
        minusX = Math.max(minusX, 0);
        minusX = Math.min(minusX, $picCover.width() - $cover.width());
        minusY = Math.max(minusY, 0);
        minusY = Math.min(minusY, $picCover.height() - $cover.height());
        $cover.css({
            left: minusX + 'px',
            top: minusY + 'px'
        });
        $show.css('backgroundPosition', (-(minusX / $picCover.width()) * imgArr[index].imgW) + 'px ' + (-(minusY / $picCover.height()) * imgArr[index].imgH) + 'px');
    }).mouseleave(function () {
        $cover.hide();
        $show.hide();
    });
    $show.mouseover(function () {
        $cover.hide();
        $(this).hide();
    }).mousemove(function () {
        return false;
    });
    function init() {
        $tabLiImg.each(function (i) {
            var imgWidth = $(this).width();
            var imgHeight = $(this).height();
            if (imgWidth >= imgHeight) {
                $(this).prop({
                    width: 50,
                    height: 50 / imgWidth * imgHeight
                });
                $(this).css({
                    top: (50 - 50 / imgWidth * imgHeight) / 2 + 'px'
                });
                imgArr[i] = {width: 1, height: imgHeight / imgWidth, imgW: imgWidth, imgH: imgHeight};
            } else {
                $(this).prop({
                    width: 50 / imgHeight * imgWidth,
                    height: 50
                });
                $(this).css({
                    left: (50 - 50 / imgHeight * imgWidth) / 2 + 'px'
                });
                imgArr[i] = {width: imgWidth / imgHeight, height: 1, imgW: imgWidth, imgH: imgHeight};
            }
            ;
            $(this).show();
        });
    }
    ;


</script>
</body>
</html>