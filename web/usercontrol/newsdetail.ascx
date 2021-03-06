<%@ Control Language="C#" AutoEventWireup="true" CodeFile="newsdetail.ascx.cs" Inherits="web_usercontrol_newsdetail" %>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td valign="top" style="border:none">
            <br />
            <asp:Repeater ID="Repeater_NewsDetails" runat="server" DataSourceID="dsNewsDetails">
                <ItemTemplate>
                    <h1><asp:Label ID="Label1" runat="server" Text='<%# Bind("Title") %>'></asp:Label></h1>
                    <br />
                    <p><%# Eval("Content", "&nbsp;&nbsp;{0}").Replace("\r\n", "<br />\r\n") %>p>
                </ItemTemplate>
            </asp:Repeater>
            <%--<asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="dsNewsDetails" BorderWidth="0">
                    <asp:TemplateField ItemStyle-BorderWidth="0">
                        <ItemTemplate>
                            
                        </ItemTemplate>
                    </asp:TemplateField>
            </asp:DetailsView>--%>
            <asp:SqlDataSource ID="dsNewsDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetContentDetails" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="ID" SessionField="ContentId" Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="Type" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
    <tr>
        <td style="height: 19px">            
            <asp:LinkButton ID="lnkBack" runat="server" Text="Back" Width="100px" CausesValidation="False" OnClick="lnkBack_Click"></asp:LinkButton>
        </td>
    </tr>
</table>