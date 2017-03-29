/**
 * Created by computer on 2016/12/5.
 */
var email_reg = /^\w+@\w+\.\w+[(com)|(cn)]$/;
$('#J_Email').blur(function () {
    if (!email_reg.test($('#J_Email').val())) {
        $('#tips').html("请输入合法的邮箱地址");
        $('#J_Email').val("").focus();
        $('#tips').show();
    } else {
        $('#tips').hide();
    }
});

$('#drag').drag();
var _index = 0;
var ol = $('.wrap .steps ol li');
$('#J_BtnEmailForm').click(function () {

    if ($('.drag_text').html() != "验证通过") {
        $('#tips').html("验证码不正确，请重新输入");
        $('#tips').show();
        return;
    } else if (!email_reg.test($('#J_Email').val())) {
        $('#tips').html("请输入合法的邮箱地址");
        $('#J_Email').val("").focus();
        $('#tips').show();
    } else {
        var J_Email = $('#J_Email').val();
        _index++;
        ol.eq(_index).addClass('active');
        $('#l2').show();
        $('#l1').hide();
        $('.content').animate({height: '340px'});
    }
});
$('#J_BtnInfoForm').click(function () {


    if ($('#J_Password').val().length < 8 || $('#J_Password').val().length > 16) {
        $('#J_MsgInfoForm').show();
        $('#J_MsgInfoForm').html("密码长度不符合");
        return;
    }
    if ($('#J_RePassword').val() != ($("#J_Password").val())) {
        $('#J_MsgInfoForm').show();
        $('#J_MsgInfoForm').html("两次密码不一致");
        return;
    }

    if($('#J_Nick').val().trim().length <= 0){
        $('#J_MsgInfoForm').show();
        $('#J_MsgInfoForm').html("用户名必填");
        return;
    }
    if ($('#J_Password').val().length > 8 && $('#J_Password').val().length < 16 && $('#J_Nick').val().trim().length > 0) {
        $('#J_MsgInfoForm').hide();
        ol.eq(2).addClass('active');
        $('#l3').show();
        $('.content').animate({height: '280px'},1000);
        $('#l2').hide();

    }

});