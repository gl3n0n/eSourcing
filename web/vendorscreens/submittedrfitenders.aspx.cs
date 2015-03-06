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
using EBid.lib.constant;
using EBid.lib.bid.data;
using EBid.lib.bid.trans;
using EBid.lib;

public partial class web_vendorscreens_submittedrfitenders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.VENDOR)
            Response.Redirect("../unauthorizedaccess.aspx");
        Session[Constant.SESSION_LASTPAGE] = Request.AppRelativeCurrentExecutionFilePath;

        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Submitted RFI Tenders");
        if (Session["Renegotiated"] != null)
            Session["Renegotiated"] = null;
    }
    protected void gvSubmittedRfiTenders_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "EditRfiTender":
                {
                    string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                    Session["RfiDetailNo"] = args[0];
                    Session["RfiTenderNo"] = args[1];
                    Session["RfiRefNo"] = args[3];
                    DateTime deadline = DateTime.Parse(args[2]);
                    Response.Redirect("rfiitemdetails.aspx");
                } break;
            case "EditRfiEventTenders":
                {
                    string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                    Session["RfiRefNo"] = args[0];
                    Session["RfiTenderNo"] = args[1];
                    Response.Redirect("rfieventdetails.aspx");
                } break;
        }
    }
}