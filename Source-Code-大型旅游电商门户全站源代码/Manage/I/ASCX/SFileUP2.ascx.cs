using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Model;
using ZoomLa.Common;
using ZoomLa.Components;
using System.IO;
using ZoomLa.BLL.Helper;
using System.Drawing;

public partial class Manage_I_ASCX_SFileUP2 : System.Web.UI.UserControl
{
    public enum FileType
    {
        Img, Office, All
    }
    [Browsable(true)]//FileUrl
    public string FileUrl
    {
        set { ViewState["FileUP_FileUrl"] = value; }
        get { return ViewState["FileUP_FileUrl"] == null ? "" : ViewState["FileUP_FileUrl"].ToString(); }
    }
    public string FName { get { return Path.GetFileName(FileUrl); } }
    private string[] exname = ".doc,.docx,.xls,.xlsx".Split(',');
    [Browsable(true)]   //img,office,all
    public FileType FType
    {
        get { return ViewState["FileUP_FType"] == null ? FileType.All : (FileType)Enum.Parse(typeof(FileType), ViewState["FileUP_FType"].ToString()); }
        set { ViewState["FileUP_FType"] = value; }
    }
    [Browsable(true)]
    public bool IsNull
    {
        get { return ViewState["FileUp_IsNull"] == null ? false : (bool)ViewState["FileUp_IsNull"]; }
        set { ViewState["FileUp_IsNull"] = value; }
    }
    //保存的路径
    [Browsable(false)]
    public string SaveUrl
    {
        get
        {
            if (ViewState["FileUP_SaveUrl"] == null)
            {
                ViewState["FileUP_SaveUrl"] = "/UploadFiles/Images/SingleF/";
            }
            return ViewState["FileUP_SaveUrl"].ToString();
        }
        set { ViewState["FileUP_SaveUrl"] = value; }
    }
    //是否启用等比例压缩(只适用于图片)
    [Browsable(true)]
    public bool IsCompress
    {
        get
        {
            if (ViewState["FileUP_IsCompress"] == null)
            {
                ViewState["FileUP_IsCompress"] = false;
            }
            return Convert.ToBoolean(ViewState["FileUP_IsCompress"].ToString());
        }
        set { ViewState["FileUP_IsCompress"] = value; }
    }
    [Browsable(true)]
    public int MaxWidth
    {
        get
        {
            if (ViewState["FileUP_MaxWidth"] == null)
            {
                ViewState["FileUP_MaxWidth"] = 0;
            }
            return Convert.ToInt32(ViewState["FileUP_MaxWidth"]);
        }
        set { ViewState["FileUP_MaxWidth"] = value; }
    }
    /// <summary>
    /// 是否以真实文件名存储(默认否)
    /// </summary>
    [Browsable(true)]
    public bool IsRelName
    {
        get
        {
            if (ViewState["FileUP_IsReName"] == null)
            {
                ViewState["FileUP_IsReName"] = false;
            }
            return Convert.ToBoolean(ViewState["FileUP_IsReName"].ToString());
        }
        set { ViewState["FileUP_IsReName"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            switch (FType)
            {
                case FileType.Img:
                    FileUp_File.Attributes.Add("accept", "image/x-png,image/gif,image/jpeg");
                    break;
                case FileType.Office:
                    FileUp_File.Attributes.Add("accept", "application/msexcel,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                    break;
                case FileType.All:
                    break;
                default:
                    break;
            }
        }
    }
    public string SaveFile()
    {
        if (string.IsNullOrEmpty(FVPath_T.Text) && !IsNull) { function.WriteErrMsg("请选择上传文件!"); }
        if (FileUp_File.HasFile)
        {
            string filename = function.GetFileName() + Path.GetExtension(FileUp_File.FileName);
            if (IsRelName) { filename = FileUp_File.FileName; }
            if (FType == FileType.Img && !SafeSC.IsImage(FileUp_File.FileName))
            {
                function.WriteErrMsg("必须上传图片格式的文件!");
            }
            if (FType == FileType.Img)
            {
                string vpath = "";
                ImgHelper imghelp = new ImgHelper();
                //if (IsCompress)//压缩与最大比只能有一个生效
                //{
                //    imghelp.CompressImg(FileUp_File.PostedFile, 1000, vpath);
                //}
                if (MaxWidth > 0)
                {
                    vpath = SafeSC.SaveFile(SaveUrl, FileUp_File, filename);
                    using (FileStream fs = new FileStream(Server.MapPath(vpath), FileMode.Open, FileAccess.Read))
                    {
                        System.Drawing.Image img = System.Drawing.Image.FromStream(fs);
                        double ImgPercent = (double)MaxWidth / (double)img.Width;
                        int width = (int)(img.Width * ImgPercent);
                        int height = (int)(img.Height * ImgPercent);
                        img.Dispose();
                        Bitmap bmp = imghelp.ZoomImg(vpath, height, width);
                        string cutedVPath = SaveUrl + function.GetRandomString(6) + Path.GetExtension(filename);
                        imghelp.SaveImg(cutedVPath, bmp);
                        FileUrl = cutedVPath; return FileUrl;
                    }
                }
            }
            if (FType == FileType.Office && !exname.Contains(Path.GetExtension(FileUp_File.FileName)))
                function.WriteErrMsg("必须上传office格式的文件!");
            FileUrl = SafeSC.SaveFile(SaveUrl, FileUp_File, filename);
            //FileUrl = SaveUrl + filename;
            //if (!Directory.Exists(function.VToP(SaveUrl))) { SafeSC.CreateDir(SaveUrl); }
            //if (!FileUp_File.SaveAs(FileUrl)) { function.WriteErrMsg(FileUp_File.ErrorMsg); }
        }
        return FileUrl;
    }

}