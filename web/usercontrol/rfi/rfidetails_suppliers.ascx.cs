using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EBid.lib;
using EBid.lib.constant;
//using ICSharpCode.SharpZipLib.Zip;
using System.IO;

public partial class web_usercontrol_rfi_rfidetails_suppliers : System.Web.UI.UserControl
{
    public int prev_vendor_id = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
		gvInvitedSuppliers.DataBind();
    }

    public void gvInvitedSuppliers_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int status = Int32.Parse(gvInvitedSuppliers.DataKeys[e.Row.RowIndex].Values[1].ToString());
            if (status > 0)
            {
                e.Row.Cells[2].Text = "with RFI tenders";
            }
            else if (status == 0)
            {
                e.Row.Cells[2].Text = "no remarks";
            }

            if (gvInvitedSuppliers.DataKeys[e.Row.RowIndex].Values[2].ToString() == "")
                e.Row.Cells[3].Text = "&nbsp;&nbsp;No Attachment";

            if (Int32.Parse(prev_vendor_id.ToString()) == Int32.Parse(gvInvitedSuppliers.DataKeys[e.Row.RowIndex].Values[0].ToString()))
            {

                e.Row.Cells[0].Text = "&nbsp;";
                e.Row.Cells[1].Text = "&nbsp;";
                e.Row.Cells[2].Text = "&nbsp;";
            }

            prev_vendor_id = Int32.Parse(gvInvitedSuppliers.DataKeys[e.Row.RowIndex].Values[0].ToString());
        }
    }

    protected void gvFileAttachments_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Download":
                {
                    string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                    string path = Constant.FILEATTACHMENTSFOLDERDIR;
                    string[] folder = args[0].Split(new char[] { '_' });
                    path = path + folder[1].ToString() + '\\' + folder[2].ToString() + '\\';
                    FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                } break;
        }
    }

    //protected void lnkDownloadAll_Click(object sender, EventArgs e)
    //{
        //string path = Constant.FILEATTACHMENTSFOLDERDIR;
        //byte[] buffer = new byte[4096];
        //var tempFileName = Server.MapPath(@"temp/" + Guid.NewGuid().ToString() + ".zip");

        //var zipOutputStream = new ZipOutputStream(File.Create(tempFileName));
        //var fileName = String.Empty;
        //var readBytes = 0;

        //foreach (GridViewRow row in gvInvitedSuppliers.Rows)
        //{
        //    var isChecked = (row.FindControl("cbAttachment") as CheckBox).Checked;
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

        //    zipOutputStream.Finish();
        //    zipOutputStream.Close();

        //    Response.ContentType = "application/x-zip-compressed";
        //    Response.AppendHeader("Content-Disposition", "attachment; filename=YourFile.zip");
        //    Response.WriteFile(tempFileName);

        //    Response.Flush();
        //    Response.Close();

        //    //Deletes the Temp File
        //    if (File.Exists(tempFileName))
        //        File.Delete(tempFileName);
    //}

    protected void lnkDownloadAll_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.BufferOutput = false;
        Response.ContentType = "application/zip";
        Response.AddHeader("content-disposition", "attachment; filename=RfiRefNo_" + Session["RfiRefNo"].ToString() + ".zip"); // File name of a zip file

        using (Ionic.Zip.ZipFile zip = new Ionic.Zip.ZipFile())
        {
            string fileNameActual = String.Empty;
            string fileNameOrig = String.Empty;
            string vendorName = String.Empty;
            string path2tmp = String.Empty;
			int i = 0;
            foreach (GridViewRow row1 in gvInvitedSuppliers.Rows)
            {
                if (row1.FindControl("lnkDownload") != null && row1.FindControl("txtFileAttachment") != null)
                {
                    vendorName = (row1.FindControl("txtVendorNme") as HiddenField).Value.ToString().Replace("'","").Replace(","," ").Replace("."," ");
                    fileNameActual = (row1.FindControl("lnkDownload") as LinkButton).Text;
                    path2tmp = (row1.FindControl("txtFileAttachment") as HiddenField).Value.ToString();
                    string[] args = path2tmp.Split(new char[] { '|' });
                    string path = Constant.FILEATTACHMENTSFOLDERDIR;
                    string[] folder = args[0].Split(new char[] { '_' });
                    //path = path + folder[1].ToString() + '\\' + folder[2].ToString() + '\\';
                    //fileNameActual = path + args[0];
                    ////fileNameOrig = folder[1].ToString() + '\\' + args[1];
                    //fileNameOrig = vendorName + '\\' + args[1];
                    //if (File.Exists(fileNameActual))
                    //{
                    //    zip.AddFile(fileNameActual).FileName = fileNameOrig;
                    //}
					path = path + folder[1].ToString() + '\\' + folder[2].ToString() + '\\';
                    fileNameActual = path + args[0];
                    //fileNameOrig = folder[1].ToString() + '\\' + args[1];
                    fileNameOrig = i.ToString() + "_" + vendorName + "_" + args[1];
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