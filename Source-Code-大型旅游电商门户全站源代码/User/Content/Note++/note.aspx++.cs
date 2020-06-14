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

public partial class test_note : System.Web.UI.Page
{
    public int Mid { get { return DataConvert.CLng(Request.QueryString["ID"]); } }
    public int NodeID { get { return DataConvert.CLng(Request.QueryString["nodeid"]); } }
    B_Content conBll = new B_Content();
    B_User buser = new B_User();
    //http://player.youku.com/player.php/sid/XMTQ1OTU0NzMwOA==/v.swf
    protected void Page_Load(object sender, EventArgs e)
    {
        if (function.isAjax())
        {
            string action = Request["action"];
            string result = "";
            switch (action)
            {
                case "save":
                    string value = Request["value"];
                    result = SaveBy(value).ToString();
                    RepToClient(result);
                    break;
            }
        }
        if (!IsPostBack)
        {
            B_User.CheckIsLogged(Request.RawUrl);
            if (Mid > 0)
            {
                M_UserInfo mu = buser.GetLogin();
                M_CommonData model = conBll.SelReturnModel(Mid);
                M_Content conMod = new M_Content();
                conMod.id = model.GeneralID;
                conMod.title = model.Title;
                conMod.topimg = model.TopImg;
                DataTable table = SqlHelper.ExecuteTable("SELECT * FROM ZL_C_YJMX WHERE ID=" + model.ItemID);
                if (table.Rows.Count < 1) { function.WriteErrMsg("游记不存在"); }
                if (!model.Inputer.Equals(mu.UserName)) { function.WriteErrMsg("你无权修改该游记"); }
                if (!string.IsNullOrEmpty(DataConvert.CStr(table.Rows[0]["content"])))
                {
                    conMod.comlist = JsonConvert.DeserializeObject<List<M_Component>>(table.Rows[0]["content"].ToString());
                }
                conMod.mp3 = DataConvert.CStr(table.Rows[0]["music"]);
                conMod.pic =DataConvert.CStr(table.Rows[0]["pic"]);
                Save_Hid.Value = JsonConvert.SerializeObject(conMod);
            }
        }
    }
    private void MyBind() { }
    protected void Save_Btn_Click(object sender, EventArgs e)
    {
        int gid = SaveBy(Save_Hid.Value, 99);
        Response.Redirect("view.aspx?id=" + gid);
    }
    private int SaveBy(string json, int status = 0)
    {
        M_UserInfo mu = buser.GetLogin();
        M_CommonData model = new M_CommonData();
        M_Content conMod = JsonConvert.DeserializeObject<M_Content>(json);
        if (conMod.id > 0)
        {
            model = conBll.SelReturnModel(conMod.id);
            if (!mu.UserName.Equals(model.Inputer))
            {
                return -1;//无权修改该文章 
            }
        }
        model.Title = conMod.title;
        model.TopImg = conMod.topimg;
        model.Inputer = mu.UserName;
        model.Status = status;
		if (!string.IsNullOrEmpty(conMod.pic))
		{
			conMod.pic = conMod.pic.Replace(ZoomLa.Components.SiteConfig.SiteOption.UploadDir, "");
		}
        //-------------
        DataTable table = new DataTable();
        table.Columns.Add(new DataColumn("FieldName", typeof(string)));
        table.Columns.Add(new DataColumn("FieldType", typeof(string)));
        table.Columns.Add(new DataColumn("FieldValue", typeof(string)));
        table.Columns.Add(new DataColumn("FieldAlias", typeof(string)));
        DataRow dr = table.NewRow(); DataRow dr2 = table.NewRow(); DataRow dr3 = table.NewRow(); DataRow dr4 = table.NewRow();
        dr["FieldName"] = "music"; dr2["FieldName"] = "content"; dr3["FieldName"] = "pic"; dr4["FieldName"] = "synopsis";
        dr["FieldType"] = "TextType"; dr2["FieldType"] = "MultipleTextType"; dr3["FieldType"] = "TextType"; dr4["FieldType"] = "MultipleTextType";
        dr["FieldValue"] = conMod.mp3;
        dr2["FieldValue"] = JsonConvert.SerializeObject(conMod.comlist);
        dr3["FieldValue"] = conMod.pic;
        dr4["FieldValue"] = Sys_Hid.Value;
        table.Rows.Add(dr); table.Rows.Add(dr2); table.Rows.Add(dr3); table.Rows.Add(dr4);
        //-------------
        if (model.GeneralID > 0) { conBll.UpdateContent(table, model); }
        else
        {
            //M_ModelInfo modelMod = new B_Model().SelReturnModel(46);
            model.ModelID = 46;
            model.TableName = "ZL_C_yjmx";//"ZL_C_yjmx"
            model.NodeID = NodeID;
            model.GeneralID = conBll.AddContent(table, model);
        }
        return model.GeneralID;
    }
    private void RepToClient(string result) {
        Response.Clear(); Response.Write(result); Response.Flush(); Response.End();
    }
    protected void SaveToDraft_Btn_Click(object sender, EventArgs e)
    {
        int gid = SaveBy(Save_Hid.Value);
        function.WriteSuccessMsg("保存为草稿成功", "view.aspx?id="+gid);
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
}