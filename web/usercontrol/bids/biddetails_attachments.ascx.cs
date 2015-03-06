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
using System.Linq;
using System.Xml.Linq;
using EBid.lib;
using EBid.lib.constant;
using ICSharpCode.SharpZipLib.Zip;

public partial class web_usercontrol_bids_biddetails_attachments : System.Web.UI.UserControl
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
                    if (Session["ViewOption"] != null)
                    {
                        if (Session["ViewOption"] == "AsBuyer")
                        {
                            string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                            string path = Constant.FILEATTACHMENTSFOLDERDIR;
                            FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                        }
                        else if (Session["ViewOption"] == "AsVendor")
                        {
                            string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                            string path = Constant.FILEATTACHMENTSFOLDERDIR + Session["TVendorId"].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\";
                            FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                        }
                    }
               
                } break;
        }
    }

    protected void lnkDownloadAll_Click(object sender, EventArgs e)
    {
        if (Session["ViewOption"] != null)
        {
            if (Session["ViewOption"] == "AsBuyer")
            {
                string path = Constant.FILEATTACHMENTSFOLDERDIR;
                ZipAllFiles(path);
            }
            else if (Session["ViewOption"] == "AsVendor")
            {
                string path = Constant.FILEATTACHMENTSFOLDERDIR + Session["TVendorId"].ToString() + "\\"
                                + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\";
                ZipAllFiles(path);
            }
        }
    }

    ///<summary>
    /// By: Edrick Tan 11/21/2012
    ///</summary>
    private void ZipAllFiles(string path)
    {
        byte[] buffer = new byte[4096];
        var tempFileName = Server.MapPath(@"temp/" + Guid.NewGuid().ToString() + ".zip");

        var zipOutputStream = new ZipOutputStream(File.Create(tempFileName));
        var fileName = String.Empty;
        var readBytes = 0;

        foreach (GridViewRow row in gvFileAttachments.Rows)
        {
            var isChecked = (row.FindControl("cbFile") as CheckBox).Checked;
            if (!isChecked) continue;
            fileName = (row.FindControl("lnkDownload") as LinkButton).Text;
            if(fileName.ToString()!=""){
            var zipEntry = new ZipEntry(fileName);
            zipOutputStream.PutNextEntry(zipEntry);

            using (var fs = File.OpenRead(path))
            {
                do
                {
                    readBytes = fs.Read(buffer, 0, buffer.Length);
                    zipOutputStream.Write(buffer, 0, readBytes);
                } while (readBytes > 0);
            }

        }
        zipOutputStream.Finish();
        zipOutputStream.Close();

        Response.ContentType = "application/x-zip-compressed";
        Response.AppendHeader("Content-Disposition", "attachment; filename=YourFile.zip");
        Response.WriteFile(tempFileName);

        Response.Flush();
        Response.Close();

        // Deletes the Temp File
        if (File.Exists(tempFileName))
            File.Delete(tempFileName);
    }
}
}
