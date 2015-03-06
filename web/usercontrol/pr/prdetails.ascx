<%@ Control Language="C#" AutoEventWireup="true" CodeFile="prdetails.ascx.cs" Inherits="web_usercontrol_pr_prdetails" %>
<div align="left">
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="dsPRDetails" HeaderText="Details" SkinID="BidDetails">
        <Fields>
            <asp:TemplateField HeaderText="PR No" InsertVisible="False" SortExpression="PRNo">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:TextBox ID="txtPRNo" runat="server" Text='<%# Bind("PRNo") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="PR Line No" SortExpression="PR Line No">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:TextBox ID="txtPRLineNo" runat="server" Text='<%# Bind("PRLineNo") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="PR Date" SortExpression="PRDate">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                   <asp:TextBox ID="txtPRDate" runat="server" Text='<%# Bind("PRDate") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Description" SortExpression="PRDescription">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:TextBox ID="txtPRDescription" runat="server" Text='<%# Bind("PRDescription") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Commodity" SortExpression="Commodity">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:TextBox ID="txtCommodity" runat="server" Text='<%# Bind("Commodity") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Group" SortExpression="GroupName">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:TextBox ID="txtGroupName" runat="server" Text='<%# Bind("GroupName") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Buyer" SortExpression="Buyer">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:TextBox ID="txtBuyerName" runat="server" Text='<%# Bind("Buyer") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Purchasing Officer" SortExpression="PurchasingOfficer">
                <HeaderStyle Width="133px" />
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                     <asp:TextBox ID="txtPurchasingOfficer" runat="server" Text='<%# Bind("PurchasingOfficer") %>'></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="dsPRDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetPRDetails" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="PRNo" SessionField="PRNo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>   
</div>