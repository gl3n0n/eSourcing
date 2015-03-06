<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_Buyer_buyer_bidtenderdetails, App_Web_buyer_bidtenderdetails.ascx.712a9dd6" %>
<%@ Register Src="bidtender_attachments.ascx" TagName="bidtender_attachments" TagPrefix="uc1" %>

<asp:DetailsView ID="dvBidTender" runat="server" AllowPaging="True" AutoGenerateRows="False"
    DataSourceID="dsTenderDetails" SkinID="BidDetails" Width="100%" HeaderText="Bid Tender Details">    
    <EmptyDataRowStyle BackColor="white" HorizontalAlign="Center" />    
    <Fields>
        <asp:TemplateField>
            <HeaderStyle Width="120px" />
            <HeaderTemplate>
                &nbsp;Bidder
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>
                &nbsp;
                <asp:Label ID="lblVendor" runat="server" Text='<%# Bind("VendorName")%>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <HeaderStyle Width="120px" />
            <HeaderTemplate>
                &nbsp;Quantity
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>
                &nbsp;
                <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Qty", "{0:#,##0}")%>'></asp:Label>
                &nbsp;<asp:Label ID="lblUOM" runat="server" Text='<%# Bind("UnitOfMeasure")%>'></asp:Label>(s)                
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>            
            <HeaderTemplate>
                &nbsp;Unit Price
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>
                &nbsp;
                <asp:Label ID="lblMount" runat="server" Text='<%# Bind("Amount", "{0:#,##0.00}")%>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>        
        <asp:TemplateField>            
            <HeaderTemplate>
                &nbsp;Discount
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>
                &nbsp;
                <asp:Label ID="lblDiscount" runat="server" Text='<%# Bind("Discount", "{0:#,##0.00}") %>'></asp:Label>                
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>            
            <HeaderTemplate>
                &nbsp;Delivery Cost
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>
                &nbsp;
                <asp:Label ID="lblDeliveryCost" runat="server" Text='<%# Bind("DeliveryCost", "{0:#,##0.00}") %>'></asp:Label>                
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>            
            <HeaderTemplate>
                &nbsp;Total Bid Tender Price
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>
                &nbsp;
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("BidPrice", "{0:#,##0.00}") %>' Font-Bold="true"></asp:Label>                
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>            
            <HeaderTemplate>
                &nbsp;Warranty
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>
                &nbsp;
                <asp:Label ID="lblWarranty" runat="server" Text='<%# Bind("Warranty")%>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>            
            <HeaderTemplate>
                &nbsp;Remarks
            </HeaderTemplate>
            <ItemStyle BackColor="White" />
            <ItemTemplate>                
                &nbsp;
                <asp:Label ID="Label8" runat="server" Text='<%# Eval("Remarks").ToString().Trim().Length > 0 ? Eval("Remarks").ToString() : "No Remarks" %>'
                                                                            ForeColor='<%# Eval("Remarks").ToString().Trim().Length > 0 ? System.Drawing.Color.Black : System.Drawing.Color.Gray %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Fields>
    <PagerSettings Visible="False" />    
</asp:DetailsView>
<asp:SqlDataSource ID="dsTenderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
    SelectCommand="sp_GetBidTenderDetails" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="BidTenderNo" SessionField="BidTenderNo" DefaultValue="0" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<uc1:bidtender_attachments ID="Bidtender_attachments" runat="server" />
