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
using System.IO;
using System.Configuration;
using System.Data.SqlClient;

namespace EBid.web.vendor_screens
{
    public partial class BidDetails2 : System.Web.UI.Page
    {
        private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
            if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.VENDOR)
                Response.Redirect("../unauthorizedaccess.aspx");

            PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Bid Event Details");

            if (Request.QueryString["brn"] != null)
            {
                Session[Constant.SESSION_BIDREFNO] = Request.QueryString["brn"].ToString();
            }

            if (Session[Constant.SESSION_BIDREFNO] == null)
                Response.Redirect("bids.aspx");

            if (!IsPostBack)
            {
                if (Session[Constant.SESSION_LASTPAGE] != null)
                {
                  
                    if ((Session[Constant.SESSION_LASTPAGE].ToString().Trim() == "~/web/vendorscreens/finishedbidevents.aspx") ||
                        (Session[Constant.SESSION_LASTPAGE].ToString().Trim() == "~/web/vendorscreens/declinedbidevents.aspx") ||
                        (Session[Constant.SESSION_LASTPAGE].ToString().Trim() == "~/web/vendorscreens/bidsforrenegotiation.aspx")) 
                    
                    {
                        pnlComments.Visible = btnBids.Visible = btnDecline.Visible = false;
                        
                    }
                    else
                        pnlComments.Visible = btnBids.Visible = btnDecline.Visible = BidEventTransaction.IsBidEventConfirmed(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString())) == 0 ? true : false;
                }
                else
                    pnlComments.Visible = btnBids.Visible = btnDecline.Visible = BidEventTransaction.IsBidEventConfirmed(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString())) == 0 ? true : false;
            }
        }

        protected void btnBids_Click(object sender, EventArgs e)
        {
            BidEventTransaction.ConfirmBidInvitation(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()));

            int bid = int.Parse(Session[Constant.SESSION_BIDREFNO].ToString());
            int uid = int.Parse(Session[Constant.SESSION_USERID].ToString());

            if (txtComment.Text.Trim().Length > 0)
            {
                //if there is comment insert comment
                InsertParticipationComments(GetVendorsInBidId(uid, bid), txtComment.Text.ToString().Trim());
            }
            SaveVendorAuditTrail(1);
            Response.Redirect("submittender.aspx");
        }

        protected void btnDecline_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                BidEventTransaction.DeclineBidInvitation(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()));

                int bid = int.Parse(Session[Constant.SESSION_BIDREFNO].ToString());
                int uid = int.Parse(Session[Constant.SESSION_USERID].ToString());

                if (txtComment.Text.Trim().Length > 0)
                {
                    //if there is comment insert comment
                    InsertParticipationComments(GetVendorsInBidId(uid, bid), txtComment.Text.ToString().Trim());
                }
                SaveVendorAuditTrail(2);
                Response.Redirect("decline.aspx");
            }
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            if (Session[Constant.SESSION_LASTPAGE] != null)
                Response.Redirect(Session[Constant.SESSION_LASTPAGE].ToString());
            else
                Response.Redirect("bids.aspx");
        }

        protected void cvValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (txtComment.Text.Trim().Length > 0);
        }

        private int GetVendorsInBidId(int vendorid, int bidrefno)
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@VendorId", vendorid);
            param[1] = new SqlParameter("@BidRefNo", bidrefno);

            return (int)SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetVendorsInBidId", param);
        }

        private void InsertParticipationComments(int vendorsInBidId, string comments)
        {
            SqlParameter[] sqlParams = new SqlParameter[2];
            sqlParams[0] = new SqlParameter("@VendorsInBidId", SqlDbType.Int);
            sqlParams[0].Value = vendorsInBidId;
            sqlParams[1] = new SqlParameter("@Comments", SqlDbType.NVarChar);
            sqlParams[1].Value = comments;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertBidParticipantComments", sqlParams);
        }

        private int SaveVendorAuditTrail(int ConfirmDecline)
        {
            System.Web.HttpBrowserCapabilities browser = Request.Browser;
            string Browser = "Type = " + browser.Type + " Name = " + browser.Browser + " Version = " + browser.Version;
            string url = HttpContext.Current.Request.Url.AbsoluteUri;
            DateTime DateAccessed = DateTime.Now;

            SqlConnection sqlConnect = new SqlConnection(connstring);
            SqlTransaction sqlTransact = null;
            int value = 0;
            string Activity = "";

            switch (ConfirmDecline)
            {
                case 0:
                    Activity = "Viewed details of Bid Event invite with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 1:
                    Activity = "Confirmed on Bid Event invite with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 2:
                    Activity = "Declined on Bid Event invite with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
            }


            try
            {
                sqlConnect.Open();
                sqlTransact = sqlConnect.BeginTransaction();

                SqlParameter[] sqlParams = new SqlParameter[5];
                sqlParams[0] = new SqlParameter("@UserId", SqlDbType.Int);
                sqlParams[1] = new SqlParameter("@AccessedPage", SqlDbType.NVarChar);
                sqlParams[2] = new SqlParameter("@DateAccessed", SqlDbType.DateTime);
                sqlParams[3] = new SqlParameter("@BrowserType", SqlDbType.NVarChar);
                sqlParams[4] = new SqlParameter("@ActivityDetails", SqlDbType.NVarChar);


                sqlParams[0].Value = Int32.Parse(Session[Constant.SESSION_USERID].ToString());
                sqlParams[1].Value = url;
                sqlParams[2].Value = DateAccessed;
                sqlParams[3].Value = Browser;
                sqlParams[4].Value = Activity;


                value = Convert.ToInt32(SqlHelper.ExecuteScalar(sqlTransact, "sp_AddVendorAuditTrail", sqlParams));

                sqlTransact.Commit();
            }
            catch
            {
                sqlTransact.Rollback();
                value = 0;
            }
            finally
            {
                sqlConnect.Close();
            }

            return value;
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            SaveVendorAuditTrail(0);
        } 
}
}
