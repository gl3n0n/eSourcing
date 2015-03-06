<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_auctionvendor_auctionattachments, App_Web_auctionattachments.ascx.a5a12ffe" %>
<div align="left">
    <asp:GridView AutoGenerateColumns="False" runat="server" ID="gvFileAttachments" CssClass="itemDetails" 
        DataSourceID="dsAttachments" OnRowCommand="gvFileAttachments_RowCommand" SkinID="AuctionedItems"
         EmptyDataText="None">         
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
        SelectCommand="s3p_EBid_GetAuctionFileAttachmentByAuctionRefNo" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="AuctionRefNo" SessionField="AuctionRefNo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>