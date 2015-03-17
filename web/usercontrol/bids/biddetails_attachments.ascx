<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_bids_biddetails_attachments, App_Web_biddetails_attachments.ascx.712a9dd6" %>
<%@ Import Namespace="System"  %>
<%@ Import Namespace="System.Data"  %>
<%@ Import Namespace="System.Configuration"  %>
<%@ Import Namespace="System.Collections"  %>
<%@ Import Namespace="System.Web"  %>
<%@ Import Namespace="System.Web.Security"  %>
<%@ Import Namespace="System.Web.UI.WebControls"  %>
<%@ Import Namespace="System.Web.UI.WebControls.WebParts"  %>
<%@ Import Namespace="System.Web.UI.HtmlControls"  %>
<%@ Import Namespace="System.Web.UI"  %>
<%@ Import Namespace="System.IO"  %>
<%@ Import Namespace="EBid.lib"  %>
<%@ Import Namespace="EBid.lib.constant"  %>
<%@ Import Namespace="ICSharpCode.SharpZipLib.Zip"  %>
<script  runat="server">
    protected void gvFileAttachments_DataBound(Object sender, EventArgs e)
    {
        if(gvFileAttachments.Rows.Count == 0)
        {
            lnkDownloadAll.Visible = false;
        }
    }

    protected void gvFileAttachments_RowCommand2(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Download":
                {
                    if (Session["ViewOption"] != null)
                    {
                        if (Session["ViewOption"].ToString() == "AsBuyer")
                        {
                            string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                            string path = Constant.FILEATTACHMENTSFOLDERDIR;
                            FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                        }
                        else if (Session["ViewOption"].ToString() == "AsVendor")
                        {
                            string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                            string path = Constant.FILEATTACHMENTSFOLDERDIR + Session["TVendorId"].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\";
                            FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                        }
                    }
                    else
                    {
                        string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                        string path = Constant.FILEATTACHMENTSFOLDERDIR;
                        FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                    }
               
                } break;
        }
    }

    
    protected void lnkDownloadAll_Click2(object sender, EventArgs e)
    {
        Response.Clear();
        Response.BufferOutput = false;
        Response.ContentType = "application/zip";
        Response.AddHeader("content-disposition", "attachment; filename=BidRefNo_" + Session["BidRefNo"].ToString()+ ".zip"); // File name of a zip file

        using (Ionic.Zip.ZipFile zip = new Ionic.Zip.ZipFile())
        {
            string fileNameActual = String.Empty;
            string fileNameOrig = String.Empty;
            string vendorName = String.Empty;
            string path2tmp = String.Empty;
            foreach (GridViewRow row1 in gvFileAttachments.Rows)
            {
                if (row1.FindControl("lnkDownload") != null && row1.FindControl("txtFileAttachment") != null)
                {
                    //vendorName = Session["TVendorId"].ToString();
                    fileNameActual = (row1.FindControl("lnkDownload") as LinkButton).Text;
                    path2tmp = (row1.FindControl("txtFileAttachment") as HiddenField).Value.ToString();
                    string[] args = path2tmp.Split(new char[] { '|' });
                    string path = Constant.FILEATTACHMENTSFOLDERDIR;
                    string[] folder = args[0].Split(new char[] { '_' });
                    //path = path + folder[1].ToString() + '\\' + folder[2].ToString() + '\\';
                    path = path + '\\';
                    fileNameActual = path + args[0];
                    //fileNameOrig = folder[1].ToString() + '\\' + args[1];
                    fileNameOrig =  args[1];
                    if (File.Exists(fileNameActual))
                    {
                        zip.AddFile(fileNameActual).FileName = fileNameOrig;
                    }
                }
            }
            zip.Save(Response.OutputStream);
        }

        Response.Flush();
		Response.End();
    }

</script>




<div align="left">
    <asp:GridView AutoGenerateColumns="False" runat="server" ID="gvFileAttachments" CssClass="itemDetails" 
        DataSourceID="dsAttachments" OnRowCommand="gvFileAttachments_RowCommand2" SkinID="AuctionedItems"
        EmptyDataText="No Attachments" OnDataBound="gvFileAttachments_DataBound">         
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
        SelectCommand="sp_GetBidEventFileAttachments" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="BidRefNo" SessionField="BidRefNo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:LinkButton ID="lnkDownloadAll" runat="server" Width="160px" 
        onclick="lnkDownloadAll_Click2">Download All Attachments</asp:LinkButton>
</div>
