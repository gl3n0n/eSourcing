<%@ page language="C#" autoeventwireup="true" inherits="web_buyer_screens_supplierSelect2, App_Web_supplierselect2.aspx.1829e19c" theme="default" %>

<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavAuctions" Src="~/web/usercontrol/Buyer/TopNavAuctions.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav_Auctions" Src="~/web/usercontrol/Buyer/TopNav2_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_buyer.css" />

    <script language="javascript" type="text/javascript" src="../include/selectSupplierJSFunctions.js"></script>

</head>
<body onload="createListObjects(document.frmSelectSuppliers.lstSupplierA, document.frmSelectSuppliers.lstSupplierB);">
    <div>
        <div align="left">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <form runat="server" id="frmSelectSuppliers">
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
                                        <EBid:TopNavAuctions runat="server" ID="TopNavAuctions" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <EBid:TopNav_Auctions runat="server" ID="TopNav_Auctions" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td id="relatedInfo">
                                        <h2>
                                            Bids</h2>
                                        <div align="left">
                                            <EBid:LeftNav runat="server" ID="LeftNav" />
                                        </div>
                                        <div align="left">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table3">
                                                <tr>
                                                    <td>
                                                        <!-- #BeginEditable "commentArea" -->
                                                        &nbsp;<!-- #EndEditable --></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                        <p>
                                            &nbsp;</p>
                                    </td>
                                    <td id="content">
                                        <!-- #BeginEditable "contentArea" -->
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
                                            <tr>
                                                <td valign="top">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td id="content0">
                                                                <br />
                                                                <h1>
                                                                    Select Suppliers</h1>
                                                                <br />
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td>
                                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="pageDetails">
                                                                                <tr>
                                                                                    <th colspan="3">
                                                                                        Supplier Category :&nbsp;
                                                                                        <asp:Label runat="server" ID="lblSupplierCategory"></asp:Label></th>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="3">
                                                                                        &nbsp;</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="3">
                                                                                        <table width="100%">
                                                                                            <tr>
                                                                                                <td align="right">
                                                                                                    <asp:ListBox Style="height: 200; width: 200" runat="server" ID="lstSupplierA" onDblClick="addAttribute();"></asp:ListBox>
                                                                                                </td>
                                                                                                <td width="30" align="center">
                                                                                                    <input type="button" runat="server" id="btnSelectAll" value="&gt;&gt;" onclick="addAll();" style="width: 25px" /><br />
                                                                                                    <input type="button" runat="server" id="btnSelectOne" value="&gt;" onclick="addAttribute();" style="width: 25px" /><br />
                                                                                                    <input type="button" runat="server" id="btnDeselectOne" value="&lt;" onclick="delAttribute();" style="width: 25px" /><br />
                                                                                                    <input type="button" runat="server" id="btnDeselectAll" value="&lt;&lt;" onclick="delAll();" style="width: 25px" />
                                                                                                </td>
                                                                                                <td align="left">
                                                                                                    <asp:ListBox Style="height: 200; width: 200" runat="server" ID="lstSupplierB" onDblClick="delAttribute();"></asp:ListBox>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td align="center">
                                                                                        <a runat="server" id="btnClick" style="cursor: hand; font-size: 8pt; text-decoration: underline" onmouseover="UnderLine(this, 'over')" onmouseout="UnderLine(this, 'out')">Click here if you would like to include
                                                                                            a one time supplier.</a>
                                                                                        <br />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:LinkButton runat="server" ID="btnOk" OnClick="btnOk_Click">OK</asp:LinkButton></td>
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
                                        </table>
                                        &nbsp;<!-- #EndEditable -->
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
                    <input type="hidden" runat="server" id="hdnSuppliers" name="hdnSuppliers" />
                    <input type="hidden" runat="server" id="hdnAuctionRefNo" name="hdnAuctionRefNo" />
                    <input type="hidden" runat="server" id="hdnCategoryId" name="hdnCategoryId" />
                    <input type="hidden" runat="server" id="hdnOTS" name="hdnOTS" />
                    <input type="hidden" runat="server" id="hdnVendorsForACategoryId" name="hdnVendorsForACategoryId" />
                </form>
            </table>
        </div>
        &nbsp;</div>
</body>
<!-- #EndTemplate -->
</html>
