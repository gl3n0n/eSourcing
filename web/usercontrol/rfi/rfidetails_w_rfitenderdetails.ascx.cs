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
using EBid.lib.bid.data;
using EBid.lib.bid.trans;
using EBid.lib.user.trans;
using EBid.lib.user.data;
using EBid.lib;

public partial class web_usercontrol_rfi_rfidetails_w_rfitenderdetails : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        pnlVendor.Visible = (Session[Constant.SESSION_USERTYPE].ToString() == "2");
    }

    protected void gvRfiItemDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "RfiTenderDetails":
                {
                    string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                    Session["RfiRefNo"] = args[0];
                    Session["RfiTenderNo"] = args[1];
                    Session["RfiDetailNo"] = args[2];

                    Response.Redirect("rfiitemdetails.aspx");

                } break;
        }
    }

    protected void lnkContactBuyer_Click(object sender, EventArgs e)
    {
        Session["CB_BuyerID"] = dView.DataKey["BuyerId"].ToString();
        Session["CB_Subject"] = String.Format("RFI EVENT INQUIRY: {0}", dView.DataKey["ItemDesc"].ToString());
        Response.Redirect("contactbuyer.aspx");
    }
}