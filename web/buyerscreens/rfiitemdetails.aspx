<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rfiitemdetails.aspx.cs" Inherits="web_buyerscreens_rfiitemdetails" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc5" %>
<%@ Register Src="../usercontrol/rfi/rfiitemdetails.ascx" TagName="rfiitemdetails" TagPrefix="uc2" %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavRfi" Src="~/WEB/usercontrol/Buyer/TopNavRfi.ascx" %>
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
									<EBid:TopNavRfi ID="TopNavRfi" runat="server" />
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
										Bids</h2>
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
																RFI Item Details</h1>
															<p>
																<uc2:rfiitemdetails ID="rfiitemdetails1" runat="server" />
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
