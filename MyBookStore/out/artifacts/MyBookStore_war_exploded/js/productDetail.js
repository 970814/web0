/**
 * Created by 明明 on 2016/12/13.
 */
var $tabLi = $('.tab ul li');
var $picImg = $('.pic img');
var $tabLiImg = $('.tab li img');
var $picCover = $('.pic_cover');
var $cover = $('.cover');
var $show = $('.show');
var $discuss = $('#discuss');
var imgArr = [];
var index = 0;
init();
$discuss.click(function () {
    $('#barrage').slideDown('1500');
});
$('#close-barrage').click(function () {
    $('#barrage').slideUp('1500');
});

$('#barrage-send-btn').click(function () {
    var oInputText = $('#barrage-text-input').val();
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
