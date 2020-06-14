using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ZoomLa.BLL;
using ZoomLa.Common;
using ZoomLa.Model;
using ZoomLa.Components;
using ZoomLa.SQLDAL;
using ThoughtWorks.QRCode.Codec;
using System.Drawing;
using System.IO;

public partial class User_Info_UserBase : CustomerPageAction
{
        
    B_User buser = new B_User();
    B_Group gpBll = new B_Group();
    B_UserBaseField ubfbll = new B_UserBaseField();
    B_ModelField fieldBll = new B_ModelField();
    B_PointGrounp pointBll = new B_PointGrounp();
    protected void Page_Load(object sender, EventArgs e)
    { 
        if (!IsPostBack)
        {
            switchID.Value = HttpUtility.HtmlEncode(Request.QueryString["sel"]);
            if (!buser.CheckLogin())
            {
                function.WriteErrMsg("请先<a href=/User/Login.aspx>登录</a>！", "/User/Login.aspx");
            }
            if (SiteConfig.UserConfig.UserMobilAuth.Equals("0"))
            {
                tbMobile.Enabled = false;
            }
            M_UserInfo mu = buser.GetLogin();
            UserFace_Hid.Value = Path.GetFileName(mu.UserFace);
            tbUserFace.Text = mu.UserFace;
            CompanyName.Text = mu.CompanyName;
            UserFace_Img.ImageUrl = mu.UserFace;
            SFile_Up.FileUrl = mu.UserFace;
            //CompanyGroup是否为企业用户组0-否 1-是
            //if (gpBll.GetByID(Convert.ToInt32(mu.GroupID)).CompanyGroup == 1)
            //{
            //    DivCompany.Visible = true;
            //    txtCompanyName.Text = mu.CompanyName;
            //    txtCompanyDescribe.Text = mu.CompanyDescribe;
            //}
            M_Uinfo binfo = buser.GetUserBaseByuserid(mu.UserID);
            if (!binfo.IsNull)
            {
                tbTrueName.Text = mu.TrueName;
                txtHonName.Text = mu.HoneyName;
                tbUserSex.SelectedValue = binfo.UserSex ? "1" : "0";
                address.Value = binfo.Province + "," + binfo.City + "," + binfo.County;
                tbAddress.Text = binfo.Address;
                tbBirthday.Text = binfo.BirthDay;
                tbFaceWidth.Text = binfo.FaceWidth.ToString();
                tbFaceHeight.Text = binfo.FaceHeight.ToString();
                tbFax.Text = binfo.Fax;
                tbHomepage.Text = binfo.HomePage;
                tbHomePhone.Text = binfo.HomePhone;
                tbIDCard.Text = binfo.IDCard;
                tbMobile.Text = binfo.Mobile;
                tbMSN.Text = binfo.MSN;
                tbOfficePhone.Text = binfo.OfficePhone;
                tbPrivacy.SelectedValue = binfo.Privating.ToString();
                tbQQ.Text = binfo.QQ;
                tbSign.Text = binfo.Sign;
                tbUC.Text = binfo.UC;
                tbZipCode.Text = binfo.ZipCode;
                //公司信息与职务
                Position.Text = binfo.Position;
            }
            lblHtml.Text = fieldBll.InputallHtml(0, 0, new ModelConfig()
            {
                Fields = SiteConfig.UserConfig.RegFieldsMustFill + "," + SiteConfig.UserConfig.RegFieldsSelectFill,
                Source = ModelConfig.SType.UserRegister,
                ValueDT = buser.GetUserBaseByuserid(mu.UserID.ToString())
            });
        }
    }
    protected void sure_Click(object sender, EventArgs e)
    {
        M_UserInfo info = buser.GetLogin();
        string PWD = Second.Text;

        if (StringHelper.MD5(PWD) == info.PayPassWord)
        {
            DV_show.Visible = true;
            Login.Visible = false;
        }
        else
        {
            Response.Write("<script>alert('密码错误,请重新输入！');</script>");
            DV_show.Visible = false;
            Login.Visible = true;
            ;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!buser.CheckLogin())
        {
            function.WriteErrMsg("请先登录！", "/User/Login.aspx");
        }
        else
        {
            DataTable dt = ubfbll.Select_All();
            Call commonCall = new Call();
            DataTable table = commonCall.GetDTFromPage(dt, Page, ViewState);
            M_UserInfo uinfo = buser.GetLogin();
            uinfo.UserFace = tbUserFace.Text.Trim();
            uinfo.HoneyName = Server.HtmlEncode(txtHonName.Text.Trim());
            uinfo.CompanyName = Server.HtmlEncode(CompanyName.Text.Trim());
            M_Uinfo binfo = buser.GetUserBaseByuserid(uinfo.UserID);
            binfo.Address = Server.HtmlEncode(tbAddress.Text.Trim());
            binfo.BirthDay = Server.HtmlEncode(tbBirthday.Text.Trim());
            binfo.FaceHeight = DataConverter.CLng(tbFaceHeight.Text.Trim());
            binfo.FaceWidth = DataConverter.CLng(tbFaceWidth.Text.Trim());
            binfo.UserFace = uinfo.UserFace;
            binfo.Fax = tbFax.Text.Trim();
            binfo.HomePage = Server.HtmlEncode(tbHomepage.Text.Trim());
            //binfo.ICQ = Server.HtmlEncode(tbICQ.Text.Trim());
            binfo.HomePhone = Server.HtmlEncode(tbHomePhone.Text.Trim());
            binfo.IDCard = Server.HtmlEncode(tbIDCard.Text.Trim());
            binfo.Mobile = Server.HtmlEncode(tbMobile.Text.Trim());
            binfo.MSN = Server.HtmlEncode(tbMSN.Text.Trim());
            binfo.OfficePhone = Server.HtmlEncode(tbOfficePhone.Text.Trim());
            binfo.Privating = tbPrivacy.SelectedIndex;
            //binfo.PHS = Server.HtmlEncode(tbPHS.Text.Trim());
            binfo.QQ = Server.HtmlEncode(tbQQ.Text.Trim());
            binfo.Sign = Server.HtmlEncode(tbSign.Text.Trim());
            uinfo.TrueName = Server.HtmlEncode(tbTrueName.Text.Trim());
            binfo.UC = Server.HtmlEncode(tbUC.Text.Trim());
            binfo.UserSex = DataConverter.CBool(tbUserSex.SelectedValue);
            //binfo.Yahoo = Server.HtmlEncode(tbYahoo.Text.Trim());
            binfo.ZipCode = Server.HtmlEncode(tbZipCode.Text.Trim());
            binfo.HoneyName = uinfo.HoneyName;
            string[] adrestr=address.Value.Split(new char[]{','},StringSplitOptions.RemoveEmptyEntries);
            binfo.Province = adrestr[0];
            binfo.City = adrestr[1];
            binfo.County = adrestr[2];
            binfo.Position = Server.HtmlEncode(Position.Text.Trim());
            if (binfo.IsNull)
            {
                binfo.UserId = uinfo.UserID;
                buser.UpDateUser(uinfo);
                buser.AddBase(binfo);
            }
            else
            {
                uinfo.CompanyName = Server.HtmlEncode(txtCompanyName.Text);
                uinfo.CompanyDescribe = Server.HtmlEncode(txtCompanyDescribe.Text);
                buser.UpDateUser(uinfo);
                buser.UpdateBase(binfo);//更新用户信息 
            }
            if (table.Rows.Count > 0)
            {
                buser.UpdateUserFile(binfo.UserId, table);
            }
            Response.Redirect(Request.RawUrl);
        }
    }
    public void SwitchEditState(bool bSelected)
    {
        tbTrueName.Enabled = bSelected;
        txtHonName.Enabled = bSelected;
        tbUserSex.Enabled = bSelected;
        tbAddress.Enabled = bSelected;
        tbBirthday.Enabled = bSelected;
        tbFaceWidth.Enabled = bSelected;
        tbFaceHeight.Enabled = bSelected;
        tbFax.Enabled = bSelected;
        tbHomepage.Enabled = bSelected;
        tbHomePhone.Enabled = bSelected;
        //tbICQ.Enabled = bSelected;
        tbIDCard.Enabled = bSelected;
        tbMobile.Enabled = bSelected;
        tbMSN.Enabled = bSelected;
        tbOfficePhone.Enabled = bSelected;
        //tbPHS.Enabled = bSelected;
        tbPrivacy.Enabled = bSelected;
        tbQQ.Enabled = bSelected;
        tbSign.Enabled = bSelected;
        tbUC.Enabled = bSelected;
        tbUserFace.Enabled = bSelected;
        btnSave.Enabled = bSelected;
        //tbYahoo.Enabled = bSelected;
        tbZipCode.Enabled = bSelected;
        Response.Write("<script>document.getElementById('myface').disabled=" + bSelected + ";</script>");
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        SwitchEditState(true);  //切换控件可编辑的状态
    }
    protected void BtUpImage_Click(object sender, EventArgs e)
    {
        M_UserInfo mu=buser.GetLogin();
        string vpath = SiteConfig.SiteOption.UploadDir + "User/" + mu.UserName + mu.UserID + "/";
        SFile_Up.SaveUrl = vpath;
        string imgurl= SFile_Up.SaveFile();
        UserFace_Img.ImageUrl = imgurl;
        UserFace_Hid.Value = Path.GetFileName(imgurl);
        tbUserFace.Text = imgurl;
    }
    private System.Drawing.Image SaveCode(QRCodeEncoder qrCodeEncoder, String data, System.Drawing.Image image, int Type)
    {
        image = qrCodeEncoder.Encode(data, System.Text.Encoding.Default);
        string upclass, newtimename, filenames, filesname, indexname, tempfilename;
        upclass = Server.HtmlEncode(Request.QueryString["menu"]);
        using (Bitmap bp = new Bitmap(image))
        {
            using (MemoryStream stream = new MemoryStream())
            {
                //bp.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);
                filenames = "QrCode.jpg";
                if (filenames.Length > 0)
                {
                    if (filenames.IndexOf(".") > 0)
                    {
                        filesname = filenames.Substring(filenames.LastIndexOf(".")).ToLower();
                        Random indexcc = new Random();
                        indexname = Convert.ToString(indexcc.Next(9999));//取出一个随机数

                        //如目录不存在则创建目录
                        if (!Directory.Exists(Server.MapPath(SiteConfig.SiteOption.UploadDir + "/QrCode")))
                        {
                            Directory.CreateDirectory(Server.MapPath(SiteConfig.SiteOption.UploadDir + "/QrCode"));
                        }

                        newtimename = Convert.ToString(DateTime.Now.Year) + Convert.ToString(DateTime.Now.Month) + Convert.ToString(DateTime.Now.Day) + Convert.ToString(DateTime.Now.Hour) + Convert.ToString(DateTime.Now.Minute) + Convert.ToString(DateTime.Now.Second) + Convert.ToString(DateTime.Now.Millisecond);

                        tempfilename = SiteConfig.SiteOption.UploadDir + "/QrCode/" + newtimename + indexname + filesname;
                        try
                        {
                            image.Save(Server.MapPath(tempfilename));
                        }
                        catch (Exception err)
                        {
                            Response.Write(err);
                        }
                        ImgCode.ImageUrl = tempfilename;
                        //Mcode.ImageUrl = "QrCode/" + newtimename + indexname + filesname;

                        //Mcode.CreateTime = DateTime.Now;
                        if (!string.IsNullOrEmpty(Request["ID"]))
                        {
                            //Mcode.ID = DataConverter.CLng(Request["ID"]);
                            //if (Bcode.UpdateByID(Mcode))
                            //{
                            //    ClientScript.RegisterStartupScript(GetType(), "", "<script>alert('修改成功');</script>");
                            //}
                            //else
                            //{
                            //    ClientScript.RegisterStartupScript(GetType(), "", "<script>alert('修改失败');</script>");
                            //}
                        }
                        else
                        {
                            //    if (Bcode.insert(Mcode) > 0)
                            //    {
                            //        //成功
                            //    }
                            //    else
                            //    {
                            //        ClientScript.RegisterStartupScript(GetType(), "", "<script>alert('创建失败');</script>");
                            //    }
                            //}
                        }
                    }
                }
            }
            return image;
        }
    }//生成二维码
}