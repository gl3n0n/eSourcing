<%@ page language="C#" autoeventwireup="true" inherits="web_purchasingscreens_withdrawnbiditemdetails, App_Web_withdrawnbiditemdetails.aspx.9bdd8cc1" theme="default" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc4" %>

<%@ Register Src="../usercontrol/bids/biditemdetails_wo_tenders.ascx" TagName="biditemdetails_wo_tenders"
    TagPrefix="uc2" %>

<%@ Register Src="../usercontrol/bids/buyer_bidtenderdetails.ascx" TagName="buyer_bidtenderdetails"
    TagPrefix="uc3" %>

<%@ Register Src="../usercontrol/bids/biddetails_items.ascx" TagName="biddetails_items"
    TagPrefix="uc1" %>

<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Bids" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>.:| Globe Telecom eSourcing System | Withdrawn Bid Item Details |:.</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/style_ph.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
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
                                    <EBid:Purchasing_TopNav_Bids runat="server" ID="Purchasing_TopNav_Bids" />
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
                                    <h2>
                                        Bid Events</h2>
                                    <div align="left">
                                    <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                    </div>
                                    <h2>
                                        Comments</h2>                                                
                                    <div align="center">
                                        <uc4:commentlist ID="Commentlist1" runat="server" />
                                    </div>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
                                        <tr>
                                            <td valign="top">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td id="content0">
                                                            <br />
                                                            <h1>Bid Item Details</h1>                                                            
                                                            <uc2:biditemdetails_wo_tenders ID="Biditemdetails_wo_tenders1" runat="server" />
                                                            <br />                                                            
                                                         </td>
                                                    </tr>
                                                                                                        
                                                </table>
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td>
                                                            <asp:LinkButton runat="server" ID="lnkCancel" Text="Back" OnClick="lnkCancel_Click"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                 </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer" style="height: 38px">
                        <EBid:Footer runat="server" ID="Footer1" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
