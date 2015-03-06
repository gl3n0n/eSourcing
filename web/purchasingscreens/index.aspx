<%@ page language="c#" enableeventvalidation="true" inherits="EBid.WEB.purchasing_screens.index, App_Web_index.aspx.9bdd8cc1" theme="default" %>

<%@ Register Src="../usercontrol/news_announcements_nav.ascx" TagName="news_announcements_nav"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Home" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Home.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav_Home" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Home.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav_Home2" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Home2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="C#" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />

    <%@ Import Namespace="System" %>
    <%@ Import Namespace="System.Collections" %>
    <%@ Import Namespace="System.ComponentModel" %>
    <%@ Import Namespace="System.Configuration" %>
    <%@ Import Namespace="System.Data" %>
    <%@ Import Namespace="System.Text" %>
    <%@ Import Namespace="System.Drawing" %>
    <%@ Import Namespace="System.Web" %>
    <%@ Import Namespace="System.Web.Security" %>
    <%@ Import Namespace="System.Web.SessionState" %>
    <%@ Import Namespace="System.Web.UI" %>
    <%@ Import Namespace="System.Web.UI.WebControls" %>
    <%@ Import Namespace="System.Web.UI.WebControls.WebParts" %>
    <%@ Import Namespace="System.Web.UI.HtmlControls" %>
    <%@ Import Namespace="EBid.lib.bid.data" %>
    <%@ Import Namespace="EBid.lib.bid.trans" %>
    <%@ Import Namespace="EBid.lib.constant" %>
    <%@ Import Namespace="EBid.lib.auction.data" %>
    <%@ Import Namespace="EBid.lib" %>
    <%@ Import Namespace="System.IO" %>
    <%@ Import Namespace="System.Data.Sql" %>
    <%@ Import Namespace="System.Data.SqlClient" %>
    <%@ Import Namespace="System.Globalization"%>

    <script type="text/C#" runat="server">
    
        protected void Page_LoadComplete(object sender, System.EventArgs e)
        {
            lblBacClarifications.Text = "(0)";
            DisplayCount();
        }
        private void DisplayCount()
        {
            // get all counters for this buyer
            DataRow dr = GetBacCounters(int.Parse(Session["UserId"].ToString()));

            // BAC BID EVENTS
            lblBacClarifications.Text = String.Format("({0})", dr["BacClarificationsCount"].ToString());
        }

        public static DataRow GetBacCounters(int PurchasingId)
        {
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

            string Cnt;

            DataRow dr = null;
            SqlConnection sqlConnect = new SqlConnection(connstring);
            using (sqlConnect)
            {
                sqlConnect.Open();

                SqlParameter[] sqlParams = new SqlParameter[1];
                sqlParams[0] = new SqlParameter("@PurchasingId", SqlDbType.Int);
                sqlParams[0].Value = PurchasingId;

                dr = SqlHelper.ExecuteDataset(connstring, CommandType.StoredProcedure, "sp_GetPurchasingCounters", sqlParams).Tables[0].Rows[0];

            }
            return dr;
        }
        
    </script>
