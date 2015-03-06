<%@ page language="C#" autoeventwireup="true" inherits="web_purchasingscreens_report_totalauctionevents_itemdetails, App_Web_report_totalauctionevents_itemdetails.aspx.9bdd8cc1" theme="default" %>

<%@ Register Src="../usercontrol/purchasing/Purchasing_LeftNav_Reports.ascx" TagName="Purchasing_LeftNav_Reports" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Reports" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Reports.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>

<%@ Register Src="../usercontrol/auctionvendor/auctiondetail.ascx" TagName="auctiondetail" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/auctionvendor/auctionitems.ascx" TagName="auctionitems" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/AuctionVendor/auctionattachments.ascx" TagName="auctionattachments" TagPrefix="uc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />
    <script type="text/javascript" src="../include/util.js"></script>
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
                                    <EBid:Purchasing_TopNav_Reports runat="server" ID="Purchasing_TopNav_Reports" />
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
                    <td class="content">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%">
                            <tr>
                                <td id="relatedInfo">
                                    <uc1:Purchasing_LeftNav_Reports ID="Purchasing_LeftNav_Reports1" runat="server" />
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <br />
                                        <h1>
                                            Auction Event Details </h1>
                                        <div>
                                        <!-- contents here //-->

                                        <uc3:auctiondetail ID="Auctiondetail1" runat="server" />
                                        <uc2:auctionitems ID="Auctionitems1" runat="server" />

                                        <br />
                                        <uc1:auctionattachments ID="Auctionattachments1" runat="server" />
                                        <br />
                                        <asp:GridView runat="server" ID="gvSuppliers" AutoGenerateColumns="False" SkinID="AuctionedItems" AllowSorting="True" DataSourceID="dsAuctionParticipants" DataKeyNames="ParticipantId,UserName,Ticket,Alias,VendorName,VendorEmail,MobileNo">
                                            <HeaderStyle ForeColor="White" HorizontalAlign="Center" Height="20px" />
                                            <RowStyle BackColor="White" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="&#160;Supplier&#160;" SortExpression="VendorName">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        &nbsp;<asp:Label ID="Label4" runat="server" Text='<%# Bind("VendorName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="&#160;Alias&#160;" SortExpression="Alias">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("Alias") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="&#160;Email Address&#160;" SortExpression="VendorEmail">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        &nbsp;<asp:Label ID="Label2" runat="server" Text='<%# Bind("VendorEmail") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="&#160;Mobile No.&#160;" SortExpression="VendorEmail">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        &nbsp;<asp:Label ID="lnlmobileno" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="&#160;No. of Emails Sent&#160;" SortExpression="EmailSent">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmailSent") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="dsAuctionParticipants" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetAuctionParticipants" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="0" Name="AuctionRefNo" SessionField="AuctionRefNo" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <br />

                                        <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td id="actions">
                                                <asp:LinkButton ID="LinkButton1" runat="server" Width="100px" OnClick="LinkButton1_Click">Back</asp:LinkButton>
                                            </td>
                                        </tr>
                                        </table>
                                        <br />

                                        <!-- contents here //-->
                                        </div>
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
