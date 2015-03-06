﻿using System;
using System.Collections;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EBid.lib.bid.trans;
using EBid.lib.bid.data;
using EBid.lib.constant;
using EBid.lib;
using System.IO;
using System.IO.Compression;
using System.Xml;
using System.Text;
using CalendarControl;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class web_usercontrol_bac_bac_basisForAwarding : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // force to show attachment
        if (Request.Params["ShowAttachment"] is object)
        {
            string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
            string sCommand, sContentType;
            SqlDataReader oReader;

            //addAttachmentMsg.Text = "";

            sCommand = "SELECT * FROM tblBACSupportingDocuments WHERE FileUploadID=" + Request.Params["ShowAttachment"];
            oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
            if (oReader.HasRows)
            {
                oReader.Read();
                sCommand = (string)oReader["ActualFileName"];
                sContentType = (string)oReader["ContentType"];
                string myBuyerID = (string)oReader["BuyerID"].ToString();
                FileInfo OrigFile = new FileInfo(Constant.FILEATTACHMENTSFOLDERDIR + myBuyerID + "\\BAC\\" + sCommand);
                FileInfo GZFile = new FileInfo(Constant.FILEATTACHMENTSFOLDERDIR + myBuyerID + "\\BAC\\" + sCommand + ".gz");
                if (GZFile.Exists)
                {
                    try
                    {
                        Decompress(GZFile);
                        //Response.Redirect("../../web/fileattachments/" + myBuyerID + "/BAC/" + sCommand);
                        Response.Clear();
                        Response.ContentType = sContentType;
                        Response.AppendHeader("Content-Disposition", "attachment; filename=" + OrigFile.ToString());
                        Response.TransmitFile(OrigFile.ToString(), 0, OrigFile.Length);
                        //File.Delete(Constant.FILEATTACHMENTSFOLDERDIR + myBuyerID + "\\BAC\\" + sCommand);
                        Response.Flush();
                        Response.End();
                    }
                    finally
                    {
                        File.Delete(Constant.FILEATTACHMENTSFOLDERDIR + myBuyerID + "\\BAC\\" + sCommand);
                    }
                }
            }
        }
        count_attachements();

    }
    public static void Decompress(FileInfo fi)
    {
        // Get the stream of the source file.
        using (FileStream inFile = fi.OpenRead())
        {
            // Get original file extension, for example
            // "doc" from report.doc.gz.
            string curFile = fi.FullName;
            string origName = curFile.Remove(curFile.Length - fi.Extension.Length);

            //Create the decompressed file.
            using (FileStream outFile = File.Create(origName))
            {
                using (GZipStream Decompress = new GZipStream(inFile, CompressionMode.Decompress))
                {
                    // Copy the decompression stream 
                    // into the output file.
                    Decompress.CopyTo(outFile);

                    //Console.WriteLine("Decompressed: {0}", fi.Name);
                }
            }
        }
    }
    protected void count_attachements()
    {
        string sCommand;
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;
       

        //BASIS FOR AWARDING
        //bfa_LowestPr
        sCommand = "SELECT Count(*) as Count FROM tblBACSupportingDocuments WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND DocuName='bfa_LowestPr'";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            bfa_LowestPr_count.Text = oReader["Count"].ToString();
        } oReader.Close();
        //bfa_SoleLOA
        sCommand = "SELECT Count(*) as Count FROM tblBACSupportingDocuments WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND DocuName='bfa_SoleLOA'";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            bfa_SoleLOA_count.Text = oReader["Count"].ToString();
        } oReader.Close();
        //bfa_SoleCSD
        sCommand = "SELECT Count(*) as Count FROM tblBACSupportingDocuments WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND DocuName='bfa_SoleCSD'";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            bfa_SoleCSD_count.Text = oReader["Count"].ToString();
        } oReader.Close();
        //bfa_TechSpec
        sCommand = "SELECT Count(*) as Count FROM tblBACSupportingDocuments WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND DocuName='bfa_TechSpec'";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            bfa_TechSpec_count.Text = oReader["Count"].ToString();
        } oReader.Close();
        //bfa_LeadTime
        sCommand = "SELECT Count(*) as Count FROM tblBACSupportingDocuments WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND DocuName='bfa_LeadTime'";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            bfa_LeadTime_count.Text = oReader["Count"].ToString();
        } oReader.Close();
        //bfa_BFAOth
        sCommand = "SELECT Count(*) as Count FROM tblBACSupportingDocuments WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND DocuName='bfa_BFAOth'";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            bfa_BFAOth_count.Text = oReader["Count"].ToString();
        } oReader.Close();


        //Label1.Text = Repeater_SDA_APR.Items.Count.ToString();
    }
}