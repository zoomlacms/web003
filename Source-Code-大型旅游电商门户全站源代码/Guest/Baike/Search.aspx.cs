using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Model;
using System.Data;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using ZoomLa.Common;

//支持词条名搜索,支持词条标签搜索
public partial class Guestbook_BkSearch : System.Web.UI.Page
{
    B_Baike bkBll = new B_Baike();
    B_User buser = new B_User();
    public string Tittle { get { return Server.UrlDecode(Request.QueryString["tittle"]); } }
    public string BType { get { return Server.UrlDecode(Request.QueryString["BType"]); } }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MyBind();
        }
    }
    private void MyBind() 
    {
        DataTable dt = bkBll.SelByInfo(Tittle, BType);
        if (!string.IsNullOrEmpty(Tittle))
        {
            if (dt.Rows.Count < 1)
            {
                lblTittle.Text = "<div>逐浪百科尚未收录词条\"<font color='red'>" + Tittle + "</font>\"，也未找到相关词条。<br/>欢迎您来创建，与广大网友分享关于该词条的信息。<a href='BKEditor.aspx?tittle=" + Tittle + "'><font color='blue'>我来创建</font></a></div>";
            }
        }
        else if(!string.IsNullOrEmpty(BType))
        {
            if (dt.Rows.Count < 1)
            {
                lblTittle.Text = "<div>逐浪百科尚未收录词条<br/>欢迎您来创建，与广大网友分享各种词条的信息。</div>";
            }
        }
        else
        {
            function.WriteErrMsg("未输入查询条件");
        }
        repSearch.DataSource = dt;
        repSearch.DataBind();
    }
    protected string getstyle()
    {
        if (buser.CheckLogin())
        {
            return "display:inline-table";
        }
        else return "display:none";
    }
    protected string getstyles()
    {
        if (buser.CheckLogin())
        {
            return "display:none";
        }
        else return "display:inline-table";
    }
}