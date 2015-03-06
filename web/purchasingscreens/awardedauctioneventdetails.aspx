<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_AwardedAuctionEventDetails, App_Web_awardedauctioneventdetails.aspx.9bdd8cc1" theme="default" %>

<%@ Register Src="../usercontrol/AuctionVendor/auctiondetail.ascx" TagName="auctiondetail" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/AuctionVendor/auctionitems.ascx" TagName="auctionitems" TagPrefix="uc3" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Auct" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Auct.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Auct.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav_Not" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Auct_Not.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>    
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../include/awardedbiditems.js"></script>
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
                                    <EBid:Purchasing_TopNav_Auct runat="server" ID="Purchasing_TopNav_Auct" />
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
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                                <br />
                                                <h2>
                                                    Notifications</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Purchasing_LeftNav_Not runat="server" ID="Purchasing_LeftNav1" />
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
					                    <tr>
						                    <td valign=top>
						                    <table border="0" cellpadding="0" cellspacing="0" width="100%" >
							                    <tr>
								                    <td id="content0">
								                        <h1><br />Auction Event Details</h1>										
								                        <div align="left">
                                                            <uc2:auctiondetail ID="Auctiondetail1" runat="server" />									            
                                                            <uc3:auctionitems ID="Auctionitems1" runat="server" />
                                                        </div>
                                                        <br />
								                        <table border="0" cellpadding="0" cellspacing="0" width="100%"  id="actions">
									                        <tr>
										                        <td><asp:LinkButton runat="server" ID="btnOK" OnClick="btnOK_Click" >Back</asp:LinkButton></td>
									                        </tr>
								                        </table>									        
								                    </td>
							                    </tr>
						                    </table></td>
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
