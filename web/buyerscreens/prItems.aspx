<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prItems.aspx.cs" Inherits="web_buyerscreens_prItems" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PR Items</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
	<meta http-equiv="Content-Language" content="en-us" />
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
	<script type="text/javascript" src="../include/generaljsfunctions.js"></script>
	<script type="text/javascript" src="../include/events.js"></script>	
</head>
<body>
    <div>
        <form id="frmPRs" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" style="width:100%;  vertical-align: top; height: 100%;">
            <tr>
                <td id="content">
                    <br />
                    <h1>PR Items</h1>
                    <br />
                    <asp:GridView ID="gvPRItems" runat="server" SkinID="BidEvents" AllowPaging="True" 
                        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="PRNo" 
                        DataSourceID ="dsPRItems">
                    <Columns>
                        <asp:TemplateField HeaderText="PR" InsertVisible="False" SortExpression="PRNo">
                            <HeaderStyle HorizontalAlign="Center" Width="90px" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblPRNo" runat="server" Text='<%# Bind("PRNo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PR Description" SortExpression="PrDescription">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblDesc" runat="server" Text='<%# Bind("PRDescription") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item Code" SortExpression="ItemCode">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblItemCode" runat="server" Text='<%# Bind("ItemCode") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PR Date" SortExpression="PRDate">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblDate" runat="server" Text='<%# Bind("PRDate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit of Measure" SortExpression="UOM">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblUOM" runat="server" Text='<%# Bind("UOM") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity" SortExpression="Qty">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit Price" SortExpression="UnitPrice">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblUnitPrice" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delivery Date" SortExpression="PRDate">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                &nbsp<asp:Label ID="lblDeliveryDate" runat="server" Text='<%# Bind("DeliveryDate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="dsPRItems" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                        SelectCommand="sp_ViewGroupedPR" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
                            <asp:QueryStringParameter Name="GroupName" QueryStringField="GroupName" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
            </tr>   
            </table>
        </form>
    </div>
</body>
</html>
