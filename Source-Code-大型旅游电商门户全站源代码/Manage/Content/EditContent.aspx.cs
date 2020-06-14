using System;
using System.IO;
using System.Collections;
using System.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Components;
using ZoomLa.Model;
using ZoomLa.SQLDAL;
using ZoomLa.BLL.Helper;

public partial class V_Content_EditContent : CustomerPageAction
{
    protected B_Node bnode = new B_Node();
    protected B_Model bmode = new B_Model();
    protected B_ShowField bshow = new B_ShowField();
    protected B_ModelField fieldBll = new B_ModelField();
    protected B_MultiNode bmn = new B_MultiNode();
    protected B_Content contentBll = new B_Content();
    protected B_Admin badmin = new B_Admin();
    protected B_User buser = new B_User();
    protected B_Spec specbll = new B_Spec();
    protected B_Content_WordChain wordBll = new B_Content_WordChain();
    protected List<string> content = new List<string>();
    protected B_CollectionItem bc = new B_CollectionItem();
    protected B_Content_ScheTask taskBll = new B_Content_ScheTask();
    protected B_KeyWord keyBll = new B_KeyWord();
    protected bool createnew = true;
    public string keys = "";
    //----工作流
    B_Process proBll = new B_Process();
    M_Process proMod = new M_Process();
    //-----------
    public int NodeID
    {
        get
        {
            return DataConvert.CLng(ViewState["NodeID"]);
        }
        set { ViewState["NodeID"] = value; }
    }
    public int ModelID
    {
        get
        {
            return DataConvert.CLng(ViewState["ModelID"]);
        }
        set { ViewState["ModelID"] = value; }
    }
    public int GeneralID { get { return Convert.ToInt32(Request.QueryString["GeneralID"]); } }
    public string NodeDir { get { return ViewState["NodeDir"] as string; } set { ViewState["NodeDir"] = value; } }
    private string pdfLink = SiteConfig.SiteOption.UploadDir + "PDF/";
    private string wordLink = SiteConfig.SiteOption.UploadDir + "Word/";
    public string GetAlias(string field, DataTable dt)
    {
        DataRow[] drs = dt.Select("FieldName='" + field + "'");
        return drs.Length > 0 ? drs[0]["FieldAlias"].ToString() : Resources.L.未定义;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        B_Admin badmin = new B_Admin();
        if (!IsPostBack)
        {
            B_ARoleAuth.CheckEx(ZLEnum.Auth.content, "ContentMange");
            M_CommonData Cdata = contentBll.GetCommonData(GeneralID);
            //计划任务(审核时间)
            M_Content_ScheTask taskmod = taskBll.SelByGid(GeneralID, M_Content_ScheTask.TaskTypeEnum.AuditArt);
            if (taskmod != null)
            {
                CheckDate_T.Text = taskmod.ExecuteTime2.ToString();
                CheckDate_Hid.Value = taskmod.ExecuteTime2.ToString();
            }
            taskmod = taskBll.SelByGid(GeneralID, M_Content_ScheTask.TaskTypeEnum.UnAuditArt);
            if (taskmod!=null)
            {
                TimeDate_T.Text = taskmod.ExecuteTime2.ToString();
                TimeDate_Hid.Value = taskmod.ExecuteTime2.ToString();
            }
            M_ModelInfo model = bmode.GetModelById(Cdata.ModelID);
            ModelID = Cdata.ModelID;
            NodeID = Cdata.NodeID;
            DataTable fieldDT = fieldBll.SelByModelID(ModelID,true);
            bt_txt.Text = GetAlias("Title", fieldDT)+"：";
            gjz_txt.Text = GetAlias("Tagkey", fieldDT) + "：";
            SubTitle_L.Text = GetAlias("Subtitle", fieldDT) + "：";
            tj_txt.Text = GetAlias("EliteLevel", fieldDT);
            zht_txt.Text = GetAlias("Status", fieldDT);
            hits_txt.Text = GetAlias("Hits", fieldDT);
            RelatedIDS_Hid.Value = Cdata.RelatedIDS;
            Button1.Text = "添加为新" + model.ItemName;
            EBtnSubmit.Text = "保存" + model.ItemName;
            //-----工作流,检测该节点是否绑定工作流，如无绑定，则直接通过,未绑定,则以第一步为准
            ddlFlow.DataSource = proBll.SelByNodeID2(NodeID);
            ddlFlow.DataTextField = "PName";
            ddlFlow.DataValueField = "PPassCode";
            ddlFlow.DataBind();
            ddlFlow.SelectedValue = Cdata.Status.ToString().Equals("-3") || string.IsNullOrEmpty(Cdata.Status.ToString()) ? "0" : Cdata.Status.ToString();
            //-----工作流(End)
            //-----智能关键词
            keys = keyBll.SelToJson();
            ModelID = Cdata.ModelID;
            M_Node nnn = bnode.GetNodeXML(NodeID);
            if (nnn.Contribute != 1)
            {
                function.Script(this, "ShowSys();");
            }
            NodeDir = nnn.NodeDir;
            CreateHTML.Visible = nnn.ListPageHtmlEx < 3;
            nodename.Value = nnn.NodeName;
            EBtnSubmit.Text = "修改" + bmode.GetModelById(ModelID).ItemName;
            txtTitle.Text = Cdata.Title;
            SeledPic_Hid.Value = Cdata.TopImg;
            txtAddTime.Text = Cdata.CreateTime == DateTime.MinValue ? "" : Cdata.CreateTime.ToString("yyyy-MM-dd HH:mm:ss");
            txtInputer.Text = Cdata.Inputer;
            txtdate.Text = Cdata.UpDateTime.ToString("yyyy-MM-dd HH:mm:ss");
            txtNum.Text = Cdata.Hits.ToString();
            ChkAudit.Checked = Cdata.EliteLevel > 0;
            TxtTemplate_hid.Value = Cdata.Template;
            TlpView_Tlp.SelectedID = Cdata.Template;
            TlpView_Tlp.SelectedValue = Cdata.Template;
            Keywords.Text = Cdata.TagKey;
            Subtitle.Text = Cdata.Subtitle;
            PYtitle.Text = Cdata.PYtitle;
            pronum.Text = Cdata.Pronum.ToString();
            proweek.Text = Cdata.ProWeek.ToString();
            BidType.SelectedValue = Cdata.BidType.ToString();
            bidmoney.Text = Cdata.BidMoney.ToString("F2");
            ThreadStyle.Value = Cdata.TitleStyle.ToString();
            txtTitle.Style.Value += Cdata.TitleStyle.ToString();
            IsComm_Radio.SelectedValue = Cdata.IsComm.ToString();
            #region 专题
            if (specbll.GetSpecList().Rows.Count > 0)
            { SpecInfo_Li.Text = "<button type='button' class='btn btn-info btn-sm' onclick='ShowSpDiag()'>添加至专题</button>"; }
            else
            { SpecInfo_Li.Text = "<div style='margin:5px;' class='btn btn-default disabled'><span class='glyphicon glyphicon-info-sign'></span> 尚未定义专题</div>"; }
            Spec_Hid.Value = Cdata.SpecialID;
            if (!string.IsNullOrEmpty(Cdata.SpecialID))
            {
                string ids = Cdata.SpecialID.Trim(',');
                DataTable dtspecs = specbll.SelByIDS(ids);
                string names = "";
                if (dtspecs != null)
                {
                    foreach (DataRow item in dtspecs.Rows)
                    {
                        names += "{\"id\":\"" + item["SpecID"] + "\",\"name\":\"" + item["SpecName"] + "\"},";
                    }
                }
                names = names.TrimEnd(',');
                function.Script(this, "DealResult('[" + names + "]');");
            }
            #endregion
            DataTable dtContent = contentBll.GetContent(GeneralID);
            ModelHtml.Text = fieldBll.InputallHtml(ModelID, NodeID, new ModelConfig()
            {
                ValueDT = dtContent
            });//模型内容
            //检测是否已生成PDF或Html
            if (File.Exists(Server.MapPath(Cdata.PdfLink)))
            {
                makePDFBtn.Enabled = false;
                downPdfHref.Text += Cdata.GeneralID + ".pdf";
                delPdfHref.Visible = true;
                downPdfHref.Visible = true;
            }
            if (File.Exists(Server.MapPath(wordLink + Cdata.GeneralID + ".doc")))
            {
                makeWordBtn.Enabled = false;
                downWordHref.Text += Cdata.GeneralID + ".doc";
                downWordHref.Visible = true;
                delWordHref.Visible = true;
            }
            string breadTlp = "<li><a href='ContentManage.aspx'>内容管理</a></li><li><a href='ContentManage.aspx?NodeID=" + nnn.NodeID + "'>" + nnn.NodeName + "</a></li><li class='active'>";
            breadTlp += "[向本栏目修改"+model.ItemName+"]";
            if (!string.IsNullOrEmpty(Cdata.Template))//启用个性模板
            {
                breadTlp += "<span class='margin_l5 rd_red'>(提示:该内容已启用个性模板)</span>";
            }
            breadTlp+="</li>";
            breadTlp += "<div class='pull-right hidden-xs'><span><a href='" + customPath2 + "Content/SchedTask.aspx' title='查看计划任务'><span class='glyphicon glyphicon-time' style='color:#28b462;'></span></a>" + GetOpenView() + "<span onclick=\"ShowDiag('EditNode.aspx?NodeID=" + NodeID + "','配置本节点');\" class='glyphicon glyphicon-cog' title='配置本节点' style='cursor:pointer;margin-left:5px;'></span></span></div>";
            Call.SetBreadCrumb(Master, breadTlp);
            BindTempList();
        }
    }
    
