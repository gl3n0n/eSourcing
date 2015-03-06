<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_report_eventtenderscomparison, App_Web_report_eventtenderscomparison.aspx.1829e19c" theme="default" %>

<%@ Register Src="../usercontrol/reports/eventtenderscomparison.ascx" TagName="eventtenderscomparison" TagPrefix="uc2" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
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
                                        <EBid:GlobalLinksNav runat="server" ID="GlobalLinksNav" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNavBids runat="server" ID="TopNavBids" />
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
                <tr valign="top">
                    <td valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>
                                        Bid Events</h2>
                                    <div align="left">
                                        <EBid:LeftNav ID="LeftNav" runat="server" />
                                    </div>
                                    <br />
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table4">
                                            <tr>
                                                <td>
                                                    <h1>
                                                        <br />
                                                        Bid Event Tenders Comparision
                                                        
                                                    </h1>
                                                   <uc2:eventtenderscomparison ID="Eventtenderscomparison1" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer" height="50px">
                        <EBid:Footer runat="server" ID="Footer1" />
                        <input type="hidden" id="hdnUserId" name="hdnUserId" runat="server" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
