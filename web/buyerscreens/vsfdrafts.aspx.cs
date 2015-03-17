using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using EBid.lib;
using EBid.lib.constant;

public partial class web_buyer_screens_vsfdrafts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.BUYER)
            Response.Redirect("../unauthorizedaccess.aspx");

        Session[Constant.SESSION_LASTPAGE] = Request.AppRelativeCurrentExecutionFilePath;
        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Vendor Shortlisting Form");
    }

    protected void gvBids_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("Details"))
        {
            Session["ViewOption"] = "AsBuyer";
            string sArg = e.CommandArgument.ToString().Trim();
            char[] mySeparator = new char[] { ';' };
            string[] Arr = sArg.Split(mySeparator);
            Session["VSFId"] = "";
            Session["VSFId"] = Arr[0].ToString();
            //Session["BuyerBacRefNo"] = Arr[1].ToString();
            Session["pageDetails"] = "vsfdrafts.aspx";
		
            //Server.Transfer("bidawardingchecklist.aspx");
            Server.Transfer("vsfcreate.aspx");
            //System.Web.HttpContext.Current.Response.Write("<SCRIPT LANGUAGE='JavaScript'>alert('" + Session["Session_BidRefNoAsBac"] + "')</SCRIPT>");
            //Server.Transfer("bidawardingchecklist.aspx", true);
        }
    }

    protected void chkShowEventsBeforeDeadline_CheckedChanged(object sender, EventArgs e)
    {
        if (chkShowEventsBeforeDeadline.Checked)
        {
            dsAproved.FilterExpression = "IsPastDeadline = 'NO'";
        }
        else
        {
            dsAproved.FilterExpression = "IsPastDeadline IN ('YES','NO')";
        }
        dsAproved.DataBind();
    }
}
