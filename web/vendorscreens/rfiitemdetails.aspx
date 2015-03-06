<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rfiitemdetails.aspx.cs" Inherits="web_vendorscreens_rfiitemdetails" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/rfi/buyer_rfitenderdetails.ascx" TagName="buyer_rfitenderdetails"
    TagPrefix="uc2" %>
<%@ Register Src="~/web/usercontrol/rfi/rfiitemdetails.ascx" TagName="RfiItemDetails" TagPrefix="uc1" %>

<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>.:| Globe Telecom eSourcing System | RFI Item Details |:.</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style_v.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../include/util.js"></script>

    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div align="left">
        <form id="Form1" runat = "server">
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
                                    <EBid:Vendor_TopNav_Bids runat="server" ID="Vendor_TopNav_Bids" />
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
                                        RFI Events</h2>
                                    <div align="left">
                                        <EBid:Vendor_LeftNav_Bids runat="server" ID="LeftNav" />
                                    </div>
                                    <p>&nbsp;</p>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <h1>
                                                    <br />
                                                    RFI Item Details</h1>
                                                <br />
                                               		<uc1:RfiItemDetails ID="Rfiitemdetails1" runat="server" />											
                                                <p>
                                                    &nbsp;<uc2:buyer_rfitenderdetails ID="Buyer_rfitenderdetails1" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <div align="left">                                                    
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                            <tr>
                                                <td style="height: 34px">
                                                    <asp:LinkButton ID="lnkBack" runat="server" OnClick="lnkBack_Click">Back</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
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
