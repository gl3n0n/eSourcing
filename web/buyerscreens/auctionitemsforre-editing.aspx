<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_auctionitemsforre_editing, App_Web_auctionitemsforre-editing.aspx.1829e19c" theme="default" %>

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
    <div>
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
                                        <h2>
                                            Auctions</h2>
                                        <div align="left">
                                            <EBid:LeftNavAuctions1 runat="server" ID="LeftNavAuctions1" />
                                        </div>
                                        <h2>
                                            Notifications</h2>
                                        <div align="left">
                                            <EBid:LeftNavNotifications runat="server" ID="LeftNavNotifications" />
                                        </div>
                                        <p>
                                            &nbsp;</p>
                                    </td>
                                    <td id="content">
                                        <div align="left">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
                                                <tr>
                                                    <td valign="top">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td id="content0">
                                                                    <div align="left">
                                                                        <h1>
                                                                            <br />
                                                                            Auction Events For Re-Editing</h1>
                                                                             <p>
                                                                                These are your auction events for re-editing. Click on the auction event reference number or the auction event description to view the details of that event.
                                                                            </p>
                                                                        <div align="left">
                                                                            <asp:GridView ID="gvAuctions" runat="server" SkinID="BidEvents" 
                                                                                AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowCommand="gvAuctions_RowCommand"                                                                                 
                                                                                DataSourceID="dsAuctionsForReedit">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Reference No." SortExpression="ItemDesc">
                                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                                        <ItemStyle Width="90px" />
                                                                                        <ItemTemplate>
                                                                                            &nbsp;<asp:LinkButton ID="lnkRefNo" runat="server" Text='<%# Bind("AuctionRefNo") %>' 
                                                                                                CommandArgument='<%# Bind("AuctionRefNo") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Auction Event" SortExpression="ItemDesc">
                                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                                        <ItemTemplate>
                                                                                            &nbsp;<asp:LinkButton ID="lnkItemDesc" runat="server" Text='<%# Bind("ItemDesc") %>' 
                                                                                                CommandArgument='<%# Bind("AuctionRefNo") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Date Sent For Re-Edit" SortExpression="DateSentForReedit">
                                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                                        <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblDateCreated" runat="server" Text='<%# Bind("DateSentForReedit", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                            </asp:GridView>
                                                                            <asp:SqlDataSource ID="dsAuctionsForReedit" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetBuyerAuctionsForReediting" SelectCommandType="StoredProcedure">
                                                                                <SelectParameters>
                                                                                    <asp:SessionParameter DefaultValue="0" Name="BuyerId" SessionField="UserId" Type="Int32" />
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
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
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
    </div>
</body>
</html>
