<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_bidConfirmation, App_Web_bidconfirmation.aspx.9bdd8cc1" enableeventvalidation="true" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Bids" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="CommentBox" Src="~/web/usercontrol/CommentBox.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>.:| Globe Telecom eSourcing System |  |:.</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    <!--
	function CheckIfPosted(isPosted)
	{
		if(isPosted != 1)
			if(document.forms[0]['CommentBox:hdnIsPosted'].value == 1)
			   document.getElementById('hdnIsPosted').value = 1;
			else
				alert("Please enter a comment first!");
		else
			document.getElementById('hdnIsPosted').value = 1;
	}
	//-->
	</script>
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
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <h2>
                                                    Bids</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:CommentBox runat="server" ID="CommentBox" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page0">
                                        <tr>
                                            <td valign="top">
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td id="content0">
                                                            <h1>
                                                                <br />
                                                                <asp:Label runat="server" ID="lblTitle"></asp:Label></h1>
                                                            <p>
                                                                <asp:Label runat="server" ID="lblMessage"></asp:Label></p>
                                                            <div align="left">
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="itemDetails">
                                                                    <tr>
                                                                        <th>
                                                                            <asp:LinkButton runat="server" ID="lnkBidItem" OnClick="lnkBidItem_Click"></asp:LinkButton></th>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <br />
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton runat="server" ID="btnOK" OnClick="btnOK_Click">Confirm</asp:LinkButton>
                                                                        <asp:LinkButton runat="server" ID="btnCancel" OnClick="btnCancel_Click">Cancel</asp:LinkButton>
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
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer" height="50px">
                        <EBid:Footer runat="server" ID="Footer" />
                        <input type="hidden" id="hdnIsPosted" name="hdnIsPosted" runat="server" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
