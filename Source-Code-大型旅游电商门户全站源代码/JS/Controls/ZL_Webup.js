/*
*需ZL_Common,ZL_Dialog
*未实现:预览功能
*使用Json方式,纯支持方式实现
*/
//附件操作JS,需ZL_Common.js,ZL_Dialog支持
//WUFile {name: "test.html", size: 76272, type: "text/html", lastModifiedDate: Thu Apr 16 2015 17:41:02 GMT+0800 (China Standard Time), id: "WU_FILE_0"…}
var MFileUP = function (option) {
    var ref = this;
    var def_config={ id: "uploader", hid: "Attach_Hid", json: { ashx: "action=General", pval: "", accept: "files" }, nametype: "all" }//divid,hiddenID,给上传控件的Json
    ref.config = $.extend(def_config, option);
    if (window.ZL_Dialog)
    { ref.attachDiag = new ZL_Dialog(); }
}
MFileUP.prototype.imgli = "<li data-name='@name'><p><img src='@src' /></p>"
                         + "<div class='file-panel' style='height: 0px;'><span class='cancel'>删除</span></div></li>";//图片li模板
MFileUP.prototype.divli = "<li data-name='@name'><div class='imgview'><div class='ext @ex'></div><div class='fname'>@fname</div></div><div class='file-panel' style='height: 0px;'><span class='cancel'>删除</span><a href='/PreView.aspx?vpath=@fsrc' target='_blank'><span class='prev'></span></a></div></li>";
MFileUP.prototype.onlyimgli="<li data-name='@name'><p><img src='@src' /></p>"
                         + "<div class='file-panel' style='height: 0px;'><a href='/Plat/Doc/DownFile.aspx?FName=@fsrc' target='_blank'><span class='down'></span></a><a href='/PreView.aspx?vpath=@fsrc' target='_blank'><span class='prev'></span></a></div></li>";
MFileUP.prototype.onlydivli = "<li data-name='@name'><div class='imgview'><div class='ext @ex'></div><div class='fname'>@fname</div></div><div class='file-panel' style='height: 0px;'><a href='/Plat/Doc/DownFile.aspx?FName=@fsrc' target='_blank'><span class='down'></span></a>"
                        + "<a href='/PreView.aspx?vpath=@fsrc' target='_blank'><span class='prev'></span></a></div></li>";
MFileUP.prototype.ShowFileUP = function () {
    var ref = this.constructor == Object ?this : ZL_Webup;
    ref.attachDiag.title = "文件上传";
    ref.attachDiag.reload = true;
    ref.attachDiag.backdrop = true;
    ref.attachDiag.maxbtn = false;
    ref.attachDiag.width = "width1100";//Blog
    ref.attachDiag.url = "/Plugins/WebUploader/WebUP.aspx?json=" + JSON.stringify(ref.config.json);//{\"ashx\":\"action=Blog\",\"pval\":\"\"}
    ref.attachDiag.ShowModal();
};
MFileUP.prototype.AddAttach = function (file, ret, pval) {
    var ref = this;
    $uploader = $("#" + ref.config.id);
    $hid = $("#" + ref.config.hid);
    var src = ret._raw;
    var imgli = ref.imgli;
    var divli = ref.divli;
    $uploader.show();
    var li = "", name = src;
    if (ref.config.nametype == "fname") {
        name = GetFname(src);
    }
    if (IsImage(src)) {
        var li = imgli.replace(/@src/, src).replace(/@name/, name).replace(/@fsrc/g, encodeURI(name));
    }
    else {
        var li = divli.replace("@ex", GetExName(src)).replace("@fname", GetFname(src, 6)).replace(/@name/, name).replace(/@fsrc/g, encodeURI(name));
    }
    $uploader.find(".filelist").append(li);
    if (ref.config.nametype == "all") {
        $hid.val($hid.val() + src + "|");
    }
    else if (ref.config.nametype == "fname") {
        $hid.val($hid.val() + GetFname(src, 0) + "|");//仅存文件名,用于防止用户随意指定图片
    }
    ref.BindAttachEvent();
    ref.attachDiag.CloseModal();
};
MFileUP.prototype.RemoveAttach = function (name) {
    var ref = this;
    $uploader = $("#" + ref.config.id);
    $hid = $("#" + ref.config.hid);
    var attctArr = $hid.val().split('|');
    var result = "";
    for (var i = 0; i < attctArr.length; i++) {
        if (attctArr[i] != name) {
            result += attctArr[i] + "|";
        }
    }
    result = result.replace("||", "|").trim("|");
    $hid.val(result);
    if ($uploader.find(".filelist li").length < 1) { $uploader.hide(); }
}
MFileUP.prototype.BindAttachEvent = function () {
    var ref = this;
    $uploader = $("#" + ref.config.id);
    $uploader.find(".filelist li").mouseenter(function () {
        $btns = $(this).find(".file-panel");
        $btns.stop().animate({ height: 30 });
    }).mouseleave(function () {
        $btns = $(this).find(".file-panel");
        $btns.stop().animate({ height: 0 });
    });
    $uploader.find(".filelist li .cancel").click(function () {
        $li = $(this).closest("li");
        ref.RemoveAttach($li.data("name"));
        $li.remove();
    });
};
MFileUP.prototype.AddReadOnlyLi = function (imgs) {
    var ref = this;
    $uploader = $("#" + ref.config.id);
    $hid = $("#" + ref.config.hid);
    for (var i = 0; i < imgs.split('|').length; i++) {
        var src = imgs.split('|')[i];
        var imgli = ref.onlyimgli;
        var divli = ref.onlydivli;
        $uploader.show();
        var li = "", name = GetFname(src);
        if (IsImage(src)) {
            var li = imgli.replace(/@src/g, src).replace(/@name/, name).replace(/@fsrc/g, encodeURI(src));
        }
        else {
            var li = divli.replace("@ex", GetExName(src)).replace("@fname", GetFname(src, 6)).replace(/@name/, name).replace(/@fsrc/g, encodeURI(src));
        }
        $uploader.find(".filelist").append(li);
    }
    ref.BindAttachEvent("preview");
}
var ZL_Webup = new MFileUP();
var SFileUP = {
    AjaxUpFile: function (fid,callback) {
        var formdata = new FormData();
        formdata.append("file", $("#" + fid)[0].files[0]);
        $.ajax({
            type: 'POST',
            url: '/Plugins/Uploadify/UploadFileHandler.ashx',
            data: formdata,
            processData: false,
            contentType: false,
            success: callback
        });
    },
    AjaxUpBase64:function(base64str,callback){
        $.post('/Plugins/Uploadify/Base64.ashx', { base64: base64str }, callback);
    },
    isWebImg: function (fname) {
        if (!fname || fname == "") { return false; }
        fname = fname.toLowerCase();
        if (fname.indexOf("data:image/") > -1)//base64
        {
            return true;
        }
        else if (fname.indexOf(".") > 0) {
            var start = fname.lastIndexOf(".");
            var ext = fname.substring((start + 1), fname.length);//jpg|png|gif
            return (ext == "jpg" || ext == "png" || ext == "gif"||ext=="jpeg")
        }
        else { return false; }
    }
}