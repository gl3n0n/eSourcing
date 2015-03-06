<%@ Page Language="c#" Inherits="EBid.web.vendor_screens.index" CodeFile="index.aspx.cs" %>

<%@ Import Namespace="System"%>
<%@ Import Namespace="System.Collections"%>
<%@ Import Namespace="System.ComponentModel"%>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Drawing"%>
<%@ Import Namespace="System.Web"%>
<%@ Import Namespace="System.Web.SessionState"%>
<%@ Import Namespace="System.Web.Security"%>
<%@ Import Namespace="System.Web.UI"%>
<%@ Import Namespace="System.Web.UI.WebControls"%>
<%@ Import Namespace="System.Web.UI.HtmlControls"%>
<%@ Import Namespace="EBid.lib.bid.data"%>
<%@ Import Namespace="EBid.lib.bid.trans"%>
<%@ Import Namespace="EBid.lib.user.trans"%>
<%@ Import Namespace="EBid.lib.constant"%>
<%@ Import Namespace="EBid.lib"%>
<%@ Import Namespace="System.Data.Sql"%>
<%@ Import Namespace="System.Data.SqlClient"%>

<script language="c#" runat="server">    

string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        SaveVendorAuditTrail();
    } 
    
    private int SaveVendorAuditTrail()
    {
        System.Web.HttpBrowserCapabilities browser = Request.Browser;
        string Browser = "Type = " + browser.Type + " Name = " + browser.Browser + " Version = " + browser.Version;
        string url = HttpContext.Current.Request.Url.AbsoluteUri;
        DateTime DateAccessed = DateTime.Now;
                        
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        int value = 0;

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
            sqlParams[4].Value = "Viewed home page.";


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
        
</script>

<%@ Register Src="../usercontrol/news_announcements_nav.ascx" TagName="news_announcements_nav" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDateTime.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Home" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Home.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Auctions" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Auctions.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_v.css" />
    <script type="text/javascript" src="../include/util.js"></script>

    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body onload="SetStatus();">
    <div align="left">
        <form id="Form1" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" id="page">
                <tr>
                    <td valign="top" height="137">
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
                                    <EBid:Vendor_TopNav_Home runat="server" ID="Vendor_topNav_Home" />
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
                    <td class="content" valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <uc1:news_announcements_nav ID="News_announcements_nav1" runat="server" />
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <br />
                                        <h1>
                                            <asp:Label runat="server" ID="lblVendorName"></asp:Label></h1>
                                        <p>
                                            Listed below are the items that need your attention.</p>
                                        <table width="100%">
                                            <tr>
                                                <td valign="top" width="50%" style="padding-right: 10px;">
                                                    <h3>
                                                        Bid Events</h3>
                                                    <p style="padding-left: 10px;">
                                                        <a href="bids.aspx">New Bid Events
                                                            <asp:Label runat="server" ID="lblBidEventsCount"></asp:Label>
                                                        </a>
                                                    </p>
                                                    <h3>
                                                        Bid Items</h3>
                                                    <p style="padding-left: 10px;">
                                                        <a href="AwardedBids.aspx">Awarded Bid Items
                                                            <asp:Label runat="server" ID="lblAwardedBidItemsCnt" /></a>
                                                    </p>
                                                    <h3>
                                                        Bid Tenders</h3>
                                                    <p style="padding-left: 10px;">
                                                        <a href="tenderdrafts.aspx">Bid Tender Drafts
                                                            <asp:Label runat="server" ID="lblDraftBidTendersCount"></asp:Label>
                                                        </a>
                                                        <br />
                                                        <a href="submittedtenders.aspx">Submitted Bid Tenders
                                                            <asp:Label runat="server" ID="lblSubmittedBidTendersCount"></asp:Label>
                                                        </a>
                                                        <br />
                                                        <a href="bidsforrenegotiation.aspx">Bid Tenders for Clarification
                                                            <asp:Label runat="server" ID="lblForRenegotiationBidTendersCount"></asp:Label>
                                                        </a>
                                                        <br />
                                                    </p>
                                                    <h3>
                                                        RFI</h3>
                                                        <p style="padding-left: 10px;">
                                                            <a href="rfi.aspx">New RFI Events
                                                                <asp:Label runat="server" ID="lblNewRFI"></asp:Label></a>
                                                            <br />
                                                            <a href="submittedrfitenders.aspx">Submitted RFI Tenders
                                                                <asp:Label runat="server" ID="lblSubmittedRfiTenders"></asp:Label></a>
                                                            <br />
                                                        </p>
                                                </td>
                                                <td valign="top" width="50%" style="padding-left: 10px;">
                                                    <h3>
                                                        Auction Events</h3>
                                                    <p style="padding-left: 10px;">
                                                        <a href="auctions.aspx">New Auction Events
                                                            <asp:Label runat="server" ID="lblNewAuctionCount" /></a>
                                                    </p>
                                                    <h3>
                                                        Auction Items</h3>
                                                    <p style="padding-left: 10px;">
                                                        <a href="awardedAuctions.aspx">Awarded Auction Items
                                                            <asp:Label runat="server" ID="lblAwardedAuctionsCnt" /></a>
                                                    </p>
                                                    <h3>
                                                        Auction Notifications</h3>
                                                    <p style="padding-left: 10px;">
                                                        <a href="../auctions/ongoingauctionevents.aspx">Ongoing Auction Events
                                                            <asp:Label runat="server" ID="lblOngoingAuctions" /></a><br />
                                                        <a href="../auctions/upcomingauctionevents.aspx">Upcoming Auction Events
                                                            <asp:Label runat="server" ID="lblUpcomingAuctions" /></a><br />
                                                        <a href="../auctions/finishedauctionevents.aspx">Finished Auction Events
                                                            <asp:Label runat="server" ID="lblFinishedAuctions" /></a>
                                                        </p>
                                                    <h3>
                                                        Others</h3>
                                                    <p style="padding-left: 10px;">
                                                        <a href="changepassword.aspx">Change Password</a><br />                                                        
                                                        <asp:LinkButton ID="lnkContactBuyer" runat="server" OnClick="lnkContactBuyer_Click">Contact Buyer</asp:LinkButton>
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