</head>
<body>
    <div align="left">
        <form id="Form1" method="post" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr>
                    <td valign="top" height="137px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <div align="left" id="masthead">
                                        <EBid:GlobalLinksNav runat="server" ID="GlobalLinksNav" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:Purchasing_TopNav_Home runat="server" ID="Purchasing_TopNav_Home" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopDate runat="server" ID="TopDate" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%;">
                            <tr>
                                <td id="relatedInfo">
                                    <uc1:news_announcements_nav ID="News_announcements_nav1" runat="server" />
                                                                    
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <br />
                                        <h1>                                            
                                            <asp:Label ID="lblName" runat="server" /></h1>
                                        <p>
                                            Listed below are the items that need your attention.</p>
                                            <table width="100%" cellpadding="0" cellspacing="0">                                                
                                                <tr>                                                    
                                                    <td valign="top" width="50%" style="padding-right: 10px;">
                                                        <h3>
                                                            Bids Events</h3>
                                                        <p style="padding-left:15px">
                                                            <a href="bids.aspx">
                                                                Bid Events For Approval
                                                                <asp:Label runat="server" ID="lblBidEventsForApproval" Text=""></asp:Label>
                                                            </a>
                                                            <br />
                                                            <a href="approvedbidevents.aspx">
                                                                Approved Bid Events
                                                                <asp:Label runat="server" ID="lblApprovedBidEvents" Text="" />
                                                            </a>
                                                           <br />
                                                           <a href="bidinvitations.aspx">
                                                                 Bid Event Invitations
                                                                <asp:Label runat="server" ID="lblBidInvitations" Text="" />
                                                            </a>                                                             
                                                        </p>
                                                        <br />
                                                        <h3>
                                                            Bids Items</h3>
                                                        <p style="padding-left:15px">
                                                            <a href="bidsforconversion.aspx">
                                                                Converted Bid Items
                                                                <asp:Label runat="server" ID="lblConvertedBidItems" Text=""></asp:Label>
                                                            </a>                                                            
                                                         <br /> 
                                                            <a href="awardedbiditems.aspx">
                                                                Awarded Bid Items
                                                                <asp:Label runat="server" ID="lblAwardedBidItems" Text=""></asp:Label>
                                                            </a>
                                                         <br /> 
                                                            <a href="withdrawnedbiditems.aspx">
                                                                 Withdrawn Bid Items
                                                                <asp:Label runat="server" ID="lblWithdrawnItems" Text=""></asp:Label>
                                                            </a>                                                                    
                                                        </p>
                                                        <br />
                                                        <h3>
                                                            Bids Tenders</h3>
                                                         <p style="padding-left:15px">
                                                            <a href="bidsforeval.aspx">
                                                                Recieved Endorsements
                                                                <asp:Label runat="server" ID="lblRecievedEndorsements" Text="" />
                                                            </a>
                                                            <br />
                                                            <a href="bidsforrenegotiation.aspx">
                                                                Bid Tenders For Clarification
                                                                <asp:Label runat="server" ID="lblBidTendersForRenegotiation" Text="" />
                                                            </a>
                                                            <br />
                                                         </p> 
                                                         <br />
                                                        <h3>
                                                            BAC</h3>
                                                         <p style="padding-left:15px">
                                                            <a href="bacendorsed.aspx">View Endorsed BAC
                                                                <asp:Label runat="server" ID="lblBacEndorsed" Text="" />
                                                            </a><br />
                                                            <a href="bacawarded.aspx">View Awarded BAC
                                                                <asp:Label runat="server" ID="lblBacAwarded" Text="" />
                                                            </a><br />
                                                            <a href="bacforclarifications.aspx">BAC for Clarifications
                                                                <asp:Label runat="server" ID="lblBacClarifications" Text="" />
                                                            </a><br />
                                                            <a href="bacrejected.aspx">View Rejected BAC
                                                                <asp:Label runat="server" ID="lblBacRejected" Text="" />
                                                            </a><br />
                                                            <a href="bacforawarding.aspx">View Ongoing BAC
                                                                <asp:Label runat="server" ID="lblBacForAwarding" Text="" />
                                                            </a><br />
                                                         </p>                                                                            
                                                    </td>                                                    
                                                    <td valign="top" width="50%" style="padding-left: 10px;">
                                                        <h3>
                                                            Auctions Events</h3>
                                                        <p style="padding-left:15px">
                                                            <a href="auctions.aspx">
                                                                Auction Events For Approval
                                                                <asp:Label runat="server" ID="lblAuctionEventsForApproval" Text="" />
                                                            </a>
                                                            <br />
                                                            <a href="auctioninvitations.aspx">
                                                                Auction Event Invitations
                                                                <asp:Label runat="server" ID="lblConfirmedAuctionInvitations" Text="" />
                                                            </a>
                                                        </p>
                                                        <br />
                                                         <h3>
                                                            Auctions Items</h3>
                                                          <p style="padding-left:15px">
                                                            <a href="awardedauctions.aspx">
                                                                Awarded Auction Items
                                                                <asp:Label runat="server" ID="lblAwardedAuctionItems" Text="" />
                                                            </a>
                                                            <br />
                                                            <a href="auctionitemsforawarding.aspx">
                                                                Endorsed Auction Items
                                                                <asp:Label runat="server" ID="lblEndorsedAuctionItems" Text="" />
                                                            </a>
                                                          </p>
                                                          <br />
                                                        <h3>
                                                            Notifications</h3>
                                                        <p style="padding-left:15px">
                                                            <a href="../auctions/ongoingauctionevents.aspx">Ongoing Auction Events 
                                                            <asp:Label runat="server" ID="lblOngoingAuctionEvents" Text="" />
                                                            </a>
                                                            <br />
                                                            <a href="../auctions/upcomingauctionevents.aspx">Upcoming Auction Events 
                                                            <asp:Label runat="server" ID="lblUpcomingAuctionEvents" Text="" />
                                                            </a>
                                                            <br />
                                                            <a href="../auctions/finishedauctionevents.aspx">Finished Auction Events 
                                                            <asp:Label runat="server" ID="lblFinishedAuctionEvents" Text="" />
                                                            </a>
                                                        </p>

                                                    <h3>
                                                        Vendor Shortlisting Form</h3>
                                                    <p style="padding-left: 10px;">
                                            <a href="vsfendorsed.aspx">View Endorsed
                                                <asp:Label runat="server" ID="LabelVSF2" Text="(0)"></asp:Label></a>
                                            <br />
                                            <a href="vsfapproved.aspx">View Approved
                                                <asp:Label runat="server" ID="LabelVSF3" Text="(0)"></asp:Label></a>
                                            <br />
                                                    </p>

                                                        <h3>
                                                            Others</h3>
                                                        <p style="padding-left:15px">
                                                        <a href="../purchasingscreens/changepwd.aspx">Change Password                                                        
                                                        </a>                                                        
                                                        </p>
                                                    </td>
                                                </tr>
                                            </table>                                    
                                        <p>
                                            <br />
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer" height="50px">
                        <EBid:Footer runat="server" ID="Footer1" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
