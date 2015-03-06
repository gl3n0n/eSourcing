<%@ control language="C#" autoeventwireup="true" inherits="WEB_user_control_TopNav3, App_Web_topnav3.ascx.7683b4b2" %>
<table border="0" cellpadding="0" cellspacing="0" class="tasks">
    <tr>
        <td style="padding-left: 10px; text-align: left;">
            <iframe src="../../clock.aspx" height="20" width="300" frameborder="0" scrolling="no" ></iframe>
            <asp:Label runat="server" ID="lblDate" Font-Bold="True" Font-Size="12px" style="display:none" ></asp:Label>
            <asp:Label runat="server" ID="lblTime" Font-Bold="True" Font-Size="12px" style="display:none" ></asp:Label>
        </td>
        <td style="width: 10px;">
        </td>
        <td style="padding-right: 10px; text-align: right;">
            <asp:LinkButton runat="server" ID="lnkCreateNewItem" OnClick="lnkCreateNewItem_Click"
                CausesValidation="False">Create New BAC</asp:LinkButton>
        </td>
    </tr>
</table>
