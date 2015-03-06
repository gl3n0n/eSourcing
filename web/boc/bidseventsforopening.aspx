<%@ page language="c#" enableeventvalidation="true" inherits="EBid.WEB.boc.bideventsforopening, App_Web_bidseventsforopening.aspx.14769a0e" theme="default" %>
<%@ Register Src="../usercontrol/boc/BOC_LeftNav_Bids.ascx" TagName="BOC_LeftNav_Bids" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/boc/BOC_TopNav_Bids.ascx" TagName="BOC_TopNav_Bids" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style_ph.css" rel="stylesheet" type="text/css" />
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
                                    <uc1:BOC_TopNav_Bids ID="BOC_TopNav_Bids1" runat="server" />
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
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%;">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>
                                        Bid Events</h2>
                                    <uc2:BOC_LeftNav_Bids ID="BOC_LeftNav_Bids1" runat="server" />
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
                                                                Bid Events For Opening</h1>
                                                            <br />
                                                            <asp:GridView runat="server" ID="gvBidEventsForOpening" SkinID="BidEvents" AllowPaging="True"
                                                                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="BidRefNo,CommitteeId,IsApprovedByPurchasing,IsApprovedByFinance,IsApprovedByAudit,Deadline" DataSourceID="dsBidEventsForOpening"
                                                                OnRowCommand="gvBidEventsForOpening_RowCommand" OnRowDataBound="gvBidEventsForOpening_RowDataBound">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Reference No." SortExpression="BidRefNo">
                                                                        <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkBidRefNo" runat="server" Text='<%# Eval("BidRefNo") %>'
                                                                                CommandName="bidEvent" CommandArgument='<%# Eval("BidRefNo", "{0}") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Bid Event" SortExpression="ItemDesc">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkBidEvent" runat="server" Text='<%# Eval("ItemDesc") %>'
                                                                                CommandName="bidEvent" CommandArgument='<%# Eval("BidRefNo", "{0}") %>'></asp:LinkButton><br />	
                                                                                &nbsp;&nbsp;<asp:Label ID="LabelTenderCount" runat="server" ForeColor="gray" Text='<%# showBidTenderCount(Eval("SubmittedTenderCount")) %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Buyer" SortExpression="Creator">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("Creator") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText=" ">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            <asp:Panel ID="pnlOpeningCommittee" runat="server" Width="200" visible="false">
                                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size:11px; font-family:Arial;">
                                                                                    <tr>
                                                                                        <td align="center" style="width: 70px;">
                                                                                            Purchasing</td>
                                                                                        <td align="center" style="width: 70px;">
                                                                                            Finance</td>
                                                                                        <td align="center" style="width: 70px;">
                                                                                            VM</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="center" style="width: 70px">
                                                                                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# (Eval("IsApprovedByPurchasing").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg"%>'>
                                                                                            </asp:Image>
                                                                                        </td>
                                                                                        <td align="center" style="width: 70px">
                                                                                            <asp:Image ID="Image2" runat="server" ImageUrl='<%# (Eval("IsApprovedByFinance").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg"%>'>
                                                                                            </asp:Image>
                                                                                        </td>
                                                                                        <td align="center" style="width: 70px;">
                                                                                            <asp:Image ID="Image3" runat="server" ImageUrl='<%# (Eval("IsApprovedByAudit").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg" %>'>
                                                                                            </asp:Image>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:Panel>
                                                                            <asp:Panel ID="pnlOpenEvent" runat="server" Width="200" visible="false">
                                                                                <asp:LinkButton ID="lnkOpenEvent" runat="server" Text='Open'
                                                                                CommandName="openEvent" CommandArgument='<%# Eval("BidRefNo", "{0}") %>' >
                                                                            </asp:LinkButton>
                                                                            </asp:Panel>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="80px" HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Submission Deadline" SortExpression="Deadline">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="Label2" runat="server" Text='<%# Bind("Deadline", "{0:D}") %>'></asp:Label><br />
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Deadline", "{0:T}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="dsBidEventsForOpening" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                                SelectCommand="sp_QueryBidsEventsForOpening" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter DefaultValue="0" Name="BOCId" SessionField="UserId" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
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
