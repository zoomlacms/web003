using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.SQLDAL;

public partial class Common_API_NearBy : System.Web.UI.Page
{
    private int Gid { get { return DataConvert.CLng(Request.QueryString["Gid"]); } }
    //已经选中的Gids
    private string Seled { get { return Request.QueryString["seled"] ?? ""; } }
    B_Node nodeBll = new B_Node();
    protected void Page_Load(object sender, EventArgs e)
    {
        B_Admin.CheckIsLogged();
        if (Gid < 1) { function.WriteErrMsg("请指定需要关联的景点"); }
        DataTable modelDT = SqlHelper.JoinQuery("TOP 1 A.GeneralID,A.ItemID,A.Title,B.dtzb,B.Price", "ZL_CommonModel", "ZL_C_jdmx", "A.ItemID=B.ID", "A.GeneralID="+Gid);
        if (modelDT.Rows.Count < 1 || string.IsNullOrEmpty(DataConvert.CStr(modelDT.Rows[0]["dtzb"]))) { function.WriteErrMsg("请先为景点设定坐标数据"); }

        double lng = 0;// 104.873626
        double lat = 0;// 26.587309
        if (!GetPointByStr(DataConvert.CStr(modelDT.Rows[0]["dtzb"]), out lng, out lat))
        {
            function.WriteErrMsg("景点坐标不正确");
        }
        string nids = "1";
        DataTable nodeDT = nodeBll.SelByPid(1, true);//景点的父节点为1
        foreach (DataRow dr in nodeDT.Rows)
        {
            nids += "," + dr["NodeID"];
        }
        //----------------------------------------------------------
        string where = "A.NodeID IN (" + nids + ")AND A.GeneralID!=" + Gid + " AND dtzb IS NOT NULL AND dtzb!=''";
        DataTable dt = SqlHelper.JoinQuery("A.GeneralID,A.ItemID,A.Title,B.dtzb,B.Price", "ZL_CommonModel", "ZL_C_jdmx", "A.ItemID=B.ID", where);
        dt.Columns.Add(new DataColumn("distance", typeof(double)));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            DataRow dr = dt.Rows[i];
            string json = dr["dtzb"].ToString();
            if (string.IsNullOrEmpty(json) || json.Equals("[]")) { continue; }
            double lng2,lat2;
            if (GetPointByStr(json, out lng2, out lat2))
            {
                dr["distance"] = BaiduMap.GetShortDistance(lng, lat, lng2,lat2);
            }
        }
        dt.Columns.Remove("dtzb");
        dt.DefaultView.Sort = "distance ASC";
        dt = dt.DefaultView.ToTable();
        DataTable result = dt.Clone();
        for (int i = 0; i < 50 && i < dt.Rows.Count; i++)
        {
            result.Rows.Add(dt.Rows[i].ItemArray);
        }
        //result.DefaultView.Sort = "distance ASC";
        RPT.DataSource = result;
        RPT.DataBind();
    }
    private bool GetPointByStr(string json, out double lng, out double lat)
    {
        try
        {
            lng = -1; lat = -1; 
            if (json.StartsWith("["))//完全地图
            {
                List<M_Map_Marker> list = JsonConvert.DeserializeObject<List<M_Map_Marker>>(json);
                if (list.Count < 1) { return false; }
                lng = Convert.ToDouble(list[0].mark.lng);
                lat = Convert.ToDouble(list[0].mark.lat);
            }
            else
            {
                json = json.Replace("=", "");
                lng = Convert.ToDouble(json.Split(',')[0]);
                lat = Convert.ToDouble(json.Split(',')[1]);
            }
        }
        catch (Exception ex) { throw new Exception(json + ":" + ex.Message); }
        return true;
    }
    public string IsChecked() 
    {
        if (("," + Seled + ",").Contains("," + Eval("GeneralID") + ",")) { return "checked='checked'"; }
        else { return ""; }
    }
    //107.613827,29.013192(lng,lat)
    //[{"mark":{"lng":104.873626,"lat":26.587309},"content":"%3Cp%3E%E8%90%A8%E8%BE%BE%E8%90%A8%E8%BE%BE%E6%92%92%E6%97%A6%E6%92%92%3C/p%3E","icon":"/Common/Label/Map/Img/f1.png"}]
    public class M_Map_Marker
    {
        /// <summary>
        /// 实际存的是坐标
        /// </summary>
        public M_Map_Point mark { get; set; }
        public string content = "";
        public string icon = "";
        //两个景点之间的坐标
        public double distance = 0;
    }
    public class M_Map_Point
    {
        public string lng = "";
        public string lat = "";
    }
}
/// <summary>
/// 提供地图的辅助类
/// </summary>
public class BaiduMap
{
    static double DEF_PI = 3.14159265359; // PI
    static double DEF_2PI = 6.28318530712; // 2*PI
    static double DEF_PI180 = 0.01745329252; // PI/180.0
    static double DEF_R = 6370693.5; // radius of earth
    /// <summary>
    /// 适用于近距离
    /// </summary>
    /// <returns></returns>
    public static double GetShortDistance(double lng1, double lat1, double lng2, double lat2)
    {
        double ew1, ns1, ew2, ns2;
        double dx, dy, dew;
        double distance;
        // 角度转换为弧度
        ew1 = lng1 * DEF_PI180;
        ns1 = lat1 * DEF_PI180;
        ew2 = lng2 * DEF_PI180;
        ns2 = lat2 * DEF_PI180;
        // 经度差
        dew = ew1 - ew2;
        // 若跨东经和西经180 度，进行调整
        if (dew > DEF_PI)
            dew = DEF_2PI - dew;
        else if (dew < -DEF_PI)
            dew = DEF_2PI + dew;
        dx = DEF_R * Math.Cos(ns1) * dew; // 东西方向长度(在纬度圈上的投影长度)
        dy = DEF_R * (ns1 - ns2); // 南北方向长度(在经度圈上的投影长度)
        // 勾股定理求斜边长
        distance = Math.Sqrt(dx * dx + dy * dy);
        return distance;
    }
    //适用于远距离
    public static double GetLongDistance(double lng1, double lat1, double lng2, double lat2)
    {
        double ew1, ns1, ew2, ns2;
        double distance;
        // 角度转换为弧度
        ew1 = lng1 * DEF_PI180;
        ns1 = lat1 * DEF_PI180;
        ew2 = lng2 * DEF_PI180;
        ns2 = lat2 * DEF_PI180;
        // 求大圆劣弧与球心所夹的角(弧度)
        distance = Math.Sin(ns1) * Math.Sin(ns2) + Math.Cos(ns1) * Math.Cos(ns2) * Math.Cos(ew1 - ew2);
        // 调整到[-1..1]范围内，避免溢出
        if (distance > 1.0)
            distance = 1.0;
        else if (distance < -1.0)
            distance = -1.0;
        // 求大圆劣弧长度
        distance = DEF_R * Math.Acos(distance);
        return distance;
    }

}