<%@ Page Language="c#" EnableEventValidation="true" Inherits="EBid.WEB.bac.changepwd"
    CodeFile="changepwd.aspx.cs" %>

<%@ Register Src="../usercontrol/UCchangepassword.ascx" TagName="UCchangepassword"
    TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/news_announcements_nav.ascx" TagName="news_announcements_nav"
    TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/bac/BAC_TopNav_Home.ascx" TagName="BAC_TopNav_Home"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>.:| Globe Telecom eSourcing System | Home |:.</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="C#" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style_ph.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div align="left">
        <form id="Form1" method="post" runat="server">
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
                                    <uc1:BAC_TopNav_Home ID="BAC_TopNav_Home1" runat="server" />
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
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%;">
                            <tr>
                                <td id="relatedInfo">
                                    <uc3:news_announcements_nav ID="News_announcements_nav1" runat="server" />
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <h1>
                                            <br />
                                            <asp:Label ID="lblName" runat="server">Change Password</asp:Label>&nbsp;</h1>
                                        <p>
                                            <uc2:UCchangepassword ID="UCchangepassword1" runat="server" />
                                            &nbsp;</p>
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
