using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.IO;
using EBid.lib;
using EBid.lib.constant;
using Ionic.Zip;

public partial class web_usercontrol_bids_bidtender_attachments1 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gvFileAttachments_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Download":
                {
                    string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                    string path = Constant.FILEATTACHMENTSFOLDERDIR + Session["TVendorId"].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\";
                    //string path = Constant.FILEATTACHMENTSFOLDERDIR +  "\\";
                    FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                } break;
        }
    }



    protected void lnkDownloadAll_Click(object sender, EventArgs e)
    {
        
        Response.Clear();
        Response.BufferOutput = false;
        Response.ContentType = "application/zip";
        Response.AddHeader("content-disposition", "attachment; filename=BidRefNo_" + Session["BidRefNo"].ToString()+"_"+Session["TVendorId"].ToString() + ".zip"); // File name of a zip file

        using (Ionic.Zip.ZipFile zip = new Ionic.Zip.ZipFile())
        {
            string fileNameActual = String.Empty;
            string fileNameOrig = String.Empty;
            string vendorName = String.Empty;
            string path2tmp = String.Empty;
	    int i = 0;
            foreach (GridViewRow row1 in gvFileAttachments.Rows)
            {
                if (row1.FindControl("lnkDownload") != null && row1.FindControl("txtFileAttachment") != null)
                {
                    vendorName = Session["TVendorId"].ToString();
                    fileNameActual = (row1.FindControl("lnkDownload") as LinkButton).Text;
                    path2tmp = (row1.FindControl("txtFileAttachment") as HiddenField).Value.ToString();
                    string[] args = path2tmp.Split(new char[] { '|' });
                    string path = Constant.FILEATTACHMENTSFOLDERDIR;
                    string[] folder = args[0].Split(new char[] { '_' });
                    path = path + folder[1].ToString() + '\\' + folder[2].ToString() + '\\';
                    fileNameActual = path + args[0];
                    //fileNameOrig = folder[1].ToString() + '\\' + args[1];
                    fileNameOrig =  i.ToString()+"_"+args[1];
                    if (File.Exists(fileNameActual))
                    {
                        zip.AddFile(fileNameActual).FileName = fileNameOrig;
                    }
		i++;
                }
            }
            zip.Save(Response.OutputStream);
        }

        Response.Close();
    }
}
