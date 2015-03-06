<%@ page language="C#" autoeventwireup="true" inherits="web_vendorscreens_AuctionDetails, App_Web_auctiondetails.aspx.8a7237e8" theme="default" %>

<%@ Register Src="../usercontrol/commentlist_auction.ascx" TagName="commentlist_auction" TagPrefix="uc5" %>

<%@ Register Src="../usercontrol/AuctionVendor/auctionattachments.ascx" TagName="auctionattachments"
    TagPrefix="uc4" %>

<%@ Register Src="../usercontrol/auctionvendor/auctionitems.ascx" TagName="auctionitems" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/vendor/Vendor_LeftNav_Notifications.ascx" TagName="Vendor_LeftNav_Notifications" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/auctionvendor/auctiondetail.ascx" TagName="auctiondetail" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Auction" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Auctions" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Auctions.ascx" %>
<%@ Register TagPrefix="EBid" TagName="CommentArea" Src="~/web/usercontrol/CommentArea.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style_v.css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../include/util.js"></script>

    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
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
                                    <EBid:Vendor_TopNav_Auction runat="server" ID="Vendor_TopNav_Auction" />
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
                                        Auctions</h2>                                    
                                    <div>
                                        <EBid:Vendor_LeftNav_Auctions runat="server" ID="Vendor_LeftNav_Bids" />
                                    </div>
                                    <br />
                                    <h2>
                                        Notifications</h2>
                                    <div>
                                        <uc2:Vendor_LeftNav_Notifications ID="Vendor_LeftNav_Notifications1" runat="server" />
                                    </div>
                                   <h2>
                                        Comments</h2> 
                                   <div> 
                                        <uc5:commentlist_auction ID="Commentlist_auction1" runat="server" /> 
                                   </div> 
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
                                                                Auction Event Details</h1>
                                                            <uc1:auctiondetail ID="Auctiondetail1" runat="server" />
                                                            <uc3:auctionitems ID="Auctionitems1" runat="server" />
                                                            <uc4:auctionattachments ID="Auctionattachments1" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnkBack" runat="server" CausesValidation="false" OnClick="lnkBack_Click">Back</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                    <br /><br />
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
