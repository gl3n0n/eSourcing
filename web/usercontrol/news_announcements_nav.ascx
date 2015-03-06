<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_news_announcements_nav, App_Web_news_announcements_nav.ascx.317b4283" %>
<div>
    <h2>
        Top 10 Announcements</h2>
    <p>
        <asp:DataList ID="dlAnnouncements" runat="server" DataKeyField="ID" DataSourceID="dsAnnouncements" OnItemCommand="dlAnnouncements_ItemCommand">
            <ItemTemplate>                
                <asp:LinkButton ID="lnkAnnouncement" runat="server" Text='<%# Limit_title(Eval("Title", "» {0}")) %>'
                    ForeColor="White" Font-Size="11px" CommandArgument='<%# Bind("ID") %>' CommandName="ViewAnnouncementDetail" 
                    CausesValidation="false" ToolTip='<%# Bind("Title", "» {0}") %>'></asp:LinkButton>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="dsAnnouncements" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
            SelectCommand="sp_GetTop10Announcement" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </p>
    <h2>
        Top 10 News</h2>
    <p>
        <asp:DataList ID="dlNews" runat="server" DataKeyField="ID" DataSourceID="dsNews" OnItemCommand="dlNews_ItemCommand">
            <ItemTemplate>
                <asp:LinkButton ID="lnkNews" runat="server" Text='<%# Limit_title(Eval("Title", "» {0}")) %>'
                    ForeColor="White" Font-Size="11px" CommandArgument='<%# Bind("ID") %>' CommandName="ViewNewsDetail" 
                    CausesValidation="false" ToolTip='<%# Bind("Title", "» {0}") %>'></asp:LinkButton>
            </ItemTemplate>
        </asp:DataList><asp:SqlDataSource ID="dsNews" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
            SelectCommand="sp_GetTop10News" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </p>
</div>