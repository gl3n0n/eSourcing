using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
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
using System.Data.Sql;
using System.Data.SqlClient;

/// <summary>
/// CREATED BY: Edrick Tan 02/12/2013
/// </summary>
public partial class web_buyerscreens_prDetails : System.Web.UI.Page
{
    private string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.BUYER)
            Response.Redirect("../unauthorizedaccess.aspx");

        if (Session["PrRefNo"] == null)
            Response.Redirect("viewPR.aspx");
        PageTitle.Text = String.Format(Constant.TITLEFORMAT, "PR Details");

        if (Session[Constant.SESSION_LASTPAGE] != null)
        {
            if (Session[Constant.SESSION_LASTPAGE].ToString() == "~/web/buyerscreens/viewPR.aspx")
            {
                lnkSave.Visible = true;
            }
            else
            {
                lnkSave.Visible = false;
            }
        }
        Label lbStatus = (Label)DetailsView1.FooterRow.FindControl("lblPRStatus");
        TextBox tbItemCode = (TextBox)DetailsView1.FooterRow.FindControl("txtItemCode");
        TextBox tbPRDescription = (TextBox)DetailsView1.FooterRow.FindControl("txtPRDescription");
        TextBox tbDeliveryDate = (TextBox)DetailsView1.FooterRow.FindControl("txtDeliveryDate");
        TextBox tbUOM = (TextBox)DetailsView1.FooterRow.FindControl("txtUOM");
        TextBox tbQty = (TextBox)DetailsView1.FooterRow.FindControl("txtQty");
        TextBox tbUnitPrice = (TextBox)DetailsView1.FooterRow.FindControl("txtUnitPrice");
        TextBox tbCurrency = (TextBox)DetailsView1.FooterRow.FindControl("txtCurrency");
        TextBox tbCommodity = (TextBox)DetailsView1.FooterRow.FindControl("txtCommodity");
        TextBox tbGroupName = (TextBox)DetailsView1.FooterRow.FindControl("txtGroupName");

        if (lbStatus.Text.ToString() == "Used")
        {
            tbItemCode.Enabled = false;
            tbPRDescription.Enabled = false;
            tbDeliveryDate.Enabled = false;
            tbUOM.Enabled = false;
            tbQty.Enabled = false;
            tbUnitPrice.Enabled = false;
            tbCurrency.Enabled = false;
            tbCommodity.Enabled = false;
            tbGroupName.Enabled = false;
            lnkSave.Visible = false;
        }
    }

    //BACK ACTION
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        if (Session[Constant.SESSION_LASTPAGE] != null)
            Response.Redirect(Session[Constant.SESSION_LASTPAGE].ToString());
        else
            Response.Redirect("viewPR.aspx");
    }

    //SAVE CHANGES ACTION
    protected void lnkSave_Click(object sender, EventArgs e)
    {
        Label lblPrRefNo = (Label)DetailsView1.FooterRow.FindControl("lblPrRefNo");
        //Label lbPRNo = (Label)DetailsView1.FooterRow.FindControl("lblPRNo");
        Label lbPRLineNo = (Label)DetailsView1.FooterRow.FindControl("lblPRLineNo");
        Label lbPRDate = (Label)DetailsView1.FooterRow.FindControl("lblPRDate");
        TextBox tbItemCode = (TextBox)DetailsView1.FooterRow.FindControl("txtItemCode");
        TextBox tbPRDescription = (TextBox)DetailsView1.FooterRow.FindControl("txtPRDescription");
        TextBox tbDeliveryDate = (TextBox)DetailsView1.FooterRow.FindControl("txtDeliveryDate");
        TextBox tbUOM = (TextBox)DetailsView1.FooterRow.FindControl("txtUOM");
        TextBox tbQty = (TextBox)DetailsView1.FooterRow.FindControl("txtQty");
        TextBox tbUnitPrice = (TextBox)DetailsView1.FooterRow.FindControl("txtUnitPrice");
        TextBox tbCurrency = (TextBox)DetailsView1.FooterRow.FindControl("txtCurrency");
        TextBox tbCommodity = (TextBox)DetailsView1.FooterRow.FindControl("txtCommodity");
        TextBox tbGroupName = (TextBox)DetailsView1.FooterRow.FindControl("txtGroupName");
        Label lbBuyer = (Label)DetailsView1.FooterRow.FindControl("lblBuyerName");

        UpdatePR(int.Parse(lblPrRefNo.Text.ToString()), int.Parse(lbPRLineNo.Text.ToString()), lbPRDate.Text.ToString(), tbItemCode.Text.ToString(), tbPRDescription.Text.ToString(), tbDeliveryDate.Text.ToString(), tbUOM.Text.ToString(), tbQty.Text.ToString(), tbUnitPrice.Text.ToString(), tbCurrency.Text.ToString(), tbCommodity.Text.ToString(), tbGroupName.Text.ToString(),int.Parse(Session[Constant.SESSION_USERID].ToString()));      
    }

    //UPDATE PR
    private void UpdatePR(int prrefno, int prlineno, string prdate, string itemcode, string prdescription, string deliverydate, string uom, string qty, string unitPrice, string currency, string commodity, string groupname, int buyerId)
    {
        SqlConnection sqlConn = new SqlConnection(connstring);
        SqlTransaction sqlTrans = null;

        try
        {
            sqlConn.Open();
            sqlTrans = sqlConn.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[13];
            sqlParams[0] = new SqlParameter("@PrRefNo", SqlDbType.Int);
            sqlParams[1] = new SqlParameter("@PRLineNo", SqlDbType.Int);
            sqlParams[2] = new SqlParameter("@ItemCode", SqlDbType.VarChar);
            sqlParams[3] = new SqlParameter("@PRDescription", SqlDbType.VarChar);
            sqlParams[4] = new SqlParameter("@PRDate", SqlDbType.DateTime);
            sqlParams[5] = new SqlParameter("@DeliveryDate", SqlDbType.DateTime);
            sqlParams[6] = new SqlParameter("@UOM", SqlDbType.VarChar);
            sqlParams[7] = new SqlParameter("@Qty", SqlDbType.Int);
            sqlParams[8] = new SqlParameter("@UnitPrice", SqlDbType.Money);
            sqlParams[9] = new SqlParameter("@Currency", SqlDbType.VarChar);
            sqlParams[10] = new SqlParameter("@GroupName", SqlDbType.VarChar);
            sqlParams[11] = new SqlParameter("@Commodity", SqlDbType.VarChar);
            sqlParams[12] = new SqlParameter("@BuyerId", SqlDbType.Int);

            sqlParams[0].Value = prrefno;
            sqlParams[1].Value = prlineno;
            sqlParams[2].Value = itemcode;
            sqlParams[3].Value = prdescription;
            sqlParams[4].Value = prdate;
            sqlParams[5].Value = deliverydate;
            sqlParams[6].Value = uom;
            sqlParams[7].Value = qty;
            sqlParams[8].Value = unitPrice;
            sqlParams[9].Value = currency;
            sqlParams[10].Value = groupname;
            sqlParams[11].Value = commodity;
            sqlParams[12].Value = buyerId;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_UpdatePRDetails", sqlParams);
            sqlTrans.Commit();

            lblMessage.Text = "Changes was saved successfully";
        }
        catch (Exception ex)
        {
            sqlTrans.Rollback();
            lblMessage.Text = "Saving of changes was unsuccessful Error: " + ex.Message;
        }
    }
}