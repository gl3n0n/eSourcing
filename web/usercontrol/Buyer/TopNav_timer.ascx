<%@ control language="C#" autoeventwireup="true" inherits="WEB_user_control_TopNav_timer" CodeFile="TopNav_timer.ascx.cs" %>
<table border="0" cellpadding="0" cellspacing="0" class="tasks">
    <tr>
        <td style="padding-left: 5px; text-align: left;">
            <iframe src="../../clock.aspx" height="20" width="300" frameborder="0" scrolling="no" ></iframe>
        </td>
        <td style="width: 10px;">
        </td>
        <td style="padding-right: 10px; text-align: right;">
            <asp:LinkButton runat="server" ID="lnkCreateNewItem" OnClick="lnkCreateNewItem_Click"
                CausesValidation="False">Create New Bid Event</asp:LinkButton>
        </td>
    </tr>
</table>
