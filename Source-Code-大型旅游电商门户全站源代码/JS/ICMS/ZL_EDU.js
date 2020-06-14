//排课系统JS
//var tdTlp = "<td class='item' data-time='@time' data-day='@day'  data-num='@num'><div class='itemhead'><span class='glyphicon glyphicon-cog bantd' title='禁用|启用'></span></div><textarea class='content'></textarea></td>";
var tdTlp = "<td class='item' data-time='@time' data-day='@day' data-num='@num'></td>";
//--------------数组
function GetItem(arr, $td) {
    if (!arr || arr.length < 1) return;
    for (var i = 0; i < arr.length; i++) {
        if (arr[i].time == $td.data("time") && arr[i].day == $td.data("day") && arr[i].num == $td.data("num"))
        { return arr[i]; }
    }
}
function InitTable() {
    table.html("");
    config = JSON.parse($("#Json_Hid").val());
    config.items = JSON.parse(config.items);
    for (var i = 0; i < config.premoning; i++) {
        var html = "";
        if (i == 0) {
            html = '<tr><td class="flag_td" rowspan="' + config.premoning + '">早读</td>';
        }
        else { html = '<tr>'; }
        for (var j = 0; j < config.weekday; j++) {
            html += tdTlp.replace("@time", "premoning").replace("@num", (i + 1)).replace("@day", (j + 1));
        }
        html += "</tr>";
        table.append(html);
    }
    for (var i = 0; i < config.moring; i++) {
        var html = "";
        //左方时间标识
        if (i == 0) {
            html = '<tr><td class="flag_td" rowspan="' + config.moring + '">上午</td>';
        }
        else { html = '<tr>'; }
        //生成横列
        for (var j = 0; j < config.weekday; j++) {
            html += tdTlp.replace("@time", "moring").replace("@num", (i + 1)).replace("@day", (j + 1));
        }
        html += "</tr>";
        table.append(html);
    }
    //午休,需要多增加一列
    table.append('<tr><td style="background-color:#d9edf7;text-align:center;height:30px;line-height:30px;" colspan="' + (config.weekday+1) + '">午  休</td></tr>');
    for (var i = 0; i < config.afternoon; i++) {
        var html = "";
        if (i == 0) {
            html = '<tr><td class="flag_td" rowspan="' + config.afternoon + '">下午</td>';
        }
        else { html = '<tr>'; }
        for (var j = 0; j < config.weekday; j++) {
            html += tdTlp.replace("@time", "afternoon").replace("@num", (i + 1)).replace("@day", (j + 1));
        }
        html += "</tr>";
        table.append(html);
    }
    for (var i = 0; i < config.evening; i++) {
        var html = "";
        if (i == 0) {
            html = '<tr><td class="flag_td" rowspan="' + config.afternoon + '">晚自习</td>';
        }
        else { html = '<tr>'; }
        for (var j = 0; j < config.weekday; j++) {
            html += tdTlp.replace("@time", "evening").replace("@num", (i + 1)).replace("@day", (j + 1));
        }
        html += "</tr>";
        table.append(html);
    }
    HideTBColumn(config.weekday);
    var oldpop = null;
    //绑定事件
    table.find(".item").click(function () {
        $this = $(this);
        //禁止修改
        if ($("#BanEdit_Hid").val() == "1") { return false; }
        //忽略此次点击(空白)
        if ($this.hasClass("ignore")) { $this.removeClass("ignore"); return; }
        if ($this.hasClass("active")) {  return; }
        table.find(".item").removeClass("active");
        $this.addClass("active");
        //table.find(".item").popover("destory");
        //隐去其他
        if (oldpop != null) { oldpop.popover("hide"); }
        var btn = $("<a class='pop_btn'>");
        oldpop = btn;
        //----开始显示,用一个超链接附载,不能直接附,否则会造成表格错乱
        btn.popover({
            trigger: 'manual',
            placement: 'top',
            html: true,
            content: subject_html
        });
        $this.append(btn);
        btn.popover('show');
        $("#subject_tb tr .custom_btn").click(function () {
            $("#custom_div").show();
        });
        $("#addCustom_btn").click(function () {
            addToTable($("#Subject_T").val());
        });
        $("#subject_tb tr td:not(.noclick)").click(function () {
            //-----执行
            var $this = $(this);
            addToTable($this.text());
        });
    });
    var addToTable = function (text) {
        var $td = getCurSelected();
        var color = "";
        switch ($td.data("day")) {
            case 1:
                color = "#8577FA";
                break;
            case 2:
                color = "#D7CA3A";
                break;
            case 3:
                color = "#40AAFF";
                break;
            case 4:
                color = "#42D2A8";
                break;
            case 5:
                color = "#73C3EC";
                break;
            case 6:
                color = "#A9D338";
                break;
            case 7:
                color = "#E9A582";
                break;
            default:
                alert("星期数据不正确");
                break;
        }
        switch (text) {
            case "空白":
                $td.css("background-color", "");               
                $td.text("");
                break;
            default:
                $td.css("background-color", color);
                $td.text(text);
                break;
        }
        $td.addClass("ignore");
        $td.removeClass("active");
        $("#custom_div").hide();
    }
    //获取当前需要添加的位置
    var getCurSelected = function () { return $("#courseTable").find(".active:first"); }
    //===============================================
    table.find(".item").each(function () {
        var $td = $(this);
        var model = GetItem(config.items, $td);
        if (model && model.text!="") {
            table.find(".item").removeClass("active");
            $td.addClass("active");
            addToTable(model.text);
            //$text = $td.find(".content");
            //$text.val(model.text);
            //if (model.disabled) {
            //    $text.addClass("disabled");
            //    $text[0].disabled = true;
            //    $text.val("不安排");
            //}
        }

    });
}
function UpdateConfig() {
    config.weekday = $("#WeekDay_DP").val();
    config.premoning = $("#PreMoning_DP").val();
    config.moring = $("#Moring_DP").val();
    config.afternoon = $("#Afternoon_DP").val();
    config.evening = $("#Evening_DP").val();
}
function Render() {
    SaveConfig();
    InitTable();
}
//读取其td配置,拼接为json
function SaveConfig() {
    UpdateConfig();
    var jsonArr = [];
    table.find(".item").each(function () {
        var jsontd = { time: "", day: "", num: "", disabled: "", text: "" };//时间,第几天,节数,是否禁用,自定义文本
        //$text = $(this).find(".content");
        //jsontd.disabled = $text.hasClass("disabled");
        var $td = $(this);
        jsontd.time = $td.data("time");
        jsontd.day = $td.data("day");
        jsontd.num = $td.data("num");
        jsontd.text = $(this).text();
        jsonArr.push(jsontd);
    });
    config.items = JSON.stringify(jsonArr);
    $("#Json_Hid").val(JSON.stringify(config));
    return true;
}
//--------------
//节次时间配置,单独页面,默认40分钟一节课
function ShowSetTime() {
    var diag = new ZL_Dialog();
    diag.title = "节次时间";
    diag.maxbtn = false;
    diag.width = 600;
    diag.url = "SetTime.aspx?m=" + config.moring + "&a=" + config.afternoon + "&e=" + config.evening;
    diag.ShowModal();
}
//--------------表格相关操作
function HideTBColumn(col) {
    $("#maintable thead td").show();
    $("#maintable thead td:gt(" + col + ")").hide();
    $("#maintable tr").each(function () {
        $(this).find("td:gt(" + col + ")").addClass("hid");
    });
}
//--------------
//返回一天的td
Array.prototype.GetDayItem = function (day) {
    var itemday = [];
    for (var i = 0; i < this.length; i++) {
        if (this[i].day == day) itemday.push(this[i]);
    }
    return itemday;
}

//--------------
var subject_html = "<div class=\"subject_div\" id=\"subject_div\">"
+ "<table class=\"table table-bordered\" style=\"color:#fff;\" id=\"subject_tb\">"
+ "<tr><td>语文</td><td>数学</td><td>英语</td><td>物理</td><td>化学</td><td>生物</td></tr>"
+ "<tr><td>地理</td><td>历史</td><td>政治</td><td>体育</td><td>科学</td><td>信息</td></tr>"
+ "<tr><td>美术</td><td>音乐</td><td>自习</td><td>空白</td><td colspan=\"2\" class=\"noclick custom_btn\"></td></tr>"
+ "</table>"
+ "<div id=\"custom_div\" class=\"input-group\">"
+ "<input type=\"text\" placeholder=\"科目名称\" id=\"Subject_T\" class=\"form-control\"  style=\"width:300px;\"/>"
+ "<span class=\"input-group-btn\">"
+ "<input value=\"确定\" id=\"addCustom_btn\" class=\"btn btn-default\" style=\"width:80px;\" />"
+ "</span>"
+ "</div>"
+ "</div>";