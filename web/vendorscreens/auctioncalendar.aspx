<%@ page language="C#" autoeventwireup="true" inherits="web_vendorscreens_auctionCalendar, App_Web_auctioncalendar.aspx.8a7237e8" theme="default" maintainscrollpositiononpostback="true" %>

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
            sqlParams[4].Value = "Viewed auction calendar.";


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

<%@ Register Src="../usercontrol/Vendor/Vendor_LeftNav_Notifications.ascx" TagName="Vendor_LeftNav_Notifications" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Auction" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Auctions" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Auctions.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_v.css">
    <script type="text/javascript" src="../include/util.js"></script>
</head>
<body onload="SetStatus();">
    <div align="left">
        <form id="Form1" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" id="page">
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
                                    <EBid:Vendor_TopNav_Auction runat="server" ID="Vendor_topNav_Auction" />
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
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <h2>
                                                    Auction Events</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Vendor_LeftNav_Auctions runat="server" ID="Vendor_LeftNav_Auctions" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <h2>
                                                    Notifications</h2>
                                                <uc1:Vendor_LeftNav_Notifications ID="Vendor_LeftNav_Notifications1" runat="server" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <h2>
                                                    Auction Calendar</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Calendar runat="server" ID="auctCalendar" OnSelectionChanged="auctCalendar_SelectionChanged"
                                                    SkinID="Calendar"></asp:Calendar>
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content">
                                    <h1>
                                        <br />
                                        Auction Calendar</h1>
                                    <br />                                    
                                    <asp:GridView runat="server" ID="gvAuctionEvents" AllowPaging="True"
                                        AllowSorting="True" AutoGenerateColumns="False" SkinID="BidEvents"
                                        EmptyDataText="There Are No Auction Event(s) On This Date." DataSourceID="dsAuctionEvent">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Reference No." SortExpression="AuctionRefNo">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="90px" />
                                                <ItemTemplate>
                                                    &nbsp;<asp:LinkButton CommandName="Select" ID="lblRefNo" runat="server" Text='<%# Bind("AuctionRefNo") %>'
                                                        CommandArgument='<%# Bind("AuctionRefNo") %>' OnCommand="lblAuctionItems_Command" Width="95%"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Auction Events" SortExpression="ItemDesc">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    &nbsp;<asp:LinkButton CommandName="Select" ID="lblAuctionItems" runat="server" Text='<%# Bind("ItemDesc") %>'
                                                        CommandArgument='<%# Bind("AuctionRefNo") %>' OnCommand="lblAuctionItems_Command"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Start Date" SortExpression="AuctionStartDateTime">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStartDate" runat="server" Text='<%# Bind("AuctionStartDateTime", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="End Date" SortExpression="AuctionEndDateTime">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEndDate" runat="server" Text='<%# Bind("AuctionEndDateTime", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="dsAuctionEvent" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                        SelectCommand="s3p_EBid_ApprovedAuctionsByDate" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="auctCalendar" DefaultValue="" Name="AuctionDate"
                                                PropertyName="SelectedDate" Type="DateTime" />
                                            <asp:SessionParameter DefaultValue="" Name="Vendorid" SessionField="UserId" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <p>
                                        &nbsp;</p>
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
