<%@ page language="c#" inherits="EBid.web.vendor_screens.auctions, App_Web_auctions.aspx.8a7237e8" theme="default" %>

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
            sqlParams[4].Value = "Viewed list of new auction events.";


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

<%@ Register Src="../usercontrol/Vendor/Vendor_LeftNav_Notifications.ascx" TagName="Vendor_LeftNav_Notifications"
    TagPrefix="uc1" %>
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
    <div>
        <form id="Form1" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr height="137px">
                    <td valign="top">
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
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>
                                        Auction Events</h2>
                                    <div align="left">
                                        <EBid:Vendor_LeftNav_Auctions runat="server" ID="Vendor_LeftNav_Auctions" />
                                    </div>
                                    <br />
                                    <h2>
                                        Notifications</h2>
                                    <div align="left">
                                        <uc1:Vendor_LeftNav_Notifications ID="Vendor_LeftNav_Notifications1" runat="server" />
                                    </div>
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <h1>
                                        <br />
                                        New Auction Events</h1>
                                    <br />
                                    <div align="left">
                                        <asp:GridView runat="server" ID="gvAuctionsForApproval" AllowPaging="True"
                                            AllowSorting="True" AutoGenerateColumns="False" SkinID="BidEvents"
                                            EmptyDataText="No Auction Events to display at the moment." DataSourceID="dsVendorAuctions" OnRowCommand="gvAuctionsForApproval_RowCommand">                                            
                                            <Columns>
                                                <asp:TemplateField HeaderText="Reference No." SortExpression="AuctionRefNo">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="90px" />
                                                    <ItemTemplate>
                                                        &nbsp;<asp:LinkButton CommandName="Select" ID="lnkRefNo" runat="server" Text='<%# Bind("AuctionRefNo") %>'
                                                            CommandArgument='<%# Bind("AuctionRefNo") %>' Width="95%" Visible='<%# ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>' ></asp:LinkButton>
                                                           <asp:LinkButton CommandName="Select2" ID="lnkRefNo2" runat="server" Text='<%# Bind("AuctionRefNo") %>'
                                                            CommandArgument='<%# Bind("AuctionRefNo") %>' Visible='<%# !ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>' ></asp:LinkButton> 
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Auction Event" SortExpression="ItemDesc">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        &nbsp;<asp:LinkButton CommandName="Select" ID="lnkDesc" runat="server" Text='<%# Bind("ItemDesc") %>'
                                                            CommandArgument='<%# Bind("AuctionRefNo") %>'  Visible='<%# ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>' ></asp:LinkButton>
                                                           <asp:LinkButton CommandName="Select2" ID="lnkDesc2" runat="server" Text='<%# Bind("ItemDesc") %>' CommandArgument='<%# Bind("AuctionRefNo") %>'
                                                           Visible='<%# !ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>' ></asp:LinkButton> 
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Start Date" SortExpression="AuctionStartDateTime">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStartDate" runat="server" Text='<%# Bind("AuctionStartDateTime", "{0:D}") %>'></asp:Label><br />
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("AuctionStartDateTime", "{0:T}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="End Date" SortExpression="AuctionEndDateTime">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    <ItemTemplate>                                                        
                                                        <asp:Label ID="lblEndDate" runat="server" Text='<%# Bind("AuctionEndDateTime", "{0:D}") %>'></asp:Label><br />
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("AuctionEndDateTime", "{0:T}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Confirmation Deadline" SortExpression="AuctionDeadline">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="140px" HorizontalAlign="Center" />
													<ItemTemplate>
													     <asp:Label ID="lblDeadline" runat="server" Text='<%# Bind("AuctionDeadline", "{0:D}") %>' Visible='<%# ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>'></asp:Label>
														<asp:Label ID="lblConfirmationStatus" runat="server" Font-Size="11px" Text='<%# ConfirmationStatus(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString())  %>'
															Visible='<%# !ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>'></asp:Label>
													</ItemTemplate>
												</asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="dsVendorAuctions" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                            SelectCommand="sp_GetVendorAuctions" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="VendorId" SessionField="userid" Type="Int32" />
                                                <asp:Parameter DefaultValue="0" Name="Status" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <p>
                                            &nbsp;</p>
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
