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
using EBid.lib.bid.trans;
using EBid.lib.constant;
using EBid.lib;

public partial class web_buyerscreens_submittedrfiitems : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.BUYER)
            Response.Redirect("../unauthorizedaccess.aspx");
        
        Session[Constant.SESSION_LASTPAGE] = Request.AppRelativeCurrentExecutionFilePath;
        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "RFI Events For Approval");
    }

    protected void gvRfis_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Details":
                {
                    Session["RfiRefNo"]
 = e.CommandArgument.ToString();
                    Response.Redirect("rfieventdetails.aspx");
                } break;
        }
    }
}