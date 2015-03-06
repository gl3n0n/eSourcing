<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_AuctionVendor_AuctionItemBidHistory, App_Web_auctionitembidhistory.ascx.a5a12ffe" %>
<asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" DataSourceID="dsAuctionBidHistory" SkinID="AuctionedItems" AllowSorting="True" AllowPaging="True" >
    <Columns>                                                            
        <asp:TemplateField HeaderText="Bidder" SortExpression="VendorName">                                                                    
            <HeaderStyle HorizontalAlign="Center" />
            <ItemTemplate>                                                                    
                &nbsp;&nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Bind("VendorName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Bid" SortExpression="Bid">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Bid") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Date Submitted" SortExpression="DateSubmitted">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("DateSubmitted","{0:D}&nbsp;{0:T}") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="dsAuctionBidHistory" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
    SelectCommand="sp_GetAuctionedItemAllBidHistory" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter DefaultValue="0" Name="Auctiondetailno" SessionField="AuctionDetailNo"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>