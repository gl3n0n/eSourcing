<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewPR.aspx.cs" Inherits="web_buyerscreens_viewPR" %>

<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav2" Src="~/WEB/usercontrol/Buyer/TopNav2.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_buyer.css" />
</head>
<body>
    <div>
        <form id="form1" runat="server">
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
                                    <EBid:TopNavBids ID="TopNavBids" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNav2 ID="TopNav2" runat="server" />
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
                                    <h2 align="left">Bids</h2>
                                    <div align="left">
                                         <EBid:LeftNav ID="LeftNav" runat="server" />
                                    </div>
                                    <p>
                                        &nbsp</p>
                                </td>
                                <td id="content">
                                    <div align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table4">
                                        <tr>    
                                            <td>
                                                <h1>
                                                    <br />
                                                    View PR
                                                </h1>
                                                <p>
                                                    Click on the PR No. or the PR description to view the details of the PR.
                                                </p>
                                                <asp:GridView ID="gvPR" runat="server" SkinID="BidEvents" AllowPaging="True" AllowSorting="True"
                                                    AutoGenerateColumns="False" DataKeyNames="PrRefNo" DataSourceID ="dsSubmitted"
                                                    OnRowCommand="gvPR_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="PR Ref">
                                                            <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPrRefNo" runat="server" Text='<%#Bind("PrRefNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PR" InsertVisible="False" SortExpression="PRNo">
                                                            <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                                            <ItemTemplate>
                                                                &nbsp<asp:LinkButton ID="lnkPRNo" runat="server" Text='<%# Bind("PRNo") %>'
                                                                    CommandArgument='<%# Bind("PrRefNo") %>' CommandName="Details"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PR Description" SortExpression="PrDescription">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp<asp:LinkButton ID="lnkDesc" runat="server" Text='<%# Bind("PRDescription") %>' 
                                                                     CommandArgument='<%# Bind("PrRefNo") %>' CommandName="Details"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Item Code" SortExpression="ItemCode">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp<asp:LinkButton ID="lnkItemCode" runat="server" Text='<%# Bind("ItemCode") %>' 
                                                                     CommandArgument='<%# Bind("PrRefNo") %>' CommandName="Details"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PR Date" SortExpression="PRDate">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp<asp:LinkButton ID="lnkDate" runat="server" Text='<%# Bind("PRDate") %>' 
                                                                     CommandArgument='<%# Bind("PrRefNo") %>' CommandName="Details"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp<asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PR Group" SortExpression="GroupName">
                                                            <HeaderStyle HorizontalAlign="Center" Width="200px"/>
                                                            <ItemTemplate>
                                                                &nbsp<asp:Label ID="lblPRGroup" runat="server" Text='<%# Bind("GroupName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="">
                                                            <HeaderStyle HorizontalAlign="Center"/>
                                                            <ItemTemplate>
                                                                &nbsp<asp:LinkButton ID="lnkEditPRGroup" runat="server" Text="Edit Group" CommandArgument='<%# Bind("PrRefNo") %>' 
                                                                        CommandName="Details"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="dsSubmitted" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                        SelectCommand="sp_GetViewPR" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
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
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
