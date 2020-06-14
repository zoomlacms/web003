using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.Model;
using ZoomLa.BLL;
using System.Data;
using ZoomLa.BLL.Message;
using ZoomLa.Model.Message;
using ZoomLa.SQLDAL;
using System.Data.SqlClient;
using ZoomLa.Common;

public partial class Guestbook_BkDetails : System.Web.UI.Page
{
    B_Baike bkBll = new B_Baike();
    B_BaikeEdit editBll = new B_BaikeEdit();
    M_BaikeEdit medit = new M_BaikeEdit();
    B_User b_User = new B_User();
    B_Admin badmin = new B_Admin();
    public int Mid { get { return DataConvert.CLng(Request.QueryString["id"]); } }
    public int EditID { get { return DataConvert.CLng(Request.QueryString["editid"]); } }
    public string Tittle { get { return Request.QueryString["Tittle"] ?? ""; } }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MyBind();
        }
    }
    protected void MyBind()
    {
        M_Baike bkMod = bkBll.SelReturnModel(Mid);
        if (bkMod == null) { function.WriteErrMsg("该词条不存在!"); }
        M_BaikeEdit editMod =new M_BaikeEdit();
        if (EditID>0)//版本预览模式(指定一个版本记录的id查看详情)
        {
            editMod = editBll.SelReturnModel(EditID);
            if (editMod == null) { function.WriteErrMsg("该词条不存在或审核未通过!"); }
            if (b_User.GetLogin().UserID != editMod.UserId && !badmin.CheckLogin()) { function.WriteErrMsg("您没有权限查看此词条信息!"); }
        }
        Contents_div.InnerHtml = bkMod.Contents;
        tittle_sp.InnerText = bkMod.Tittle;
        cate_sp.InnerText = "( " + bkMod.Classification + " )";
        Brief_L.Text = bkMod.Brief;
        if (string.IsNullOrEmpty(bkMod.BriefImg)) { pic_div.Visible = false; }
        else { pic_img.Src = bkMod.BriefImg; }
        info_hid.Value = bkMod.Extend;
        refence_hid.Value = bkMod.Reference;
        //词条标签
        string[] btypeArr = bkMod.Btype.Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
        foreach (string item in btypeArr)
        {
            BType_L.Text += "<a href='/Guest/Baike/Search.aspx?btype=" + HttpUtility.UrlEncode(item) + "' class='btype_a' target='_blank'>" + item + "</a>";
        }
    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        Response.Redirect("BKEditor.aspx?ID=" + Mid);
    }

    //收藏模块后期处理
    protected void lbtFavorite_Click(object sender, EventArgs e)
    {
        M_Baike bkMod = bkBll.SelByTittle(Tittle);
        //DataTable dt1 = SqlHelper.ExecuteTable(CommandType.Text, "select * from ZL_Favorite where Owner=" + b_User.GetLogin().UserID + "and FavoriType=4 and InfoID=" + bkMod.ID, null);
        //if (dt1.Rows.Count > 0)
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('收藏失败，已收藏该词条！');</script>");
        //    return;
        //}
        //int flag = SqlHelper.ExecuteNonQuery(CommandType.Text, "insert into ZL_Favorite values('" + muser.UserID + "','" + bkMod.ID + "','" + DateTime.Now.ToString() + "','4','/Guest/Baike/Details.aspx?soure=manager&tittle=@key','')", sp);
        //if (flag == 1)
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('收藏成功！');</script>");
        //}
        //else
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('收藏失败，请重试！');</script>");
        //}
    }
    protected string getstyle()
    {
        if (b_User.CheckLogin())
        {
            return "display:inherit";
        }
        else return "display:none";
    }
    protected string getstyles()
    {
        if (b_User.CheckLogin())
        {
            return "display:none";
        }
        else return "display:inherit";
    }
}