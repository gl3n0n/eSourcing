<%@ page language="C#" autoeventwireup="true" inherits="WEB_buyer_screens_AuctionInvitations, App_Web_auctioninvitations.aspx.1829e19c" theme="default" %>

<%@ Register TagPrefix="EBid" TagName="TopNavAuction" Src="~/WEB/usercontrol/Buyer/TopNavAuctions.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav_Auctions" Src="~/web/usercontrol/Buyer/TopNav2_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavAuctions1" Src="~/web/usercontrol/Buyer/LeftNavAuctions1.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavNotifications" Src="~/web/usercontrol/Buyer/LeftNavNotifications.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
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
                                    <EBid:TopNavAuction runat="server" ID="TopNavAuction" />
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
                                                                        Auction Invitations</h1>
                                                                    <p>
                                                                        These are auction events that has been confirmed, declined and not responded yet.</p>                                                                    
                                                                    <asp:GridView ID="gvAuctionInvitations" runat="server" SkinID="BidEvents"
                                                                        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                                                        DataKeyNames="AuctionRefNo" DataSourceID="sdsInvitations" OnRowCommand="gvAuctionInvitations_RowCommand">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Reference No." InsertVisible="False" SortExpression="AuctionRefNo">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle Width="90px" />
                                                                                <ItemTemplate>
                                                                                    &nbsp;<asp:LinkButton ID="Label1" runat="server" Text='<%# Bind("AuctionRefNo") %>' CommandName="ViewDetails" CommandArgument='<%# Bind("AuctionRefNo") %>'></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Auction Event" SortExpression="ItemDesc">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemTemplate>
                                                                                    &nbsp;<asp:LinkButton ID="Label2" runat="server" Text='<%# Bind("ItemDesc") %>' CommandName="ViewDetails" CommandArgument='<%# Bind("AuctionRefNo") %>'></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Pending" SortExpression="PendingCount">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="Label3" runat="server" Text='<%# String.Format("{0}/{1}", Eval("PendingCount"),Eval("TotalCount")) %>' Enabled='<%# IsEnabled(Eval("PendingCount").ToString()) %>' CommandName="Pending" CommandArgument='<%# Bind("AuctionRefNo") %>'></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Confirmed" SortExpression="ConfirmedCount">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="Label4" runat="server" Text='<%# String.Format("{0}/{1}", Eval("ConfirmedCount"),Eval("TotalCount")) %>' Enabled='<%# IsEnabled(Eval("ConfirmedCount").ToString()) %>' CommandName="Confirmed" CommandArgument='<%# Bind("AuctionRefNo") %>'></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Declined" SortExpression="DeclinedCount">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="Label5" runat="server" Text='<%# String.Format("{0}/{1}", Eval("DeclinedCount"),Eval("TotalCount")) %>' Enabled='<%# IsEnabled(Eval("DeclinedCount").ToString()) %>' CommandName="Declined" CommandArgument='<%# Bind("AuctionRefNo") %>'></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                    <asp:SqlDataSource ID="sdsInvitations" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetAuctionInvitations" SelectCommandType="StoredProcedure">
                                                                        <SelectParameters>
                                                                            <asp:SessionParameter DefaultValue="0" Name="BuyerId" SessionField="UserID" Type="Int32" />
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
                                                                    <p>
                                                                        &nbsp;</p>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
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
