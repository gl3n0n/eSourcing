<%@ Page Language="C#" AutoEventWireup="true" CodeFile="biditemdetails.aspx.cs" Inherits="web_buyerscreens_biditemdetails" MaintainScrollPositionOnPostback="true" %>

<%@ Reference Control="~/web/usercontrol/commentlist_tender.ascx" %>
<%@ Register Src="../usercontrol/bids/bidtender_attachments_buyer.ascx" TagName="bidtender_attachments" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/bids/bidtenderdetails.ascx" TagName="bidtenderdetails" TagPrefix="uc1" %>
<%@ Register Src="../usercontrol/bids/biditemdetails.ascx" TagName="biditemdetails" TagPrefix="uc2" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
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
                                    <EBid:TopNavBids runat="server" ID="TopNavBids" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNav2 runat="server" ID="TopNav2" />
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
                                            <td id="Td1">
                                                <h2>
                                                    Bid Events</h2>
                                                <div align="left">
                                                    <EBid:LeftNav runat="server" ID="LeftNav" />
                                                </div>
                                                <h2>
                                                    Comments</h2>
                                                <div align="left">
                                                    <asp:PlaceHolder ID="phComments" runat="server"></asp:PlaceHolder>
                                                </div>
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content" style="width: 100%">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table5">
                                        <tr>
                                            <td id="content0">
                                                <h1>
                                                    <br />
                                                    Bid Item Details</h1>
                                                <p>
                                                    These are the submitted tenders for this bid item.
                                                    <br />
                                                </p>
                                                <div align="left">
                                                    <p>
                                                        <uc2:biditemdetails ID="ctrlBidItemDetails" runat="server" />
                                                    </p>
                                                    <p>
                                                        <asp:GridView ID="gvBidItemTenders" runat="server" Width="100%" AutoGenerateColumns="False" SkinID="AuctionedItems" DataKeyNames="BidTenderNo" DataSourceID="dsBidItemTenders" OnRowCommand="gvBidItemTenders_RowCommand"
                                                            OnSelectedIndexChanged="gvBidItemTenders_SelectedIndexChanged" OnDataBound="gvBidItemTenders_DataBound">
                                                            <SelectedRowStyle BackColor="#50A4D1" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Tender No." InsertVisible="False" SortExpression="BidTenderNo">
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                    <ItemStyle Width="80px" />
                                                                    <ItemTemplate>
                                                                        &nbsp;<asp:LinkButton ID="lnkTenderNo" runat="server" ToolTip="Click to view details and comments of this bid tender." Width="95%"
                                                                            CausesValidation="False" CommandName="Select" CommandArgument='<%# Bind("BidTenRef") %>' Text='<%# Bind("BidTenderNo") %>' Enabled='<%# !isEnabled(Eval("Status"),Eval("RenegotiationDeadline")) %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Bidder" SortExpression="VendorName">
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <ItemTemplate>                                                                        
                                                                        <asp:LinkButton ID="lnkVendor" runat="server" ToolTip="Click to view details and comments of this bid tender." Width="95%"
                                                                            CausesValidation="False" CommandName="Select" CommandArgument='<%# Bind("BidTenRef") %>' Text='<%# Bind("VendorName") %>' Enabled='<%# !isEnabled(Eval("Status"),Eval("RenegotiationDeadline")) %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Bid Price" SortExpression="BidPrice">
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <ItemTemplate>                                                                        
                                                                        <asp:Label ID="lnkPrice" runat="server" Width="95%" Text='<%# Bind("BidPrice", "{0:#,##0.00}") %>' Visible='<%# !isEnabled(Eval("Status"),Eval("RenegotiationDeadline")) %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Date Submitted" SortExpression="DateSubmitted">
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lnkDate" runat="server" Width="95%" Text='<%# Bind("DateSubmitted", "{0:D}<br />{0:T}") %>'></asp:Label>                                                                        
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Remarks" SortExpression="Remarks">
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("Remarks").ToString().Trim().Length > 0 ? Eval("Remarks").ToString() : "No Remarks" %>' ForeColor='<%# Eval("Remarks").ToString().Trim().Length > 0 ? System.Drawing.Color.Black : System.Drawing.Color.Gray %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <ItemStyle HorizontalAlign="Center" Width="80px" />
                                                                    <ItemTemplate>
                                                                        <asp:Panel runat="server" ID="pnlLinks">                                                                            
                                                                            <asp:LinkButton ID="lnkEndorse" runat="server" ToolTip="Click to endorse this bid item." CommandArgument='<%# Bind("BidTenderNo") %>' CommandName="Endorse" Visible='<%# !isEndorsed(Eval("Status")) %>' Enabled='<%# !isEnabled(Eval("Status"),Eval("RenegotiationDeadline")) %>'>Endorse</asp:LinkButton>
                                                                            <asp:Label ID="lblStatus" runat="server" Text="Endorsed" Visible='<%# isEndorsed(Eval("Status")) %>'></asp:Label>
                                                                        </asp:Panel>
                                                                        <asp:Panel runat="server" ID="pnlComments" Visible="false">
                                                                            Comments
                                                                            <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Font-Names="Arial" Width="100%" Height="45px"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="rfvComments" runat="server" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Comments Required." ControlToValidate="txtComment"></asp:RequiredFieldValidator>
                                                                            <br />
                                                                            <asp:LinkButton ID="lnkOK" runat="server" CommandName="ContinueEndorsement" CommandArgument='<%# Bind("BidTenderNo") %>' OnClientClick="return confirm('Are you sure you want to endorse this item?');">OK</asp:LinkButton>&nbsp;&nbsp;
                                                                            <asp:LinkButton ID="lnkCancel" runat="server" CommandName="CancelEndorsement" CausesValidation="false">Cancel</asp:LinkButton>
                                                                            <br /><br />
                                                                        </asp:Panel>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="dsBidItemTenders" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetBidItemTenders" SelectCommandType="StoredProcedure">
                                                            <SelectParameters>
                                                                <asp:SessionParameter DefaultValue="0" Name="BidDetailNo" SessionField="BidDetailNo" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </p>
                                                    <center>
                                                        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="red" Font-Size="11px"></asp:Label></center>
                                                    <p>
                                                        <asp:DetailsView ID="dvTenderDetails" runat="server" Width="100%" AutoGenerateRows="False" DataKeyNames="BidTenderNo" DataSourceID="dsBidItemTenders" SkinID="BidDetails" Visible="false">
                                                            <HeaderTemplate>
                                                                &nbsp;Bid Tender Details
                                                            </HeaderTemplate>
                                                            <Fields>
                                                                <asp:TemplateField HeaderText="Tender No." InsertVisible="False">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("BidTenderNo") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Bidder">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("VendorName") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("Amount", "{0:#,##0.00}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Discount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("Discount", "{0:#,##0.00}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Delivery Cost">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("DeliveryCost", "{0:#,##0.00}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Bid Price">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label2" runat="server" Font-Bold="true" Text='<%# Bind("BidPrice", "{0:#,##0.00}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Remarks">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("Remarks").ToString().Trim().Length > 0 ? Eval("Remarks").ToString() : "No Remarks" %>' ForeColor='<%# Eval("Remarks").ToString().Trim().Length > 0 ? System.Drawing.Color.Black : System.Drawing.Color.Gray %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Date Submitted">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("DateSubmitted", "{0:D}") %>'></asp:Label>,
                                                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("DateSubmitted", "{0:T}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Fields>
                                                        </asp:DetailsView>
                                                    </p>
                                                    <p>
                                                        <asp:Panel runat="server" ID="pnlBidTenderAttachments" Visible=false>     
                                                          <uc3:bidtender_attachments ID="Bidtender_attachments" runat="server" />
                                                        </asp:Panel>
                                                    </p>
                                                    <br />
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                        <tr>
                                                            <td style="height: 34px">
                                                                &nbsp;
                                                                <asp:HyperLink ID="lnkComparison" runat="server" Width="160px">Comparison By Bid Item</asp:HyperLink>
                                                                <asp:LinkButton ID="lnkBack" runat="server" OnClick="lnkBack_Click" Width="100px">Back</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <br />
                                                </div>
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
