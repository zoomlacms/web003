namespace ZoomLa.WebSite.Comment
{
    using System;
    using System.Data;
    using System.Configuration;
    using System.Collections;
    using System.Linq;
    using System.Linq.Expressions;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.WebControls.WebParts;
    using System.Web.UI.HtmlControls;
    using ZoomLa.BLL;
    using ZoomLa.Common;
    using System.Text;
    using ZoomLa.Model;
    using ZoomLa.Components;
    using System.Xml;

    public partial class CommentFor : System.Web.UI.Page
    {
        private B_Content bll = new B_Content();
        private B_Comment bcomment = new B_Comment();
        private B_User buser = new B_User();
        private B_Permission pll = new B_Permission();
        private M_UserInfo UserInfo = new M_UserInfo();
        protected B_Sensitivity sll = new B_Sensitivity();
        protected B_Node nodeBll = new B_Node();
        public int ItemID { get { return DataConverter.CLng(Request.QueryString["ID"]); } }
        public int Cpage { get { int cpage = DataConverter.CLng(Request.QueryString["PageID"]); return cpage < 1 ? 1 : cpage; } }
        public string C_Title { get { return ViewState["C_Title"].ToString(); } set { ViewState["C_Title"] = value; } }
        public int ModelID { get { return Convert.ToInt32(ViewState["ModelID"]); } set { ViewState["ModelID"] = value; } }
        //当前文章下所有评论,回发前释放
        public DataTable CommentDT
        {
            get
            {
                if (ViewState["CommentList"] == null)
                {
                    ViewState["CommentList"] = bcomment.SeachCommentByGid1(ItemID);
                }
                return (DataTable)ViewState["CommentList"];

            }
            set { ViewState["CommentList"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (function.isAjax())
            {
                string action = Request.Form["action"];
                string value = "";
                switch (action)
                {
                    case "report"://举报
                        value = Request.Form["cid"];
                        M_UserInfo info = buser.GetLogin();
                        bcomment.ReportComment(Convert.ToInt32(value), info.UserID);
                        Response.Write("1");
                        break;
                    case "support"://支持反对操作
                        value = Request.Form["flag"];
                        bool result = true;
                        if (buser.GetLogin().IsNull)
                            result= bcomment.Support(Convert.ToInt32(Request.Form["id"]), Convert.ToInt32(value), EnviorHelper.GetUserIP());
                        else
                            result= bcomment.Support(Convert.ToInt32(Request.Form["id"]), Convert.ToInt32(value), EnviorHelper.GetUserIP(), buser.GetLogin().UserID, buser.GetLogin().UserName);
                        Response.Write(result?"1":"-1");
                        break;
                    case "assist"://顶与踩
                        bool bl = true;
                        if (buser.GetLogin().IsNull)
                            bl = bcomment.Support(0, Convert.ToInt32(Request.Form["value"]), EnviorHelper.GetUserIP(), Convert.ToInt32(Request.Form["gid"]));
                        else
                            bl = bcomment.Support(0, Convert.ToInt32(Request.Form["value"]), EnviorHelper.GetUserIP(), buser.GetLogin().UserID, buser.GetLogin().UserName, Convert.ToInt32(Request.Form["gid"]));
                        Response.Write(bl ? "1" : "0");
                        break;
                    case "reply"://回复
                        Response.Write(btnHuiFu());
                        break;
                    case "sender"://发送评论
                        Response.Write(SenderComm());
                        break;
                    default:
                        break;
                }
                Response.Flush(); Response.End();
            }
            else if (!IsPostBack)
            {
                if (ItemID < 1) function.WriteErrMsg("内容ID错误");
                //获取节点配置
                M_CommonData cdata = bll.GetCommonData(ItemID);
                M_Node nodeMod = nodeBll.GetNodeXML(cdata.NodeID);
                C_Title = cdata.Title;
                ModelID = cdata.ModelID;
                switch (nodeMod.CommentType)
                {
                    case "0"://关闭
                        nocoment.Visible = true;
                        CommentInput.Visible = false;
                        return;
                    case "2"://注册用户
                        //islogin = buser.CheckLogin() ? 0 : 1;
                        break;
                    default://游客
                        break;
                }
                comentyes.Visible = true;
                RPT.ItemDataBound += RPT_ItemDataBound;
                MyBind();
            }

        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            CommentDT = null;
        }
        private void MyBind()
        {
            int count = CommentDT.Rows.Count;
            CommCount_L.Text = bcomment.GetUpCount(ItemID, -1).ToString();
            asscount.InnerText = bcomment.GetUpCount(ItemID, 1).ToString();
            this.Label1.Text = count + "条";//评论总数
            //this.Label2.Text = pktrue.ToString();//支持
            //this.Label3.Text = pkfalse.ToString();//反对
            RPT.DataSource = CommentDT;
            RPT.DataBind();
            M_CommonData cdata = bll.GetCommonData(ItemID);
            M_Node mnode = nodeBll.GetNodeXML(cdata.NodeID);
            if (mnode == null)
            {
                nocoment.Visible = true;
                CommentInput.Visible = false;
                return;
            }
            if ((string.IsNullOrEmpty(mnode.CommentType)||mnode.CommentType.Equals("2")) && !buser.CheckLogin())
            {
                nologin.Visible = true;
                CommentInput.Visible = false;
                comentyes.Visible = false;
            }
                
        }
        public string GetReport(string ids, string cid)
        {
            if (ids.IndexOf("," + buser.GetLogin().UserID + ",") > -1)
                return "<span class='comm_btns gray_9'>已举报</span>";
            else
                return "<span class='comm_btns' onclick='Report(this)' data-cid='" + cid + "'>举报</span>";
        }


        // 发表评论
        protected string SenderComm()
        {
            M_UserInfo mu = buser.GetLogin(false);
            if (!ZoomlaSecurityCenter.VCodeCheck(Request.Form["VCode_hid"], Request.Form["VCode"]))//Need
                return "-1";
            M_Comment comment = new M_Comment();
            comment.CommentID = 0;
            comment.GeneralID = ItemID;
            M_CommonData cdata = bll.GetCommonData(ItemID);
            if (cdata.IsComm != 1)
                return "-4";
            //GetNodePreate(cdata.NodeID);
            M_Node mnode = nodeBll.GetNodeXML(cdata.NodeID);
            if (mnode.CommentType.Equals("2") && !buser.CheckLogin())
                return "-2";

            comment.UserID = mu.UserID;//支持一个支持匿名方法
            comment.Title = BaseClass.CheckInjection(this.HdnTitle.Value);
            if (string.IsNullOrEmpty(Request.Form["content"]))
                return "-3";
            comment.Contents = BaseClass.CheckInjection(sll.ProcessSen(Request.Form["content"]));
            comment.Audited = false;
            DataTable dts = bcomment.SeachComment_ByGeneralID2(ItemID);
            if (mnode.Purview != null && mnode.Purview != "")
            {
                string Purview = mnode.Purview;
                DataTable AuitDT = nodeBll.GetNodeAuitDT(mnode.Purview);
                if (AuitDT == null && AuitDT.Rows.Count <= 0) { return "-4"; }
                DataRow auitdr = AuitDT.Rows[0];
                string forum_v = auitdr["forum"].ToString();
                if (string.IsNullOrEmpty(forum_v))
                    return "-4";
                string[] forumarr = forum_v.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                if (!forumarr.Contains("1"))//不允许评论
                    return "-4";
                if (!forumarr.Contains("2"))//不需要审核
                {
                    comment.Audited = true;
                }
                if (forumarr.Contains("3")) //一个文章只评论一次
                {
                    if (bcomment.SearchByUser(mu.UserID, cdata.NodeID).Rows.Count > 0)
                        return "-5";
                }
            }
            comment.Status = 0;
            comment.Score = DataConverter.CLng(Request.Form["Score"]);
            comment.CommentTime = DateTime.Now;
            DataTable dt = bcomment.SeachComment_ByGeneralID2(ItemID);
            if (bcomment.Add(comment))
            {
                if (SiteConfig.UserConfig.CommentRule > 0 && mu.UserID > 0)//增加积分
                {
                    buser.ChangeVirtualMoney(mu.UserID, new M_UserExpHis()
                    {
                        score = SiteConfig.UserConfig.CommentRule,
                        detail = "发表评论增加积分",
                        ScoreType = (int)M_UserExpHis.SType.Point
                    });
                }
            }
            return comment.Audited ? "2" : "1";
        }
        //回复
        private string btnHuiFu()
        {
            if (!ZoomlaSecurityCenter.VCodeCheck(Request.Form["VCode_hid"], Request.Form["VCode"]))
                return "-1";
            M_UserInfo mu = buser.GetLogin();
            M_Comment comment = new M_Comment();
            comment.CommentID = 0;
            comment.GeneralID = ItemID;
            M_CommonData cdata = bll.GetCommonData(ItemID);
            M_Node mnode = nodeBll.GetNodeXML(cdata.NodeID);
            if (mnode.CommentType.Equals("2") && !buser.CheckLogin())
                return "-2";
            //GetNodePreate(cdata.NodeID);
            comment.UserID = mu.UserID;
            comment.Title = BaseClass.CheckInjection(this.HdnTitle.Value);
            if (string.IsNullOrEmpty(Request.Form["content"]))
                return "-3";
            comment.Contents = BaseClass.CheckInjection(sll.ProcessSen(Request.Form["content"].ToString()));
            comment.Audited = false;
            comment.CommentTime = DateTime.Now;
            comment.Status = 0;
            comment.Pid = DataConverter.CLng(Request.Form["id"]);
            if (bcomment.Add(comment))
            {
                if (SiteConfig.UserConfig.CommentRule > 0 && mu.UserID > 0)
                {
                    buser.ChangeVirtualMoney(mu.UserID, new M_UserExpHis()
                    {
                        score = SiteConfig.UserConfig.CommentRule,
                        detail = "发表评论增加积分",
                        ScoreType = (int)M_UserExpHis.SType.Point
                    });
                }
            }
            return "1";
            //Response.Redirect(Request.RawUrl);
        }

        public string GetPK(string pk)
        {
            if (DataConverter.CBool(pk))
            {
                return "我支持";
            }
            else
            {
                return "我反对";
            }
        }

        private void GetNodePreate(int prentid)
        {
            M_Node nodes = nodeBll.GetNodeXML(prentid);
            GetMethod(nodes);
        }

        private void GetMethod(M_Node nodeinfo)
        {
            if (nodeinfo.Purview != null && nodeinfo.Purview != "")
            {
                string Purview = nodeinfo.Purview;
                Purview = "<Purview>" + Purview + "</Purview>";
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(Purview);

                string View_v = doc.SelectSingleNode("//View").InnerText;
                string ViewGroup_v = doc.SelectSingleNode("//ViewGroup").InnerText;
                string ViewSunGroup_v = doc.SelectSingleNode("//ViewSunGroup").InnerText;
                string input_v = doc.SelectSingleNode("//input").InnerText;
                string forum_v = doc.SelectSingleNode("//forum").InnerText;

                if (input_v != null && input_v != "")
                {
                    if (forum_v.IndexOf(',') > -1)
                    {
                        string[] forumarr = forum_v.Split(',');
                        string t1 = forumarr[0].ToString();
                        string t2 = forumarr[1].ToString();
                       // bool t3 = true;
                       // if (t2 == "2") { t3 = false; } else { t3 = true; }
                        //istrue = t3;
                    }
                    else
                    {
                        if (forum_v == "2")
                        {
                            function.WriteErrMsg("很抱歉！您没有权限在该栏目下发布评论！");
                        }
                    }
                }
                else
                {
                    function.WriteErrMsg("很抱歉！您没有权限在该栏目下发布评论！");
                }
            }
        }

        public string GetUserName(string uid)
        {
            try
            {
                string uname = buser.SeachByID(DataConverter.CLng(uid)).UserName;
                return string.IsNullOrEmpty(uname) ? "匿名" : uname;
                // return "";
            }
            catch
            {
                return "匿名";
            }
        }
        public string GetUserFace(string uid)
        {
            try
            {
                string uface = buser.SeachByID(DataConverter.CLng(uid)).UserFace;
                return string.IsNullOrEmpty(uface) ? "/Images/userface/noface.gif" : uface;
            }
            catch
            {
                return "/Images/userface/noface.gif";
            }
        }
        //根据评论内容审核状态显示相应内容

        protected void RPT_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                string temphtml = "<div class='clearfix'></div><div class='replybody'>{5}<h5>{0}评论人：{1}<span class='comm-date'>@Level</span></h5>"
                                    + "<p class='list-group-item-text'>{4}</p><div class='text-right'>"
                                    + "<span class='comm_btns support' data-id='{6}' data-flag='1' onclick='Support(this)'>支持(<span class='count'>{7}</span>)</span>"
                                    + "<span class='comm_btns support' data-id='{6}' data-flag='0' onclick='Support(this)'>反对(<span class='count'>{8}</span>)</span>{3}"
                                    + "<span class='comm_btns' onclick='showHuiFu(this,{6})'>回复</span></div></div>";
                Literal lit = e.Item.FindControl("Commment_Lit") as Literal;
                int level = 0;
                lit.Text = SelChildComment(CommentDT, dr.Row, temphtml, ref level);
            }
        }
        public string SelChildComment(DataTable dt, DataRow dr, string temp, ref int level)
        {
            string str = "";
            dt.DefaultView.RowFilter = ""; dt = dt.DefaultView.ToTable();
            dt.DefaultView.RowFilter = "CommentID=" + dr["pid"];
            foreach (DataRow item in dt.DefaultView.ToTable().Rows)
            {
                string content = Convert.ToInt32(item["Audited"]) == 1 ? item["Contents"].ToString() : "<span class='comm_audited'><span class='glyphicon glyphicon-ok-sign'></span>感谢回复,编辑正在审核中</span>";
                str = string.Format(temp, "", GetUserName(item["UserID"].ToString()), GetPK(item["PKS"].ToString())
                                    , GetReport(item["ReprotIDS"].ToString(), item["CommentID"].ToString()), content, SelChildComment(dt, item, temp, ref level)
                                    , item["CommentID"], item["AgreeCount"], item["DontCount"]);
                str = str.Replace("@Level", (++level).ToString());
            }
            return str;
        }
        //回复事件
        protected void Reply_B_Click(object sender, EventArgs e)
        {
            btnHuiFu();
        }
    }
}