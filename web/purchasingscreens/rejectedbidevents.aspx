<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rejectedbidevents.aspx.cs" Inherits="web_purchasing_screens_RejectedBidEvents" %>

<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Bids" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>	
	<title id="PageTitle" runat="server"></title>
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
                                    <EBid:Purchasing_TopNav_Bids runat="server" ID="Purchasing_TopNav_Bids" />
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
                                    <h2>
                                        Bid Events</h2>
                                    <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
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
                                                                Rejected Bid Events</h1>
                                                            <br />
                                                            <asp:GridView runat="server" ID="gvRejectedBids" SkinID="BidEvents"
                                                                AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                                                                EmptyDataText="No Bid Events To Display." 
                                                                DataKeyNames="BidRefNo" DataSourceID="dsRejectedBidEvents" OnRowCommand="gvBids_RowCommand">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Reference No." InsertVisible="False" SortExpression="BidRefNo">
                                                                        <HeaderStyle HorizontalAlign="Center" />  
                                                                        <ItemStyle Width="85px" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkBidNo" runat="server" CommandName="bidRefNo" CommandArgument='<%# Eval("BidRefNo", "{0}") %>'
                                                                                Text='<%# Bind("BidRefNo") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Rejected Bid Events" SortExpression="ItemDesc">
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:LinkButton ID="lnkBidEvent" runat="server" CommandName="bidRefNo" CommandArgument='<%# Eval("BidRefNo", "{0}") %>'
                                                                                Text='<%# Eval("ItemDesc") %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Date Rejected" SortExpression="DateRejected">
                                                                        <HeaderStyle HorizontalAlign="Center" />  
                                                                        <ItemStyle Width="180px" HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:Label ID="lblDateRejected" runat="server" Text='<%# Eval("DateRejected","{0:D}<br />{0:T}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="dsRejectedBidEvents" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                                SelectCommand="s3p_EBid_GetRejectedBidEvents" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="PurchasingId" SessionField="UserId" Type="int32" />
                                                                </SelectParameters>
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
