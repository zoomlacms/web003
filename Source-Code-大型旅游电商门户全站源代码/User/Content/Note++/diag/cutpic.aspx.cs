using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.BLL.Helper;
using ZoomLa.Common;

public partial class test_diag_cutpic : System.Web.UI.Page
{
    private string savePath = "/UploadFiles/User/cutpic/";
    public string ImgPath { get { return GetImgPath(IPath); } }
    public string IPath { get { return Request.QueryString["ipath"] ?? ""; } }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (function.isAjax())
        {
            string action = Request["action"];
            string vpath = Request["vpath"];
            string warning = "";
            string result = "";
            if (action.Equals("crop"))
            {
                int x1 = int.Parse(Request.Form["x1"]);
                int y1 = int.Parse(Request.Form["y1"]);
                int width = int.Parse(Request.Form["width"]);
                int height = int.Parse(Request.Form["height"]);
                savePath += (function.GetRandomString(4) + Path.GetFileName(vpath));
                result = ImageDealLib.imgcrop(vpath, savePath, x1, y1, width, height, ImageDealLib.FileCache.Save, out warning);
            }
            Response.Clear(); Response.Write(result); Response.Flush(); Response.End();
        }
        if (!IsPostBack)
        {
            if (!Directory.Exists(Server.MapPath(savePath))) { Directory.CreateDirectory(Server.MapPath(savePath)); }
            if (string.IsNullOrEmpty(IPath)) { function.WriteErrMsg("未指定图片路径"); }
            using (FileStream fs = new FileStream(Server.MapPath(ImgPath), FileMode.Open, FileAccess.Read))
            {
                System.Drawing.Image image = System.Drawing.Image.FromStream(fs);
                int width = image.Width;
                int height = image.Height;
                wrap_div.Style.Add("width", width + "px");
                wrap_div.Style.Add("height", height + "px");
            }
        }
    }
    //只允许处理/uploadfiles/user/目录下的图片
    private string GetImgPath(string url) 
    {
        return SafeSC.PathDeal("/UploadFiles/User/" + IPath.ToLower().Replace("/uploadfiles/user/", ""));
    }
}