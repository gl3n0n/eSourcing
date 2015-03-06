<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rfiforeval.aspx.cs" Inherits="web_buyerscreens_rfiforeval" %>

<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavRfi" Src="~/WEB/usercontrol/Buyer/TopNavRfi.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    <form runat="server">
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
                            <EBid:TopNavRfi runat="server" ID="TopNavRfi" />
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
        <tr valign="top">
            <td valign="top">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                    <tr>
                        <td id="relatedInfo">
                                <h2 align="left">Bids </h2>
                            <div align="left">
                                <EBid:LeftNav runat="server" ID="LeftNav" />
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
                                                                Received RFI Tenders</h1>
                                                            <p>
                                                                These are the tenders that have been submitted by the vendors.<br />&nbsp;
                                                                <asp:CheckBox ID="chkShowTenderizedRfisOnly" runat="server" AutoPostBack="True"
                                                                    Text="Show only those RFI Items with RFI Tenders." ToolTip="Check to filter to show only those RFI items with atleast one RFI tender."
                                                                    OnCheckedChanged="chkShowTenderizedRfisOnly_CheckedChanged" />
                                                                <asp:CheckBox ID="chkPastSubmissionDeadline" runat="server" AutoPostBack="True" 
                                                                    Text="Show only those RFI Items with past submission deadline" ToolTip="Check to filter to show only RFI Items with past submission deadline." 
                                                                    OnCheckedChanged="chkPastSubmissionDeadline_CheckedChanged" Visible="false" />
                                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                            </p>
                                                            <asp:GridView ID="gvReceivedUnlockedTenders" runat="server" AutoGenerateColumns="False"
                                                                SkinID="BidEvents" AllowPaging="True" AllowSorting="True" PageSize="20" Width="100%"
                                                                BorderColor="White" OnRowCommand="gvReceivedUnlockedTenders_RowCommand" DataSourceID="dsReceivedItemTenders"
                                                                OnRowDataBound="gvReceivedUnlockedTenders_RowDataBound" DataKeyNames="RfiRefNo">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Detail No." InsertVisible="False" SortExpression="RfiDetailNo">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle Width="90px" />
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkRfiDetailNo" runat="server" Text='<%# Bind("RfiDetailNo") %>'
                                                                                Visible='<%# valueIsOpen(Eval("Status"), Eval("SubmittedTenderCount")) %>' Width="95%"
                                                                                CommandName='ViewRfiItemDetails' CommandArgument='<%# Bind("RfiDetailNo") %>'
                                                                                ToolTip="Click to view RFI tenders for this RFI item."></asp:LinkButton>
                                                                            <asp:Label ID="lblRfiDetailNo" runat="server" Text='<%# Bind("RfiDetailNo") %>' Visible='<%# valueIsNotOpen(Eval("Status"), Eval("SubmittedTenderCount")) %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Rfi Item" SortExpression="DetailDesc">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkRfiItem" runat="server" Text='<%# Bind("DetailDesc") %>' Visible='<%# valueIsOpen(Eval("Status"), Eval("SubmittedTenderCount")) %>'
                                                                                CommandName="ViewRfiItemDetails" CommandArgument='<%# Bind("RfiDetailNo") %>'
                                                                                ToolTip="Click to view RFI tenders for this RFI item."></asp:LinkButton>
                                                                            <asp:Label ID="lblRfiItem" runat="server" Text='<%# Bind("DetailDesc") %>' Visible='<%# valueIsNotOpen(Eval("Status"), Eval("SubmittedTenderCount")) %>'></asp:Label>
                                                                            <br />
                                                                            &nbsp;&nbsp;<asp:Label ID="Label1" runat="server" ForeColor="gray" Text='<%# showRfiTenderCount(Eval("SubmittedTenderCount")) %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Rfi Event" SortExpression="ItemDesc">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkRfiEvent" runat="server" Text='<%# Bind("ItemDesc") %>'
                                                                                CommandName="ViewRfiEventDetails" CommandArgument='<%# Bind("RfiRefNo") %>' ToolTip="Click to view details of this RFI event."></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Rfi Submission Deadline" SortExpression="Deadline">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblRfiSubmissionDeadline" runat="server" Text='<%# Bind("Deadline", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="dsReceivedItemTenders" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                                SelectCommand="sp_GetBuyerReceivedRFIItemTenders" SelectCommandType="StoredProcedure"
                                                                FilterExpression="SubmittedTenderCount >= {0}">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
                                                                </SelectParameters>
                                                                <FilterParameters>
                                                                    <asp:ControlParameter ControlID="HiddenField1" Name="ShowItemsWithTenders" PropertyName="Value"
                                                                        DefaultValue="0" Type="Int32" />
                                                                </FilterParameters>
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
            <td id="footer" height="50px" align="left">
                <EBid:Footer runat="server" ID="Footer" />
            </td>
        </tr>
    </table>
    </form>
    </div>
</body>
</html>
