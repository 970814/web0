/**
 * Created by computer on 2016/11/29.
 */
$('.slide-bar ul li').click(function () {
    var index = $(this).index();
    var _top = $('.floor').eq(index).offset().top;
    $('html,body').animate({'scrollTop': (_top - 50 )}, 1000);
});
$('#returnTop').unbind("click");
$(window).scroll(function () {
    var Top = $(window).scrollTop();

    $('.floor').each(function (i) {
        if (Top >= $(this).offset().top) {
            if (i == 0) {
                $('.slide-bar ul li').eq(i).addClass('curse').siblings().removeClass('curse');
            }
            $('.slide-bar ul li').eq(i + 1).addClass('curse').siblings().removeClass('curse');
        }
    });
    if (Top > 100) {
        $('.slide-bar').show();
    } else {
        $('.slide-bar').hide();
    }
});
function play(x) {
    var l_wid = 900 / x;
    var a_html = "", t_css = "", z = 0;
    for (var i = 0; i < x; i++) {
        if (i > x / 2) {
            z--;
        } else {
            z++;
        }
        a_html += "<li>" +
            "				<span class='s1'></span>" +
            "				<span class='s2'></span>" +
            "				<span class='s3'></span>" +
            "				<span class='s4'></span>" +
            "		</li>";
        t_css += "li:nth-child(" + (i + 1) + "){transition:1s " + (i * 0.05) + "s all;z-index:" + z + ";}#pic_ul li:nth-child(" + (i + 1) + ") span{background-position:" + (-l_wid * i) + "px;}"
    }
    $("#css").append("#pic_ul li{width:" + l_wid + "px;}#pic_ul li span{width:" + l_wid + "px;}" + t_css);
    $("#pic_ul").append(a_html);
}
var time;
play(20);
$("ol li").click(function () {
    var a = $(this).index();
    var b = -a * 90 + "deg";
    $("#pic_ul").find("li").css("transform", "translateZ(-180px) rotateX(" + b + ")");
});
time = setInterval("setTime()", 4000);
var this_index = 0;
function setTime() {
    if (this_index > $("ol li").length) {
        this_index = 1;
    }
    var b = -this_index * 90 + "deg";
    $("#pic_ul").find("li").css("transform", "translateZ(-180px) rotateX(" + b + ")");
    this_index++;
}

$(".box").hover(function () {
    clearInterval(time);
}, function () {
    time = setInterval("setTime()", 4000);
});


var cli = 0;
$("#polling").click(function () {

    if (cli == 0) {
        $(".right-slider-bar").animate({right: '0px'}, 1000);
        $("#form").animate({right: '85px'}, 1700);
        $("#polling").html("收回")
        cli = 1;
        return;
    }
    if (cli == 1) {
        $(".right-slider-bar").animate({right: '-780px'}, 1000);
        $("#form").animate({right: '-600px'}, 700);
        $("#polling").html("查询")
        cli = 0;
        return;
    }
});