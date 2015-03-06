<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bacrejected.aspx.cs" Inherits="web_buyer_screens_RejectedBidItems" %>

<%@ Register Src="../usercontrol/commentlist.ascx" TagName="commentlist" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav3" Src="~/WEB/usercontrol/Buyer/TopNav3.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
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
                                    <EBid:TopNavBids runat="server" ID="TopNavBids" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNav3 runat="server" ID="TopNav3" />
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
                                        Bid Events</h2>
                                    <div align="left">
                                        <EBid:LeftNav ID="LeftNav" runat="server" />
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
                                                        Rejected BAC
                                                    </h1>
                                                    <p>
                                                        These are your awarded BAC. Click on the bid event reference number or the bid event description to view the details of bac.<br />
                                                        <!--<asp:CheckBox ID="chkShowEventsBeforeDeadline" runat="server" Text="Show only bid events before bid submission deadline" AutoPostBack="True" OnCheckedChanged="chkShowEventsBeforeDeadline_CheckedChanged" />OnRowCommand="gvBids_RowCommand" -->
                                                    </p>
                                                    <asp:GridView ID="gvBids" runat="server" SkinID="BidEvents" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowCommand="gvBids_RowCommand" DataKeyNames="BidRefNo" DataSourceID="dsAproved">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Reference No." InsertVisible="False" SortExpression="BacRefNo">
                                                                <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkRefNo" runat="server" Text='<%# Convert.ToInt32(Eval("BidRefNo"))>0 ? Eval("BidRefNo")+" (Bid)" : Eval("BidRefNo").ToString().Replace("-","")+" (Auc)" %>' CommandArgument='<%# Bind("BACBID") %>' CommandName="Details"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Bid Event" SortExpression="ItemDesc">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:LinkButton ID="lnkDesc" runat="server" Text='<%# Bind("ItemDesc") %>' CommandArgument='<%# Bind("BACBID") %>' CommandName="Details"></asp:LinkButton><br />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Date Submitted" SortExpression="DateSubmitted">
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="180px" />
                                                                <ItemTemplate>
                                                                    &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("DateSubmitted", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="dsAproved" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" 
                                                        SelectCommand="SELECT BacRefNo, BidRefNo, ItemDesc, PreparedDt, DateSubmitted, CONVERT(VARCHAR, BidRefNo)+';'+CONVERT(VARCHAR, BacRefNo) AS BACBID FROM tblBacBidItems WHERE BuyerID=@BuyerID AND Status=@Status ORDER BY DateSubmitted DESC" 
                                                        SelectCommandType="Text">
                                                        <SelectParameters>
                                                            <asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
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
                        <EBid:Footer runat="server" ID="Footer1" />
                        <input type="hidden" id="hdnUserId" name="hdnUserId" runat="server" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
