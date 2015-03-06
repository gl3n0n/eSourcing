<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rfidetails_details.ascx.cs" Inherits="web_usercontrol_rfi_rfidetails_details" %>
<div align="left">
    <asp:DetailsView ID="dvEventDetails" runat="server" AutoGenerateRows="False" DataSourceID="dsEventDetails"
        Width="100%" SkinID="BidDetails" HeaderText="RFI Event Details">
        <Fields>
            <asp:TemplateField HeaderText="RFI Reference No." InsertVisible="False" SortExpression="RfiRefNo">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblRfiRefNo" runat="server" Text='<%# Bind("RfiRefNo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" SortExpression="ItemDesc">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblItemDesc" runat="server" Text='<%# Bind("ItemDesc") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Requestor" SortExpression="Requestor">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblRequestor" runat="server" Text='<%# Bind("Requestor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Company" SortExpression="Company">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblCompany" runat="server" Text='<%# Bind("Company") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Group / Department" SortExpression="GroupDeptSecName">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblGroupDeptSecName" runat="server" Text='<%# Bind("GroupDeptSecName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Currency" SortExpression="Currency">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblCurrency" runat="server" Text='<%# Bind("Currency") %>'></asp:Label>
                    <asp:HiddenField ID="hdnCurrency" runat="server"  Value='<%# Bind("CurrencyId") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category" SortExpression="CategoryName">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblCategoryName" runat="server" Text='<%# Bind("CategoryName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="DeliverTo" SortExpression="DeliverTo">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblDeliverTo" runat="server" Text='<%# Bind("DeliverTo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Incoterm" SortExpression="Incoterm">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblIncoterm" runat="server" Text='<%# Bind("Incoterm") %>'></asp:Label>
                    <asp:HiddenField ID="hdnIncoterm" runat="server"  Value='<%# Bind("IncotermId") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Buyer / Creator" SortExpression="Buyer">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblBuyer" runat="server" Text='<%# Bind("Buyer") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date Created" SortExpression="DateCreated">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblDateCreated" runat="server" Text='<%# Bind("DateCreated", "{0:D}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RFI Submission Deadline" SortExpression="Deadline">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:Label ID="lblDeadline" runat="server" Text='<%# Bind("Deadline", "{0:D}  {0:T}") %>'></asp:Label>
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
</div>
