using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Model;

public partial class User_MobileReg : System.Web.UI.Page
{
    B_User buser = new B_User();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }
    protected void Sure_Btn_Click(object sender, EventArgs e)
    {
        string code = Session["Cur_MobileSafeCode"] == null ? "" : Session["Cur_MobileSafeCode"].ToString();
        if (string.IsNullOrEmpty(code)) { function.WriteErrMsg("验证码不存在"); }
        if (!code.Equals(VCode_T.Text)) { function.WriteErrMsg("验证码不正确"); }
        Session["Cur_MobileSafeCode"] = null;
        M_UserInfo mu = buser.GetLogin();
        M_Uinfo basemu = new M_Uinfo();
        mu.UserName = Mobile_T.Text.Trim();
        mu.UserPwd = StringHelper.MD5(Passwd_T.Text.Replace(" ", ""));
        mu.Email = mu.UserName + "@mobile.com";
        basemu.Mobile = mu.UserName;
        basemu.UserId = buser.Add(mu);
        buser.AddBase(basemu);
        function.WriteSuccessMsg("注册成功", "/User/Default.aspx");
    }
}