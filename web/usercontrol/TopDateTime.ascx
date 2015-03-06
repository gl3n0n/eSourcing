<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_TopDateTime" CodeFile="TopDateTime.ascx.cs" %>
<table border="0" cellpadding="0" cellspacing="0" class="tasks" onload="DisplayTime();">
    <tr>       
        <td style="padding-left: 10px; text-align: left;">
            <iframe src="../../clock.aspx" height="20" width="300" frameborder="0" scrolling="no" color=""></iframe>
            <asp:Label runat="server" ID="lblDate" style="display:none"></asp:Label>
        </td>        
    </tr>
</table>