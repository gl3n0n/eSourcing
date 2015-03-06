<%@ Page Language="c#" EnableEventValidation="true" Inherits="EBid.WEB.bac.index"
    CodeFile="index.aspx.cs" %>

<%@ Register Src="../usercontrol/announcementdetail.ascx" TagName="announcementdetail" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/news_announcements_nav.ascx" TagName="news_announcements_nav" TagPrefix="uc3" %>

<%//@ Register Src="../usercontrol/boc/BOC_TopNav_Home.ascx" TagName="BOC_TopNav_Home" TagPrefix="uc1" %>
<%@ Register Src="../usercontrol/bac/BAC_LeftNav_Bids.ascx" TagName="BAC_LeftNav_Bids" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/bac/BAC_TopNav_Home.ascx" TagName="BAC_TopNav_Home" TagPrefix="uc1" %>  
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="C#" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link href="../css/style_ph.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
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
                                    <h2>
                                        Bid Events</h2>
                                    <uc3:news_announcements_nav ID="News_announcements_nav1" runat="server" />                     
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <br />
                                        <h1>                                            
                                            <asp:Label ID="lblName" runat="server" />
                                            </h1>
                                        <p>
                                            Listed below are the items that need your attention.</p>
                                        <h3>Bid Awarding Checklist</h3>
                                        <p style="padding-left:15px">
                                            <a href="bacapprovedpurchasing.aspx">Endorsed BAC
                                               <asp:Label runat="server" ID="lblBacEndorsed" Text="(0)"></asp:Label>
                                            </a>
                                            <br />
                                            <a href="bacawarded.aspx">Awarded BAC
                                               <asp:Label runat="server" ID="lblBacAwarded" Text="(0)"></asp:Label>
                                            </a>
                                            <br />
                                            <a href="bacforclarifications.aspx">BAC for Clarifications
                                               <asp:Label runat="server" ID="lblBacClarifications" Text="(0)"></asp:Label>
                                            </a>
                                            <br />
                                            <a href="bacrejected.aspx">Rejected BAC
                                               <asp:Label runat="server" ID="lblBacRejected" Text="(0)"></asp:Label>
                                            </a>
                                            <br />
                                            <a href="bacforawarding.aspx">Ongoing BAC
                                               <asp:Label runat="server" ID="lblBacForAwarding" Text="(0)"></asp:Label>
                                            </a>
					 </p>

                                         <br />                                                        
                                         <h3>
                                             Others</h3>
                                         <p style="padding-left:15px">
                                         <a href="../bac/changepwd.aspx">Change Password                                                        
                                         </a>                                                        
                                         </p>
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
