/*用于放置公用的控件方法,JSON*/
var Control = {
    EnableEnter: function () {//回车插件,过滤不可见控件
        $("input[data-enter]").keydown(function () {
            if (event.keyCode == 13) {
                var flag = false;
                var code = $(this).data("enter");
                var $arr = $("[data-enter]:visible").sort(function (a, b) { return $(a).data("enter") - $(b).data("enter") });
                var $next = null;
                for (var i = 0; i < $arr.length; i++) {
                    if ($($arr[i]).data("enter") > code) {
                        $next = $($arr[i]); break;
                    }
                }
                if ($next == null || $next.length < 0) return false;
                switch ($next.attr("type")) {
                    case "button":
                        $next.trigger("click").focus();
                        break;
                    case "submit"://有Bug,会提交两镒
                        flag = true;
                        break;
                    default:
                        $next.focus();
                        break;
                }
                return flag;
            }
        });//EnableEnter End;
    }
}
Control.Scroll = {
    ToTop: function () {
        function setScollTop() {
            if ($(window).scrollTop() > 1) {
                $(window).scrollTop($(window).scrollTop() - 30);
                setTimeout(setScollTop, 1);
            }
        }
        setTimeout(setScollTop, 1);
    },
    ToBottom: function () {
        function setScollDown() {
            var top = $(window).scrollTop();
            $(window).scrollTop($(window).scrollTop() + 30);
            if (top != $(window).scrollTop())
                setTimeout(setScollDown, 1);
        }
        setTimeout(setScollDown, 1);
    }
}
Control.Mobile = {
    SendVaildMsg: function (btnid,codeid,hcodeid,mobile) {//发送短信验证码
        var $btnobj = $("#" + btnid);//按钮对象
        var $codeobj = $("#" + codeid);//验证码输入框对象
        var $hcodeobj = $("#" + hcodeid);//验证码隐藏值对象
        $btnobj.attr("disabled", "disabled");
        $.post("/API/MobileMsg.ashx", { action: "SendVailMsg", code: $codeobj.val(),hcode:$hcodeobj.val(), mobile: mobile }, function (data) {
            if (data == "1"||data=="发送成功！") {
                alert("验证码已发送至您的手机,请您验收!");
                var sendminute = 60;//计时
                var sendtimeflag = setInterval(function () {
                    sendminute--;
                    $btnobj.text("(" + sendminute + "秒后)重发验证码");
                    if (sendminute <= 0) {//时间到
                        $btnobj.text("重发验证码");
                        $btnobj.removeAttr("disabled");
                        sendminute = 60;
                        clearInterval(sendtimeflag);
                    }
                }, 1000);
            } else {
                alert("发送失败!详情:" + data);
                $btnobj.removeAttr("disabled");
            }
        })
    }
}