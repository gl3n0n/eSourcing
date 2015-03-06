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
using EBid.lib.constant;
using EBid.lib.bid.trans;
using EBid.lib;

public partial class web_buyerscreens_rfiforeval : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.BUYER)
            Response.Redirect("../unauthorizedaccess.aspx");

        Session[Constant.SESSION_LASTPAGE] = Request.AppRelativeCurrentExecutionFilePath;
        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Received RFI Tenders");

        if (!IsPostBack)
        {
            // set checkbox default checked value
            if (Session["ShowItemsWithTendersOnly"] != null)
            {
                chkShowTenderizedRfisOnly.Checked = bool.Parse(Session["ShowItemsWithTendersOnly"].ToString());
                if (chkShowTenderizedRfisOnly.Checked)
                    dsReceivedItemTenders.FilterExpression = "SubmittedTenderCount >= 1";
                else
                    dsReceivedItemTenders.FilterExpression = "SubmittedTenderCount >= 0";
                gvReceivedUnlockedTenders.DataSourceID = "dsReceivedItemTenders";
                gvReceivedUnlockedTenders.DataBind();
            }

            if (Session["ShowItemsWithPastSubmission"] != null)
            {
                chkPastSubmissionDeadline.Checked = bool.Parse(Session["ShowItemsWithPastSubmission"].ToString());
            }
        }
    }

    protected void gvReceivedUnlockedTenders_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow gvr = ((Control)e.CommandSource).NamingContainer as GridViewRow;

        switch (e.CommandName.ToString().Trim())
        {
            case "ViewRfiEventDetails":
                Session["ViewOption"] = "AsBuyer";
                Session["RfiRefNo"] = e.CommandArgument.ToString().Trim();
                Response.Redirect("rfieventdetails.aspx");
                break;
            case "ViewRfiItemDetails":
                Session["RfiRefNo"] = gvReceivedUnlockedTenders.DataKeys[gvr.RowIndex].Values[0].ToString();
                Session["RfiDetailNo"] = e.CommandArgument.ToString().Trim();
                Response.Redirect("rfiitemdetails.aspx");
                break;
        }
    }

    protected void gvReceivedUnlockedTenders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Attributes.Add("style", "padding-left: 5px;");
            e.Row.Cells[1].Attributes.Add("style", "padding-left: 5px;");
        }
    }

    //CHECKS WHETHER THE STATUS OF THE RECORD IS "OPEN"
    public bool valueIsOpen(Object itemStat, Object itemCount)
    {
        int count = Int32.Parse(itemCount.ToString());

        if (itemStat.ToString().ToUpper() == "Open".ToUpper())
            return (count > 0);
        else
            return false;
    }

    //CHECKS WHETHER THE STATUS OF THE RECORD IS "OPEN"
    public bool valueIsNotOpen(Object itemStat, Object itemCount)
    {
        int count = Int32.Parse(itemCount.ToString());

        if (itemStat.ToString().ToUpper() != "Open".ToUpper())
            return true;
        else
        {
            return (count <= 0);
        }
    }

    protected string showRfiTenderCount(Object itemCount)
    {
        int count = Int32.Parse(itemCount.ToString());

        if (count == 0)
            return "(There are no rfi tenders for this item.)";
        else if (count == 1)
            return "(There is 1 rfi tender for this item.)";
        else
            return "(There are " + itemCount + " rfi tenders for this item.)";
    }

    protected void chkShowTenderizedRfisOnly_CheckedChanged(object sender, EventArgs e)
    {
        Session["ShowItemsWithTendersOnly"] = chkShowTenderizedRfisOnly.Checked.ToString();
        HiddenField1.Value = chkShowTenderizedRfisOnly.Checked ? "1" : "0";
    }

    protected void chkPastSubmissionDeadline_CheckedChanged(object sender, EventArgs e)
    {
        Session["ShowItemsWithPastSubmission"] = chkPastSubmissionDeadline.Checked.ToString();
        if (chkPastSubmissionDeadline.Checked == true)
        {
            dsReceivedItemTenders.FilterExpression = "DateNow >  Deadline";
            gvReceivedUnlockedTenders.DataBind();
        }
    }

}