<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_BOC_LeftNav, App_Web_boc_leftnav_bids.ascx.b5379dd9" %>
<table border="0" cellpadding="0" cellspacing="0" width="100%" id="related">
    <tr>
        <td>
            <asp:HyperLink runat="server" ID="btnBidsForApproval" NavigateUrl="~/web/boc/bidseventsforopening.aspx">
								Bid Events For Opening</asp:HyperLink></td>
    </tr>
    <tr>
        <td>
            <asp:HyperLink runat="server" ID="btnApprovedBidItems" NavigateUrl="~/web/boc/bidsopened.aspx">
								Bid Events Opened</asp:HyperLink></td>
    </tr>    
</table>
