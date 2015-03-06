<%@ control language="C#" autoeventwireup="true" CodeFile="bidtender_attachments.ascx.cs" inherits="web_usercontrol_bids_bidtender_attachments" %>
<div align="left">
    <asp:GridView AutoGenerateColumns="False" runat="server" ID="gvFileAttachments" CssClass="itemDetails" 
        DataSourceID="dsAttachments" OnRowCommand="gvFileAttachments_RowCommand" SkinID="AuctionedItems"
         EmptyDataText="No Attachments For This Bid Tender/Bid Event">         
        <Columns>
            <asp:TemplateField HeaderText="&nbsp;File Attachments">
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/web/images/paperclip.gif" Width="15px" Height="15px" 
                        AlternateText="Click to download" CausesValidation="false" CommandArgument='<%# Bind("FileAttachment") %>' CommandName="Download" />
                    <asp:LinkButton ID="lnkDownload" runat="server" ToolTip="Click to download" CausesValidation="false" Text='<%# Bind("OriginalFileName") %>' CommandArgument='<%# Bind("FileAttachment") %>' CommandName="Download" Width="95%"></asp:LinkButton>
					<asp:HiddenField runat="server" ID="txtFileAttachment" value='<%# Bind("FileAttachment") %>'></asp:HiddenField>
                </ItemTemplate>                
            </asp:TemplateField>
        </Columns>
    </asp:GridView>    
    <asp:SqlDataSource ID="dsAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
        SelectCommand="sp_GetBidTenderAttachments" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="BidTenderNo" SessionField="BidTenderNo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
	<asp:LinkButton ID="lnkDownloadAll" runat="server" Width="160px" 
        onclick="lnkDownloadAll_Click">Download All Attachments</asp:LinkButton>
</div>
