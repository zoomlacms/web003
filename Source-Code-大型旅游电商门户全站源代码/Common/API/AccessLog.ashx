<%@ WebHandler Language="C#" Class="AccessLog" %>

using System;
using System.Data;
using System.Web;
using ZoomLa.BLL;
using ZoomLa.Model;
using ZoomLa.BLL.API;
using ZoomLa.BLL.CreateJS;
using ZoomLa.SQLDAL;

public class AccessLog :API_Base, IHttpHandler {

    B_User buser = new B_User();
    B_CodeModel codeBll = new B_CodeModel("ZL_EX_AccessLog");
    private int TUid { get { return DataConvert.CLng(Req("tuid")); } }
    public void ProcessRequest(HttpContext context)
    {
        M_UserInfo mu = buser.GetLogin();
        retMod.retcode = M_APIResult.Failed;
        //retMod.callback = CallBack;//暂不开放JsonP
        //当前登录
        try
        {
            switch (Action)
            {
                case "add":
                    {
                        if (!mu.IsNull)
                        {
                            DataRow dr = codeBll.NewModel();
                            dr["UserID"] = mu.UserID;
                            dr["CDate"] = DateTime.Now;
                            dr["TUserID"] = TUid;
                            //DataTable logDT = SqlHelper.ExecuteTable("SELECT TOP 1 * FROM " + codeBll.TbName + " WHERE UserID=" + mu.UserID + " AND TUserID=" + TUid);
                            //if (logDT.Rows.Count > 0) { dr["ID"] = logDT.Rows[0]["ID"]; codeBll.UpdateByID(dr, "id"); }
                            //else { codeBll.Insert(dr); }
                            codeBll.Insert(dr);
                            retMod.retcode = M_APIResult.Success;
                        }
                    }
                    break;
                case "list":
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