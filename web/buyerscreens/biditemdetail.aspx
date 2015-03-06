<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_biditemdetail, App_Web_biditemdetail.aspx.1829e19c" theme="default" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc5" %>

<%@ Register Src="../usercontrol/bids/buyer_bidtenderdetails.ascx" TagName="buyer_bidtenderdetails" TagPrefix="uc4" %>
<%@ Register Src="../usercontrol/bids/bidtenderdetails.ascx" TagName="bidtenderdetails" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/bids/biditemdetails.ascx" TagName="biditemdetails" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/commentlist_tender.ascx" TagName="commentlist_tender" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="CommentBox" Src="~/web/usercontrol/CommentBox.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
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

</head>
<body>
	<div align="left">
		<form runat="server" id="frm1">
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
									<EBid:TopNavBids ID="TopNavBids1" runat="server" />
								</td>
							</tr>
							<tr>
								<td>
									<EBid:TopNav2 ID="TopNav2" runat="server" />
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
										Bid Events</h2>
									<div align="left">
										<EBid:LeftNav ID="LeftNav" runat="server" />
									</div>									
									<h2>
                                        Comments</h2>                                                
                                    <div align="center">
                                        &nbsp;
                                        <uc5:commentlist ID="Commentlist1" runat="server" />
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
																Bid Item Details</h1>
															<p>
																<uc2:biditemdetails ID="Biditemdetails1" runat="server" />
															</p>															
															<div align="left">
																<table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
																	<tr>
																		<td>
																			<asp:LinkButton runat="server" ID="lnkBack" OnClick="lnkBack_Click">Back</asp:LinkButton>
																		</td>
																	</tr>
																</table>
															</div>
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
					<td id="footer" height="50px">
						<EBid:Footer runat="server" ID="Footer1" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
