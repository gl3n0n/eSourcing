<%@ page language="C#" autoeventwireup="true" inherits="web_onlineAuction_UpcomingAuctionEvents, App_Web_upcomingauctionevents.aspx.162804a0" theme="default" %>

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
            sqlParams[4].Value = "Viewed list of upcoming auction events.";


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
	<link rel="stylesheet" type="text/css" href="../css/style_oa.css" />
</head>
<body>
	<div>
		<form runat="server">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
				<tr>
					<td valign="top" height="137">
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
									<EBid:AuctionVendor_TopNav_Upcoming runat="server" ID="AuctionVendor_TopNav_Upcoming" />									
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
									<h1>
										<br />
										Upcoming Auction Events</h1>
									<div align="left">
										<br />
										<asp:GridView ID="gvAuctionEvents" runat="server" AutoGenerateColumns="False" DataKeyNames="AuctionRefNo"
											SkinID="AuctionEvents" AllowPaging="True" AllowSorting="True" 
											EmptyDataText="There are no upcoming auctions at this moment." DataSourceID="dsUpcomingAuctions">
											<EmptyDataRowStyle HorizontalAlign="center" Height="25px" />
											<Columns>
											    <asp:TemplateField HeaderText="&#160;Reference No.&#160;" SortExpression="AuctionRefNo">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="90px" HorizontalAlign="Center" />													
													<ItemTemplate>
														&nbsp;<asp:LinkButton ID="lblrefno" runat="server" Text='<%# Bind("AuctionRefNo") %>'
															CommandName="SelectAuctionItem" CommandArgument='<%#Bind("AuctionRefNo") %>' OnCommand="lblAuctionEvents_Command">'></asp:LinkButton>
													</ItemTemplate>
												</asp:TemplateField>
												
												<asp:TemplateField HeaderText="&#160;Auction Events&#160;" SortExpression="ItemDesc">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemTemplate>
														&nbsp;<asp:LinkButton ID="lblAuctionEvents" runat="server" Text='<%# Bind("ItemDesc") %>'
															CommandName="SelectAuctionItem" CommandArgument='<%#Bind("AuctionRefNo") %>' OnCommand="lblAuctionEvents_Command">'></asp:LinkButton>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField HeaderText="&#160;Confirmation Deadline&#160;" SortExpression="AuctionDeadline">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="180px" HorizontalAlign="Center" />
													<ItemTemplate>
														<asp:Label ID="Label1" runat="server" Text='<%# Eval("AuctionDeadline", "{0:D}") %>'></asp:Label>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField HeaderText="&#160;Event Date and Time&#160;" SortExpression="AuctionStartDateTime">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="240px" HorizontalAlign="Center" />
													<ItemTemplate>														
														&nbsp;<label style="font-family:Arial; font-size: 9px;">FROM:</label>
														&nbsp;<asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("AuctionStartDateTime", "{0:D}<br />{0:T}") %>'></asp:Label><br />
														&nbsp;<label style="font-family:Arial; font-size: 9px;">TO:</label>
														&nbsp;<asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("AuctionEndDateTime", "{0:D}<br />{0:T}") %>'></asp:Label>												
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField HeaderText="&#160;Duration&#160;" SortExpression="Duration">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="90px" HorizontalAlign="Center" />
													<ItemTemplate>
														<asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></asp:Label>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField>
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="120px" HorizontalAlign="Center" />
													<ItemTemplate>
														<asp:Panel ID="pnlConfirmation" runat="server" Visible='<%# ShowConfirmation(Eval("ConfirmationStatus").ToString(), Eval("DeadlineReached").ToString()) %>'>
															<asp:LinkButton ID="lblAction" runat="server" Text="Confirm | Decline" CommandArgument='<%# Eval("AuctionRefNo") %>' OnCommand="lblAction_Command"></asp:LinkButton>
														</asp:Panel>
														<asp:Label ID="lblConfirmationStatus" runat="server" Visible='<%# !ShowConfirmation(Eval("ConfirmationStatus").ToString(), Eval("DeadlineReached").ToString()) %>' Text='<%# ConfirmationStatus(Eval("ConfirmationStatus").ToString()) %>'></asp:Label>														
													</ItemTemplate>
												</asp:TemplateField>
											</Columns>
										</asp:GridView>
										<asp:SqlDataSource ID="dsUpcomingAuctions" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
											SelectCommand="sp_GetUpcomingAuctions" SelectCommandType="StoredProcedure">
											<SelectParameters>
												<asp:SessionParameter DefaultValue="0" Name="UserId" SessionField="UserId" Type="Int32" />
												<asp:SessionParameter DefaultValue="0" Name="UserType" SessionField="UserType" Type="Int32" />
											</SelectParameters>
										</asp:SqlDataSource>
									</div>
								</td>
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
				<tr><td>&nbsp;</td></tr>
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
