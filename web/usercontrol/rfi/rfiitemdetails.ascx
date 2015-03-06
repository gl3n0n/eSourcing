<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rfiitemdetails.ascx.cs" Inherits="web_usercontrol_rfi_rfiitemdetails" %>
<asp:DetailsView id="dvRfiItem" Width="100%" SkinID="BidDetails" DataSourceID="dsRfiItemDetails"
    runat="server" DataKeyNames="RfiDetailNo,RfiRefNo" HeaderText="RFI Item Details">    
    <Fields>
        <asp:TemplateField HeaderText="Detail No." InsertVisible="False" SortExpression="RfiDetailNo">
            <HeaderStyle Width="120px" />            
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("RfiDetailNo") %>'></asp:Label>                     
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Description" SortExpression="DetailDesc">                        
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("DetailDesc") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SKU" SortExpression="SKU">            
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("SKU") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Quantity" SortExpression="Qty">            
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("Qty", "{0:#,##0}") %>'></asp:Label>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("UnitofMeasure") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>        
        <asp:TemplateField HeaderText="DeliveryDate" SortExpression="DeliveryDate">            
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Bind("DeliveryDate", "{0:D}") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Currency" SortExpression="Currency">            
            <ItemTemplate>
                <asp:Label ID="Label10" runat="server" Text='<%# Bind("Currency") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="RFI Event" InsertVisible="False" SortExpression="RfiRefNo">            
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Bind("RfiRefNo") %>'></asp:Label> - 
                <asp:Label ID="Label8" runat="server" Text='<%# Bind("ItemDesc") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="RFI Tenders" SortExpression="RfiTenderCount">            
            <ItemTemplate>
                <asp:Label ID="Label9" runat="server" Text='<%# Bind("RfiTenderCount") %>'></asp:Label>                
            </ItemTemplate>
        </asp:TemplateField>
    </Fields>
</asp:DetailsView>
<asp:SqlDataSource ID="dsRfiItemDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
    SelectCommand="sp_GetRFIItemDetails" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter DefaultValue="0" Name="RfiDetailNo" SessionField="RfiDetailNo"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>