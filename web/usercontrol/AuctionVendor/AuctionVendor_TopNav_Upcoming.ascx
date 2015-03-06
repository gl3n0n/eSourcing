<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_Vendor_AuctionVendor_TopNav_Upcoming, App_Web_auctionvendor_topnav_upcoming.ascx.a5a12ffe" %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="tabs" id="table1">
	<tr>
		<td width="200px">
		<asp:linkbutton runat="server" ID="lnkHome" OnClick="lnkHome_Click">Home</asp:linkbutton>
		</td>
		<td width="200px">
		<asp:linkbutton runat="server" ID="lnkOngoingAuctions" OnClick="lnkOngoingAuctions_Click">Ongoing Auctions</asp:linkbutton>
		</td>
		<td class="activeTab" width="200px">
		<asp:linkbutton runat="server" ID="lnkUpcomingAuctions" OnClick="lnkUpcomingAuctions_Click">Upcoming Auctions</asp:linkbutton>
		</td>
		<td width="200px">
		<asp:linkbutton runat="server" ID="lnkFinishedAuctions" OnClick="lnkFinishedAuctions_Click">Finished Auctions</asp:linkbutton>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
