<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_RegProductSubCategory, App_Web_regproductsubcategory.aspx.1829e19c" theme="default" %>

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

    <script language="javascript" type="text/javascript" src="../include/customValidation.js"></script>

</head>
<body>
    <div align="left" height="100%">
        <form id="Form1" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr>
                    <td valign="top" width="100%">
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
                    <td height="100%">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>
                                        Products</h2>
                                    <div align="left">
                                        <EBid:LeftNavProducts runat="server" ID="LeftNavProducts" />
                                    </div>
                                    <br />
                                </td>
                                <td id="content">
                                    <h1>
                                        <br />
                                        Add Sub Category</h1>
                                    <div align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="itemDetails">
                                            <tr>
                                                <th colspan="2">
                                                    Details</th>                                                
                                            </tr>
                                            <tr>
                                                <td style="width: 130px">
                                                    Category:</td>
                                                <td class="value">
                                                    <table cellpadding="0" cellspacing="0" border="0" id="clearTable">
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlCategory">
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" Display="None" ErrorMessage="Category is a required field." SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnCategory" runat="server" Text="Add Category" CausesValidation="false" PostBackUrl="~/web/buyerscreens/RegProductCategory.aspx"></asp:LinkButton>
                                                                </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Sub-Category Name:
                                                </td>
                                                <td class="value">
                                                    <table id="clearTable" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtSubCategoryName" MaxLength="50" Width="200px"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="rfvSubCategoryName" runat="server" ControlToValidate="txtSubCategoryName" Display="None" ErrorMessage="Sub-Category is a required field." SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                <asp:Label ID="lblSubCategoryName" runat="server" CssClass="messagelabels"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Sub-Category Description:
                                                </td>
                                                <td class="value">
                                                    <table id="clearTable" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtSubCategoryDesc" Width="200px" Rows="5" TextMode="MultiLine"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                    </div>
                                    <div align="left">
                                        <div align="left">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                <tr>
                                                    <td align="left" width="75%" style="height: 34px">
                                                        <asp:Label ID="lblMessage" runat="server" CssClass="messagelabels"></asp:Label>
                                                    </td>
                                                    <td align="right" width="25%" style="height: 34px">
                                                        <asp:LinkButton runat="server" ID="btnSave" Width="100px" OnClick="btnSave_Click">Save</asp:LinkButton>
                                                        <asp:LinkButton runat="server" ID="btnClear" Width="100px" CausesValidation="False" OnClick="btnClear_Click">Clear</asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer">
                        <EBid:Footer runat="server" ID="Footer1" />
                        <asp:CustomValidator ID="cuvValidate" runat="server" ClientValidationFunction="ValidatorIndividualAlert(this, args);" Display="None"></asp:CustomValidator></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
