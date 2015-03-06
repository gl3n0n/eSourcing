<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_Vendor_Vendor_LeftNav_Bids, App_Web_vendor_leftnav_bids.ascx.2311790e" %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" id="related">
	<tr>
		<td style="height: 19px">
			<asp:HyperLink ID="lnk1" runat="server" NavigateUrl="~/web/vendorscreens/bids.aspx">New Bid Events</asp:HyperLink>
		</td>
	</tr>
	<tr>
		<td style="height: 19px">
			<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/web/vendorscreens/declinedbidevents.aspx">Declined Bid Events</asp:HyperLink>
		</td>
	</tr>
	<tr>
		<td style="height: 19px">
			<asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/web/vendorscreens/finishedbidevents.aspx">Finished Bid Events</asp:HyperLink>
		</td>
	</tr>
</table>
<h2>Bid Items</h2>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="related">
	<tr>
		<td>			
			<asp:HyperLink ID="lnk4" runat="server" NavigateUrl="~/web/vendorscreens/awardedbids.aspx">Awarded Bid Items</asp:HyperLink>
		</td>
	</tr>
	<tr>
		<td>			
			<asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/web/vendorscreens/withdrawnedbiditems.aspx">Withdrawn Bid Items</asp:HyperLink>
		</td>
	</tr>		
</table>
<h2>Bid Tenders</h2>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="related">
	<tr>
		<td>
			<asp:HyperLink ID="lnk2" runat="server" NavigateUrl="~/web/vendorscreens/tenderdrafts.aspx">Bid Tender Drafts</asp:HyperLink>
		</td>
	</tr>
	<tr>
		<td>			
			<asp:HyperLink ID="lnk3" runat="server" NavigateUrl="~/web/vendorscreens/submittedtenders.aspx">Submitted Bid Tenders</asp:HyperLink>
		</td>
	</tr>
	<tr>
		<td>			
			<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/web/vendorscreens/bidsforrenegotiation.aspx">Bid Tenders For Clarification</asp:HyperLink>
		</td>
	</tr>
</table>
