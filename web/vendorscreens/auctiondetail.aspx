<%@ page language="C#" autoeventwireup="true" inherits="web_vendorscreens_auctiondetail, App_Web_auctiondetail.aspx.8a7237e8" theme="default" %>

<%@ Register Src="../usercontrol/auctionvendor/auctiondetail.ascx" TagName="auctiondetail" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/auctionvendor/auctionitems.ascx" TagName="auctionitems" TagPrefix="uc3" %>

<%@ Register Src="../usercontrol/Vendor/Vendor_LeftNav_Notifications.ascx" TagName="Vendor_LeftNav_Notifications"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Auction" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Auctions" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Auctions.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_v.css">
    <script type="text/javascript" src="../include/util.js"></script>
</head>
<body onload="SetStatus();">
    <div>
        <form id="Form1" runat="server">
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
                                    <EBid:Vendor_TopNav_Auction runat="server" ID="Vendor_topNav_Auction" />
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
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>
                                        Auction Events</h2>
                                    <div align="left">
                                        <EBid:Vendor_LeftNav_Auctions runat="server" ID="Vendor_LeftNav_Auctions" />
                                    </div>
                                    <br />
                                    <h2>
                                        Notifications</h2>
                                    <div align="left">
                                        <uc1:Vendor_LeftNav_Notifications ID="Vendor_LeftNav_Notifications1" runat="server" />
                                    </div>
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <h1>
                                        <br />
                                        Auction Event Details</h1>
                                    <div align="left">
                                        <uc2:auctiondetail ID="Auctiondetail1" runat="server" />
                                        <uc3:auctionitems ID="Auctionitems1" runat="server" /><br />
                                    </div>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnkBack" runat="server" CausesValidation="false" OnClick="lnkBack_Click">Back</asp:LinkButton>
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