    //专题id|名称，
    private string SetSpecial(string specialid)
    {
        string sps = "";
        B_Spec Bs = new B_Spec();
        if (!string.IsNullOrEmpty(specialid))
        {
            string[] arr = specialid.Split(new char[] { ',' });
            for (int i = 0; i < arr.Length; i++)
            {
                if (!string.IsNullOrEmpty(arr[i]))
                {
                    M_Spec dd = Bs.GetSpec(DataConverter.CLng(arr[i]));
                    sps += arr[i] + "|" + dd.SpecName + ",";
                }
            }
        }
        return sps;
    }

    private string SetNode(string noid)
    {
        string str = "";
        string[] strarr = noid.Split(new char[] { ',' });
        for (int i = 0; i < strarr.Length; i++)
        {
            if (!string.IsNullOrEmpty(strarr[i]))
                str += strarr[i] + "|" + GetParent(DataConverter.CLng(strarr[i])) + ",";
        }
        return str;
    }

    private string GetParent(int ParentID)
    {
        string str = "";
        M_Node mn = bnode.GetNodeXML(ParentID);
        if (mn.ParentID > 0)
        {
            str = GetParent(mn.ParentID) + "&gt;&gt;" + mn.NodeName;
        }
        else
        {
            str = mn.NodeName;
        }
        return str;
    }
    //保存项目
    protected void EBtnSubmit_Click(object sender, EventArgs e)
    {
        B_Admin.CheckIsLogged();
        M_AdminInfo adminMod = badmin.GetAdminLogin();
        M_CommonData CData = contentBll.GetCommonData(GeneralID);
        NodeID = CData.NodeID;
        ModelID = CData.ModelID;
        CData.Title = txtTitle.Text;
        CData.NodeID = NodeID;
        int elite = ChkAudit.Checked ? 1 : 0;
        if (CData.EliteLevel == 0 && elite == 1)//推荐增加用户积分
        {
            if (SiteConfig.UserConfig.InfoRule > 0)
            {
                M_UserInfo muser = buser.GetUserByName(adminMod.AdminName);
                if (!muser.IsNull)
                {
                    buser.ChangeVirtualMoney(muser.UserID, new M_UserExpHis()
                    {
                        score = SiteConfig.UserConfig.InfoRule,
                        detail = "修改内容:" + txtTitle.Text + "增加积分",
                        ScoreType = (int)M_UserExpHis.SType.Point,
                        Operator = muser.UserID,
                        OperatorIP = Request.UserHostAddress
                    });
                }
            }
        }
        /*-----------可用智能判断模型与节点绑定-------------------*/
        M_Node nodeinfo = bnode.GetNodeXML(NodeID);
        if (nodeinfo.ContentModel != "")
        {
            string ContentModel = "," + nodeinfo.ContentModel + ",";
            if (ContentModel.IndexOf("," + ModelID.ToString() + ",") == -1)
            {
                nodeinfo.ContentModel = nodeinfo.ContentModel + "," + ModelID.ToString();
                bnode.UpdateNode(nodeinfo);
            }
        }
        else
        {
            nodeinfo.ContentModel = ModelID.ToString();
            bnode.UpdateNode(nodeinfo);
        }
        /*---------------------------------------------*/
        CData.EliteLevel = elite;
        CData.InfoID = "";
        CData.Template = TxtTemplate_hid.Value;
        CData.Hits = DataConverter.CLng(txtNum.Text);
        CData.UpDateType = 2;
        CData.UpDateTime = DataConverter.CDate(txtdate.Text);
        CData.Hits = string.IsNullOrEmpty(txtNum.Text) ? 0 : DataConverter.CLng(txtNum.Text);
        if (!string.IsNullOrEmpty(txtAddTime.Text))
        {
            CData.CreateTime = DataConverter.CDate(txtAddTime.Text);
        }
        if (!string.IsNullOrEmpty(txtInputer.Text))
        {
            CData.Inputer = txtInputer.Text;
        }
        string OldKey = CData.TagKey;
        CData.TagKey = Request.Form["tabinput"];
        CData.Status = Convert.ToInt32(string.IsNullOrEmpty(ddlFlow.SelectedValue) ? "-3" : ddlFlow.SelectedValue);//-3为草稿状态
        CData.ProWeek = DataConverter.CLng(proweek.Text);
        CData.Pronum = DataConverter.CLng(pronum.Text);
        CData.BidType = DataConverter.CLng(BidType.SelectedValue);
        CData.BidMoney = DataConverter.CDouble(bidmoney.Text);
        CData.Subtitle = Subtitle.Text;
        CData.PYtitle = PYtitle.Text;
        string tree = "";
        CData.FirstNodeID = bnode.SelFirstNodeID(NodeID,ref tree);
        CData.TitleStyle = ThreadStyle.Value;
        CData.ParentTree = tree;
        CData.TopImg = Request.Form["selectpic"];//首页图片
        CData.SpecialID = Spec_Hid.Value;
        CData.RelatedIDS = RelatedIDS_Hid.Value;
        CData.IsComm = Convert.ToInt32(IsComm_Radio.SelectedValue);
        DataTable dt = fieldBll.SelByModelID(ModelID);
        Call commonCall = new Call();
        DataTable table = commonCall.GetDTFromPage(dt, Page, ViewState, content);
        contentBll.UpdateContent(table, CData);
        //推送
        if (!string.IsNullOrEmpty(pushcon_hid.Value))
        {
            string[] nodeArr = pushcon_hid.Value.Trim(',').Split(',');
            for (int i = 0; i < nodeArr.Length; i++)
            {
                CData.NodeID = Convert.ToInt32(nodeArr[i]);
                contentBll.AddContent(table, CData);
            }
        }
        #region 关键词
        {
            keys = StrHelper.RemoveRepeat(CData.TagKey.Split(','), IgnoreKey_Hid.Value.Split(','));
            if (!string.IsNullOrEmpty(keys))
            {
                keyBll.AddKeyWord(keys, 1);
            }
        }
        #endregion
        ZLLog.ToDB(ZLEnum.Log.content, new M_Log()
         {
             UName = adminMod.AdminName,
             Source = Request.RawUrl,
             Action = "修改内容",
             Message = "标题:" + CData.Title + ",Gid:" + CData.GeneralID,
             Level = "edit"
         });
        //修改计划任务(审核时间)
        if (!CheckDate_Hid.Value.Equals(CheckDate_T.Text))
            UpdateSched(GeneralID, M_Content_ScheTask.TaskTypeEnum.AuditArt, CheckDate_T.Text);
        //修改计划任务(过期时间)
        if (!TimeDate_Hid.Value.Equals(TimeDate_T.Text))
            UpdateSched(GeneralID, M_Content_ScheTask.TaskTypeEnum.UnAuditArt, TimeDate_T.Text);
        if (!string.IsNullOrEmpty(Request.Form["HdnSpec"]))//专题
        {
            string SpecID = Request.Form["HdnSpec"];// HdnSpec.Value;
            if (SpecID.EndsWith(","))
            {
                SpecID = SpecID.Substring(0, SpecID.LastIndexOf(","));
            }
        }
        CreateHtmlDel createHtml = CreateHtmlFunc;
        createHtml.BeginInvoke(HttpContext.Current.Request, createnew, CData, table, null, null);
        //if (nodeMod.ListPageHtmlEx < 3 && quickmake.Checked == true)
        //    iscreate = "1";
        Response.Redirect("ContentShow.aspx?gid=" + GeneralID + "&type=edit");
    }
    //更新计划任务
    public void UpdateSched(int gid,M_Content_ScheTask.TaskTypeEnum type,string datetext)
    {
        M_Content_ScheTask taskmod = taskBll.SelByGid(GeneralID, type);
        if (!string.IsNullOrEmpty(datetext))
        {
            if (taskmod == null)
                taskmod = new M_Content_ScheTask();
            taskmod.TaskType = (int)type;
            taskmod.TaskContent = GeneralID.ToString();
            taskmod.ExecuteTime = datetext;
            taskmod.LastTime = DateTime.Parse(datetext);
            taskmod.Status = 0;
            if (taskmod.ID > 0)
            { taskBll.Update(taskmod); }
            else
            { taskBll.Add(taskmod); }
        }
        else if (taskmod != null)
        {
            taskBll.Delete(taskmod.ID);
        }
    }
    //生成Html
    public delegate void CreateHtmlDel(HttpRequest r, bool c, M_CommonData cdate, DataTable table);
    public void CreateHtmlFunc(HttpRequest r, bool c, M_CommonData cdate, DataTable table)
    {
        M_Node nnn = bnode.GetNodeXML(NodeID);
        if (nnn.ListPageHtmlEx < 3 && quickmake.Checked == true)
        {
            B_Create CreateBll = new B_Create(r);
            if (c)
            {
                CreateBll.createann(cdate.GeneralID.ToString());//发布内容页
                CreateBll.CreateColumnByID(NodeID.ToString());//发布栏目页
            }
            CreateBll.CreatePageIndex();//发布首页
        }
        string[] strArr = fieldBll.GetIsChain(ModelID, 1).Split(',');//需要替换的字段
        for (int i = 0; i < strArr.Length; i++)
        {
            DataRow[] dr = table.Select("FieldName = '" + strArr[i] + "' ");
            if (dr != null && dr.Length > 0)
                dr[0]["FieldValue"] = wordBll.RePlaceKeyWord(dr[0]["FieldValue"].ToString());
        }
        contentBll.UpdateContent(table, cdate);
    }
    private void WriteXML(string cxml)
    {
        string filename = "Create_" + DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Millisecond.ToString() + ".config";
        FileSystemObject.Create(Server.MapPath("/Config/" + filename), FsoMethod.File);
        //创建任务对应的XML
        XmlDocument xml = new XmlDocument();
        xml.LoadXml(cxml.ToString());
        xml.Save(HttpContext.Current.Server.MapPath("/Config/" + filename));
    }
    private bool FindInArr(string[] OldArr, string key)
    {
        bool flag = false;
        for (int i = 0; i < OldArr.Length; i++)
        {
            if (key == OldArr[i])
                return true;
        }
        return flag;
    }
    //添加为新内容
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            B_Admin.CheckIsLogged();
            M_AdminInfo adminMod = badmin.GetAdminLogin();
            M_CommonData CData = contentBll.GetCommonData(GeneralID);
            NodeID = CData.NodeID;
            ModelID = CData.ModelID;
            CData.Title = txtTitle.Text;
            int elite = ChkAudit.Checked ? 1 : 0;
            if (CData.EliteLevel == 0 && elite == 1)
            {
                if (SiteConfig.UserConfig.InfoRule > 0)
                {
                    M_UserInfo muser = buser.GetUserByName(adminMod.AdminName);
                    if (!muser.IsNull)
                    {
                        buser.ChangeVirtualMoney(muser.UserID, new M_UserExpHis()
                        {
                            score = SiteConfig.UserConfig.InfoRule,
                            detail = "修改内容:" + txtTitle.Text + "增加积分",
                            ScoreType = (int)M_UserExpHis.SType.Point
                        });
                    }
                }
            }
            CData.EliteLevel = elite;
            CData.InfoID = "";
            CData.Template = TxtTemplate_hid.Value;
            if (TlpView_Tlp.Count > 0)
                CData.Template = TlpView_Tlp.SelectedValue;
            CData.Hits = DataConverter.CLng(txtNum.Text);
            CData.FirstNodeID = (CData.NodeID);
            CData.UpDateType = 2;
            CData.UpDateTime = DataConverter.CDate(txtdate.Text);
            CData.Hits = string.IsNullOrEmpty(txtNum.Text) ? 0 : DataConverter.CLng(txtNum.Text);
            CData.PdfLink = "";
            CData.Status = Convert.ToInt32(ddlFlow.SelectedValue.Trim());
            if (string.IsNullOrEmpty(txtAddTime.Text))
            {
                CData.CreateTime = contentBll.GetCommonData(GeneralID).CreateTime;
            }
            else
            {
                CData.CreateTime = DataConverter.CDate(txtAddTime.Text);
            }
            if (string.IsNullOrEmpty(txtInputer.Text))
            {
                CData.Inputer = contentBll.GetCommonData(GeneralID).Inputer;
            }
            else
            {
                CData.Inputer = txtInputer.Text;
            }
            CData.Status = Convert.ToInt32(ddlFlow.SelectedValue.Trim());
            string OldKey = CData.TagKey;
            //CData.TagKey = Keyword;
            CData.TopImg = "";//首页图片
            DataTable dt = fieldBll.SelByModelID(ModelID);
            Call commonCall = new Call();
            DataTable table = commonCall.GetDTFromPage(dt, Page, ViewState, content);
            int newID = contentBll.AddContent(table, CData);//插入信息给两个表，主表和从表:CData-主表的模型，table-从表
            if (quickmake.Checked == true)
            {
                B_Create CreateBll = new B_Create();
                if (createnew)
                {
                    CreateBll.createann(newID.ToString());//发布内容页
                    CreateBll.CreateColumnByID(NodeID.ToString());//发布栏目页
                }
                CreateBll.CreatePageIndex(); //发布首页
            }
            //关键字
            B_KeyWord kll = new B_KeyWord();
            //积分
            if (SiteConfig.UserConfig.InfoRule > 0)
            {
                M_UserInfo muser = buser.GetUserByName(adminMod.AdminName);
                if (!muser.IsNull)
                {
                    buser.ChangeVirtualMoney(muser.UserID, new M_UserExpHis()
                    {
                        UserID = muser.UserID,
                        detail = "添加内容:" + txtTitle.Text + "增加积分",
                        score = SiteConfig.UserConfig.InfoRule,
                        ScoreType = (int)M_UserExpHis.SType.Point
                    });
                }
            }
            Response.Redirect("ContentShow.aspx?gid=" + newID + "&type=add");
        }
    }
    //-----用于生成Word与PDF
    private string MakePDFFile(M_CommonData CData, IList<string> content)
    {
        pdfLink += CData.GeneralID + ".pdf";
        string strSql = "select source from " + CData.TableName + " where id=" + CData.ItemID;
        string source = "";
        SqlDataReader dr = SqlHelper.ExecuteReader(System.Data.CommandType.Text, strSql);
        if (dr.Read())
        {
            source = dr["source"].ToString();
        }
        dr.Close();
        return pdfLink;
    }
    private void MakeWordFile(M_CommonData CData, string content)
    {
        if (!Directory.Exists(Server.MapPath(wordLink)))
            Directory.CreateDirectory(Server.MapPath(wordLink));
        wordLink += CData.GeneralID + ".doc";
        content = NoHTML(content);
        content = CData.Title + "\r\n" + DateTime.Now.ToString("yyyy年MM月dd日") + "\r\n" + content;
        File.WriteAllText(Server.MapPath(wordLink), content, Encoding.Default);
    }
    public string NoHTML(string Htmlstring)
    {
        //Htmlstring = Htmlstring.Replace("\r\n", "");
        Htmlstring = Regex.Replace(Htmlstring, @"</p>", "\r\n", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"<br/>", "\r\n", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"[PageCode/]", "\r\n", RegexOptions.IgnoreCase);
        //删除脚本
        Htmlstring = Regex.Replace(Htmlstring, @"<script.*?</script>", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"<style.*?</style>", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"<.*?>", "", RegexOptions.IgnoreCase);
        //删除HTML
        Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "", RegexOptions.IgnoreCase);
        //Htmlstring = Regex.Replace(Htmlstring, @"([\r\n])[\s]+", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"-->", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"<!--.*", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(quot|#34);", "\"", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(amp|#38);", "&", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(lt|#60);", "<", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(gt|#62);", ">", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(nbsp|#160);", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(iexcl|#161);", "\xa1", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(cent|#162);", "\xa2", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(pound|#163);", "\xa3", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(copy|#169);", "\xa9", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&#(\d+);", "", RegexOptions.IgnoreCase);
        Htmlstring = Htmlstring.Replace("<", "");
        Htmlstring = Htmlstring.Replace(">", "");
        Htmlstring = HttpContext.Current.Server.HtmlEncode(Htmlstring).Trim();
        Htmlstring = Htmlstring.Replace("&amp;ldquo;", "“");
        Htmlstring = Htmlstring.Replace("&amp;rdquo;", "”");
        Htmlstring = Htmlstring.Replace("&quot;", "\"");
        return Htmlstring;
    }
    protected void makePDFBtn_Click(object sender, EventArgs e)
    {
        if (!Directory.Exists(Server.MapPath(pdfLink)))
            Directory.CreateDirectory(Server.MapPath(pdfLink));
        M_CommonData CData = contentBll.GetCommonData(GeneralID);
        DataTable dt = fieldBll.GetModelFieldList(CData.ModelID);
        Call commonCall = new Call();
        DataTable table = commonCall.GetDTFromPage(dt, Page, ViewState, content);
        GetText(table);
        CData.PdfLink = pdfLink + GeneralID + ".pdf";//必须先设置好再传参
        if (content.Count > 0)
        {
            MakePDFFile(CData, content);
            contentBll.UpdateByID(CData);
            Response.Redirect("EditContent.aspx?GeneralID=" + GeneralID + "&tab=1");
        }
        else
        {
            function.WriteErrMsg("文章内容内容为空，无法生成", "javascript:history.go(-1);");
        }
    }
    protected void delPdfBtn_Click(object sender, EventArgs e)
    {
        M_CommonData CData = contentBll.GetCommonData(GeneralID);
        pdfLink += GeneralID + ".pdf";
        File.Delete(Server.MapPath(pdfLink));
        CData.PdfLink = "";
        contentBll.UpdateByID(CData);
        Response.Redirect("EditContent.aspx?GeneralID=" + GeneralID + "&tab=1");
    }
    protected void downPdfBtn_Click(object sender, EventArgs e)
    {
        pdfLink += GeneralID + ".pdf";
        if (File.Exists(Server.MapPath(pdfLink)))
        {
            DownFile(Server.MapPath(pdfLink), GeneralID + ".pdf");
        }
        Response.Redirect("EditContent.aspx?GeneralID=" + GeneralID + "&tab=1");
    }
    protected void makeWordBtn_Click(object sender, EventArgs e)
    {
        M_CommonData CData = contentBll.GetCommonData(GeneralID);
        DataTable dt = fieldBll.SelByModelID(CData.ModelID);
        Call commonCall = new Call();
        DataTable table = commonCall.GetDTFromPage(dt, Page, ViewState, content);
        GetText(table);
        if (content.Count > 0)
        {
            MakeWordFile(CData, content[0]);
            Response.Redirect("EditContent.aspx?GeneralID=" + GeneralID + "&tab=1");
        }
        else
        {
            function.WriteErrMsg("文章内容内容为空，无法生成", "javascript:history.go(-1);");
        }
    }
    protected void delWordBtn_Click(object sender, EventArgs e)
    {
        wordLink += GeneralID + ".doc";
        File.Delete(Server.MapPath(wordLink));
        Response.Redirect("EditContent.aspx?GeneralID=" + GeneralID + "&tab=1");
    }
    protected void downWordBtn_Click(object sender, EventArgs e)
    {
        wordLink += GeneralID + ".doc";
        if (File.Exists(Server.MapPath(wordLink)))
        {
            DownFile(Server.MapPath(wordLink), GeneralID + ".doc");
        }
        Response.Redirect("EditContent.aspx?GeneralID=" + GeneralID + "&tab=1");
    }
    public List<string> GetText(DataTable table)
    {
        foreach (DataRow dr in table.Rows)
        {
            string ftype = dr["FieldType"].ToString();
            string fvalue = Page.Request.Form["txt_" + dr["FieldName"].ToString()];
            if ((ftype == "TextType" || ftype == "MultipleTextType" || ftype == "MultipleHtmlType" || ftype == "PullFileType") && !string.IsNullOrEmpty(fvalue))
            {
                if (ftype == "MultipleHtmlType")
                {
                    content.Add(fvalue);
                }
            }
        }
        return content;
    }
    //物理路径,回传文件名
    public void DownFile(string path, string downName)
    {
        SafeSC.DownFile(function.PToV(path), downName);
    }
    public string GetOpenView()
    {
        string outstr = " <a href='/Item/" + GeneralID + ".aspx' target='_blank'><span class='glyphicon glyphicon-eye-open'></span></a>";        
        return outstr;
    }
    public void BindTempList()
    {
        string pathdir = (AppDomain.CurrentDomain.BaseDirectory + ZoomLa.Components.SiteConfig.SiteOption.TemplateDir.Replace("/", @"\")).Replace(@"\\", @"\");
        DataTable tables = FileSystemObject.GetDirectoryAllInfos(pathdir + "/内容页/", FsoMethod.File);
        tables.Columns.Add("TemplatePic");//添加模板图片url
        tables.Columns.Add("TemplateID");
        tables.Columns.Add("TemplateUrl");
        for (int i = 0; i < tables.Rows.Count; i++)
        {
            tables.Rows[i]["rname"] = tables.Rows[i]["rname"].ToString().Replace(pathdir, "").Replace(@"\", "/").Substring(1);
            string filename = "内容页_" + Path.GetFileNameWithoutExtension(tables.Rows[i]["name"].ToString()) + ".jpg";
            tables.Rows[i]["TemplatePic"] = ZoomLa.Components.SiteConfig.SiteOption.TemplateDir + "/thumbnail/" + filename;
            tables.Rows[i]["TemplateID"] = tables.Rows[i]["rname"];
            tables.Rows[i]["TemplateUrl"] = tables.Rows[i]["rname"];
            if (!File.Exists(function.VToP(pathdir + "/thumbnail/" + filename)))
            {
                tables.Rows.Remove(tables.Rows[i]);
                i--;
            }
        }
        TlpView_Tlp.DataSource = tables;
        tables.DefaultView.RowFilter = "type=1 OR name LIKE '%.html'";
        TlpView_Tlp.DataBind();
    }
}