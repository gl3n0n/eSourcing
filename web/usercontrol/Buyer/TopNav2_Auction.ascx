<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_Buyer_TopNav2_Auction, App_Web_topnav2_auction.ascx.7683b4b2" %>
<table border="0" cellpadding="0" cellspacing="0" class="tasks">
    <tr>
        <td style="padding-left: 10px; text-align: left;">
            <iframe src="../../clock.aspx" height="20" width="300" frameborder="0" scrolling="no" ></iframe>
                    <div style="display:none"> Today is <asp:Label runat="server" ID="lblDate"></asp:Label></div>
        </td>
        <td style="width: 10px;">
        </td>
        <td style="padding-right: 10px; text-align: right;">
            <asp:LinkButton runat="server" ID="lnkCreateNewItem" OnClick="lnkCreateNewItem_Click" CausesValidation="False">Create New Auction Event</asp:LinkButton>
        </td>
    </tr>
</table>
