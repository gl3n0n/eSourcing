<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_reports_eventtenderscomparison, App_Web_eventtenderscomparison.ascx.d6e4e657" %>
<table border="0" cellpadding="0" cellspacing="0" style="font-size: 11px; font-family: Arial; width: 100%">
    <tr>
        <td valign="top" style="padding-top: 5px; width: 110px;">
            Bid Events</td>
        <td>
            <asp:ListBox ID="lbEvents" runat="server" Width="300px" Rows="6" DataSourceID="sdsEvents" DataTextField="BidEvent" DataValueField="BidRefNo"></asp:ListBox><asp:SqlDataSource ID="sdsEvents" runat="server"
                ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetEventForComparison" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="PurchasingId" SessionField="UserId" Type="Int32" />
                    <asp:SessionParameter DefaultValue="0" Name="UserType" SessionField="UserType" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>    
    <tr>
        <td colspan="2" style="height: 10px;">
        </td>
    </tr>
    <tr>
        <td colspan="2" id="actions">
            <asp:LinkButton ID="lnkViewReport" runat="server" OnClick="lnkViewReport_Click" Width="100px">View Report</asp:LinkButton>
        </td>
    </tr>
</table>