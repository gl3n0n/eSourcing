<%--<%@ Control Language="C#" AutoEventWireup="true" CodeFile="approved_bid_attachment.ascx.cs" Inherits="web_usercontrol_bids_approved_bid_attachment" %>
--%><%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_bids_approved_bid_attachment, App_Web_approved_bid_attachment.ascx.712a9dd6" %>
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
</div>