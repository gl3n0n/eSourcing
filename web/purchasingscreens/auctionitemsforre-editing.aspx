<%@ page language="C#" autoeventwireup="true" inherits="web_purchasingscreens_auctionitemsforre_editing, App_Web_auctionitemsforre-editing.aspx.9bdd8cc1" theme="default" %>

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
                                                                Auction Events For Re-editing</h1>
                                                            <br />
                                                            <asp:GridView runat="server" ID="gvRejectedAuctions" AllowPaging="True" SkinID="BidEvents"
                                                                AllowSorting="True" AutoGenerateColumns="False" OnRowCommand="gvBids_RowCommand"                                                                
                                                                DataKeyNames="AuctionRefNo" DataSourceID="dsAuctionsForReedit">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Reference No." SortExpression="AuctionRefNo">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle Width="90px" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkRefNo" runat="server" CommandName="AuctionEvent"
                                                                                CommandArgument='<%# Eval("AuctionRefNo") %>' Text='<%# Eval("AuctionRefNo") %>' Width="95%"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Auction Event" SortExpression="ItemDesc">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkAuctionEvent" runat="server" CommandName="AuctionEvent"
                                                                                CommandArgument='<%# Eval("AuctionRefNo") %>' Text='<%# Eval("ItemDesc") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Date Submitted" SortExpression="DateSubmitted">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle Width="180px" HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="lblDateSentForReedit" runat="server" Text='<%# Bind("DateSubmitted", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="dsAuctionsForReedit" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                                SelectCommand="sp_GetPurchasingAuctionsForReediting" SelectCommandType="StoredProcedure">
                                                            </asp:SqlDataSource>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </table>
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
                        <EBid:Footer runat="server" ID="Footer1" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>