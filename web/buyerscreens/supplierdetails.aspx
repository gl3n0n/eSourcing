<%@ Page Language="C#" AutoEventWireup="true" CodeFile="supplierdetails.aspx.cs" Inherits="web_buyer_screens_SupplierDetails" %>

<%@ Register TagPrefix="EBid" TagName="TopNavSuppliers" Src="~/WEB/usercontrol/Buyer/TopNavSuppliers.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavSuppliers" Src="~/WEB/usercontrol/Buyer/LeftNavSuppliers.ascx" %>
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
    <style type="text/css">
        .auto-style1 {
            width: 268435456px;
            height: 18px;
        }
        .auto-style2 {
            vertical-align: top;
            font-size: 11px;
            color: #000000;
            font-weight: normal;
            width: 268435456px;
            background-color: #FFFFFF;
        }
        .auto-style5 {
            height: 18px;
        }
    </style>
</head>
<body>
    <div align="left">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
            <form runat="server">
                <tr>
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
                                    <EBid:TopNavSuppliers runat="server" ID="TopNavSuppliers" />
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
                <tr height="100%">
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>
                                        Suppliers</h2>
                                    <EBid:LeftNavSuppliers runat="server" ID="LeftNavSuppliers" />
                                    <div align="left">                                        
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table3">
                                            <tr>
                                                <td>
                                                    <div align="left">
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table4">
                                                            <tr>
                                                                <td>
                                                                    &nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>                                        
                                    </div>
                                </td>
                                <td id="content" style="width: 100%">                                    
                                    <h1>
                                        <br />
                                        Supplier Profile</h1>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="itemDetails">
                                        <tr>
                                            <th>
                                                Company information</th>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Company Name:
                                                        </td>
                                                        <td style="border-width: 0" width="80%">
                                                            <asp:Label runat="server" ID="lblCompanyName"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Address: (Head Office)
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblAddressHeadOffice"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Telephone:</td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblTelephone"></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Fax:</td>
                                                        <td style="border-width: 0" width="30%">
                                                            <asp:Label runat="server" ID="lblFax"></asp:Label></td>
                                                        <td style="border-width: 0" width="20%">
                                                            Extension:</td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblExtension"></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Address: (Branch)</td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblAddressBranch"></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Telephone:</td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblTelephone1"></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Fax:</td>
                                                        <td style="border-width: 0" width="30%">
                                                            <asp:Label runat="server" ID="lblFax1"></asp:Label></td>
                                                        <td style="border-width: 0" width="20%">
                                                            Extension:</td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblExtension1"></asp:Label></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells" colspan="4">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            VAT Reg. No.:
                                                        </td>
                                                        <td style="border-width: 0" width="20%">
                                                            <asp:Label runat="server" ID="lblVatRegNo"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            TIN:
                                                        </td>
                                                        <td style="border-width: 0" width="20%">
                                                            <asp:Label runat="server" ID="lblTin"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            P.O. Box:
                                                        </td>
                                                        <td style="border-width: 0" width="30%">
                                                            <asp:Label runat="server" ID="lblPOBox"></asp:Label>
                                                        </td>
                                                        <td style="border-width: 0" width="20%">
                                                            Postal Code:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblPostalCode"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Email:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblEmail"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Standard Terms of Payment:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblStandardTerms"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Special Terms:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblSpecialTerms"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Minimum Order Value:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblMinimumOrderValue"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Sales Person:
                                                        </td>
                                                        <td style="border-width: 0" width="30%">
                                                            <asp:Label runat="server" ID="lblSalesPerson"></asp:Label>
                                                        </td>
                                                        <td style="border-width: 0" width="20%">
                                                            Telephone:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblTelephone2"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Type of Business Organization:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblTypeOfBusinessOrganization"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Ownership:
                                                        </td>
                                                        <td style="border-width: 0" width="3%">
                                                            <asp:Label runat="server" ID="lblFilipino"></asp:Label>
                                                        </td>
                                                        <td style="border-width: 0" width="27%">
                                                            % Filipino
                                                        </td>
                                                        <td style="border-width: 0" width="3%">
                                                            <asp:Label runat="server" ID="lblOtherNationality"></asp:Label>
                                                        </td>
                                                        <td style="border-width: 0">
                                                            % Other Nationality
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells">
                                                <table cellpadding="0" border="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Company Classification:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblCompanyClassification"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="value">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Sole Supplier:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblSoleSupplier"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="evenCells">
                                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                    <tr>
                                                        <td style="border-width: 0" width="20%">
                                                            Specialization:
                                                        </td>
                                                        <td style="border-width: 0">
                                                            <asp:Label runat="server" ID="lblSpecialization"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="vendorDetails_all">
                                        <tr>
                                            <th colspan="3" class="itemDetails_th">
                                                Key Personell</th>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvKeyPersonnel" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0px">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Names">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtName" runat="server" Text='<%# Bind("Name")%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="vendorDetails_td" />
                                                            <HeaderStyle CssClass="vendorDetails_th" Font-Bold="False" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Position">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtTitlePosition" runat="server" Text='<%# Bind("Position") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="vendorDetails_td" />
                                                            <HeaderStyle CssClass="vendorDetails_th" Font-Bold="False" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="vendorDetails_all">
                                        <tr>
                                            <th colspan="3" class="itemDetails_th">
                                                Present Services availed from Globe Telecom</th>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvPresentServices" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width='33%' HeaderText="Type Of Plan" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtTypeOfPlan" runat="server" Text='<%# Bind("Plan") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='33%' HeaderText="Acct No." ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtAcctNo" runat="server" Text='<%# Bind("AcctNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='33%' HeaderText="Credit Limit" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtCreditLimit" runat="server" Text='<%# Bind("CreditLimit") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="vendorDetails_all">
                                        <tr>
                                            <th colspan="3" class="itemDetails_th">
                                                References</th>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvMajorCustomers" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Major Customers" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtMajorCust" runat="server" Text='<%# Bind("Customer")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Average Monthly Sales" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtAveMonthlySales" runat="server" Text='<%# Bind("Sale")%>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvBanks" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Banks" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtBanks" runat="server" Text='<%# Bind("Bank") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Credit Line" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtCreditLine" runat="server" Text='<%# Bind("CreditLine") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvAffiliatedCompanies" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Affiliated Companies" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtAffiliatedCompanies" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Kind Of Business" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtKindOfBusiness" runat="server" Text='<%# Bind("Business") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvExternalAuditors" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="External Auditors" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtExternalAuditors" runat="server" Text='<%# Bind("Auditor") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='50%' HeaderText="Legal Counsel" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtLegalCounsel" runat="server" Text='<%# Bind("Counsel") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="vendorDetails_all">
                                        <tr>
                                            <th colspan="3" class="itemDetails_th">
                                                Add Equipment</th>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvEquipment" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-Width='33%' HeaderText="Type" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtType" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='33%' HeaderText="Units" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtUnit" runat="server" Text='<%# Bind("Unit") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width='33%' HeaderText="Remarks" ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="vendorDetails_all">
                                        <tr>
                                            <th colspan="3" class="itemDetails_th">
                                                Relative Working in Globe Telecom</th>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:GridView Width='100%' ID="gvRelatives" runat="server" AutoGenerateColumns="False" CssClass="vendorDetails" BorderWidth="0">
                                                    <AlternatingRowStyle CssClass="evenCells" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Name" ItemStyle-Width='33%' ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Title/Position" ItemStyle-Width='33%' ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtTitlePosition" runat="server" Text='<%# Bind("TitlePosition") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Relationship" ItemStyle-Width='33%' ItemStyle-CssClass="vendorDetails_td" HeaderStyle-CssClass="vendorDetails_th" HeaderStyle-Font-Bold="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="txtRelationship" runat="server" Text='<%# Bind("Relationship") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <div align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="ClearGrid">
                                            <tr>
                                                <th colspan="2" class="auto-style5">
                                                    Supplier Type:</th>
                                                <th colspan="2" class="auto-style1" style="width:30%">
                                                    Category:</th>
                                                <th colspan="2" class="auto-style1" style="width:50%">
                                                    Sub Category:</th>
                                            </tr>
                                            <tr>
                                                <td class="value" colspan="2">
                                                    <asp:Label runat="server" ID="lblSupplierType" /></td>
                                                <td class="auto-style2" colspan="2">
                                                    <asp:Label runat="server" ID="lblCategory" /></td>
                                                <td class="value" colspan="2">
                                                    <asp:Label runat="server" ID="lblSubCategory" /></td>
                                            </tr>
                                            <tr>
                                                <th colspan="3">
                                                    ISO Classification:</th>
                                                <th colspan="3">
                                                    PCAB Class:</th>
                                            </tr>
                                            <tr>
                                                <td class="value" colspan="3">
                                                    <asp:Label runat="server" ID="lblISOStandard"></asp:Label>
                                                </td>
                                                <td class="value" colspan="3">
                                                    <asp:Label runat="server" ID="lblPCABClass" /></td>
                                            </tr>
                                            <tr>
                                                <th colspan="3">
                                                    Brands:</th>
                                                <th colspan="3">
                                                    Services:</th>
                                            </tr>
                                            <tr>
                                                <td class="value" colspan="3" bordercolor="#FFFFFF">
                                                    <asp:GridView ShowHeader="false" ID="gvBrands" runat="server" AutoGenerateColumns="false" CssClass="ClearGrid">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblBrands" Text='<%# Bind("BrandName")%>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="ClearGrid" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <br />
                                                </td>
                                                <td class="value" colspan="3">
                                                    <asp:GridView ShowHeader="false" ID="gvServices" runat="server" AutoGenerateColumns="false" CssClass="ClearGrid">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblServices" Text='<%# Bind("ServiceName")%>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="ClearGrid" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th colspan="3">
                                                    Locations</th>
                                                <th colspan="3">
                                                    Items:</th>
                                            </tr>
                                            <tr>
                                                <td class="value" colspan="3">
                                                    <asp:GridView ShowHeader="false" ID="gvLocations" runat="server" AutoGenerateColumns="false" CssClass="ClearGrid">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblLocations" Text='<%# Bind("LocationName")%>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="ClearGrid" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <br />
                                                </td>
                                                <td class="value" colspan="3">
                                                    <asp:GridView ShowHeader="false" ID="gvItems" runat="server" AutoGenerateColumns="false" CssClass="ClearGrid">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblItems" Text='<%# Bind("ItemsCarried")%>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="ClearGrid" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <br />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <br />
   
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="itemDetails">
																			<tr>
                                                                                <th colspan="9">Other Info</th>	
                                                                            </tr>
																			<tr>
																				<td colspan="3" width="33%" class="evenCells"><strong>SLA Date</strong></td>
																				<td colspan="3" width="33%" class="evenCells"><strong>Accreditation Duration</strong></td>
																				<td colspan="3" width="33%" class="evenCells"><strong>Performance Evaluation Rating</strong></td>
																			</tr>
																			<tr>
																				<td class="value" width="20">&nbsp;</td>
																				<td class="value" width="6%">SIR Date</td>
																				<td class="value" width="12%">&nbsp;<asp:Label ID="tbSLASIRDate" runat="server" Text=""></asp:Label></td>
																				<td class="value" width="20">&nbsp;</td>
																				<td class="value" width="6%">FROM</td>
																				<td class="value" width="12%">&nbsp;<asp:Label ID="tbAccrFrom" runat="server" Text=""></asp:Label></td>
																				<td class="value" width="20">&nbsp;</td>
																				<td class="value" width="6%">Date</td>
																				<td class="value" width="12%">&nbsp;<asp:Label ID="tbPerfDate" runat="server" Text=""></asp:Label></td>
																			</tr>
																			<tr>
																				<td class="value">&nbsp;</td>
																				<td class="value">Date Approved</td>
																				<td class="value">&nbsp;<asp:Label ID="tbSLADateApproved" runat="server" Text=""></asp:Label></td>
																				</td>
																				<td class="value">&nbsp;</td>
																				<td class="value">TO</td>
																				<td class="value">&nbsp;<asp:Label ID="tbAccrTo" runat="server" Text=""></asp:Label></td>
																				<td class="value">&nbsp;</td>
																				<td class="value">Rate</td>
																				<td class="value">&nbsp;<asp:Label ID="tbPerfRate" runat="server" Text=""></asp:Label></td>
																			</tr>
																			<tr>
																				<td class="evenCells" colspan="2"><strong>Accredited Since</strong></td>
																				<td class="evenCells">&nbsp;<asp:Label ID="tbSLAAccredited" runat="server" Text=""></asp:Label></td>
																				<td colspan="6" class="evenCells">&nbsp;</td>
																			</tr>
																			<tr>
																				<td colspan="3" class="value"><strong>Composite Rating</strong></td>
																				<td colspan="3"  class="value"><strong>Maximum Exposure</strong></td>
																				<td colspan="3" class="value"><strong>Incident Report</strong></td>
																			</tr>
																			<tr>
																				<td class="value">&nbsp;</td>
																				<td class="value">SIR Date</td>
																				<td class="value">&nbsp;<asp:Label ID="tbCompSIRDate" runat="server" Text=""></asp:Label></td>
																				<td class="value">&nbsp;</td>
																				<td class="value">SIR Date</td>
																				<td class="value">&nbsp;<asp:Label ID="tbMaxSIRDate" runat="server" Text=""></asp:Label></td>
																				<td class="value">&nbsp;</td>
																				<td class="value">IR Date</td>
																				<td class="value">&nbsp;<asp:Label ID="tbIRDate" runat="server" Text=""></asp:Label></td>
																			</tr>
																			<tr>
																				<td class="value">&nbsp;</td>
																				<td class="value">Rate</td>
																				<td class="value">&nbsp;<asp:Label ID="tbCompRate" runat="server" Text=""></asp:Label></td>
																				<td class="value">&nbsp;</td>
																				<td class="value">Rate</td>
																				<td class="value">&nbsp;<asp:Label ID="tbMaxRate" runat="server" Text=""></asp:Label></td>
																				<!--<td colspan="3" class="value">&nbsp;</td>-->
																				<td class="value">&nbsp;</td>
																				<td class="value">IR Number</td>
																				<td class="value">&nbsp;<asp:Label ID="tbIRNumber" runat="server" Text=""></asp:Label></td>
																			</tr>
																			<tr>
																				<td colspan="7" class="value">&nbsp;</td>
																				<td class="value">IR Description</td>
																				<td class="value">&nbsp;<asp:Label ID="tbIRDescription" runat="server" Text=""></asp:Label></td>
																			</tr>
																		</table>

                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                        <tr>
                                            <td>
                                                <%--<asp:LinkButton runat="server" ID="btnEdit" Text="Edit" OnClick="btnEdit_Click"></asp:LinkButton>--%>
                                                <asp:LinkButton runat="server" ID="btnOK" Text="Ok" PostBackUrl="~/web/buyerscreens/index.aspx"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer">
                        <EBid:Footer runat="server" ID="Footer" />
                    </td>
                </tr>
            </form>
        </table>
    </div>
</body>
</html>
