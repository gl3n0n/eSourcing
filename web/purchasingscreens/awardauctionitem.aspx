<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_AwardAuctionItem, App_Web_awardauctionitem.aspx.9bdd8cc1" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Auct" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Auct.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Auct.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav_Not" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Auct_Not.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>.:| Globe Telecom eSourcing System |  |:.</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
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
                                    <EBid:Purchasing_TopNav_Auct runat="server" ID="Purchasing_TopNav_Auct" />
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
                                                    Auctions</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                                <br />
                                                <h2>
                                                    Notifications</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Purchasing_LeftNav_Not runat="server" ID="Purchasing_LeftNav1" />
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
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
                                                                Awarded Auction Items</h1>
                                                            <p>
                                                                You have awarded the following items to the following suppliers.</p>
                                                            <div align="left">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="itemDetails">
                                                                    <tr>
                                                                        <th>
                                                                            <asp:LinkButton runat="server" ID="lnkAuctionItem" OnClick="lnkAuctionItem_Click"></asp:LinkButton></th>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <asp:GridView runat="server" ID="gvAwardedItems" AutoGenerateColumns="False" CssClass="itemDetails"
                                                                DataSourceID="dsAwardedItems">
                                                                <HeaderStyle CssClass="itemDetails_th" ForeColor="White" />
                                                                <RowStyle CssClass="itemDetails_td" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Item">
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="lblAuctionItems" runat="server" Text='<%# Bind("Item") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="136px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Description">
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Bid Amount">
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Amount", "{0:F}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle BackColor="White" Width="132px" />
                                                                        <HeaderStyle BorderColor="White" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Supplier">
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="lblCompany" runat="server" Text='<%# Bind("VendorName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemStyle BackColor="White" Width="132px" />
                                                                        <HeaderStyle BorderColor="White" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="dsAwardedItems" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                                SelectCommand="s3p_EBid_QueryAwardedItemsbyAuctRefNo" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="auctionRefNo" SessionField="AuctionRefNo" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <br />
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions1">
                                                                <tr>
                                                                    <td>
                                                                       <%-- <a href="awardedAuctionItems.aspx">Ok</a> <a href="index.aspx">Cancel</a>--%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 20px;">
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
