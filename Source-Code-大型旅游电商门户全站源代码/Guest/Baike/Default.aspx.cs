using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Model;
using System.Data;
using System.Text.RegularExpressions;
using ZoomLa.SQLDAL;


public partial class Guestbook_BkSearch : System.Web.UI.Page
{
    B_Baike b_Baike = new B_Baike();
    protected B_User b_User = new B_User();
    protected void Page_Load(object sender, EventArgs e)
    {
       //lblTittle.Text = "";
        if (!IsPostBack)
        { 
            if (b_User.CheckLogin())
            {
            } 
            string tittle = Request.QueryString["tittle"];
            if (!string.IsNullOrEmpty(tittle))
            {
            }
            bindType();
            bindSee();
            bindElite();
            bindUser();
            bindAlter();
            bindCreat();
            //bindElite2();
            bindBrief();
         //   Bindpage();
            Bindmans();
            Bindlatestnews();
            BindTS();
            bindElitepicture();
            bindDateTimeNow();
        }
    }

    protected void bindType()
    {
        DataTable dt = B_GradeOption.GetGradeList(3, 0);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)//指触发的类型为DadaList中的基本行或内容行
        {
            Repeater rep = e.Item.FindControl("Repeater2") as Repeater;//找到里层的repeater对象
            DataRowView rowv = (DataRowView)e.Item.DataItem;//找到分类Repeater关联的数据项 
            int Gid = DataConvert.CLng(rowv["GradeID"]);
            DataTable dt = B_GradeOption.GetGradeListTop(3, Gid,3);
            rep.DataSource = dt;
            rep.DataBind();
        }
    }

    protected void bindSee()
    {
        DataTable dt = b_Baike.SelectSee(10, "status>0", " AddTime desc");
        Repeater3.DataSource = dt;
        Repeater3.DataBind();
    }

    protected void bindElite()
    {
        DataTable dt = b_Baike.SelectSee(1, " status>0 And Elite=1", " AddTime desc");
        Repeater4.DataSource = dt;
        Repeater4.DataBind();
    }

    protected void bindDateTimeNow()
    {
        DataTable dt = b_Baike.SelectSee(1, " status>0 and tittle like '%" + DateTime.Now.Month + "%' and tittle like '%" + DateTime.Now.Day + "%'", " AddTime desc");
        Repeater9.DataSource = dt;
        Repeater9.DataBind();
    }

    protected void bindElitepicture()
    {
        DataTable dt = b_Baike.SelectSee(1, " status>0 And Elite=3", " AddTime desc");
        picture.DataSource = dt;
        picture.DataBind();
    }

    protected void bindBrief()
    {
        DataTable dt = b_Baike.SelectSee(10, "datediff(day, getdate(),AddTime)=0 and status>0", "AddTime desc");
        Youkown.DataSource = dt;
        Youkown.DataBind();
    }

    protected void bindUser()
    {
        DataTable dt = b_Baike.SelectSee(10, "datediff(week,getdate(),AddTime)<1", " AddTime desc");
        B_User buser = new B_User();
        DataTable dt2 = new DataTable();
        if(dt.Rows.Count>0){
        for (int i = 0; i < dt.Rows.Count;i++ )
        {
            dt2 = buser.GetUserBaseByuserid(dt.Rows[i]["UserID"].ToString());
        }
        Repeater5.DataSource = dt2;
        Repeater5.DataBind();
        }
    }
      
    protected void bindAlter()
    {
        DataTable dt = b_Baike.SelectSee(6, "status=2", " AddTime desc");
        Repeater6.DataSource = dt;
        Repeater6.DataBind(); 
    }
      
    protected void bindCreat()
       {
           DataTable dt = b_Baike.SelectSee(15, "status=-1", " AddTime desc");
           Repeater7.DataSource = dt;
           Repeater7.DataBind();
       }

    protected void BindTS()
    {
        DataTable dt = b_Baike.SelectSee(1, "status>0 and Elite=2", "AddTime desc");
        Repeater8.DataSource = dt;
        Repeater8.DataBind();
    }

    protected void Bindmans()
    { 
        DataTable dt = b_Baike.SelectSee(1, "status>0 and Classification='人物'", "AddTime desc");
        mans.DataSource = dt;
        mans.DataBind();
    }

    protected void Bindlatestnews()
    { 
        //B_Content bcont=new B_Content();
        //M_CommonData model=new M_CommonData();
        //DataTable dt = bcont.SelectSee(5,"status=99","CreateTime desc");
        //Latestrnews.DataSource = dt;
        //Latestrnews.DataBind();
    }

    public  string NoHTML(string Htmlstring) //替换HTML标记
    {
        string pattern = "http://([^\\s]+)\".+?span.+?\\[(.+?)\\].+?>(.+?)<";
        Regex reg = new Regex(pattern, RegexOptions.IgnoreCase);
        //删除脚本
        Htmlstring = Regex.Replace(Htmlstring, @"<script[^>]*?>.*?</script>", "", RegexOptions.IgnoreCase);
        //删除HTML
        Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"([\r\n])[\s]+", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"-->", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"<!--.*", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(quot|#34);", "\"", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(amp|#38);", "&", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(lt|#60);", "<", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(gt|#62);", ">", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(nbsp|#160);", " ", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(iexcl|#161);", "\xa1", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(cent|#162);", "\xa2", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(pound|#163);", "\xa3", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(copy|#169);", "\xa9", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&#(\d+);", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"<img[^>]*>;", "", RegexOptions.IgnoreCase);
        Htmlstring.Replace("<", "");
        Htmlstring.Replace(">", "");
        Htmlstring.Replace("\r\n", "");
        Htmlstring = HttpContext.Current.Server.HtmlEncode(Htmlstring).Trim();
        if (Htmlstring.Length > 200 || Htmlstring.Length > 20)
        {
            return Htmlstring.Substring(0,10);
        }
        return Htmlstring;
    }

    

    public string GetLeftString(string str)
    {
        if (str.Length <= 12)
            return str;
        return str.Substring(0, 12) + "..."; ;
    }
    protected string getstyle()
    {
        if (b_User.CheckLogin())
        {
            return "display:inline-table";
        }
        else return "display:none";
    }
    protected string getstyles()
    {
        if (b_User.CheckLogin())
        {
            return "display:none";
        }
        else return "display:inline-table";
    }
}