<%@ page language="C#" autoeventwireup="true" inherits="web_onlineAuction_UpcomingAuctionEvents, App_Web_finishedauctionevents.aspx.162804a0" theme="default" %>

<%@ Import Namespace="System"%>
<%@ Import Namespace="System.Collections"%>
<%@ Import Namespace="System.ComponentModel"%>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Drawing"%>
<%@ Import Namespace="System.Web"%>
<%@ Import Namespace="System.Web.SessionState"%>
<%@ Import Namespace="System.Web.Security"%>
<%@ Import Namespace="System.Web.UI"%>
<%@ Import Namespace="System.Web.UI.WebControls"%>
<%@ Import Namespace="System.Web.UI.HtmlControls"%>
<%@ Import Namespace="EBid.lib.bid.data"%>
<%@ Import Namespace="EBid.lib.bid.trans"%>
<%@ Import Namespace="EBid.lib.user.trans"%>
<%@ Import Namespace="EBid.lib.constant"%>
<%@ Import Namespace="EBid.lib"%>
<%@ Import Namespace="System.Data.Sql"%>
<%@ Import Namespace="System.Data.SqlClient"%>

<script language="c#" runat="server">    

string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        SaveVendorAuditTrail();
    } 
    
    private int SaveVendorAuditTrail()
    {
        System.Web.HttpBrowserCapabilities browser = Request.Browser;
        string Browser = "Type = " + browser.Type + " Name = " + browser.Browser + " Version = " + browser.Version;
        string url = HttpContext.Current.Request.Url.AbsoluteUri;
        DateTime DateAccessed = DateTime.Now;
                        
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        int value = 0;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[5];
            sqlParams[0] = new SqlParameter("@UserId", SqlDbType.Int);
            sqlParams[1] = new SqlParameter("@AccessedPage", SqlDbType.NVarChar);
            sqlParams[2] = new SqlParameter("@DateAccessed", SqlDbType.DateTime);
            sqlParams[3] = new SqlParameter("@BrowserType", SqlDbType.NVarChar);
            sqlParams[4] = new SqlParameter("@ActivityDetails", SqlDbType.NVarChar);


            sqlParams[0].Value = Int32.Parse(Session[Constant.SESSION_USERID].ToString());
            sqlParams[1].Value = url;
            sqlParams[2].Value = DateAccessed;
            sqlParams[3].Value = Browser;
            sqlParams[4].Value = "Viewed list of finished auction events.";


            value = Convert.ToInt32(SqlHelper.ExecuteScalar(sqlTransact, "sp_AddVendorAuditTrail", sqlParams));

            sqlTransact.Commit();
        }
        catch
        {
            sqlTransact.Rollback();
            value = 0;
        }
        finally
        {
            sqlConnect.Close();
        }

        return value;
    }
        
</script>

