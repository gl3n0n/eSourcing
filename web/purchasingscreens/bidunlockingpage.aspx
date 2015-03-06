<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_BidUnlockingPage, App_Web_bidunlockingpage.aspx.9bdd8cc1" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Bids" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Bids.ascx" %>
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
    function UnlockBtnClick()
    {
        // process only the Enter key
        if (event.keyCode == 13)
        {
             // cancel the default submit
            event.returnValue=false;
            event.cancel = true;
            
            // submit the form by programmatically clicking the specified button
            Unlock_Btn.click();
        }
    }
    function PasswordCheck()
    {
        var enteredPassword = document.getElementById("txtPassword").value;
        alert(enteredPassword);
        var usrPassword = document.getElementById("hdnPassword").value;
        alert(usrPassword);
        
       
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
                                    <h2>
                                        Bids</h2>
                                    <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <h1>
                                        <br />
                                        Bid Unlocking</h1>
                                    <p>
                                        <asp:GridView runat="server" ID="GridView1" AllowPaging="False" AutoGenerateColumns="false"
                                            CssClass="itemDetails">
                                            <HeaderStyle CssClass="itemDetails_th" />
                                            <RowStyle CssClass="itemDetails_td" />
                                            <Columns>
                                                <asp:BoundField DataField="ItemDesc" ItemStyle-BackColor="#FFFFFF" HeaderText="Bid Item" />
                                                <asp:BoundField DataField="VendorName" ItemStyle-BackColor="#FFFFFF" HeaderText="Vendor Name"
                                                    ItemStyle-Width="150px" />
                                                <asp:TemplateField HeaderText="PurchDept" ItemStyle-BackColor="#FFFFFF" ItemStyle-Width="80px"
                                                    ItemStyle-HorizontalAlign="center">
                                                    <ItemTemplate>
                                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# (Eval("PurchDept").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg"%>'>
                                                        </asp:Image>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Internal Audit" ItemStyle-BackColor="#FFFFFF" ItemStyle-Width="80px"
                                                    ItemStyle-HorizontalAlign="center">
                                                    <ItemTemplate>
                                                        <asp:Image ID="Image2" runat="server" ImageUrl='<%# (Eval("IntAuditDept").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg"%>'>
                                                        </asp:Image>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Financing" ItemStyle-BackColor="#FFFFFF" ItemStyle-Width="80px"
                                                    ItemStyle-HorizontalAlign="center">
                                                    <ItemTemplate>
                                                        <asp:Image ID="Image3" runat="server" ImageUrl='<%# (Eval("FinanceDept").ToString() != "1") ? "../../web/images/stop.jpg" : "../../web/images/go.jpg" %>'>
                                                        </asp:Image>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </p>
                                    <asp:GridView runat="server" ID="Gv1" AutoGenerateColumns="false" CssClass="itemDetails">
                                        <HeaderStyle CssClass="itemDetails_th" />
                                        <RowStyle CssClass="itemDetails_td" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Department">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Bind("DeptName") %>' ID="lblDept"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Username">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Bind("FullName")%>' ID="lblFullName"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Authentication Information" ItemStyle-BackColor="#FFFFFF">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtPassword" runat="server" TabIndex="2" TextMode="Password" Width="155px"
                                                        onkeypress="UnlockBtnClick()"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Bind("DeptID")%>' ID="lblDeptID"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <br />
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                        <tr>
                                            <td>
                                                <asp:LinkButton runat="server" ID="Back_Btn" Text="Back" OnClick="Back_Btn_Click"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="Unlock_Btn" Text="Unlock" OnClick="Unlock_Btn_Click"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="txtNote" ForeColor="#FF0000" Style="font-weight: bold"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <p>
                                        &nbsp;
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
