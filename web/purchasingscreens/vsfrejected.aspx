<%@ page language="C#" autoeventwireup="true" inherits="web_purchasing_screens_vsfrejected, App_Web_vsfrejected.aspx.9bdd8cc1" theme="default" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/WEB/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_TopNav_Suppliers" Src="~/web/usercontrol/Purchasing/Purchasing_TopNav_Suppliers.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Purchasing_LeftNav" Src="~/web/usercontrol/Purchasing/Purchasing_LeftNav_Suppliers.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>    
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style_ph.css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div>
        <form runat="server">
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
                                    <EBid:Purchasing_TopNav_Suppliers runat="server" ID="Purchasing_TopNav_Suppliers" />
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
                <tr valign="top">
                    <td valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>
                                        Vendor Shortlisting Form</h2>
                                    <div align="left">
                                        <EBid:Purchasing_LeftNav runat="server" ID="Purchasing_LeftNav" />
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
                                                        Rejected Vendor Shortlisting Form
                                                    </h1>
                                                    <p>
                                                        These are your Vendor Shortlisting Form 
                                                        endorsements. Click on the Vendor Shortlisting Form reference number or the Vendor Shortlisting Form project name to view the details.<br />
                                                        <!--<asp:CheckBox ID="chkShowEventsBeforeDeadline" runat="server" Text="Show only bid events before bid submission deadline" AutoPostBack="True" OnCheckedChanged="chkShowEventsBeforeDeadline_CheckedChanged" />-->
                                                    </p>
                                                    <asp:GridView ID="gvBids" runat="server" SkinID="BidEvents" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowCommand="gvBids_RowCommand" DataKeyNames="VSFId" DataSourceID="dsAproved">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Reference No." InsertVisible="False" SortExpression="VSFId">
                                                                <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkRefNo" runat="server" Text='<%# Bind("VSFId") %>' CommandArgument='<%# Bind("VSFId") %>' CommandName="Details"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="PR No" SortExpression="PRNo">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkPRNo" runat="server" Text='<%# Bind("PRNo") %>' CommandArgument='<%# Bind("VSFId") %>' CommandName="Details"></asp:LinkButton><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Project Name" SortExpression="ProjectName">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkProjName" runat="server" Text='<%# Bind("ProjectName") %>' CommandArgument='<%# Bind("VSFId") %>' CommandName="Details"></asp:LinkButton><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="PR Description" SortExpression="PRDescription">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkDesc" runat="server" Text='<%# Bind("PRDescription") %>' CommandArgument='<%# Bind("VSFId") %>' CommandName="Details"></asp:LinkButton><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Date" SortExpression="VSFDate">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:Label ID="lnkDate" runat="server" Text='<%# Bind("VSFDate", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="dsAproved" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" 
                                                        SelectCommand="SELECT VSFId, VSFDate, PRNo, ProjectName, PRDescription, PreparedDt FROM tblVendorShortlistingForm WHERE PurchasingId=@PurchasingId AND Status=@Status ORDER BY VSFDate DESC" 
                                                        SelectCommandType="Text">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="PurchasingId" SessionField="UserId" Type="Int32" />
                                                            <asp:Parameter Name="Status" DefaultValue="4" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                    <br />
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                        <tr>
                                                            <td>
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <p>
                                                        &nbsp;</p>
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
                        <EBid:Footer runat="server" ID="Footer" />
                        <input type="hidden" id="hdnUserId" name="hdnUserId" runat="server" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
