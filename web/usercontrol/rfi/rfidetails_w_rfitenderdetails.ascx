<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rfidetails_w_rfitenderdetails.ascx.cs" Inherits="web_usercontrol_rfi_rfidetails_w_rfitenderdetails" %>
<div align="left">
    <asp:Panel ID="pnlVendor" runat="server" Width="125px">
        <asp:LinkButton ID="lnkContactBuyer" runat="server" OnClick="lnkContactBuyer_Click">Contact Buyer</asp:LinkButton>
    </asp:Panel>    
    <asp:DetailsView ID="dView" runat="server" AutoGenerateRows="False"
        DataSourceID="dsEventDetails" 
        HeaderText="Details" SkinID="BidDetails" DataKeyNames="RfiRefNo,Buyer,ItemDesc,BuyerId">        
        <Fields>
            <asp:TemplateField HeaderText="RFI Reference No." InsertVisible="False" SortExpression="RfiRefNo">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label14" runat="server" Text='<%# Bind("RfiRefNo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" SortExpression="ItemDesc">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("ItemDesc") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>            
            <asp:TemplateField HeaderText="Requestor" SortExpression="Requestor">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label12" runat="server" Text='<%# Bind("Requestor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Company" SortExpression="Company">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Group / Department" SortExpression="GroupDeptSecName">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("GroupDeptSecName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Currency" SortExpression="Currency">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Currency") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category" SortExpression="CategoryName">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="DeliverTo" SortExpression="DeliverTo">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("DeliverTo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Incoterm" SortExpression="Incoterm">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Incoterm") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Buyer / Creator" SortExpression="Buyer">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("Buyer") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date Created" SortExpression="DateCreated">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("DateCreated", "{0:D}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RFI Submission Deadline" SortExpression="Deadline">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="White" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Deadline", "{0:D}  {0:T}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="dsEventDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
        SelectCommand="sp_GetRfiEventDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RfiRefNo" SessionField="RfiRefNo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView AutoGenerateColumns="False" AllowSorting="true" runat="server" ID="gvRfiItemDetails" SkinID="AuctionedItems"
        DataSourceID="dsItemDetails" EmptyDataText="No RFI Items" OnRowCommand="gvRfiItemDetails_RowCommand">        
        <Columns>
            <asp:TemplateField HeaderText="Item" SortExpression="Item">
                <ItemStyle CssClass="itemDetails_td" Width="65px" />
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDetailDesc" runat="server" Text='<%# Bind("Item") %>' CommandName="RfiTenderDetails" 
                    CommandArgument='<%# Bind("TenderNo", "{0}") %>'></asp:LinkButton>                                                                
                </ItemTemplate>
                <ItemStyle BackColor="White" Width="250px" />
                <HeaderStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" SortExpression="DetailDesc">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblDescription" Text='<%#Bind("DetailDesc") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center"/>
                <HeaderStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Quantity" SortExpression="Qty">
                <ItemStyle BackColor="White" HorizontalAlign="Center" Width="120px" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblQuantity" Text='<%#Bind("Qty", "{0:#,##0}") %>'></asp:Label>
                    <asp:Label runat="server" ID="lblUnitOfMeasure" Text='<%#Bind("UnitOfMeasure") %>'></asp:Label>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delivery Date" SortExpression="DeliveryDate">
                <ItemStyle BackColor="White" HorizontalAlign="Center" Width="180px" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblDeliveryDate" Text='<%#Bind("DeliveryDate", "{0:D}") %>'></asp:Label>
                </ItemTemplate>                
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="ItemStatus">
                <ItemStyle HorizontalAlign="Center" Width="100px" />
                <HeaderStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblStatus" Text='<%#Bind("ItemStatus") %>'></asp:Label>
                </ItemTemplate>                
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="dsItemDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
        SelectCommand="sp_GetRfiItemDetailsStatus" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="RfiRefNo" SessionField="RfiRefNo" Type="Int32" />
            <asp:SessionParameter Name="VendorId" SessionField="UserId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>  
</div>
