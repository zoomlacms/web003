<%@ WebHandler Language="C#" Class="AddToFav" %>

using System;
using System.Web;
using ZoomLa.BLL.Plat;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.BLL.User;
using System.Data;
using ZoomLa.SQLDAL;

public class AddToFav : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    B_User buser = new B_User();
    B_GuestAnswer answerBll = new B_GuestAnswer();
    M_GuestAnswer answerMod = new M_GuestAnswer();
    B_AskCommon askcBll = new B_AskCommon();
    M_AskCommon askcMod = new M_AskCommon();
    public void ProcessRequest(HttpContext context)
    {
        string action = context.Request.Params["action"];
        int answerid = DataConverter.CLng(context.Request.Params["amswerid"]);
        int type = DataConverter.CLng(context.Request.Params["type"]);
        switch (action)
        {
            case "add":
                M_UserInfo mu = buser.GetLogin();
                if (mu == null || mu.UserID == 0)
                    context.Response.Write("-3");//未登陆
                else if (string.IsNullOrEmpty(action) || answerid <= 0 || type <= 0)
                    context.Response.Write("-2");//参数不正确
                else
                {
                    answerMod = answerBll.SelReturnModel(answerid);
                    if (answerMod == null)
                        context.Response.Write("-1");//答案不存在
                    else
                    {
                        askcMod.AddTime = DateTime.Now;
                        askcMod.UserID = mu.UserID;
                        askcMod.Type = type;
                        askcMod.AskID = answerMod.QueId;
                        askcMod.AswID = answerMod.ID;
                        DataTable dt = new DataTable();
                        string content = "";
                        switch (type)
                        {
                            case 1:
                                content = "有用";
                                break;
                            case 2:
                                content = "同问";
                                break;
                            case 3:
                                content = "浏览";
                                break;
                            default:
                                break;
                        }
                        askcMod.Content = content;
                        dt = SqlHelper.ExecuteTable(CommandType.Text, "select * from ZL_AskCommon where UserID=" + mu.UserID + " And AswID=" + answerMod.ID + " And AskID=" + answerMod.QueId + " And Content='" + content + "'", null);
                        if (dt.Rows.Count > 0)
                            context.Response.Write("0");
                        else
                        {
                            if (askcBll.insert(askcMod) > 0)
                                context.Response.Write("1");
                            else
                                context.Response.Write("-4");//插入数据失败
                        }
                    }
                }
                break;
        }
    }

    public bool IsReusable
    {
        get {
            return false;
        }
    }
}