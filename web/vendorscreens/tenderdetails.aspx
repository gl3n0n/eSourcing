<%--<%@ page language="c#" inherits="EBid.web.vendor_screens.tenderDetails, App_Web_tenderdetails.aspx.8a7237e8" maintainscrollpositiononpostback="true" theme="default" %>--%>
<%@ page language="c#" inherits="EBid.web.vendor_screens.tenderDetails" CodeFile="tenderdetails.aspx.cs" maintainscrollpositiononpostback="true" theme="default" %>

<%@ Register Src="../usercontrol/bids/biditemdetails.ascx" TagName="biditemdetails" TagPrefix="uc5" %>
<%@ Register Src="../usercontrol/bids/buyer_bidtenderdetails.ascx" TagName="buyer_bidtenderdetails" TagPrefix="uc6" %>

<%--<%@ Register Src="../usercontrol/bids/biddetails_attachments.ascx" TagName="biddetails_attachments" TagPrefix="uc3" %>--%>
<%@ Register Src="../usercontrol/bids/biddetails_w_bidtenderdetails.ascx" TagName="biddetails_w_bidtenderdetails" TagPrefix="uc4" %>
<%@ Register Src="~/web/usercontrol/auctionvendor/vendor_attachment_download.ascx" TagName="vendor_attachment_download" TagPrefix="uc3" %>

