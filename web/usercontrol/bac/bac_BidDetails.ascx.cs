using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using EBid.lib;
using System.Data.SqlClient;

public partial class web_usercontrol_bac_BidDetails : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

        // main
        string BidRef = "";
        string sCommand = "SELECT Budgeted, CompanyID, BidRefNo FROM tblBACBidItems WHERE BacRefNo=" + Session["BuyerBacRefNo"] + "";
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            string sBudgeted = oReader["Budgeted"].ToString();
            switch (sBudgeted)
            {
                case "0": UnBudgeted.Checked = true; break;
                case "1": Budgeted.Checked = true; break;
            }
            string sCompanyID = oReader["CompanyId"].ToString();
            switch (sCompanyID)
            {
                case "0": CompanyIdGT.Checked = true; break;
                case "1": CompanyIdIC.Checked = true; break;
                case "2": CompanyIdGXI.Checked = true; break;
                case "3": CompanyIdEGG.Checked = true; break;
            }
            BidRef = oReader["BidRefNo"].ToString();
        }
        oReader.Close();

        if (Convert.ToInt32(BidRef) > 0 || Convert.ToInt32(BidRef) == -1)
        {
            sCommand = "SELECT Currency FROM tblBidItems WHERE BidRefNo=" + BidRef + " ";
            BACType1.Text = "BID ";
            BACType2.Text = "Bid ";
            BACType3.Text = "Bid ";
        }
        else
        {
            sCommand = "SELECT BidCurrency Currency FROM tblAuctionItems WHERE AuctionRefNo=ABS(" + BidRef + ")";
            BACType1.Text = "AUCTION ";
            BACType2.Text = "Auction ";
            BACType3.Text = "Auction ";
        }
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            EstItemValueLblCurr.Text = oReader["Currency"].ToString();
            oReader.Close();
        }
    }
}