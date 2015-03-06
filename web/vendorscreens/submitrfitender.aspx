<%@ Page Language="C#" AutoEventWireup="true" CodeFile="submitrfitender.aspx.cs" Inherits="web_vendorscreens_submitrfitender" %>

<%@ Register Src="../usercontrol/rfi/rfidetails_attachments.ascx" TagName="rfidetails_attachments" TagPrefix="uc3" %>
<%@ Register Src="../usercontrol/commentlist_tender.ascx" TagName="commentlist_tender" TagPrefix="uc2" %>
<%@ Register Src="../usercontrol/rfi/rfidetails_details.ascx" TagName="rfidetails_details" TagPrefix="uc1" %>
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
</head>
<body onload="FocusOn('dvRfiTender_txtAmount');">
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
                                                    RFI Event</h2>
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
                                                <h2>
                                                    Comments</h2>
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
                                                        RFI Tender Creation / Submission</h1>
                                                    <p>
                                                        Fill up the fields below then click <b>"Submit"</b> to submit your RFI tender.</p>
                                                    <div>
                                                        <uc1:rfidetails_details ID="ctrlrfiDetails" runat="server" />
                                                    </div>
                                                    <div>
                                                        <uc3:rfidetails_attachments ID="Rfidetails_attachments1" runat="server" />
                                                    </div>
                                                    <br />
                                                    <div>
                                                        <asp:GridView AutoGenerateColumns="False" runat="server" ID="gvRfiItemDetails" SkinID="AuctionedItems" DataSourceID="dsItemDetails" Width="100%" DataKeyNames="RfiDetailNo,Qty,Item,DetailDesc,UnitOfMeasure,RfiTenderNo"
                                                            OnSelectedIndexChanged="gvRfiItemDetails_SelectedIndexChanged">
                                                            <SelectedRowStyle BackColor="#50A4D1" ForeColor="White" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="SKU">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server" ID="lblItem" Text='<%#Bind("Item") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="60px" HorizontalAlign="Center" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Description">
                                                                    <ItemTemplate>
                                                                        &nbsp;<asp:Label runat="server" ID="lblDescription" Text='<%#Bind("DetailDesc") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Quantity">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server" ID="lblQuantity" Text='<%#Bind("Qty") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="90px" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Unit Of Measure">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server" ID="lblUnitOfMeasure" Text='<%#Bind("UnitOfMeasure") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Delivery Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label runat="server" ID="lblDeliveryDate" Text='<%#Bind("DeliveryDate", "{0:D}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="170px" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Task">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Select" Visible='<%# ((!isConverted(Eval("ConversionStatus"))) && (!isWithdrawn(Eval("WithdrawalStatus")))) %>' CausesValidation='false'>
                                                                        Add/Edit Tender</asp:LinkButton>
                                                                        <asp:Label runat="server" ID="lblConverted" Text='Item Has Been Converted' Visible='<%# isConverted(Eval("ConversionStatus")) %>'></asp:Label>
                                                                        <asp:Label runat="server" ID="lblWithdrawn" Text='Item Has Been Withdrawn' Visible='<%# isWithdrawn(Eval("WithdrawalStatus")) %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="dsItemDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetRfiItemAndRfiTenderDetails" SelectCommandType="StoredProcedure">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="RfiRefNo" SessionField="RfiRefNo" Type="Int32" />
                                                                <asp:SessionParameter Name="VendorId" SessionField="UserId" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </div>
                                                    <br />
                                                    <div>
                                                        <asp:DetailsView ID="dvRfiTender" runat="server" Height="50px" Width="100%" AutoGenerateRows="False" AllowPaging="True" Font-Names="Arial" Font-Size="11px" CssClass="itemDetails" HeaderText="Details" HeaderStyle-BackColor="#10659E"
                                                            HeaderStyle-ForeColor="white" HeaderStyle-Font-Bold="true" HeaderStyle-Width="120px" OnItemCommand="dvRfiTender_ItemCommand" OnDataBound="dvRfiTender_DataBound">
                                                            <HeaderTemplate>
                                                                SKU :
                                                                <asp:Label ID="Label51" runat="server" Text='<%# Bind("SKU")%>'></asp:Label>&nbsp;-&nbsp;
                                                                <asp:Label runat="server" ID="lblItemDesc" Text='<%#Bind("Description") %>'></asp:Label>
                                                            </HeaderTemplate>
                                                            <Fields>
                                                                <asp:TemplateField>
                                                                    <HeaderStyle Width="120px" Height="20px" />
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl1" runat="server" Text="Quantity"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;&nbsp;<asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity")%>'></asp:Label>
                                                                        &nbsp;<asp:Label ID="lblUOM" runat="server" Text='<%# Bind("UnitOfMeasure")%>'></asp:Label>(s)
                                                                        <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Bind("Quantity")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl2" runat="server" Text="Unit Price"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;
                                                                        <asp:TextBox runat="server" ID="txtAmount" Width="100" MaxLength="15" Text='<%# GetWholeNumberPart(Eval("Amount").ToString()) %>'></asp:TextBox>.
                                                                        <asp:TextBox runat="server" ID="txtAmountCents" Width="20" MaxLength="2" Text='<%# GetDecimalPart(Eval("Amount").ToString()) %>'></asp:TextBox><asp:Label ID="lblAmount" runat="server" Text="" ForeColor="Red" Font-Bold Font-Size="11px"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderStyle Width="120px" Height="20px" />
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl11" runat="server" Text="Sub Total Price"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;<asp:TextBox runat="server" ID="txtSubTotalPrice" Width="200px" ReadOnly="false" TabIndex="-1" BorderStyle="None" Font-Size="14px" Font-Bold="true" ForeColor="Black" onkeypress="return false;" onkeydown="return false;"
                                                                            onkeyup="return false;" Style="cursor: default; padding-top: 3px;">0.00</asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl3" runat="server" Text="Discount Per Unit Price"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;
                                                                        <asp:TextBox runat="server" ID="txtDiscount" Width="100" MaxLength="15" Text='<%# GetWholeNumberPart(Eval("Discount").ToString()) %>'></asp:TextBox>.
                                                                        <asp:TextBox runat="server" ID="txtDiscountCents" Width="20" MaxLength="2" Text='<%# GetDecimalPart(Eval("Discount").ToString()) %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl4" runat="server" Text="Delivery Cost"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;
                                                                        <asp:TextBox runat="server" ID="txtDeliveryCost" Width="100" MaxLength="15" Text='<%# GetWholeNumberPart(Eval("DeliveryCost").ToString())%>'></asp:TextBox>.
                                                                        <asp:TextBox runat="server" ID="txtDeliveryCostCents" Width="20" MaxLength="2" Text='<%# GetDecimalPart(Eval("DeliveryCost").ToString()) %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderStyle Width="120px" Height="20px" />
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl5" runat="server" Text="Total RFI Tender Price"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;<asp:TextBox runat="server" ID="txtTotalRfiTenderPrice" Width="250px" ReadOnly="false" TabIndex="-1" BorderStyle="None" Font-Size="14px" Font-Bold="true" ForeColor="Black" onkeypress="return false;"
                                                                            onkeydown="return false;" onkeyup="return false;" Style="cursor: default; padding-top: 3px;">0.00</asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl9" runat="server" Text="Warranty"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;<asp:TextBox ID="txtWarranty" runat="server" Text='<%# Bind("Warranty")%>' Width="200px" MaxLength="50"></asp:TextBox><asp:Label ID="lblWarranty" runat="server" Text="" ForeColor="Red" Font-Bold Font-Size="11px"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lbl10" runat="server" Text="Remarks"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;<asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks")%>' Width="200px" MaxLength="250"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField>
                                                                    <HeaderTemplate>
                                                                        &nbsp;<asp:Label ID="lblComments" runat="server" Text="Comments"></asp:Label>
                                                                    </HeaderTemplate>
                                                                    <ItemStyle BackColor="White" />
                                                                    <ItemTemplate>
                                                                        &nbsp;<asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Width="360px" Height="90px" Font-Names="Arial" MaxLength="999" Text='<%# Bind("Comment")%>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Fields>
                                                            <FooterStyle BackColor="White" />
                                                            <FooterTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Save" CausesValidation="false" BackColor="#990000" Width="88px" ForeColor="white" Font-Bold >Save Changes</asp:LinkButton>
                                                            </FooterTemplate>
                                                            <PagerSettings Visible="False" />
                                                            <HeaderStyle BackColor="#10659E" Font-Bold="True" ForeColor="White" Width="120px" />
                                                        </asp:DetailsView>
                                                    </div>
                                                    <asp:Literal ID="litMsg" runat="server"></asp:Literal>
                                                        <asp:SqlDataSource ID="dsFileAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>" SelectCommand="sp_GetVendorRfiEventFileAttachments" SelectCommandType="StoredProcedure">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="RfiRefNo" SessionField="RfiRefNo" Type="Int32" />
                                                                <asp:SessionParameter DefaultValue="0" Name="VendorId" SessionField="UserId" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:GridView ID="gvFileAttachment" runat="server" CssClass="itemDetails_1" AutoGenerateColumns="false" ShowFooter="true" OnRowCommand="gvFileAttachment_RowCommand" OnRowDataBound="gvFileAttachment_RowDataBound">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="&nbsp;RFI Tender File Attachments">
                                                                    <ItemStyle CssClass="valueGridItem" Width="100%" />
                                                                    <HeaderStyle CssClass="itemDetails_th" />
                                                                    <ItemTemplate>
                                                                        <asp:Literal ID="litAttach" runat="server" Text="&nbsp;" Visible='<%# IsAttached(Eval("Attached").ToString()) %>' />
                                                                        <asp:Image ID="imgAttach" runat="server" ImageUrl="~/web/images/paperclip.gif" Width="10px" Height="10px" Visible='<%# IsAttached(Eval("Attached").ToString()) %>' />
                                                                        <asp:LinkButton ID="lnkRemoveAttachment" runat="server" ForeColor="red" Font-Bold="true" CommandName="Remove" CommandArgument='<% #Bind("ID")%>' Visible='<%# IsRemovable(Eval("Attached").ToString(), Eval("IsDetachable").ToString()) %>' CausesValidation="false">Remove</asp:LinkButton>
                                                                        <asp:Label ID="lblColon" runat="server" Text=":" Visible='<%# IsRemovable(Eval("Attached").ToString(), Eval("IsDetachable").ToString()) %>' ></asp:Label>
                                                                        <asp:LinkButton ID="lnkFile" runat="server" CommandName="Download" CommandArgument='<%#Bind("FileAttachment") %>' Text='<% #Bind("Original", "{0}")%>' Visible='<%# IsAttached(Eval("Attached").ToString()) %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <p style="color: Red;">
                                                                            &nbsp;<asp:FileUpload ID="fileUpload" runat="server" Width="330px" /><br />
                                                                            &nbsp;&nbsp;(Maximum File Size:&nbsp;<asp:Label ID="lblMaxFileSize" runat="server" Text='<%$ AppSettings:MaxFileSize %>'></asp:Label>
                                                                            KB)<br />
                                                                            &nbsp;&nbsp;<asp:LinkButton ID="lnkAttach" runat="server" CausesValidation="false" CommandName="Attach">Add To Attachments List</asp:LinkButton>
                                                                            <asp:Literal ID="addAttachmentMsg" runat="server"></asp:Literal>
                                                                        </p>
                                                                    </FooterTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    <p style="text-align: center; ">
                                                        <asp:CustomValidator ID="cvCheckRfiTender" runat="server" Display="Dynamic" ErrorMessage="<br />There are no RFI tender(s) to submit. Please click Cancel button." OnServerValidate="cvCheckRfiTender_ServerValidate"></asp:CustomValidator><br />
                                                        <asp:Literal ID="litErrMsg" runat="server"></asp:Literal>
                                                    </p>
                                                    <div>
                                                        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton runat="server" ID="btnSubmit" OnClick="btnSubmit_Click" OnClientClick="return confirm('Are you sure you want to submit your RFI tender(s)?');">Submit</asp:LinkButton>
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
