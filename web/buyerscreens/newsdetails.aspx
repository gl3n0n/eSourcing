<%@ page language="C#" autoeventwireup="true" inherits="web_buyerscreens_newsdetails, App_Web_newsdetails.aspx.1829e19c" theme="default" %>

<%@ Register Src="../usercontrol/newsdetail.ascx" TagName="newsdetail" TagPrefix="uc2" %>

<%@ Register Src="../usercontrol/news_announcements_nav.ascx" TagName="news_announcements_nav" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="TopNavHome" Src="~/WEB/usercontrol/Buyer/TopNavHome.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_buyer.css" />
    <script type="text/javascript" src="../include/util.js"></script>
</head>
<body>
    <div>
        <div align="left">
            <form id="Form1" runat="server">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                    <tr height="137px">
                        <td valign="top">
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
                                        <EBid:TopNavHome runat="server" ID="TopNavHome" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background: black;">
                                        <EBid:TopNav2 runat="server" ID="TopNav2" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td class="content">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                                <tr>
                                    <td id="relatedInfo">
                                        <uc1:news_announcements_nav ID="News_announcements_nav1" runat="server" />
                                    </td>
                                    <td id="content">
                                        <uc2:newsdetail ID="Newsdetail1" runat="server" />
                                        
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
    </div>
</body>
</html>
