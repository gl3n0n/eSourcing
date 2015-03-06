<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_AwardedAuctionItemDetails, App_Web_awardedauctionitemdetails.aspx.1829e19c" theme="default" %>

<%@ Register Src="../usercontrol/commentlist_tender.ascx" TagName="commentlist_tender" TagPrefix="uc5" %>

<%@ Register Src="../usercontrol/commentlist_auction.ascx" TagName="commentlist_auction" TagPrefix="uc4" %>

<%@ Register Src="../usercontrol/AuctionVendor/AuctionItemBidHistory.ascx" TagName="AuctionItemBidHistory"
    TagPrefix="uc3" %>

<%@ Register Src="../usercontrol/AuctionVendor/AwardedAuctionVendordetails.ascx"
    TagName="AwardedAuctionVendordetails" TagPrefix="uc2" %>

<%@ Register Src="../usercontrol/AuctionVendor/auctionitemdetail.ascx" TagName="auctionitemdetail"
    TagPrefix="uc1" %>

<%@ Register  TagPrefix="EBid" TagName="TopNavAuction" Src="~/WEB/usercontrol/Buyer/TopNavAuctions.ascx" %>
<%@ Register  TagPrefix="EBid" TagName="TopNav_Auctions" Src="~/web/usercontrol/Buyer/TopNav2_Auction.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNavAuctions1" Src="~/web/usercontrol/Buyer/LeftNavAuctions1.ascx"%>
<%@ Register TagPrefix="EBid" TagName="LeftNavNotifications" Src="~/web/usercontrol/Buyer/LeftNavNotifications.ascx"%>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx"%>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title id="PageTitle" runat="server"></title>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<link rel="stylesheet" type="text/css" href="../css/style_buyer.css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div>
<form id="Form1" runat="server">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">		
		<tr>
			<td valign="top" height="137px">
			    <table border="0" cellpadding="0" cellspacing="0" width="100%">
				    <tr>
					    <td>
					        <div align="left" id="masthead">
						        <EBid:GlobalLinksNav runat="server" id="GlobalLinksNav" />
					        </div>
					    </td>
				    </tr>
				    <tr>
					    <td>
					    <EBid:TopNavAuction runat="server" id="TopNavAuction1" /></td>
				    </tr>
				    <tr>
					    <td>
					    <EBid:TopNav_Auctions runat="server" id="TopNav_Auctions" />
					    </td>
				    </tr>				
			    </table>
			</td>			
		</tr>		
		<tr valign="top">
		    <td valign="top">
			    <table border="0" cellpadding="0" cellspacing="0" width="100%"  height="100%">
				    <tr>
				    <td id="relatedInfo" >
					    <h2>Auctions</h2>
					    <div align="left">
						    <EBid:LeftNavAuctions1 runat="server" id="LeftNavAuctions1" />
					    </div>
					    <h2>Notifications</h2>
					    <div align="left">
						    <EBid:LeftNavNotifications runat="server" id="LeftNavNotifications" /><br />
                            &nbsp;<uc4:commentlist_auction ID="Commentlist_auction1" runat="server" />
					    </div>					    
				    </td>
					    <td id="content">					
					        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
						        <tr>
							        <td valign="top">
							            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
								            <tr>
									            <td id="content0">
									                <h1>
									                    <br />Auction Item Details
									                </h1>
									                <div align="left">
									                    <uc1:auctionitemdetail ID="Auctionitemdetail1" runat="server" />
									                    <br />
                                                        <uc2:awardedauctionvendordetails id="AwardedAuctionVendordetails1" runat="server"></uc2:awardedauctionvendordetails>
									                    <br />    									    
                                                    </div>
                                                    <uc3:auctionitembidhistory id="AuctionItemBidHistory1" runat="server"></uc3:auctionitembidhistory>
                                                    <br />
									                <table border="0" cellpadding="0" cellspacing="0" width="100%"  id="actions">
										                <tr>
											                <td>
											                    <asp:LinkButton runat="server" ID="btnOK" OnClick="btnOK_Click" >Back</asp:LinkButton>
											                    <input type="hidden" runat="server" id="hdnAuctionRefNo" name="hdnAuctionRefNo" />
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
			    </table>
			</td>			
		</tr>
		<tr>
			<td id="footer"><EBid:Footer runat="server" ID="Footer1" /></td>
		</tr>		
	</table>
	</form>
</div>
</body>
</html>