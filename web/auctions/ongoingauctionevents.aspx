<%@ page language="C#" autoeventwireup="true" inherits="web_onlineAuction_OngoingAuctionEvents, App_Web_ongoingauctionevents.aspx.162804a0" theme="default" %>

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
            sqlParams[4].Value = "Viewed list of on-going auction events.";


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

<%@ Register Src="../usercontrol/AuctionVendor/AuctionVendor_TopNav.ascx" TagName="AuctionVendor_TopNav"
	TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="AuctionVendor_TopNav_Home" Src="~/web/usercontrol/AuctionVendor/AuctionVendor_TopNav_Ongoing.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title id="PageTitle" runat="server"></title>	
	<meta http-equiv="Content-Language" content="en-us" />
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
	<link rel="stylesheet" type="text/css" href="../css/style.css" />
	<link rel="stylesheet" type="text/css" href="../css/style_oa.css" />
	
	<script type="text/javascript">
	<!--	    
	    function showWindow(redirecturl,title)
        {
            window.open(redirecturl,title, 'toolbar=no, menubar=no, resizable=yes , scrollbars=yes');
        }
    //-->
	</script>
</head>
<body>
	<div>
		<form runat="server">
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
									<EBid:AuctionVendor_TopNav_Home ID="AuctionVendor_TopNav_Home1" runat="server" />
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
										Ongoing Auction Events</h1>
									<div align="left">
										<br />
										<asp:GridView ID="gvAuctionEvents" runat="server" AutoGenerateColumns="False" SkinID="AuctionEvents"
											DataKeyNames="AuctionRefNo" DataSourceID="dsOngoingAuctions" AllowPaging="True"
											AllowSorting="True" EmptyDataText="There are no ongoing auctions at this moment." 
											OnRowDataBound='gvAuctionEvents_RowDataBound'>
											<EmptyDataRowStyle HorizontalAlign="center" Height="25px" />
											<Columns>
											    <asp:TemplateField HeaderText="&#160;Reference No.&#160;" SortExpression="ItemDesc">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="90px" HorizontalAlign="Center" />
													<ItemTemplate>
														&nbsp;<asp:LinkButton ID="lblauctionrefno" runat="server" Text='<%# Bind("AuctionRefNo") %>'
															CommandName="SelectAuctionItem" CommandArgument='<%#Bind("AuctionRefNo") %>'
															OnCommand="lblAuctionEvents_Command">'></asp:LinkButton>
													</ItemTemplate>
												</asp:TemplateField>
												
												<asp:TemplateField HeaderText="&#160;Auction Events&#160;" SortExpression="ItemDesc">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemTemplate>
														&nbsp;<asp:LinkButton ID="lblAuctionEvents" runat="server" Text='<%# Bind("ItemDesc") %>'
															CommandName="SelectAuctionItem" CommandArgument='<%#Bind("AuctionRefNo") %>'
															OnCommand="lblAuctionEvents_Command">'></asp:LinkButton>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField HeaderText="&#160;Start Date and Time&#160;" SortExpression="AuctionStartDateTime">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="200px" HorizontalAlign="Center" />
													<ItemTemplate>
														<asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("AuctionStartDateTime", "{0:D}<br / >{0:t}") %>'></asp:Label>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField HeaderText="&#160;End Date and Time&#160;" SortExpression="AuctionEndDateTime">
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="200px" HorizontalAlign="Center" />
													<ItemTemplate>
														<asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("AuctionEndDateTime", "{0:D}<br / >{0:t}") %>'></asp:Label>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField>
													<HeaderStyle HorizontalAlign="Center" />
													<ItemStyle Width="100px" HorizontalAlign="Center" />
													<ItemTemplate>
                                                        <asp:HyperLink ID="lnkParticipate" runat="server" Visible='<%# ShowParticipateLink(Eval("ParticipationStatus").ToString()) %>'>Participate</asp:HyperLink>
														<asp:LinkButton ID="lnkConfirm" runat="server" Text="Confirm | Decline" Visible='<%# ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>'
														    CommandName="ConfirmCommand" CommandArgument='<%# Eval("AuctionRefNo") %>' OnCommand="lnkConfirm_Command"></asp:LinkButton>
														<asp:Label ID="lblConfirmationStatus" runat="server" Font-Size="11px" Text='<%# ConfirmationStatus(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString())  %>'
															Visible='<%# !ShowConfirmDeclineLink(Eval("ParticipationStatus").ToString(), Eval("AuctionDeadlineDiff").ToString()) %>'></asp:Label>
													</ItemTemplate>
												</asp:TemplateField>
											</Columns>
										</asp:GridView>
										<asp:SqlDataSource ID="dsOngoingAuctions" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
											SelectCommand="sp_GetOngoingAuctions" SelectCommandType="StoredProcedure">
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
