<%@ page language="C#" autoeventwireup="true" inherits="WEB_buyer_screens_AwardedBidItems, App_Web_awardedbiditems.aspx.1829e19c" theme="default" %>

<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_buyer.css" />
</head>
<body>
    <div>
        <form id="form1" runat="server">
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
                                    <EBid:TopNavBids ID="TopNavBids1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNav2 ID="TopNav2" runat="server" />
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
                                    <div align="left">
                                        <EBid:LeftNav ID="LeftNav" runat="server" />
                                    </div>
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table4">
                                            <tr>
                                                <td>
                                                    <h1>
                                                        <br />
                                                        Awarded Bid Items</h1>
                                                    <p>
                                                        These are your awarded bid items.
                                                        <asp:CheckBoxList ID="chkbuyeropts" runat="server" AutoPostBack="True" Font-Names="Arial" Font-Size="11px" OnSelectedIndexChanged="chkbuyeropts_SelectedIndexChange" RepeatDirection="Horizontal" RepeatLayout="Table"
                                                            Width="330px">
                                                            <asp:ListItem Selected="True" Value='0'>Globe</asp:ListItem>
                                                            <asp:ListItem Selected="True" Value='1'>Innove</asp:ListItem>
                                                            <asp:ListItem Selected="True" Value='2'>GExchange</asp:ListItem>
                                                        </asp:CheckBoxList>
                                                    </p>
                                                    <asp:GridView ID="gvBids" runat="server" SkinID="BidEvents" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="dsAwardedItems" OnRowCommand="gvBids_RowCommand" DataKeyNames="BidTenderNo,BidDetailNo,BidRefNo">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Detail No." InsertVisible="False" SortExpression="BidDetailNo">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkBidDetailNo" runat="server" Text='<%# Bind("BidDetailNo") %>' Width="95%" CommandName="ViewBidItemDetails" CommandArgument='<%# Bind("BidTenRef") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Bid Item" SortExpression="DetailDesc">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkBidItem" runat="server" Text='<%# Bind("DetailDesc") %>' CommandName="ViewBidItemDetails" CommandArgument='<%# Bind("BidTenRef") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Bid Event" SortExpression="ItemDesc">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkBidEvent" runat="server" Text='<%# Bind("ItemDesc") %>' CommandName="ViewBidEventDetails" CommandArgument='<%# Bind("BidTenRef") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Company" SortExpression="Company">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblCompany" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Winner" SortExpression="VendorName">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblVendor" runat="server" Text='<%# Bind("VendorName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Date Awarded" SortExpression="DateAwarded">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDateAwarded" runat="server" Text='<%# Bind("DateAwarded", "{0:D}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="dsAwardedItems" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetBuyerAwardedItemTenders" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:SessionParameter DefaultValue="0" Name="BuyerId" SessionField="UserId" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                    <br />
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                        <tr>
                                                            <td align="left">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <p>
                                                        &nbsp;</p>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
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
