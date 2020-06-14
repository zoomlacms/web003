<%@ WebHandler Language="C#" Class="User" %>

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using ZoomLa.BLL;
using ZoomLa.BLL.User;
using ZoomLa.BLL.API;
using ZoomLa.BLL.CreateJS;
using ZoomLa.BLL.Helper;
using ZoomLa.Model;
using ZoomLa.Model.CreateJS;
using ZoomLa.SQLDAL;
using Newtonsoft.Json;
/// <summary>
/// 暂定于跨域设备接入,支持Json,JsonP调用
/// </summary>
public class User : IHttpHandler {
    HttpRequest request = HttpContext.Current.Request;
    HttpResponse response = HttpContext.Current.Response;
    B_User_API apiBll = new B_User_API();
    M_APIResult result = new M_APIResult();
    private string Action { get { return HttpContext.Current.Request["Action"].ToLower(); } }
    private string CallBackFunc { get { return HttpContext.Current.Request["callback"]; } }
    public void ProcessRequest(HttpContext context)
    {
        result.callback = CallBackFunc;
        M_UserInfo mu = new M_UserInfo();
        M_AJAXUser apiUser = new M_AJAXUser();
        try
        {
            switch (Action)
            {
                case "login":
                    {
                        result.retcode = M_APIResult.Failed;
                        string uname = request["uname"].Trim();
                        string upwd = request["upwd"].Trim();
                        if (StrHelper.StrNullCheck(uname, upwd)) { result.retmsg = "用户名和密码不能为空"; break; }
                        mu = apiBll.Login(uname, upwd);
                        if (mu.IsNull) { result.retmsg = "用户[" + uname + "]不存在"; break; }
                        apiUser.Copy(mu);
                        result.result = apiUser.ToJson();
                        result.retcode = M_APIResult.Success;
                    }
                    break;
                case "getlogin":
                    {
                        B_User buser = new B_User();
                        mu = buser.GetLogin();
                        if (!mu.IsNull)
                        {
                            apiUser.Copy(mu);
                            result.retmsg = buser.SessionID;
                            result.result = apiUser.ToJson();
                        }
                        else { result.retmsg = request["openid"]; result.retcode = M_APIResult.Failed; }
                    }
                    break;
                default:
                    result.retcode = M_APIResult.Failed;
                    result.retmsg = Action + "不是有效的参数";
                    break;
            }
        }
        catch (Exception ex) { result.retcode = M_APIResult.Failed; result.retmsg = ex.Message; }
        HttpContext.Current.Response.Write(result.ToString());
        HttpContext.Current.Response.Flush();
        HttpContext.Current.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}