<%@ Register Src="../usercontrol/AuctionVendor/AuctionVendor_TopNav_Finished.ascx" TagName="AuctionVendor_TopNav_Finished" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="AuctionVendor_TopNav_Upcoming" Src="~/web/usercontrol/AuctionVendor/AuctionVendor_TopNav_Upcoming.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_oa.css">
</head>
<body>
    <div>
        <form id="frmFinished" runat="server">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr>
                    <td valign="top" style="height: 137px">
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
                                    <uc1:AuctionVendor_TopNav_Finished ID="AuctionVendor_TopNav_Finished1" runat="server"></uc1:AuctionVendor_TopNav_Finished>
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
                    <td valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td valign="top" id="content">
                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <h1>
                                                    <br />
                                                    Finished Auction Events</h1>
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <div id='pnl_buyerMenu' runat="server">
                                                    <asp:CheckBoxList ID="chkbuyeropts" runat="server" AutoPostBack="True" Font-Names="Arial" Font-Size="11px" RepeatDirection="Horizontal" RepeatLayout="Table"
                                                        Width="330px">
                                                        <asp:ListItem Selected="True" Value='0'>For Endorsement</asp:ListItem>
                                                        <asp:ListItem Selected="False" Value='1'>Elapsed</asp:ListItem>
                                                        <asp:ListItem Selected="False" Value='2'>Awarded</asp:ListItem>
                                                        <asp:ListItem Selected="False" Value='3'>Failed</asp:ListItem>
                                                    </asp:CheckBoxList>
                                                </div>
                                                <div id='pnl_Menu' runat="server">
                                                    <asp:CheckBoxList ID="chkauctiontype" runat="server" AutoPostBack="True" Font-Names="Arial" Font-Size="11px" RepeatDirection="Horizontal" RepeatLayout="Table" Width="288px">
                                                        <asp:ListItem Selected="true" Value='0'>Forward Auction</asp:ListItem>
                                                        <asp:ListItem Selected="true" Value='1'>Reverse Auction</asp:ListItem>
                                                    </asp:CheckBoxList>
                                                </div>
                                                <asp:GridView ID="gvAuctionEvents" runat="server" AutoGenerateColumns="False" SkinID="AuctionEvents" DataKeyNames="AuctionRefNo" AllowPaging="True" AllowSorting="True" EmptyDataText="There are no finished auctions at this moment."
                                                    DataSourceID="dsFinishedAuctions" OnRowCreated="gvAuctionEvents_RowCreated">
                                                    <EmptyDataRowStyle HorizontalAlign="Center" Height="25px" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Reference No." SortExpression="AuctionStartDateTime">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle Width="90px" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp;<asp:LinkButton ID="lblrefno" runat="server" Text='<%# Bind("AuctionRefNo") %>' CommandName="SelectAuctionItem" CommandArgument='<%#Bind("AuctionRefNo") %>' OnCommand="lblAuctionEvents_Command">'></asp:LinkButton><br />
                                                                <asp:Label ID="Label1" runat="server" ForeColor="gray" Text='<%# Bind("AuctionType1") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="&#160;Auction Events&#160;" SortExpression="ItemDesc">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                &nbsp;<asp:LinkButton ID="lblAuctionEvents" runat="server" Text='<%# Bind("ItemDesc") %>' CommandName="SelectAuctionItem" CommandArgument='<%#Bind("AuctionRefNo") %>' OnCommand="lblAuctionEvents_Command">'></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="&#160;Start Date and Time&#160;" SortExpression="AuctionStartDateTime">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle Width="180px" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("AuctionStartDateTime", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="&#160;End Date and Time&#160;" SortExpression="AuctionEndDateTime">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle Width="180px" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("AuctionEndDateTime", "{0:D}<br />{0:T}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status">
                                                            <HeaderStyle Font-Bold="True" Font-Size="12px" ForeColor="White" HorizontalAlign="Center" />
                                                            <ItemStyle Width="190px" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <div>
                                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                                        <tr>
                                                                            <td>
                                                                                <p style="padding-left: 3px">
                                                                                    Pending:&nbsp;
                                                                                    <asp:Label ID="lblPending" runat="server" Font-Bold="true" Text='<%# Eval("PendingCount", "{0}").ToString() + "/" + Eval("DetailsCount", "{0}")  %>'></asp:Label>
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <p style="padding-right: 3px">
                                                                                    Approved:&nbsp;
                                                                                    <asp:Label ID="lblApproved" runat="server" Font-Bold="true" Text='<%# Eval("ApprovedCount", "{0}").ToString() + "/" + Eval("DetailsCount", "{0}")  %>'></asp:Label>
                                                                                </p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <p style="padding-left: 3px">
                                                                                    Disapproved:&nbsp;
                                                                                    <asp:Label ID="lblDisapproved" runat="server" Font-Bold="true" Text='<%# Eval("DisapprovedCount", "{0}").ToString() + "/" + Eval("DetailsCount", "{0}")  %>'></asp:Label>
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <p style="padding-right: 3px">
                                                                                    Re-Edit:&nbsp;
                                                                                    <asp:Label ID="lblReedit" runat="server" Font-Bold="true" Text='<%# Eval("ReeditCount", "{0}").ToString() + "/" + Eval("DetailsCount", "{0}")  %>'></asp:Label>
                                                                                </p>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemStyle Width="80px" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkEndorse" runat="server" CommandArgument='<%# Eval("AuctionRefNo") %>' OnCommand="lnkEndorse_Command" Enabled='<%# IsEndorsement(Eval("StatusDesc").ToString()) %>' Visible='<%# IsEndorsement(Eval("StatusDesc").ToString()) %>'>Endorse</asp:LinkButton>
                                                                <asp:Label ID="lblstatus" runat="server" Text='<%# Eval("StatusDesc").ToString() %>' Visible='<%# !IsEndorsement(Eval("StatusDesc").ToString()) %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="dsFinishedAuctions" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetFinishedAuctions" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:SessionParameter Name="UserId" SessionField="UserId" Type="Int32" />
                                                        <asp:SessionParameter Name="UserType" SessionField="UserType" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                    <td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lblMessage" runat="server" Text="" Font-Size="11px" ForeColor="red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
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
