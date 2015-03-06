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

public partial class usercontrol_reports_filters : System.Web.UI.UserControl
{
    //private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            clndrStartDate.Attributes.Add("style", "text-align:center;");
            clndrEndDate.Attributes.Add("style", "text-align:center;");
            //clndrStartDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            //clndrEndDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            ddlBuyerList.Items.Insert(0, new ListItem("---Select Buyer---", "0"));
            ddlBuyerList.SelectedIndex = 0;

        }

    }


    protected void lnkViewReport_Click(object sender, EventArgs e)
    {
        //TotalBidsReportParameter param = new TotalBidsReportParameter();
        //param.StartDate = DateTime.Parse(clndrStartDate.Text);
        //param.EndDate = DateTime.Parse(clndrEndDate.Text);
        //Session[Constant.PARAMETER_TOTALBIDS] = param;

        VendorParticipationStatReportParameter param = new VendorParticipationStatReportParameter();

        //param.BuyerId = null;
        //param.BuyerId = (ddlBuyerList.SelectedValue.ToString()).Trim().Length > 1 ? ddlBuyerList.SelectedValue.ToString() : null;        
        param.BuyerId = (ddlBuyerList.SelectedValue.ToString().Length > 1) ? ddlBuyerList.SelectedValue.ToString() : "";
        param.StartDate = (clndrStartDate.Text.Trim().Length > 0) ? DateTime.Parse(clndrStartDate.Text) : DateTime.Parse("1901-01-01 00:00:00");
        param.EndDate = (clndrEndDate.Text.Trim().Length > 0) ? DateTime.Parse(clndrEndDate.Text) : DateTime.Parse("2100-01-01 00:00:00");
        param.BuyerName = (ddlBuyerList.SelectedValue.ToString().Length > 1) ? ddlBuyerList.SelectedItem.Text.ToString() : "";
                
        Session[Constant.PARAMETER_VENDORPARTICIPATIONSTAT] = param;

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SHOWWINDOW", "<script type='text/javascript'> window.open('../reports/vendorparticipationstat.aspx','r1', 'toolbar=no,width=960, menubar=no, resizable=yes , scrollbars=yes'); </script>");

    }


    //private int GetParameterValue()
    //{
    //    SqlConnection sqlConnect = new SqlConnection(connstring);
    //    SqlTransaction sqlTransact = null;
    //    int value = 0;

    //    try
    //    {
    //        sqlConnect.Open();
    //        sqlTransact = sqlConnect.BeginTransaction();

    //        SqlParameter[] sqlParams = new SqlParameter[5];
    //        sqlParams[0] = new SqlParameter("@BuyerId", SqlDbType.NVarChar);
    //        sqlParams[1] = new SqlParameter("@StartDate", SqlDbType.DateTime);
    //        sqlParams[2] = new SqlParameter("@EndDate", SqlDbType.DateTime);
    //        sqlParams[3] = new SqlParameter("@SourcingStrategy", SqlDbType.NVarChar);
    //        sqlParams[4] = new SqlParameter("@CommoditySpendCategory", SqlDbType.NVarChar);


    //        sqlParams[0].Value = (Int32.Parse(ddlBuyerList.SelectedValue.ToString()) > 0) ? Int32.Parse(ddlBuyerList.SelectedValue.ToString()) : null;
    //        sqlParams[1].Value = (clndrStartDate.Text.Trim().Length > 0) ? clndrStartDate.Text.Trim() : null;
    //        sqlParams[2].Value = (clndrEndDate.Text.Trim().Length > 0) ? clndrEndDate.Text.Trim() : null;
    //        sqlParams[3].Value = (SourcingStrategy.Text.Trim().Length > 0) ? SourcingStrategy.Text.Trim() : null;
    //        sqlParams[4].Value = (CommoditySpendCategory.Text.Trim().Length > 0) ? CommoditySpendCategory.Text.Trim() : null;

    //        value = Convert.ToInt32(SqlHelper.ExecuteScalar(sqlTransact, "sp_Report_VendorParticipationStats", sqlParams));

    //        sqlTransact.Commit();
    //    }
    //    catch
    //    {
    //        sqlTransact.Rollback();
    //        value = 0;
    //    }
    //    finally
    //    {
    //        sqlConnect.Close();
    //    }

    //    return value;
    //}
}
