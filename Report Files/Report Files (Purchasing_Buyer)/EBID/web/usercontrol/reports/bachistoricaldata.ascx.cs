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
using EBid.lib.report;
using EBid.lib.reportnew;
using EBid.lib.constantnew;


public partial class usercontrol_reports_bachistoricaldata : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    { 
        if (!IsPostBack)
        {
            clndrStartDate.Attributes.Add("style", "text-align:center;");
            clndrEndDate.Attributes.Add("style", "text-align:center;");
            ddlBuyerList.Items.Insert(0, new ListItem("---Select Buyer---", "0"));
            ddlBuyerList.SelectedIndex = 0;

        }

    }


    protected void lnkViewReport_Click(object sender, EventArgs e)
    {
        BACHistoricalDataReportParameter param = new BACHistoricalDataReportParameter();
        
        
        param.BuyerId = (ddlBuyerList.SelectedValue.ToString().Length > 1) ? ddlBuyerList.SelectedValue.ToString() : "";
        param.StartDate = (clndrStartDate.Text.Trim().Length > 0) ? DateTime.Parse(clndrStartDate.Text) : DateTime.Parse("1901-01-01 00:00:00");
        param.EndDate = (clndrEndDate.Text.Trim().Length > 0) ? DateTime.Parse(clndrEndDate.Text) : DateTime.Parse("2100-01-01 00:00:00");
        param.BuyerName = (ddlBuyerList.SelectedValue.ToString().Length > 1) ? ddlBuyerList.SelectedItem.Text.ToString() : "";
        
        Session[ConstantNew.PARAMETER_BACHISTORICALDATA] = param;

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SHOWWINDOW", "<script type='text/javascript'> window.open('../reports/bachistoricaldata.aspx','r1', 'toolbar=no,width=960, menubar=no, resizable=yes , scrollbars=yes'); </script>");

    }
}
