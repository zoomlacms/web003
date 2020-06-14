<%@ WebHandler Language="C#" Class="nearby" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ZoomLa.BLL.API;
using ZoomLa.SQLDAL;
using System.Data;
using ZoomLa.BLL;
using ZoomLa.BLL.Helper;
using Newtonsoft.Json;

public class nearby : System.Web.SessionState.IReadOnlySessionState,IHttpHandler
{
    public M_APIResult retMod = new M_APIResult();
    public string Action { get { return Req("Action").ToLower(); } }
    public string CallBack { get { return Req("callback"); } }
    public string Req(string name) { return HttpContext.Current.Request[name] ?? ""; }
    public void RepToClient(M_APIResult result)
    {
        HttpResponse rep = HttpContext.Current.Response;
        rep.Clear(); rep.Write(result.ToString()); rep.Flush(); rep.End();
    }
    //仅用于313,周边景点
    public void ProcessRequest(HttpContext context)
    {
        //function.WriteErrMsg("接口默认关闭,请联系管理员开启");
        //M_UserInfo mu = buser.GetLogin();
        retMod.retcode = M_APIResult.Failed;
        //retMod.callback = CallBack;//暂不开放JsonP
        try
        {
            switch (Action)
            {
                case "list":
                    {
                        int gid = DataConvert.CLng(Req("gid"));
                        //不一次取,避免存值不规范引起的报错
                        DataTable dt = SqlHelper.ExecuteTable("SELECT TOP 1 RelatedIDS FROM ZL_CommonModel WHERE GeneralID=" + gid);
                        if (dt.Rows.Count < 1 || string.IsNullOrEmpty(DataConvert.CStr(dt.Rows[0]["RelatedIDS"])))
                        {
                            retMod.retmsg = "该景点未设置周边数据";
                        }
                        else
                        {
                            string rids = DataConvert.CStr(dt.Rows[0]["RelatedIDS"]);
                            rids = StrHelper.PureIDSForDB(rids);
                            DataTable nearDT = SqlHelper.JoinQuery("GeneralID AS gid,Title AS title,B.pic", "ZL_CommonModel", "ZL_C_JDMX", "A.ItemID=B.ID", "A.GeneralID IN (" + rids + ")");
                            retMod.result = JsonConvert.SerializeObject(nearDT);
                            retMod.retcode = M_APIResult.Success;
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}