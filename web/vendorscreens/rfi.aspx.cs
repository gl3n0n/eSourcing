using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EBid.lib.bid.data;
using EBid.lib.bid.trans;
using EBid.lib.user.trans;
using EBid.lib.constant;
using EBid.lib;

public partial class web_vendorscreens_rfi : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.VENDOR)
            Response.Redirect("../unauthorizedaccess.aspx");

        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "New RFI Events");

        Session[Constant.SESSION_LASTPAGE] = Request.AppRelativeCurrentExecutionFilePath;

        Session["TVendorId"] = Session[Constant.SESSION_USERID].ToString();
    }

    protected void gvNewRfiEvents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("SelectRfiItem"))
        {
            string[] s = e.CommandArgument.ToString().Split(new char[] { '|' });
            Session["RfiRefNo"] = s[0];
            if (s[1] == "0")
            {
                Session["ViewOption"] = "AsBuyer";
                //Response.Redirect("rfidetails.aspx");
                Response.Redirect("submitrfitender.aspx");
            }
            else if (s[1] == "1")
            {
                Response.Redirect("submitrfitender.aspx");
            }
            //Response.Redirect("submitrfitender.aspx");
        }
    }
}