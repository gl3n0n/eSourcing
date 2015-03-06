<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_bids_biddetails_attachments, App_Web_biddetails_attachments.ascx.712a9dd6" %>
<div align="left">
    <asp:GridView AutoGenerateColumns="False" runat="server" ID="gvFileAttachments" CssClass="itemDetails" 
        DataSourceID="dsAttachments" OnRowCommand="gvFileAttachments_RowCommand" SkinID="AuctionedItems"
        EmptyDataText="No Attachments">         
        <Columns>
            <asp:TemplateField HeaderText="&nbsp;File Attachments">
                <ItemStyle BackColor="white" />
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/web/images/paperclip.gif" Width="15px" Height="15px" 
                        AlternateText="Click to download" CausesValidation="false" CommandArgument='<%# Bind("FileAttachment") %>' CommandName="Download" />
                    <asp:LinkButton ID="lnkDownload" runat="server" ToolTip="Click to download" CausesValidation="false" Text='<%# Bind("OriginalFileName") %>' CommandArgument='<%# Bind("FileAttachment") %>' CommandName="Download" Width="95%"></asp:LinkButton>
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
</div>
