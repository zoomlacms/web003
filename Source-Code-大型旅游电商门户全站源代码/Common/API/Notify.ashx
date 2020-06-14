<%@ WebHandler Language="C#" Class="Notify" %>

using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Model;
using ZoomLa.SQLDAL;
using System.Data.SqlClient;

public class Notify : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    //该目录仅放本站访问API
    B_User buser = null;
    M_NotifyResult result = new M_NotifyResult();
    private string Action { get { return (HttpContext.Current.Request.QueryString["a"] ?? "").Trim().ToLower(); } }
    //user,admin默认user
    private string Source { get { return (HttpContext.Current.Request.QueryString["s"] ?? "").Trim().ToLower(); } }
    private int Success = 1, Failed = -1;
    public void ProcessRequest (HttpContext context) {
        HttpResponse Response = context.Response;
        try
        {
            switch (Source)
            {
                case "admin":
                    AdminAction();
                    break;
                case "user":
                default:
                    UserAction();
                    break;
            }
        }
        catch (Exception ex) { result.retcode = Failed; result.errmsg = ex.Message; }
        Response.Clear(); Response.Write(result.ToString()); Response.Flush(); Response.End();
    }
    private void AdminAction()
    {
        M_AdminInfo adminMod = B_Admin.GetLogin();
        if (adminMod == null || adminMod.AdminId < 1) { result.retcode = Failed; result.errmsg = "管理员未登录"; return; }
        switch (Action)
        {
            case "neworder"://新用户下单,管理员获得数量提醒
                {
                    result.num = DataConvert.CLng(SqlHelper.ExecuteTable(CommandType.Text, "SELECT Count(*) FROM ZL_OrderInfo WHERE OrderStatus=0").Rows[0][0]);
                    //Pubstart 商户会员申请 1:已审,0:待审
                    //result.num2 = DataConvert.CLng(SqlHelper.ExecuteTable(CommandType.Text, "SELECT Count(*) FROM ZL_Pub_shkysq WHERE PubStart=0").Rows[0][0]);
                    //未回答问题
                    result.num3 = DataConvert.CLng(SqlHelper.ExecuteTable(CommandType.Text, "SELECT COUNT(ID)AS Num FROM (SELECT *,(SELECT COUNT(ID) FROM ZL_GuestAnswer WHERE QueId=a.ID)Num FROM ZL_Ask A) A WHERE NUM<1").Rows[0][0]);
                }
                break;
            default:
                break;
        }
    }
    private void UserAction()
    {
        B_User buser = new B_User();
        M_UserInfo mu = buser.GetLogin();
        if (mu == null || mu.UserID < 1) { result.retcode = Failed; result.errmsg = "用户未登录"; return; }
        switch (Action)
        {
            case "ordersure"://已被管理员确认的订单,通知商户
                {
                    //SELECT Count(*)AS Count FROM ZL_Orderinfo A LEFT JOIN ZL_CommonModel B ON A.StoreID=B.GeneralID WHERE A.OrderStatus=1 AND B.Inputer='admin' 
                    SqlParameter[] sp = new SqlParameter[] {new SqlParameter("uname",mu.UserName) };
                    int count = DataConvert.CLng(SqlHelper.JoinQuery("Count(*)AS Count", "ZL_OrderInfo", "ZL_CommonModel", "A.StoreID=B.GeneralID", "A.OrderStatus=1 AND B.Inputer=@uname", "", sp).Rows[0][0]);
                    result.num = count;
                }
                break;
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
/// <summary>
/// 返回的通知结果
/// </summary>
public class M_NotifyResult
{
    public int retcode = 1;
    public int num = 0;    //一级重要信息,不二次封装,如消息数量等
    public int num2 = 0;
    public int num3 = 0;
    public string msg = "";//正常等时的提示
    public string errmsg = "";//错误时的提示
    public override string ToString()
    {
        return JsonConvert.SerializeObject(this);
    }
}