<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bacapprovedpurchasing.aspx.cs" Inherits="web_bac_bacapprovedpurchasing" %>
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
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <h2>
                                                    Bid Events</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
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
                                                                BAC Approved by Purchasing</h1>
                                                            <br />
                                                            <asp:GridView ID="gvBids" runat="server" SkinID="BidEvents" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowCommand="gvBids_RowCommand" DataKeyNames="BidRefNo" DataSourceID="dsAproved">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Reference No." InsertVisible="False" SortExpression="BidRefNo">
                                                                <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkRefNo" runat="server" Text='<%# Bind("BidRefNo") %>' CommandArgument='<%# Bind("BACBID") %>' CommandName="Details"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Bid Event" SortExpression="ItemDesc">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkDesc" runat="server" Text='<%# Bind("ItemDesc") %>' CommandArgument='<%# Bind("BACBID") %>' CommandName="Details"></asp:LinkButton><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Approving Status" SortExpression="ItemDesc">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    <table style="width: 100%;">
                                                                        <tr align="center">
                                                                            <td><asp:CheckBox ID="CheckBox1" runat="server" ViewStateMode="Inherit" /></td>
                                                                            <td><asp:CheckBox ID="CheckBox2" runat="server" ViewStateMode="Inherit" /></td>
                                                                            <td><asp:CheckBox ID="CheckBox3" runat="server" ViewStateMode="Inherit" /></td>
                                                                            <td><asp:CheckBox ID="CheckBox4" runat="server" ViewStateMode="Inherit" /></td>
                                                                            <td><asp:CheckBox ID="CheckBox5" runat="server" ViewStateMode="Inherit" /></td>
                                                                        </tr>
                                                                        <tr style='font-size:10px;' align="center">
                                                                            <td>Buyer</td>
                                                                            <td>Purchasing</td>
                                                                            <td>Bac 1</td>
                                                                            <td>Bac 2</td>
                                                                            <td>Bac 3</td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Date Created" SortExpression="DateApproved">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("PreparedDt", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="dsAproved" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" 
                                                        SelectCommand="SELECT BacRefNo, BidRefNo, ItemDesc, PreparedDt, CONVERT(VARCHAR, BidRefNo)+';'+CONVERT(VARCHAR, BacRefNo)+';'+CONVERT(VARCHAR, BuyerId) AS BACBID FROM tblBacBidItems WHERE Status=@Status"  SelectCommandType="Text" >
                                                        <SelectParameters>
                                                            <asp:Parameter Name="Status" DefaultValue="3" Type="Int32" />
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
