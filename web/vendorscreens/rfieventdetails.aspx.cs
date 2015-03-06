using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EBid.lib.bid.data;
using EBid.lib.bid.trans;
using EBid.lib.constant;
using EBid.lib;
using EBid.lib.rfi;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;

public partial class web_vendorscreens_rfieventdetails : System.Web.UI.Page
{
    private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.VENDOR)
            Response.Redirect("../unauthorizedaccess.aspx");

        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "RFI Event Details");

        if (Session["RfiRefNo"] == null)
            Response.Redirect("rfi.aspx");

    }

    //protected void btnRfi_Click(object sender, EventArgs e)
    //{
    //    int rfi = int.Parse(Session["RfiRefNo"].ToString());
    //    int uid = int.Parse(Session[Constant.SESSION_USERID].ToString());
    //    RfiEventTransaction.ConfirmRfiInvitation(rfi, uid);
    //    Response.Redirect("submitrfitender.aspx");
    //}

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        if (Session[Constant.SESSION_LASTPAGE] != null)
            Response.Redirect(Session[Constant.SESSION_LASTPAGE].ToString());
        else
            Response.Redirect("rfi.aspx");
    }
}