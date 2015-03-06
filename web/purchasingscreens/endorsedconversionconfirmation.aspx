<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_EndorsedConversionConfirmation, App_Web_endorsedconversionconfirmation.aspx.9bdd8cc1" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Bids" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TendersCommentBox" Src="~/web/usercontrol/TendersCommentBox.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
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
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <h2>
                                                    Bids</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                                <EBid:TendersCommentBox runat="server" ID="TendersCommentBox" />
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
                                                                Bid Item and Tender Conversion Confirmation</h1>
                                                            <div align="left">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="itemDetails">
                                                                    <tr>
                                                                        <th>
                                                                            Convert Bid Item
                                                                            <asp:Label runat="server" ID="lblBidRefNo" />
                                                                            and all tenders to auction.</th>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <br />
                                                            <asp:GridView runat="server" ID="gvEndorsedItems" AllowPaging="false" PageSize="20"
                                                                AllowSorting="false" AutoGenerateColumns="false" CssClass="itemDetails">
                                                                <HeaderStyle CssClass="itemDetails_th" />
                                                                <RowStyle CssClass="itemDetails_td" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Item" ItemStyle-Width="83">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblBidItems" runat="server" Text='<%# Bind("Item") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Cost" ItemStyle-Width="183" ItemStyle-BackColor="#FFFFFF">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCost" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Supplier" ItemStyle-BackColor="#FFFFFF">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblSupplier" runat="server" Text='<%# Bind("VendorName") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <br />
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                                <tr>
                                                                    <td>
                                                                        <a href="EndorsementSummary.aspx">Back</a>
                                                                        <asp:LinkButton ID="Submit" Text="Submit" runat="server" OnClick="Submit_Click"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <p>
                            &nbsp;</p>
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
