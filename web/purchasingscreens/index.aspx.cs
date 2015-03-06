using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EBid.lib.bid.trans;
using EBid.lib.auction.trans;
using EBid.lib.user.trans;
using EBid.lib.constant;
using EBid.lib;

namespace EBid.WEB.purchasing_screens
{	
	public partial class index : System.Web.UI.Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{
            PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Home");

            FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
            if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.PURCHASING)
                Response.Redirect("../unauthorizedaccess.aspx");            

            if (!(Page.IsPostBack))
            {
                if ((Session[Constant.SESSION_USERID] != null) && (Session[Constant.SESSION_USERTYPE] != null))
                {
                    lblName.Text = String.Format("Welcome {0}!", Session[Constant.SESSION_USERFULLNAME].ToString());

                    int[] purchasing_values = PurchasingTransaction.QueryCountAll(Convert.ToInt32(Session[Constant.SESSION_USERID].ToString()));

                    lblBidEventsForApproval.Text = "(" + purchasing_values[0].ToString() + ")";
                    lblApprovedBidEvents.Text = "(" + purchasing_values[1].ToString() + ")";

                    lblConvertedBidItems.Text = "(" + purchasing_values[11].ToString() + ")";
                    lblAwardedBidItems.Text = "(" + purchasing_values[4].ToString() + ")";
                    lblWithdrawnItems.Text = "(" + purchasing_values[13].ToString() + ")";

                    lblRecievedEndorsements.Text = "(" + purchasing_values[3].ToString() + ")";
                    lblBidTendersForRenegotiation.Text = "(" + purchasing_values[2].ToString() + ")";

                    lblAuctionEventsForApproval.Text = "(" + purchasing_values[5].ToString() + ")";
                    //lblConfirmedAuctionInvitations.Text = "(" + purchasing_values[6].ToString() + ")";

                    lblAwardedAuctionItems.Text = "(" + purchasing_values[7].ToString() + ")";
                    lblEndorsedAuctionItems.Text = "(" + purchasing_values[12].ToString() + ")";

                    lblOngoingAuctionEvents.Text = "(" + purchasing_values[8].ToString() + ")";
                    lblUpcomingAuctionEvents.Text = "(" + purchasing_values[9].ToString() + ")";
                    lblFinishedAuctionEvents.Text = "(" + purchasing_values[10].ToString() + ")";

                    lblBacEndorsed.Text = "(" + purchasing_values[14].ToString() + ")";
                    lblBacAwarded.Text = "(" + purchasing_values[15].ToString() + ")";
                    //lblBacClarifications.Text = "(" + purchasing_values[16].ToString() + ")";
                    lblBacRejected.Text = "(" + purchasing_values[17].ToString() + ")";
                    lblBacForAwarding.Text = "(" + purchasing_values[18].ToString() + ")";

                    LabelVSF2.Text = "(" + purchasing_values[19].ToString() + ")";
                    LabelVSF3.Text = "(" + purchasing_values[21].ToString() + ")";

                    DisplayCount();
                }                
            }

            
		}

        private void DisplayCount()
        {
            // get all counters for this buyer
            DataRow dr = GetBacCounters(int.Parse(Session[Constant.SESSION_USERID].ToString()));

            // BAC BID EVENTS
            lblBacClarifications.Text = String.Format("({0})", dr["BacClarificationsCount"].ToString());
        }

        public static DataRow GetBacCounters(int PurchasingId)
        {
            DataRow dr = null;
            SqlConnection sqlConnect = new SqlConnection(connstring);
            using (sqlConnect)
            {
                sqlConnect.Open();

                SqlParameter[] sqlParams = new SqlParameter[1];
                sqlParams[0] = new SqlParameter("@PurchasingId", SqlDbType.Int);
                sqlParams[0].Value = BACid;

                dr = SqlHelper.ExecuteDataset(connstring, CommandType.StoredProcedure, "sp_GetPurchasingCounters", sqlParams).Tables[0].Rows[0];

            }
            return dr;
        }

        protected void lnkBids_Click(object sender, System.EventArgs e)
		{
			Response.Redirect("bids.aspx");
		}
        
        protected void LinkRxTenders_Click(object sender, EventArgs e)
        {
            Response.Redirect("bidsforeval.aspx");
        }

        protected void LinkApprovedBids_Click(object sender, EventArgs e)
        {
            Response.Redirect("approvedbidevents.aspx");
        }

        protected void LinkAwardedBids_Click(object sender, EventArgs e)
        {
            Response.Redirect("awardedbiditems.aspx");
        }

        protected void LnkAuctionsForApproval_Click(object sender, EventArgs e)
        {
            Response.Redirect("auctions.aspx");
        }

        protected void LnkConfirmedAuction_Click(object sender, EventArgs e)
        {
            Response.Redirect("confirmedauctioninvitations.aspx");
        }

        protected void LnkAwardedAuctions_Click(object sender, EventArgs e)
        {
            Response.Redirect("awardedauctionitems.aspx");
        }
}
}