<%@ Register Src="../usercontrol/bids/bidtenderdetails.ascx" TagName="bidtenderdetails" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/commentlist_tender.ascx" TagName="commentlist_tender" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/bids/biddetails_details.ascx" TagName="biddetails_details" TagPrefix="uc1" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopDate" Src="~/web/usercontrol/TopDate.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_TopNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_TopNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Vendor_LeftNav_Bids" Src="~/web/usercontrol/Vendor/Vendor_LeftNav_Bids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TendersCommentBox" Src="~/web/usercontrol/TendersCommentBox.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_v.css" />
    <script type="text/javascript" src="../include/customValidation.js"></script>
    <script type="text/javascript" src="../include/util.js"></script>
    <script type="text/javascript" src="../include/events.js"></script>
    <script type="text/javascript" src="../include/generalJSFunctions.js"></script>

    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body onload="FocusOn('dvBidTender_txtAmount');">
    <div align="left">
        <form runat="server" id="frmSubmitTender" defaultbutton="btnSubmit">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr>
                    <td valign="top" height="137px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <div align="left" id="masthead">
                                        <EBid:GlobalLinksNav ID="GlobalLinksNav" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:Vendor_TopNav_Bids runat="server" ID="Vendor_TopNav_Bids" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopDate runat="server" ID="TopDate" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <h2>
                                                    Bid Events</h2>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <EBid:Vendor_LeftNav_Bids runat="server" ID="Vendor_LeftNav_Bids" />
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
	                                        <td>
		                                        <h2>Comments</h2>
	                                        </td>
                                        </tr>
                                        <tr>
	                                        <td>
		                                        <uc2:commentlist_tender ID="Commentlist_tender1" runat="server" />
	                                        </td>
                                        </tr>
                                    </table>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table9">
                                        <tr>
                                            <td id="content0">
                                                <div align="left">
                                                    <h1>
                                                        <br />
                                                        Bid Tender Creation / Submission</h1>
                                                    <p>
                                                        Fill up the fields below then click <b>"Submit"</b> to submit your bid tender or <b>"Drafts"</b> to save and modify later.
                                                    </p>
                                                     <asp:Panel ID="pnlTenderDetails" runat="server" Width="100%" Visible="false">
                                                        <p>
                                                            <uc5:biditemdetails ID="Biditemdetails1" runat="server" />
                                                            <uc6:buyer_bidtenderdetails ID="Buyer_bidtenderdetails1" runat="server" />
                                                        </p> 
                                                   </asp:Panel>                                                    
                                                   <asp:Panel ID="pnlEditTenderDetails" runat="server" Width="100%" Visible="false"> 
                                                   <p> 
                                                        &nbsp;<uc2:bidtenderdetails ID="dvBidtenderdetails" runat="server" />     
                                                        <p>
                                                            <br />
                                                            <asp:DetailsView ID="dvBidTender" runat="server" AllowPaging="True" AutoGenerateRows="False" DataSourceID="dsTenderDetails" OnDataBound="dvBidTender_DataBound" SkinID="BidDetails" Width="100%">
                                                                <HeaderTemplate>
                                                                    SKU :
                                                                    <asp:Label ID="Label51" runat="server" Text='<%# Bind("SKU")%>'></asp:Label>
                                                                    &nbsp;-&nbsp;
                                                                    <asp:Label ID="lblItemDesc" runat="server" Text='<%#Bind("DetailDesc") %>'></asp:Label>
                                                                </HeaderTemplate>
                                                                <Fields>
                                                                    <asp:TemplateField>
                                                                        <HeaderStyle Height="20px" Width="120px" />
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl1" runat="server" Text="Quantity"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;&nbsp;<asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Qty")%>'></asp:Label>
                                                                            &nbsp;<asp:Label ID="lblUOM" runat="server" Text='<%# Bind("UnitOfMeasure")%>'></asp:Label>
                                                                            (s)
                                                                            <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Bind("Qty")%>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl2" runat="server" Text="Unit Price"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;
                                                                            <asp:TextBox ID="txtAmount" runat="server" MaxLength="15" Text='<%# GetWholeNumberPart(Eval("Amount").ToString()) %>' Width="100"></asp:TextBox>
                                                                            .
                                                                            <asp:TextBox ID="txtAmountCents" runat="server" MaxLength="2" Text='<%# GetDecimalPart(Eval("Amount").ToString()) %>' Width="20">00</asp:TextBox>
                                                                            <asp:CustomValidator ID="cvAmount" runat="server" ControlToValidate="txtAmount" ErrorMessage="* Required" Font-Bold="True" Font-Size="11px" OnServerValidate="cvAmount_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderStyle Height="20px" Width="120px" />
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl11" runat="server" Text="Sub Total Price"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:TextBox ID="txtSubTotalPrice" runat="server" BorderStyle="None" Font-Bold="true" Font-Size="14px" ForeColor="Black" onkeydown="return false;" onkeypress="return false;" onkeyup="return false;" ReadOnly="false" Style="cursor: default; padding-top: 3px;" TabIndex="-1" Width="200px">0.00</asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl3" runat="server" Text="Discount Per Unit Price"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;
                                                                            <asp:TextBox ID="txtDiscount" runat="server" MaxLength="15" Text='<%# GetWholeNumberPart(Eval("Discount").ToString()) %>' Width="100"></asp:TextBox>
                                                                            .
                                                                            <asp:TextBox ID="txtDiscountCents" runat="server" MaxLength="2" Text='<%# GetDecimalPart(Eval("Discount").ToString()) %>' Width="20"></asp:TextBox>
                                                                            <asp:CustomValidator ID="cvDiscount" runat="server" ErrorMessage="* Invalid input" Font-Bold="True" Font-Size="11px" OnServerValidate="cvDiscount_ServerValidate"></asp:CustomValidator>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl4" runat="server" Text="Delivery Cost"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;
                                                                            <asp:TextBox ID="txtDeliveryCost" runat="server" MaxLength="15" Text='<%# GetWholeNumberPart(Eval("DeliveryCost").ToString())%>' Width="100"></asp:TextBox>
                                                                            .
                                                                            <asp:TextBox ID="txtDeliveryCostCents" runat="server" MaxLength="2" Text='<%# GetDecimalPart(Eval("DeliveryCost").ToString()) %>' Width="20"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderStyle Height="20px" Width="120px" />
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl5" runat="server" Text="Total Bid Tender Price"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:TextBox ID="txtTotalBidTenderPrice" runat="server" BorderStyle="None" Font-Bold="true" Font-Size="14px" ForeColor="Black" onkeydown="return false;" onkeypress="return false;" onkeyup="return false;" ReadOnly="false" Style="cursor: default; padding-top: 3px;" TabIndex="-1" Width="250px">0.00</asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl9" runat="server" Text="Warranty"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:TextBox ID="txtWarranty" runat="server" MaxLength="50" Text='<%# Bind("Warranty")%>' Width="200px"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="rfvWarranty" runat="server" ControlToValidate="txtWarranty" ErrorMessage="* Required" Font-Bold="True" Font-Size="11px" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            &nbsp;
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            &nbsp;<asp:Label ID="lbl10" runat="server" Text="Remarks"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle BackColor="White" />
                                                                        <ItemTemplate>
                                                                            &nbsp;<asp:TextBox ID="txtRemarks" runat="server" MaxLength="250" Text='<%# Bind("Remarks")%>' Width="200px"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Fields>
                                                                <FooterStyle BackColor="White" />
                                                                <FooterTemplate>
                                                                    <%--<center><asp:Label ID="lblMessage" runat="server" Font-Size="11px" ForeColor="red"></asp:Label></center>--%>
                                                                </FooterTemplate>
                                                                <PagerSettings Visible="False" />
                                                                <HeaderStyle BackColor="#10659E" Font-Bold="True" ForeColor="White" Width="120px" />
                                                            </asp:DetailsView>
                                                            <asp:SqlDataSource ID="dsTenderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetBidTenderDetails" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="BidTenderNo" SessionField="BIDTENDERNO" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <asp:SqlDataSource ID="dsIncoterm" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="s3p_EBid_GetIncoterm1" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            <asp:SqlDataSource ID="dsCurrencies" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetCurrencies" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                            <br />
                                                            <asp:SqlDataSource ID="dsFileAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetVendorBidEventFileAttachments" SelectCommandType="StoredProcedure">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="BidRefNo" SessionField="BidRefNo" Type="Int32" />
                                                                    <asp:SessionParameter DefaultValue="0" Name="VendorId" SessionField="UserId" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                            <asp:GridView ID="gvFileAttachment" runat="server" AutoGenerateColumns="false" CssClass="itemDetails_1" OnRowCommand="gvFileAttachment_RowCommand" ShowFooter="true">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="&nbsp;Bid Tender File Attachments">
                                                                        <ItemStyle CssClass="valueGridItem" Width="100%" />
                                                                        <HeaderStyle CssClass="itemDetails_th" />
                                                                        <ItemTemplate>
                                                                            <asp:Literal ID="litAttach" runat="server" Text="&nbsp;" Visible='<%# IsAttached(Eval("Attached").ToString()) %>' />
                                                                            <asp:Image ID="imgAttach" runat="server" Height="10px" ImageUrl="~/web/images/paperclip.gif" Visible='<%# IsAttached(Eval("Attached").ToString()) %>' Width="10px" />
                                                                            <asp:LinkButton ID="lnkRemoveAttachment" runat="server" ForeColor="red" Font-Bold="true" CommandName="Remove" CommandArgument='<% #Bind("ID")%>' Visible='<%# (IsRemovable(Eval("Attached").ToString(), Eval("IsDetachable").ToString())) && (IsUpdatedAttachment(Eval("Actual").ToString()))  %>' CausesValidation="false">Remove</asp:LinkButton>
                                                                            <asp:Label ID="lblColon" runat="server" Text=":" Visible='<%# (IsRemovable(Eval("Attached").ToString(), Eval("IsDetachable").ToString())) && (IsNotForClarification())%>'></asp:Label>
                                                                            <asp:LinkButton ID="lnkFile" runat="server" CommandArgument='<%#Bind("FileAttachment") %>' CommandName="Download" Text='<% #Bind("Original", "{0}")%>' Visible='<%# IsAttached(Eval("Attached").ToString()) %>'></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate>
                                                                            <p style="color: Red;">
                                                                                &nbsp;<asp:FileUpload ID="fileUpload" runat="server" Width="330px" />
                                                                                <br />
                                                                                &nbsp;&nbsp;(Maximum File Size:&nbsp;<asp:Label ID="lblMaxFileSize" runat="server" Text="<%$ AppSettings:MaxFileSize %>"></asp:Label>
                                                                                KB)<br /> &nbsp;&nbsp;<asp:LinkButton ID="lnkAttach" runat="server" CausesValidation="false" CommandName="Attach">Add To Attachments List</asp:LinkButton>
                                                                                <asp:Literal ID="addAttachmentMsg" runat="server"></asp:Literal>
                                                                            </p>
                                                                        </FooterTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:Label ID="litMsg" runat="server" Font-Names="Arial" Font-Size="11px" ForeColor="Red"></asp:Label>
                                                        </p>
                                                        <p>
                                                        </p>
                                                        <p>
                                                        </p>
                                                        <p>
                                                        </p>
                                                        <p>
                                                        </p>
                                                        <p>
                                                        </p>
                                                        <p>
                                                        </p>
                                                        <p>
                                                        </p>
                                                    </p>
                                                    </asp:Panel>
                                                    <p style="text-align: center;">                                                        
                                                        Comment<br />
                                                        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Width="360px" Height="90px"
                                                            Font-Names="Arial" MaxLength="999"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfvComment" Enabled="false" runat="server" Display="Dynamic" ErrorMessage="<br />Include a comment please."
                                                            ControlToValidate="txtComment" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                        <br />
                                                    </p>
                                                    <asp:Literal ID="litErrMsg" runat="server"></asp:Literal><br />                                                    
                                                    <div>
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton runat="server" ID="btnDraft" OnClick="btnDraft_Click"  OnClientClick="return confirm('Are you sure you want to save this tender as Draft?');">Draft </asp:LinkButton>
                                                                    <asp:LinkButton runat="server" ID="btnSubmit" OnClick="btnSubmit_Click">Submit</asp:LinkButton>
                                                                    <asp:LinkButton runat="server" ID="btnCancel" OnClick="btnCancel_Click" CausesValidation="false">Cancel</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                        <br />
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td id="footer" height="50px">
                        <EBid:Footer runat="server" ID="Footer" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
