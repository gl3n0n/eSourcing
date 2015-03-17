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
//using ICSharpCode.SharpZipLib.Zip;
using Ionic.Zip;

public partial class web_usercontrol_rfi_rfidetails_attachments : System.Web.UI.UserControl
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
                            string path = Constant.FILEATTACHMENTSFOLDERDIR + Session["TVendorId"].ToString() + "\\" + Session["RfiRefNo"].ToString() + "\\";
                            FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                        }
                    }

                } break;
        }
    }

    //protected void lnkDownloadAll_Click(object sender, EventArgs e)
    //{
    //    if (Session["ViewOption"] != null)
    //    {
    //        if (Session["ViewOption"] == "AsBuyer")
    //        {
    //            string path = Constant.FILEATTACHMENTSFOLDERDIR;
    //            ZipAllFiles(path);
    //        }
    //        else if (Session["ViewOption"] == "AsVendor")
    //        {
    //            string path = Constant.FILEATTACHMENTSFOLDERDIR + Session["TVendorId"].ToString() + "\\"
    //                            + Session["RfiRefNo"].ToString() + "\\";
    //            ZipAllFiles(path);
    //        }
    //    }
    //}

    ///<summary>
    /// By: Edrick Tan 11/21/2012
    ///</summary>
    private void ZipAllFiles(string path)
    {
        //byte[] buffer = new byte[4096];
        //var tempFileName = Server.MapPath(@"temp/" + Guid.NewGuid().ToString() + ".zip");

        //var zipOutputStream = new ZipOutputStream(File.Create(tempFileName));
        //var fileName = String.Empty;
        //var readBytes = 0;

        //foreach (GridViewRow row in gvFileAttachments.Rows)
        //{
        //    var isChecked = (row.FindControl("cbFile") as CheckBox).Checked;
        //    if (!isChecked) continue;
        //    fileName = (row.FindControl("lnkDownload") as LinkButton).Text;

        //    var zipEntry = new ZipEntry(fileName);
        //    zipOutputStream.PutNextEntry(zipEntry);

        //    using (var fs = File.OpenRead(path))
        //    {
        //        do
        //        {
        //            readBytes = fs.Read(buffer, 0, buffer.Length);
        //            zipOutputStream.Write(buffer, 0, readBytes);
        //        } while (readBytes > 0);
        //    }
        //}
        //zipOutputStream.Finish();
        //zipOutputStream.Close();

        //Response.ContentType = "application/x-zip-compressed";
        //Response.AppendHeader("Content-Disposition", "attachment; filename=YourFile.zip");
        //Response.WriteFile(tempFileName);

        //Response.Flush();
        //Response.Close();

        //// Deletes the Temp File
        //if (File.Exists(tempFileName))
        //    File.Delete(tempFileName);
    }

    protected void lnkDownloadAll_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.BufferOutput = false;
        Response.ContentType = "application/zip";
        Response.AddHeader("content-disposition", "attachment; filename=RfiRefNo_" + Session["RfiRefNo"].ToString()+ ".zip"); // File name of a zip file

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

        Response.Close();
    }

}