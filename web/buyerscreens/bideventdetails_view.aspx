<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bideventdetails_view.aspx.cs" Inherits="web_buyerscreens_bideventdetails_view" %>

<%@ Register Src="../usercontrol/bids/biddetails_suppliers_buyer.ascx" TagName="biddetails_suppliers" TagPrefix="uc5" %><%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc4" %><%@ Register Src="../usercontrol/bids/biddetails_wo_suppliers.ascx" TagName="biddetails_wo_suppliers" TagPrefix="uc3" %><%@ Register Src="../usercontrol/bids/biddetails_buyer.ascx" TagName="biddetails" TagPrefix="uc2" %><%@ Register Src="../usercontrol/bids/biddetails_attachments_buyer.ascx" TagName="biddetails_attachments" TagPrefix="uc1" %><%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %><%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %><%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %><%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Login_TopNav.ascx" %><%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %><%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %><html xmlns="http://www.w3.org/1999/xhtml"><head><title id="PageTitle" runat="server"></title><meta http-equiv="Content-Language" content="en-us" /><meta http-equiv="Content-Type" content="text/html; charset=windows-1252" /><link rel="stylesheet" type="text/css" href="../css/style.css" /><link rel="stylesheet" type="text/css" href="../css/style_buyer.css" /><link href="../css/style.css" rel="stylesheet" type="text/css" /><link href="../css/style.css" rel="stylesheet" type="text/css" /><link href="../css/style.css" rel="stylesheet" type="text/css" /><link href="../css/style.css" rel="stylesheet" type="text/css" /></head><body><div align="left">
        <form id="Form1" runat="server" defaultbutton="lnkBack">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <table border="0" cellpadding="0" cellspacing="0" width="200">
                                        <tr>
                                            <td id="Td1">
                                                <div align="left">
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
                                                    Bid Event Details</h1>
                                                <br />
                                                <div align="left">
                                                    <p>
                                                        &nbsp;<uc3:biddetails_wo_suppliers ID="Biddetails_wo_suppliers1" runat="server" />
                                                    <p>
                                                        &nbsp;<uc1:biddetails_attachments ID="Biddetails_attachments1" runat="server" />
                                                    <p>
                                                        &nbsp;<uc5:biddetails_suppliers ID="Biddetails_suppliers1" runat="server" />
                                                    <p style="text-align: center;">
                                                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                                    </p>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                        <tr>
                                                            <td style="height: 34px">
                                                                &nbsp;
                                                                <asp:HyperLink ID="lnkViewReport" runat="server" Width="160px">Comparison By Bid Event</asp:HyperLink> 
                                                                <asp:LinkButton ID="lnkBack" runat="server" OnClick="lnkBack_Click" Width="100px" Visible="false">Back</asp:LinkButton>                                                         
                                                            <asp:LinkButton runat="server" ID="btnClose" OnClientClick="window.close()">Close</asp:LinkButton>                       
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
            </table>
        </form>
    </div>
</body>
</html>
