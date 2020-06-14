using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Components;
using ZoomLa.Model;

public partial class Guest_Baike_BKEditor : System.Web.UI.Page
{
    M_Baike bkMod = new M_Baike();
    B_User buser = new B_User();
    B_Baike bkBll = new B_Baike();
    private string Tittle { get { return HttpUtility.UrlDecode((Request.QueryString["tittle"] ?? "")).Replace(" ",""); } }
    //传入ID才可修改最新词条
    private int Mid { get { return DataConverter.CLng(Request.QueryString["id"]); } }
    protected void Page_Load(object sender, EventArgs e)
    {
        B_User.CheckIsLogged(Request.RawUrl);
        if (!IsPostBack)
        {
            M_UserInfo mu = buser.GetLogin();
            //是否限定创建权限,用户所在组是否拥有创建权限
            if (!string.IsNullOrEmpty(GuestConfig.GuestOption.BKOption.CreateBKGroup))
            {
                if (!("," + GuestConfig.GuestOption.BKOption.CreateBKGroup + ",").Contains("," + mu.GroupID + ",")) { function.WriteErrMsg("您没有创建词条的权限!"); }
            }
            MyBind();
        }
    }
    private void MyBind()
    {
        bkMod = bkBll.SelReturnModel(Mid);
        bke_title.InnerText = Tittle;
        if (Mid > 0)
        {
            bke_title.InnerText = bkMod.Tittle;
            Contents_T.Text = bkMod.Contents;
            Brief_T.Text = bkMod.Brief;
            //Contents_T.Text = SafeSC.ReadFileStr("/Test/content.txt");
            pic_img.Src = bkMod.BriefImg;
            info_hid.Value = bkMod.Extend;
            class_hid.Value = bkMod.Classification;
            class_sp.InnerText = "(" + bkMod.Classification + ")";
            refence_hid.Value = bkMod.Reference;
            BType_T.Text = bkMod.Btype;
        }
        else { if (string.IsNullOrEmpty(Tittle)) { function.WriteErrMsg("未指定词条标题"); } }
    }
    protected void Save_Btn_Click(object sender, EventArgs e)
    {
        M_UserInfo mu = buser.GetLogin();
        if (Mid > 0) { bkMod = bkBll.SelReturnModel(Mid); }
        bkMod.Contents = Contents_T.Text;
        bkMod.Brief = Brief_T.Text;
        bkMod.BriefImg = pic_hid.Value;
        bkMod.Extend = info_hid.Value;
        bkMod.Reference = refence_hid.Value;
        bkMod.UpdateTime = DateTime.Now;
        bkMod.Classification = class_hid.Value;
        bkMod.Editnumb++;
        bkMod.Btype = BType_T.Text.Replace(" ", "");
        if (bkMod.ID > 0) { bkBll.UpdateByID(bkMod); }
        else
        {
            bkMod.Status = 1;
            bkMod.UserId = mu.UserID;
            bkMod.UserName = mu.UserName;
            bkMod.Tittle = Tittle;
            bkMod.ID = bkBll.insert(bkMod);
        }
        function.WriteSuccessMsg("词条操作完成","Details.aspx?ID="+bkMod.ID);
    }
}