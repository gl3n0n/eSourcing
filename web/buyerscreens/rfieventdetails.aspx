<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rfieventdetails.aspx.cs" Inherits="web_buyerscreens_rfieventdetails" %>

<%@ Register Src="../usercontrol/rfi/rfidetails_suppliers.ascx" TagName="rfidetails_suppliers" TagPrefix="uc5" %>
<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc4" %>
<%@ Register Src="../usercontrol/rfi/rfidetails_wo_suppliers.ascx" TagName="rfidetails_wo_suppliers" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/rfi/rfidetails_attachments.ascx" TagName="rfidetails_attachments" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavRfi" Src="~/WEB/usercontrol/Buyer/TopNavRfi.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
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
        <form id="Form1" runat="server" defaultbutton="lnkBack">
            &nbsp;<table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
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
                                <EBid:TopNavRfi runat="server" ID="TopNavRfi" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <EBid:TopNav2 runat="server" ID="TopNav2" />
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
                                        <td id="Td1">
                                            <h2>
                                                RFI Events</h2>
                                            <div align="left">
                                                <EBid:LeftNav runat="server" ID="LeftNav" />
                                            </div>
                                            <h2>
                                                Comments</h2>
                                            <uc4:commentlist ID="Commentlist1" runat="server" />
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
                                                RFI Event Details</h1>
                                            <br />
                                            <div align="left">
                                                <p>
                                                    &nbsp;<uc3:rfidetails_wo_suppliers ID="Rfidetails_wo_suppliers1" runat="server" />
                                                <p>
                                                    &nbsp;<uc1:rfidetails_attachments ID="Rfidetails_attachments1" runat="server" />
                                                <p>
                                                    &nbsp;<uc5:rfidetails_suppliers ID="Rfidetails_suppliers1" runat="server" />
                                                <p style="text-align: center;">
                                                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                                </p>
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td style="height: 34px">
                                                            &nbsp;
                                                            <asp:HyperLink ID="lnkViewReport" runat="server" Width="160px" Visible="False">Comparison By RFI Event</asp:HyperLink>  
                                                            <asp:LinkButton ID="lnkBack" runat="server" OnClick="lnkBack_Click" Width="100px">Back</asp:LinkButton>
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
                </td>
            </tr>    
            </table>
        </form>
    </div>
</body>
</html>
