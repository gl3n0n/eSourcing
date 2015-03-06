<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rfieventdetails.aspx.cs" Inherits="web_vendorscreens_rfieventdetails" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc6" %>
<%@ Register Src="../usercontrol/rfi/rfidetails_w_rfitenderdetails.ascx" TagName="rfidetails_w_rfitenderdetails" TagPrefix="uc5" %>
<%@ Register Src="../usercontrol/rfi/rfidetails_attachments.ascx" TagName="rfidetails_attachments" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="CommentArea" Src="~/web/usercontrol/CommentArea.ascx" %>
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
    <link rel="stylesheet" type="text/css" href="../css/style_v.css" />
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
                                                    RFI Events</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <ebid:vendor_leftnav_bids runat="server" id="Vendor_LeftNav_Bids" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <br />
                                                <h2>
                                                    Comments</h2>
                                                <uc6:commentlist id="Commentlist1" runat="server" />
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
                                                    RFI Event Details</h1>
                                                <div align="left">
                                                    <p>
                                                        &nbsp;<uc5:rfidetails_w_rfitenderdetails id="Rfidetails_w_rfitenderdetails1" runat="server" />
                                                        <p>
                                                            &nbsp;<uc1:rfidetails_attachments id="Rfidetails_attachments1" runat="server" />
                                                    <p style="text-align: center;">
                                                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                                    </p>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                        <tr>
                                                            <td style="height: 34px">                                                                
                                                                <%--<asp:LinkButton runat="server" ID="btnRfi" Width="90px" OnClick="btnRfi_Click" OnClientClick="return confirm('Are you sure you want to confirm your participation to this RFI event?');">Create RFI</asp:LinkButton>--%>
                                                                <asp:LinkButton ID="lnkBack" runat="server" Width="90px" OnClick="lnkBack_Click">Back</asp:LinkButton>
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
                        <ebid:footer runat="server" id="Footer" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
