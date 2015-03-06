<%@ page language="C#" autoeventwireup="true" inherits="web_purchasingscreens_report_savingsbybidevent, App_Web_report_savingsbybidevent.aspx.9bdd8cc1" theme="default" %>

<%@ Register Src="../usercontrol/reports/savingsbybiditem.ascx" TagName="savingsbybiditem" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/purchasing/Purchasing_LeftNav_Reports.ascx" TagName="Purchasing_LeftNav_Reports" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Reports" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Reports.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />
    <script type="text/javascript" src="../include/util.js"></script>
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
                                    <EBid:Purchasing_TopNav_Reports runat="server" ID="Purchasing_TopNav_Reports" />
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
                    <td class="content">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%">
                            <tr>
                                <td id="relatedInfo">
                                    <uc1:Purchasing_LeftNav_Reports ID="Purchasing_LeftNav_Reports1" runat="server" />
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <br />
                                        <h1>
                                            Savings By Bid Event</h1>
                                        <div>
                                            <br />                                            
                                            <uc2:savingsbybiditem ID="Savingsbybiditem1" runat="server" />
                                        </div>
                                    </div>
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
