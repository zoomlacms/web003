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
using ZoomLa.Model;
using ZoomLa.SQLDAL;

public partial class test_view : System.Web.UI.Page
{
    public int Mid { get { return DataConvert.CLng(Request.QueryString["ID"]); } }
    public string contStr = "";
    B_Content conBll = new B_Content();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Mid > 0)
            {
                M_CommonData model = conBll.SelReturnModel(Mid);
                M_Content conMod = new M_Content();
                conMod.id = model.GeneralID;
                conMod.title = model.Title;
                conMod.topimg = model.TopImg;
                DataTable table = SqlHelper.ExecuteTable("SELECT * FROM ZL_C_YJMX WHERE ID=" + model.ItemID);
                if (table.Rows.Count < 1) { function.WriteErrMsg("游记不存在"); }
                //if (!string.IsNullOrEmpty(DataConvert.CStr(table.Rows[0]["content"])))
                //{
                //    conMod.comlist = JsonConvert.DeserializeObject<List<M_Component>>(table.Rows[0]["content"].ToString());
                //}
                conMod.mp3 = DataConvert.CStr(table.Rows[0]["music"]);
                conMod.pic = DataConvert.CStr(table.Rows[0]["pic"]);
                contStr = table.Rows[0]["content"].ToString();
                Save_Hid.Value = JsonConvert.SerializeObject(conMod);
            }
        }
    }
    public class M_Content
    {
        public int id = 0;
        public string title = "";
        public string topimg = "";
        //封面图片(暂定为取第一张图)
        public string pic = "";
        //背景音乐
        public string mp3 = "";
        ////成员控件列表,用于后期修改
        public List<M_Component> comlist = new List<M_Component>();
    }
    public class M_Component
    {
        public string id = "";
        public string content = "";
        public string type = "";
        public string videoType = "";
        public string text = "";
        public bool openText = false;
        public string title = "";
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        M_CommonData model = conBll.SelReturnModel(Mid);
        model.Status = 99;
        conBll.UpdateByID(model);
        Response.Redirect("/Item/" + model.GeneralID + ".aspx");
    }
}