<%@ page language="c#" inherits="EBid.web.vendor_screens.AwardedBidDetails, App_Web_awardedbiddetails.aspx.8a7237e8" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Comments" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Comments.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>.:| Globe Telecom eSourcing System |  |:.</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_v.css">
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
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <h2>
                                                    Bids</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Vendor_LeftNav_Bids runat="server" ID="Vendor_LeftNav_Bids" />
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table4">
                                        <tr>
                                            <td id="content0">
                                                <h1>
                                                    <br />
                                                    Awarded Bid Tender Summary</h1>
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="itemDetails" height="85">
                                                    <tr>
                                                        <th colspan="2">
                                                            Details</th>
                                                    </tr>
                                                    <tr>
                                                        <td width="133">
                                                            PR Number:</td>
                                                        <td class="value">
                                                            <asp:Label runat="server" ID="lblPRNumber"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="133">
                                                            Bid reference Number:</td>
                                                        <td class="value">
                                                            <asp:Label runat="server" ID="lblBidReferenceNumber"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="133">
                                                            Category:</td>
                                                        <td class="value">
                                                            <asp:Label runat="server" ID="lblCategory"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="133">
                                                            Bid Submission Deadline:</td>
                                                        <td class="value">
                                                            <asp:Label runat="server" ID="lblBidSubmissionDeadline"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="133">
                                                            Delivery Date:
                                                        </td>
                                                        <td class="value">
                                                            <asp:Label runat="server" ID="lblDeliveryDate"></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="133">
                                                            Bid item description:
                                                        </td>
                                                        <td class="value">
                                                            <asp:Label runat="server" ID="lblBidItemDescription"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:GridView runat="server" ID="gvBids" AutoGenerateColumns="false" Width="100%"
                                                    CssClass="itemDetails">
                                                    <Columns>
                                                    </Columns>
                                                </asp:GridView>
                                                <br />
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td>
                                                            <asp:LinkButton runat="server" ID="btnOk" OnClick="btnOk_Click">Back</asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                 <p>
                                                &nbsp;
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
