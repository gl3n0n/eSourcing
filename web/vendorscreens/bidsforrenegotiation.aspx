<%@ page language="c#" inherits="EBid.web.vendor_screens.BidsForRenegotiation, App_Web_bidsforrenegotiation.aspx.8a7237e8" theme="default" %>

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
            sqlParams[4].Value = "Viewed list of bid tenders for clarification.";


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

<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Comments" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Comments.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_v.css" />
</head>
<body>
    <div align="left">
        <form id="Form1" runat="server">
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
                                    <EBid:Vendor_TopNav_Bids runat="server" ID="Vendor_TopNav_Bids" />
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
                                    <h2>
                                        Bid Events</h2>
                                    <EBid:Vendor_LeftNav_Bids runat="server" ID="Vendor_LeftNav_Bids" />
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <h1>
                                                    <br />
                                                    Bid Tenders For Clarification</h1>
                                                <br />
                                                <asp:GridView ID="gvTenderDrafts" runat="server" AutoGenerateColumns="False" Width="100%"
                                                    SkinID="BidEvents" OnRowCommand="gvTenderDrafts_RowCommand" DataKeyNames="BidRefNo,AsClarified"
                                                    AllowPaging="True" AllowSorting="True" DataSourceID="sdsRenegotiatedItems">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Tender No." SortExpression="BidRefNo">
                                                            <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                                            <ItemTemplate>
                                                                &nbsp;
                                                                <asp:LinkButton ID="lnkTenderNo" runat="server" Text='<%# Bind("BidTenderNo") %>' CommandName="EditTender"
                                                                    CommandArgument='<%# Bind("BidTenderNoDeadline", "{0}") %>' Width="95%" ToolTip="Click to view/edit bid tender for this bid item."></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Bid Item" SortExpression="DetailDesc">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>                                                                
                                                                &nbsp;<asp:LinkButton ID="lnkBidTenderDraft" runat="server" Text='<%# Bind("DetailDesc") %>' CommandName="EditTender" 
                                                                    CommandArgument='<%#Bind("BidTenderNoDeadline") %>'></asp:LinkButton>
                                                                <asp:Label ID="lblBidPrice" runat="server" Text='<%# Bind("BidPrice" , " @ <b>{0:#,000.00}</b>") %>'></asp:Label>
                                                                <asp:Label ID="lblCurrency" runat="server" Text='<%# Bind("Currency", " {0}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Bid Event" SortExpression="ItemDesc">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp;<asp:LinkButton ID="lnkBidEvent" runat="server" Text='<%# Bind("BidEvent") %>' CommandName="SelectBidEvent" CommandArgument='<%#Bind("BidRefNo") %>'></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Date Clarified" SortExpression="DateRenegotiated">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle Width="180px" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDateRenegotiated" runat="server" Text='<%# Bind("DateRenegotiated", "{0:D}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Clarification Deadline" SortExpression="RenegotiationDeadline">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle Width="180px" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRenegotiationDealine" runat="server" Text='<%# Bind("RenegotiationDeadline", "{0:D}<br />{0:T}") %>'></asp:Label>                                                                
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsRenegotiatedItems" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="s3p_EBid_GetBidTendersForRenegotiation" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter DefaultValue="0" Name="VendorId" SessionField="UserId" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer" height="50px">
                        <EBid:Footer runat="server" ID="Footer" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
