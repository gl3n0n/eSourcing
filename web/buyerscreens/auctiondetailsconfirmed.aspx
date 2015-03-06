<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_AuctionDetailsConfirmed, App_Web_auctiondetailsconfirmed.aspx.1829e19c" maintainscrollpositiononpostback="true" theme="default" %>

<%@ Register Src="../usercontrol/auctionvendor/auctiondetail.ascx" TagName="auctiondetail" TagPrefix="uc1" %>
<%@ Register Src="../usercontrol/auctionvendor/auctionitems.ascx" TagName="auctionitems" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/auctionvendor/auctionattachments.ascx" TagName="auctionattachments" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/auctionvendor/auctionparticipants.ascx" TagName="auctionparticipants" TagPrefix="uc4" %>
<%@ Register TagPrefix="EBid" TagName="TopNavAuction" Src="~/WEB/usercontrol/Buyer/TopNavAuctions.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav_Auctions" Src="~/web/usercontrol/Buyer/TopNav2_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavAuctions1" Src="~/web/usercontrol/Buyer/LeftNavAuctions1.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavNotifications" Src="~/web/usercontrol/Buyer/LeftNavNotifications.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Comments" Src="~/web/usercontrol/CommentBox.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_buyer.css" />
</head>
<body>
    <div align="left">
        <form runat="server" id="frmAuctionDetails">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
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
                                    <EBid:TopNavAuction runat="server" ID="TopNavAuction" />
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
                                        Auctions</h2>
                                    <div align="left">
                                        <EBid:LeftNavAuctions1 runat="server" ID="LeftNavAuctions1" />
                                    </div>
                                    <h2>
                                        Notifications</h2>
                                    <div align="left">
                                        <EBid:LeftNavNotifications runat="server" ID="LeftNavNotifications" />
                                    </div>
                                    <EBid:Comments runat="server" ID="Comments" />
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table6">
                                        <tr>
                                            <td id="content0">
                                                <br />
                                                <h1>
                                                    Auction Event Details</h1>
                                                <div>
                                                    <uc1:auctiondetail ID="Auctiondetail1" runat="server" />
                                                </div>
                                                <div>
                                                    <uc2:auctionitems ID="Auctionitems1" runat="server" />
                                                </div>
                                                <div>
                                                    <uc3:auctionattachments ID="Auctionattachments1" runat="server" />
                                                </div>
                                                <div>
                                                    <uc4:auctionparticipants ID="Auctionparticipants1" runat="server" />
                                                </div>
                                                <br />
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td>
                                                            &nbsp;<asp:LinkButton ID="lnkBack" runat="server" Width="100px" CausesValidation="false" OnClick="lnkBack_Click">Back</asp:LinkButton>
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
                    <td id="footer">
                        <EBid:Footer runat="server" ID="Footer" />                        
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
