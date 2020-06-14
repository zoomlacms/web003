using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.Common;
using ZoomLa.SQLDAL;

public partial class Common_API_NearConver : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //107.613827,29.013192(lat:lng)
        //[{"mark":{"lng":104.873626,"lat":26.587309},"content":"%3Cp%3E%E8%90%A8%E8%BE%BE%E8%90%A8%E8%BE%BE%E6%92%92%E6%97%A6%E6%92%92%3C/p%3E","icon":"/Common/Label/Map/Img/f1.png"}]
   
    }
    protected void Test_Click(object sender, EventArgs e)
    {
        DataTable dt = SqlHelper.ExecuteTable("SELECT ID,dtzb FROM ZL_C_JDMX WHERE dtzb IS NOT NULL AND dtzb!=''");
                        
        //string msg = "[{\"mark\":{\"lng\":{0},\"lat\":{1}},\"content\":\"\",\"icon\":\"/Common/Label/Map/Img/f1.png\"}]";
        foreach (DataRow dr in dt.Rows)
        {
            try
            {
                string dtzb = DataConvert.CStr(dr["dtzb"]);
                if (string.IsNullOrEmpty(dtzb) || !dtzb.Contains(",") || dtzb.Contains("[")) { continue; }
                dtzb = dtzb.Replace("=", "");
                string result = "[{\"mark\":{\"lng\":\"" + dtzb.Split(',')[0] + "\",\"lat\":\"" + dtzb.Split(',')[1] + "\"},\"content\":\"\",\"icon\":\"/Common/Label/Map/Img/f1.png\"}]"; 
                SqlParameter[] sp = new SqlParameter[] { new SqlParameter("dtzb", result) };
                SqlHelper.ExecuteSql("UPDATE ZL_C_JDMX SET dtzb=@dtzb WHERE ID=" + dr["ID"], sp);
            }
            catch (Exception ex) { function.WriteErrMsg(dr["ID"] + ":" + DataConvert.CStr(dr["dtzb"]) + ":" + ex.Message); }
        }
        function.WriteErrMsg("操作完成");
    }
}