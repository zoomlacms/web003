<%@ WebHandler Language="C#" Class="AddToFav" %>

using System;
using System.Web;
using ZoomLa.BLL.Plat;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.BLL.User;
using System.Data;

public class AddToFav : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    B_User buser = new B_User();
    M_Favorite mfave = new M_Favorite();
    B_Favorite bfave = new B_Favorite();
    B_Content contBll = new B_Content();
    M_CommonData contMod = new M_CommonData();
    public void ProcessRequest(HttpContext context)
    {
        string action = context.Request.Params["action"];
        string itemid = context.Request.Params["itemid"];
        string url = context.Request.Params["url"];
        string type = context.Request.Params["type"];
        switch (action)
        {
            case "add":
                M_UserInfo mu = buser.GetLogin();
                if (mu == null||mu.UserID==0)
                {
                    context.Response.Write("-3");//未登陆
                }
                else if (string.IsNullOrEmpty(action) || string.IsNullOrEmpty(itemid) || string.IsNullOrEmpty(url) || string.IsNullOrEmpty(type))
                {
                    context.Response.Write("-2");//参数不正确
                }
                else
                {
                    int InfoId = DataConverter.CLng(itemid);
                    int userId = buser.GetLogin().UserID;
                    contMod = contBll.GetCommonData(InfoId);
                    if(contMod==null)
                    {
                        context.Response.Write("-1");//内容不存在
                    }
                    else
                    {
                        mfave.AddDate = DateTime.Now;
                        mfave.Owner = userId;
                        mfave.InfoID = InfoId;
                        mfave.FavItemID = "";
                        mfave.Title = contBll.GetCommonData(InfoId).Title;
                        mfave.FavoriType = DataConverter.CLng(type);
                        mfave.FavUrl = BaseClass.CheckInjection(url);
                        DataTable dt = bfave.SelBy(mfave);
                        if (dt.Rows.Count > 0)
                        {
                            context.Response.Write("0");//已添加了收藏
                        }
                        else
                        {
                            bfave.AddFavorite(mfave);
                            context.Response.Write("1");
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