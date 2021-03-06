<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_auctioninvitationdetails, App_Web_auctioninvitationdetails.aspx.1829e19c" theme="default" %>

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
                                                                        <asp:Label ID="lblHeader" runat="server" Text=""></asp:Label>   
                                                                    </h1>
                                                                    <p>
                                                                        </p>
                                                                    <asp:GridView ID="gvAuctionInvitationDetails" runat="server" SkinID="AuctionedItems"
                                                                        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ParticipantId" DataSourceID="sdsInvitationDetails" EmptyDataText="None">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="VendorName" SortExpression="VendorName">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle Width="300px" />
                                                                                <ItemTemplate>
                                                                                    &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Bind("VendorName") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="EmailSent" SortExpression="EmailSent">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="90px" />
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmailSent") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Comment" SortExpression="Comment">
                                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                                <ItemTemplate>
                                                                                    &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("Comment") %>' ForeColor='<%# GetColor(Eval("Comment").ToString()) %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>                                                                    
                                                                    <asp:SqlDataSource ID="sdsInvitationDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetAuctionInvitationDetails" SelectCommandType="StoredProcedure">
                                                                        <SelectParameters>
                                                                            <asp:SessionParameter Name="AuctionRefNo" SessionField="AuctionRefNo" Type="Int32" />
                                                                            <asp:SessionParameter DefaultValue="0" Name="Status" SessionField="IStatus" Type="Int32" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                    <br />
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:LinkButton ID="lnkBack" runat="server" OnClick="lnkBack_Click">Back</asp:LinkButton>
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
                        <EBid:Footer runat="server" ID="Footer1" />                        
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
