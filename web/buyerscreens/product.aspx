<%@ page language="C#" autoeventwireup="true" inherits="WEB_buyer_screens_Product, App_Web_product.aspx.1829e19c" theme="default" %>

<%@ Register TagPrefix="EBid" TagName="TopNavProducts" Src="~/WEB/usercontrol/Buyer/TopNavProducts.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavProducts" Src="~/WEB/usercontrol/Buyer/LeftNavProducts.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
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
        <div align="left">
            <form id="Form1" method="post" runat="server">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                    <tr height="137px">
                        <td valign="top">
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
                                        <EBid:TopNavProducts runat="server" ID="TopNavProducts" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <EBid:TopNav2 runat="server" ID="TopNav2_1" />
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
                                            Registered Products</h2>
                                        <div align="left">
                                            <EBid:LeftNavProducts runat="server" ID="LeftNavProducts" />
                                        </div>
                                        <p>
                                            &nbsp;</p>
                                    </td>
                                    <td id="content">
                                        <h1>
                                            <br />
                                            Products</h1>
                                        <p>
                                            Search items by:
                                        </p>
                                        <div align="left">
                                            <div align="left">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="itemDetails">
                                                    <tr>
                                                        <th>
                                                            Item Name:</th>
                                                        <th>
                                                            Brand:</th>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtSKU"></asp:TextBox></td>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlBrand">
                                                            </asp:DropDownList></td>
                                                    </tr>
                                                    <tr>
                                                        <th>
                                                            Service :</th>
                                                        <th>
                                                            Sub-category</th>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlServices">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlSubCategory">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                            </div>
                                            <div align="left">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td>
                                                            <asp:LinkButton runat="server" ID="btnSearch" OnClick="btnSearch_Click">Search</asp:LinkButton></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:GridView AutoGenerateColumns="false" runat="server" ID="gvProducts" CssClass="pageDetails" OnRowCommand="gvProducts_RowCommand" PageSize="20" OnPageIndexChanging="gvProducts_PageIndexChanging" AllowPaging="true"
                                                    BorderWidth="0">
                                                    <HeaderStyle CssClass="pageDetails_th" ForeColor="#FFFFFF" />
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <FooterStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="SKU">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lnkSKU" Text='<%#Bind("SKU") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Item Name">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblItemName" Text='<%#Bind("ItemName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Product Description">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblProductDescription" Text='<%#Bind("ProductDescription") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Service Name">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblServiceName" Text='<%#Bind("ServiceName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Brand Name">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblBrandName" Text='<%#Bind("BrandName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Sub Category Name">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblSubCategoryName" Text='<%#Bind("SubCategoryName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Unit Of Measure">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" ID="lblUnitOfMeasure" Text='<%#Bind("UnitOfMeasure") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                            <div align="left" runat="server" id="dvFooter">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td>
                                                            &nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <br />
                                            <div>
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="Table1">
                                                    <tr>
                                                        <td class="value" align="center">
                                                            <asp:Label runat="server" ID="lblMessage"></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <p>
                                                &nbsp;</p>
                                        </div>
                                    </td>
                                </tr>
                            </table>
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
    </div>
</body>
</html>
