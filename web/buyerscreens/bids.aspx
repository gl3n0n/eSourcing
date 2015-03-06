<%@ page language="C#" autoeventwireup="true" inherits="WEB_buyer_screens_bids, App_Web_bids.aspx.1829e19c" theme="default" %>

<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
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
                                    <EBid:TopNavBids ID="TopNavBids1" runat="server" />
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
                                    <h2>
                                        Bid Events</h2>
                                    <div align="left">
                                        <EBid:LeftNav ID="LeftNav" runat="server" />
                                    </div>
                                    <p>
                                        &nbsp;</p>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <h1>
                                                    <br />
                                                    Bid Event Drafts</h1>
                                                <p>
                                                    These are your drafted bid events. Click <b>"Delete"</b> to delete a drafted bid event. 
                                                    Click on the bid event reference number or the bid event description to re-edit or submit that bid event.
                                                </p>
                                                <asp:GridView ID="gvBids" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                                    SkinID="BidEvents" DataKeyNames="BidRefNo" DataSourceID="dsDrafts" OnRowCommand="gvBids_RowCommand" OnRowDataBound="gvBids_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Reference No." InsertVisible="False" SortExpression="BidRefNo">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle Width="90px" />
                                                            <ItemTemplate>
                                                                &nbsp;<asp:LinkButton ID="lnkRefNo" runat="server" Text='<%# Bind("BidRefNo") %>' CommandArgument='<%# Bind("BidRefNo") %>' CommandName="Details"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Bid Event" SortExpression="ItemDesc">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp;<asp:LinkButton ID="lnkDesc" runat="server" Text='<%# Bind("ItemDesc") %>' CommandArgument='<%# Bind("BidRefNo") %>' CommandName="Details"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Date Created" SortExpression="DateCreated">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                            <ItemTemplate>
                                                                &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("DateCreated", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:CommandField ShowDeleteButton="True">                                                            
                                                            <ItemStyle Width="80px" HorizontalAlign="Center" />
                                                        </asp:CommandField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="dsDrafts" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                    DeleteCommand="sp_DeleteBuyerBidEventDraft" DeleteCommandType="StoredProcedure"
                                                    SelectCommand="sp_GetBuyerBidEventDrafts" SelectCommandType="StoredProcedure">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="BidRefNo" Type="Int32" />
                                                    </DeleteParameters>
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
                                                <br />
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
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
