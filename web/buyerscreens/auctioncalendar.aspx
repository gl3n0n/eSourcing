<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_auctionCalendar, App_Web_auctioncalendar.aspx.1829e19c" theme="default" maintainscrollpositiononpostback="true" %>

<%@ Register TagPrefix="EBid" TagName="TopNavAuction" Src="~/WEB/usercontrol/Buyer/TopNavAuctions.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav_Auctions" Src="~/web/usercontrol/Buyer/TopNav2_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavAuctions1" Src="~/web/usercontrol/Buyer/LeftNavAuctions1.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavNotifications" Src="~/web/usercontrol/Buyer/LeftNavNotifications.ascx" %>
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
    <div align="left">
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
                                    <EBid:TopNavAuction runat="server" ID="TopNavAuction1" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNav_Auctions runat="server" ID="TopNav_Auctions" />
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
                                                    Auctions</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:LeftNavAuctions1 runat="server" ID="LeftNavAuctions1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                                <h2>
                                                    Notifications</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:LeftNavNotifications runat="server" ID="LeftNavNotifications" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                                <h2>
                                                    Auction Calendar</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Calendar runat="server" ID="auctCalendar" OnSelectionChanged="auctCalendar_SelectionChanged" SkinID="Calendar" ShowGridLines="True"></asp:Calendar>
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
                                            <tr>
                                                <td valign="top">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td id="content0">
                                                                <h1>
                                                                    <br />
                                                                    Auction Calendar</h1>
                                                                <br />
                                                                <asp:GridView runat="server" ID="gvAuctionEvents" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" EmptyDataText="No Auction Event to display at the moment." DataSourceID="dsAuctionEvent"
                                                                    SkinID="BidEvents">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Reference No." SortExpression="AuctionRefNo">
                                                                            <HeaderStyle HorizontalAlign="center" />
                                                                            <ItemStyle Width="90px" />
                                                                            <ItemTemplate>
                                                                                &nbsp;<asp:LinkButton CommandName="Select" ID="lblRefNo" runat="server" Text='<%# Bind("AuctionRefNo") %>' 
                                                                                    CommandArgument='<%# Bind("AuctionRefNo") %>' OnCommand="lblAuctionItems_Command" Width="95%"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Auction Events" SortExpression="ItemDesc">
                                                                            <HeaderStyle HorizontalAlign="center" />
                                                                            <ItemTemplate>
                                                                                &nbsp;<asp:LinkButton CommandName="Select" ID="lblAuctionItems" runat="server" Text='<%# Bind("ItemDesc") %>' CommandArgument='<%# Bind("AuctionRefNo") %>' OnCommand="lblAuctionItems_Command"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Start Time" SortExpression="AuctionStartTime">
                                                                            <HeaderStyle HorizontalAlign="center" />
                                                                            <ItemStyle HorizontalAlign="center" Width="150px" />
                                                                            <ItemTemplate>
                                                                                &nbsp;<asp:Label ID="lblStartDate" runat="server" Text='<%# Bind("AuctionStartDateTime", "{0:D}&nbsp;{0:t}") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="End Time" SortExpression="AuctionEndDateTime">
                                                                            <HeaderStyle HorizontalAlign="center" />
                                                                            <ItemStyle HorizontalAlign="center" Width="150px" />
                                                                            <ItemTemplate>
                                                                                &nbsp;<asp:Label ID="lblEndDate" runat="server" Text='<%# Bind("AuctionEndDateTime", "{0:D}&nbsp;{0:t}") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                                <asp:SqlDataSource ID="dsAuctionEvent" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="s3p_EBid_BuyerApprovedAuctionsByDate" SelectCommandType="StoredProcedure">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="auctCalendar" Name="AuctionDate" PropertyName="SelectedDate" Type="DateTime" />
                                                                        <asp:SessionParameter Name="buyerId" SessionField="userid" Type="Int32" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <br />
                                                    <table id="actions" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td>
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
                        <EBid:Footer runat="server" ID="Footer1" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
