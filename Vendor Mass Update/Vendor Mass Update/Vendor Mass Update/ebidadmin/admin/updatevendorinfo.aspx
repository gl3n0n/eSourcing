<%@ Page Language="C#" AutoEventWireup="true" CodeFile="updatevendorinfo.aspx.cs" Inherits="admin_updatevendorinfo" %>

<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="AdminTopNav" Src="~/usercontrol/admin/adminTopNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Admin_TopNav_User" Src="~/usercontrol/admin/Admin_TopNav_User.ascx" %>
<%@ Register TagPrefix="EBid" TagName="AdminLeftNavUser" Src="~/usercontrol/admin/AdminLeftNavUser.ascx" %>
<%@ Register TagPrefix="EBid" TagName="AdminLeftNav" Src="~/usercontrol/admin/AdminLeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>.:| Globe Telecom | Update Vendor Information |:.</title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <script type="text/javascript" src="../include/util.js"></script>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/style_ua.css" />     
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body onload="SetStatus();">
    <div align="left">
        <form id="Form1" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr>
                    <td valign="top" height="137px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <div align="left" id="masthead">
                                        <EBid:AdminTopNav runat="server" ID="GlobalLinksNav" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:Admin_TopNav_User runat="server" ID="Admin_TopNav_User" />
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
                                        User Functions</h2>
                                    <EBid:AdminLeftNavUser runat="server" ID="AdminLeftNavUser" />
                                    <p>
                                        &nbsp;</p>
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
                                                                Update Vendor Information</h1>
                                                        </td>
                                                    </tr>
                                                    <tr align="right">
                                                        <td valign="top" height="30px">                                                            
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblUpdateMsg" runat="server" ForeColor="Red" Visible="False" Font-Names="Arial" Font-Size="11px"></asp:Label>
                                                        </td>
                                                    </tr>                                                   
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                                        
                                                                        <asp:LinkButton ID="Button1" runat="server" OnClick="UploadCSV"  CausesValidation="False"  Width="100px">Upload CSV File</asp:LinkButton><br /><asp:Label ID="Label1" runat="server" Font-Size="12px"></asp:Label>
                                                                        <br />
                                                        
                                                                    </td>
                                                    
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr><td style="height: 20px;"> </td></tr>
                                                    <tr>
                                                        <td>
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                                <tr>
                                                                    <td>
                                                                        &nbsp;
                                                                        <asp:LinkButton ID="lnkDownloadCSVfromDB" runat="server" CausesValidation="False"  Width="150px">Download Vendor Info</asp:LinkButton>
                                                                        <asp:LinkButton ID="lnkUpdateDB" runat="server" Width="150px" CausesValidation="False" OnClientClick="return confirm('Are you sure you want to update entire Users from CSV file?');">Update from CSV</asp:LinkButton>&nbsp;
                                                                        <a href="UpdateVendorInfo.aspx">Cancel</a>
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
                                <td>
                                </td>
                                <td>
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
