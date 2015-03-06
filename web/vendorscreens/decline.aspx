<%@ page language="C#" autoeventwireup="true" inherits="web_vendor_screens_Decline, App_Web_decline.aspx.8a7237e8" theme="default" %>

<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
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
                                        <ebid:globallinksnav runat="server" id="GlobalLinksNav" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <ebid:vendor_topnav_bids runat="server" id="Vendor_TopNav_Bids" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <ebid:topdate runat="server" id="TopDate" />
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
                                                <ebid:vendor_leftnav_bids runat="server" id="Vendor_LeftNav_Bids" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>                                               
                                                <p>
                                                    &nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table5">
                                        <tr>
                                            <td id="content0">
                                                <div align="left">
                                                    <h1>
                                                        <br />
                                                        You have successfully declined the Bid Invitation</h1>
                                                    <p>
                                                        You have chosen not to participate in&nbsp;
                                                        <asp:LinkButton ID="lnkBidItemName" runat="server" OnClick="lnkBidItemName_Click"></asp:LinkButton>.
                                                        An email has been sent notifying Globe of your action.</p>
                                                    <div>
                                                        &nbsp;<table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton runat="server" ID="btnOK" OnClick="btnOK_Click">OK</asp:LinkButton></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <p>
                                        &nbsp;
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer" height="50px">
                        <ebid:footer runat="server" id="Footer" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
