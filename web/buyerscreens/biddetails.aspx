<%@ page language="c#" inherits="EBid.web.boc.biddetails, App_Web_biddetails.aspx.1829e19c" maintainscrollpositiononpostback="true" theme="default" %>

<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register Src="../usercontrol/bids/biddetails_wo_suppliers.ascx" TagName="biddetails_wo_suppliers" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/bids/biddetails_suppliers.ascx" TagName="biddetails_suppliers" TagPrefix="uc6" %>
<%@ Register Src="../usercontrol/bids/biddetails_attachments.ascx" TagName="biddetails_attachments" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style_buyer.css" rel="stylesheet" type="text/css" />
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
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%">
                            <tr>
                                <td id="relatedInfo">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <h2>
                                                    Bids</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
										<EBid:LeftNav ID="LeftNav" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content" style="width: 100%">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table5">
                                        <tr>
                                            <td id="content0">
                                                <h1>
                                                    <br />
                                                    Bid Event Details</h1>
                                                <br />
                                                <uc3:biddetails_wo_suppliers ID="Biddetails_wo_suppliers1" runat="server" />
                                                <br />
                                                <div align="left">
                                                    <p>
                                                        <uc6:biddetails_suppliers ID="Biddetails_suppliers1" runat="server" />
                                                    </p>
                                                    <p>
                                                        <uc1:biddetails_attachments ID="Biddetails_attachments1" runat="server" />
                                                    </p>
                                                </div>
                                                <div align="left">
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink ID="lnkComparison" runat="server">Comparison</asp:HyperLink>
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
                <tr>
                    <td id="footer" height="50px">
                        <EBid:Footer runat="server" ID="Footer1" />
                        <input type="hidden" runat="server" id="hdnFileAttachments" />
                        <input type="hidden" runat="server" id="hdnActualFileNames" />
                        <input type="hidden" runat="server" id="hdnBidRefNo" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
