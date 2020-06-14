<%@ WebHandler Language="C#" Class="mobile" %>

using System;
using System.Web;
using System.Web.SessionState;
using ZoomLa.BLL;
using ZoomLa.BLL.API;
using ZoomLa.Model;
using ZoomLa.Common;
using ZoomLa.Components;

public class mobile : API_Base, IHttpHandler
{
    B_User buser = new B_User();
    B_Safe_Mobile mobileBll = new B_Safe_Mobile();
    RegexHelper regHelp = new RegexHelper();
    public void ProcessRequest(HttpContext context)
    {
        M_UserInfo mu = buser.GetLogin();
        retMod.retcode = M_APIResult.Failed;
        string mobile = Req("mobile").Trim();
        //retMod.callback = CallBack;//暂不开放JsonP
        try
        {
            switch (Action)
            {
                case "mobilereg"://手机注册
                    if (string.IsNullOrEmpty(mobile)) { retMod.retmsg = "手机号码不能为空"; }
                    else if (buser.IsExistUName(mobile)) { retMod.retmsg = "该手机号已被注册"; }
                    else if (!regHelp.IsMobilPhone(mobile)) { retMod.retmsg = "手机号码格式不正确"; }
                    else
                    {
                        //发送验证码
                        if (mobileBll.CheckMobile(mobile, context.Request.UserHostAddress))
                        {
                            string code = function.GetRandomString(6, 2);//验证码
                            SendWebSMS.SendMessage(mobile, "【" + SiteConfig.SiteInfo.SiteName + "】你的注册验证码:" + code);
                            //添加一条发送手机短信记录
                            mobileBll.Insert(new M_Safe_Mobile() { Phone = mobile, IP = HttpContext.Current.Request.UserHostAddress, CDate = DateTime.Now });
                            context.Session.Add("Cur_MobileSafeCode", code);
                            retMod.retcode = M_APIResult.Success;
                        }
                        else
                        {
                            retMod.retmsg = "短信发送次数超过上限!";
                        } 
                    }
                    break;
                case "SendVailMsg"://手机发送验证
                    {
                        if (!ZoomlaSecurityCenter.VCodeCheck(context.Request["hcode"], context.Request["code"])) { context.Response.Write("验证码不正确"); return; }
                        B_Safe_Mobile mobileBll = new B_Safe_Mobile();
                        //检测手机短信发送次数
                        if (mobileBll.CheckMobile(mobile, context.Request.UserHostAddress))
                        {
                            string vaildnum = function.GetRandomString(6, 2);//验证码
                            string ret = SendWebSMS.SendMessage(mobile, vaildnum);
                            //添加一条发送手机短信记录
                            mobileBll.Insert(new M_Safe_Mobile() { Phone = mobile, IP = HttpContext.Current.Request.UserHostAddress, CDate = DateTime.Now });
                            context.Session.Add("Cur_MobileSafeCode", vaildnum);
                            retMod.retcode = M_APIResult.Success;
                        }
                        else
                        {
                            retMod.retmsg = "短信发送次数超过上限!";
                        }
                    }
                    break;
                default:
                    {
                        retMod.retmsg = "[" + Action + "]接口不存在";
                    }
                    break;
            }
        }
        catch (Exception ex) { retMod.retmsg = ex.Message; }
        RepToClient(retMod);
    }

    public bool IsReusable { get { return false; } }

}

//public class API_Base : IRequiresSessionState
//{
//    public M_APIResult retMod = new M_APIResult();
//    public string Action { get { return Req("Action").ToLower(); } }
//    public string CallBack { get { return Req("callback"); } }
//    public string Req(string name) { return HttpContext.Current.Request[name] ?? ""; }
//    public void RepToClient(M_APIResult result)
//    {
//        HttpResponse rep = HttpContext.Current.Response;
//        rep.Clear(); rep.Write(result.ToString()); rep.Flush(); rep.End();
//    }
//}