<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_Vendor_AuctionVendor_TopNav_Home, App_Web_auctionvendor_topnav_ongoing.ascx.a5a12ffe" %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tabs" id="table1">
	<tr>
		<td width="200px" style="height: 19px">
			<asp:LinkButton runat="server" ID="lnkHome" OnClick="lnkHome_Click">Home</asp:LinkButton>
		</td>
		<td class="activeTab" width="200px" style="height: 19px">
			<asp:LinkButton runat="server" ID="lnkOngoingAuctions" OnClick="lnkOngoingAuctions_Click">Ongoing Auctions</asp:LinkButton>
		</td>
		<td width="200px" style="height: 19px">
			<asp:LinkButton runat="server" ID="lnkUpcomingAuctions" OnClick="lnkUpcomingAuctions_Click">Upcoming Auctions</asp:LinkButton>
		</td>
		<td width="200px" style="height: 19px">
			<asp:LinkButton runat="server" ID="lnkFinishedAuctions" OnClick="lnkFinishedAuctions_Click">Finished Auctions</asp:LinkButton>
		</td>
		<td>
			&nbsp;</td>
	</tr>
</table>
