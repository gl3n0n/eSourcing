<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_mobileno, App_Web_mobileno.ascx.317b4283" %>

<asp:DropDownList ID="ddlMobilePrefix" runat="server">
</asp:DropDownList><asp:RequiredFieldValidator ID="rfvPrefix" runat="server" ErrorMessage="*" ControlToValidate="ddlMobilePrefix" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
<asp:TextBox ID="txtMobileNo" runat="server" MaxLength="7" Width="96px"></asp:TextBox>&nbsp;
<asp:RequiredFieldValidator ID="rfvMobileNo" runat="server" ErrorMessage="*" ControlToValidate="txtMobileNo" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
