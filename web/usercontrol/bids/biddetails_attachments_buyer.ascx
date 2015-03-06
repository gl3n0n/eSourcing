<%@ Control Language="C#" AutoEventWireup="true" CodeFile="biddetails_attachments_buyer.ascx.cs"
    Inherits="web_usercontrol_bids_biddetails_attachments1" %>
<div align="left">
    <asp:GridView AutoGenerateColumns="False" runat="server" ID="gvFileAttachments" CssClass="itemDetails" 
        DataSourceID="dsAttachments" OnRowCommand="gvFileAttachments_RowCommand" SkinID="AuctionedItems"
        EmptyDataText="No Attachments">         
        <Columns>
            <asp:TemplateField HeaderText="&nbsp;File Attachments">
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <%--<asp:CheckBox ID="cbFile" runat="server" />--%>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/web/images/paperclip.gif" Width="15px" Height="15px" 
                        AlternateText="Click to download" CausesValidation="false" CommandArgument='<%# Bind("FileAttachment") %>' CommandName="Download" />
                    <asp:LinkButton ID="lnkDownload" runat="server" ToolTip="Click to download" CausesValidation="false" Text='<%# Bind("OriginalFileName") %>' CommandArgument='<%# Bind("FileAttachment") %>' CommandName="Download" Width="95%"></asp:LinkButton>
                    <asp:HiddenField runat="server" ID="txtFileAttachment" value='<%# Bind("FileAttachment") %>'></asp:HiddenField>
                    <%--<asp:HiddenField runat="server" ID="txtVendorNme" value='<%# Bind("Supplier") %>'></asp:HiddenField>--%>
                </ItemTemplate>                
            </asp:TemplateField>
        </Columns>
    </asp:GridView>    
    <asp:SqlDataSource ID="dsAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
        SelectCommand="sp_GetBidEventFileAttachments" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="BidRefNo" SessionField="BidRefNo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:LinkButton ID="lnkDownloadAll" runat="server" Width="160px" 
        onclick="lnkDownloadAll_Click">Download All Attachments</asp:LinkButton>
</div>
