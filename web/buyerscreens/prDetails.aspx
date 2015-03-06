<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prDetails.aspx.cs" Inherits="web_buyerscreens_prDetails" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc4" %>
<%@ Register Assembly="Calendar" Namespace="CalendarControl" TagPrefix="cc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style_buyer.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div align="left">
        <form id="Form1" runat="server" defaultbutton = "lnkBack">
            &nbsp<table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
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
                                        <td id="td1">
                                            <h2>
                                                Bids</h2>
                                            <div align="left">
                                                <EBid:LeftNav runat="server" ID="LeftNav" />
                                            </div>
                                            <h2>
                                                Comments</h2>
                                            <uc4:commentlist ID="Commentlist1" runat="server" />
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td id="content" style="width: 100%">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table5">
                                    <tr>
                                        <td  id="content0">
                                            <h1> 
                                            <br />
                                                PR Details</h1>
                                            <p>To edit the details of this PR, make the necessary changes and click "Save Changes"</p>
                                            <div align="left">
                                                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="dsPRDetails" 
                                                    HeaderText="Details" SkinID="BidDetails">
                                                    <Fields>
                                                        <asp:TemplateField HeaderText="PR Ref No" Visible="False">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPrRefNo" runat="server" ForeColor="Black" Text='<%# Bind("PrRefNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PR No" InsertVisible="False" SortExpression="PRNo">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPRNo" runat="server" ForeColor="Black" Text='<%# Bind("PRNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PR Line No" SortExpression="PR Line No">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPRLineNo" runat="server" ForeColor="Black" Text='<%# Bind("PRLineNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PR Date" SortExpression="PRDate">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                               <asp:Label ID="lblPRDate" runat="server" ForeColor="Black" Text='<%# Bind("PRDate") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Item Code" SortExpression="ItemCode">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white"/>
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtItemCode" runat="server" Width="350px" Text='<%# Bind("ItemCode") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Description" SortExpression="PRDescription">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtPRDescription" runat="server" Width="350px" Text='<%# Bind("PRDescription") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Delivery Date" SortExpression="DeliveryDate">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDeliveryDate" runat="server" Width="350px" Text='<%# Bind("DeliveryDate") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Unit of Measure" SortExpression="UOM">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtUOM" runat="server" Width="350px" Text='<%# Bind("UOM") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Quantity" SortExpression="Qty">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtQty" runat="server" Width="350px" Text='<%# Bind("Qty") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>                                                       
                                                        <asp:TemplateField HeaderText="Unit Price" SortExpression="UnitPrice">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtUnitPrice" runat="server" Width="350px" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Currency" SortExpression="Currency">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtCurrency" runat="server" Width="350px" Text='<%# Bind("Currency") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Commodity" SortExpression="Commodity">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtCommodity" runat="server" Width="300px" Text='<%# Bind("Commodity") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Group" SortExpression="GroupName">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtGroupName" runat="server" Width="200px" Text='<%# Bind("GroupName") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Buyer" SortExpression="Buyer">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBuyerName" runat="server" ForeColor="Black" Text='<%# Bind("Buyer") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Purchasing Officer" SortExpression="PurchasingOfficer">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white" />
                                                            <ItemTemplate>
                                                                 <asp:Label ID="lblPurchasingOfficer" ForeColor="Black" runat="server" Text='<%# Bind("PurchasingOfficer") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                                            <HeaderStyle Width="133px" />
                                                            <ItemStyle BackColor="white"/>
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPRStatus" ForeColor="Black" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Fields>
                                                </asp:DetailsView>
                                                <asp:SqlDataSource ID="dsPRDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetPRDetails" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="PrRefNo" SessionField="PrRefNo" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>   
                                                <p style="text-align: center;">
                                                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                                </p>
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td style="height: 34px">
                                                            &nbsp;
                                                            <asp:LinkButton ID="lnkSave" runat="server" OnClick="lnkSave_Click" Width="150px">Save Changes</asp:LinkButton>  
                                                            <asp:LinkButton ID="lnkBack" runat="server" OnClick="lnkBack_Click" Width="120px">Back</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
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
