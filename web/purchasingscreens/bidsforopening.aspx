<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_bidsForOpen, App_Web_bidsforopening.aspx.9bdd8cc1" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Bids" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>.:| Globe Telecom eSourcing System | Bid Events For Opening |:.</title>
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
                                <td id="relatedInfo" style="width: 250px">
                                    <h2>
                                        Bids</h2>
                                    <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <h1>
                                        <br />
                                        Bid Events for Unlocking &amp; Opening</h1>
                                    <br />
                                    <asp:GridView runat="server" ID="gvBidsForOpening" SkinID="BidEvents" 
                                        AllowPaging="True" AutoGenerateColumns="False" AllowSorting="True" 
                                        OnRowCommand="gvBids_RowCommand" DataSourceID="dsBidsForOpenning" 
                                        EmptyDataText="No Bid Events To Display.">
                                        <Columns>                                            
                                            <asp:TemplateField HeaderText="Bid Items" SortExpression="ItemDesc">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    &nbsp;<asp:LinkButton CommandName="Select" ID="lblBidEvent" runat="server" Text='<%# Bind("ItemDesc") %>'
                                                        CommandArgument='<%# Bind("BidTenderGeneralNo", "{0}") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vendor Name" SortExpression="VendorName">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    &nbsp;<asp:Label ID="lblVendorName" runat="server" Text='<%# Bind("VendorName") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PurchDept">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# (Eval("PurchDept").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg"%>'>
                                                    </asp:Image>
                                                </ItemTemplate>
                                                <ItemStyle Width="80px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Internal Audit">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Image ID="Image2" runat="server" ImageUrl='<%# (Eval("IntAuditDept").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg"%>'>
                                                    </asp:Image>
                                                </ItemTemplate>
                                                <ItemStyle Width="80px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Financing">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Image ID="Image3" runat="server" ImageUrl='<%# (Eval("FinanceDept").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg" %>'>
                                                    </asp:Image>
                                                </ItemTemplate>
                                                <ItemStyle Width="80px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="80px" />
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="dsBidsForOpenning" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                        SelectCommand="s3p_EBid_QueryBidsForOpening" SelectCommandType="StoredProcedure">
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                        <p>
                            &nbsp;</p>
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
