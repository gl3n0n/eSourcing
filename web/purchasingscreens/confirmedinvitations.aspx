<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_ConfirmedInvitations, App_Web_confirmedinvitations.aspx.9bdd8cc1" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Auct" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Auct.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Auct.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav_Not" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Auct_Not.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>	
	<title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />       
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
                                    <EBid:Purchasing_TopNav_Auct runat="server" ID="Purchasing_TopNav_Bids" />
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
                                        Auctions</h2>
                                    <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                    <br />
                                    <h2>
                                        Notifications</h2>
                                    <EBid:Purchasing_LeftNav_Not runat="server" ID="Purchasing_LeftNav_Not" />
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
                                        <tr>
                                            <td valign="top">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td id="content0">
                                                            <h1>
                                                                <br />
                                                                Confirmed Invitations</h1>
                                                            <br />
                                                            <asp:GridView runat="server" ID="gvConfirmedInvites" AllowPaging="True" SkinID="BidEvents"
                                                                AllowSorting="True" AutoGenerateColumns="False" OnRowCommand="gvBids_RowCommand"
                                                                DataSourceID="dsConfirmedVendors">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Supplier" SortExpression="VendorName">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkVendor" runat="server" CommandName="vendorId" CommandArgument='<%# Eval("VendorId", "{0}") %>'
                                                                                Text='<%# Eval("VendorName") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Date Replied" SortExpression="DateReplied">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="lblDateReplied" runat="server" Text='<%# Bind("DateReplied", "{0:D}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="dsConfirmedVendors" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                                SelectCommand="s3p_EBid_QueryConfirmedVendors" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="auctionRefNo" SessionField="AuctionRefNo" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <br />
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                                <tr>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    &nbsp;</td>
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
