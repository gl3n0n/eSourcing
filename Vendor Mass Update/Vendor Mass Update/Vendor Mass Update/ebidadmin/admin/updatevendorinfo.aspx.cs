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
using System.IO;
using System.Data.SqlClient;
using EBid.lib;
using EBid.lib.constant;
using System.ComponentModel;
using System.Drawing;
using System.Text;

public partial class admin_updatevendorinfo : System.Web.UI.Page
{
    private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
    private string csvPath = (System.AppDomain.CurrentDomain.BaseDirectory + "admin\\rfcUpdateVendorInfo\\");

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            string control1 = Request.Form["__EVENTTARGET"];
            if (control1 == "lnkUpdateDB")
            {
                //Response.Write(control1);
                //ExportCsv();
                //ReadExportedCsv();
                ReadCsvAndUpdateDB();
            }
            if (control1 == "lnkDownloadCSVfromDB")
            {
            //    //Response.Write(control1);
            //    //AttachMyFile();
                ExportCSVfromDB();
            }
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write(csvPath);
        if (Session["CategoryMessage"] != null)
        {
            lblUpdateMsg.Text = Session["CategoryMessage"].ToString() + "<br /><br />";
            lblUpdateMsg.Visible = true;
            Session["CategoryMessage"] = null;
        }
        else
            lblUpdateMsg.Visible = false;
    }

    protected void UploadCSV(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string fileExt =
               System.IO.Path.GetExtension(FileUpload1.FileName);

            if (fileExt == ".csv" || fileExt == ".txt")
            {
                try
                {
                    FileUpload1.SaveAs(csvPath + "rfcUpdateVendorInfo.csv");
                    Label1.Text = "File uploaded: " + FileUpload1.PostedFile.FileName + " <br />File size: " + FileUpload1.PostedFile.ContentLength + " kb<br>" + "Content type: " + FileUpload1.PostedFile.ContentType;
                }
                catch (Exception ex)
                {
                    Label1.Text = "ERROR: " + ex.Message.ToString();
                }
            }
            else
            {
                Label1.Text = "Only .csv & .txt files allowed!";
            }
        }
        else
        {
            Label1.Text = "You have not specified a file.";
        }
    }

    void ReadCsvAndUpdateDB()
    {
        if (File.Exists(csvPath + "rfcUpdateVendorInfo.csv"))
        {
            StreamReader csvContent = new StreamReader(csvPath + "rfcUpdateVendorInfo.csv");
            string line = "";
            string[] row;
            //string CategoryId = ""; string CategoryName = ""; 
            
            string ErrVendorId = "";

            string sqlStatement = "";
            
            string VendorId = "";                   //0
            string VendorName = "";                 //1
            string VendorCode = "";                 //2
            string Accredited = "";                 //3
            string VendorEmail = "";                //4
            string MobileNo = "";                   //5
            string VendorAddress = "";              //6
            string VendorAddress1 = "";             //7
            string VendorAddress2 = "";             //8
            string VendorAddress3 = "";             //9
            string Classification = "";             //10
            string AccredDate = "";                 //11
            string ContactPerson = "";              //12
            string SalesPersonTelNo = "";           //13
            string VendorCategory = "";             //14
            string VendorSubCategory = "";          //15
            string Syskey = "";                     //16
            string TelephoneNo = "";                //17
            string Fax = "";                        //18
            string Extension = "";                  //19
            string BranchTelephoneNo = "";          //20
            string BranchFax = "";                  //21
            string BranchExtension = "";            //22
            string VatRegNo = "";                   //23
            string TIN = "";                        //24
            string POBox = "";                      //25
            string TermsofPayment = "";             //26
            string SpecialTerms = "";               //27
            string MinOrderValue = "";              //28
            string PostalCode = "";                 //29
            string OwnershipFilipino = "";          //30
            string OwnershipOther = "";             //31
            string OrgTypeID = "";                  //32
            string Specialization = "";             //33
            string SoleSupplier1 = "";              //34
            string SoleSupplier2 = "";              //35
            string KeyPersonnel = "";               //36
            string KpPosition = "";                 //37
            string ISOStandard = "";                //38
            string PCABClass = "";                  //39
            string IsBlackListed = "";              //40
            string Vendor_Code = "";                //41
            string SLA_SIR_Date = "";               //42
            string SLA_Date_Approved = "";          //43
            string Accreditation_Duration = "";     //44
            string Accreditation_From = "";         //45
            string Accreditation_To = "";           //46
            string Perf_Evaluation_Date = "";       //47
            string Perf_Evaluation_Rate = "";       //48
            string Perf_Evaluation_Service = "";    //49
            string Composite_Rating_SIR_Date = "";  //50
            string Composite_Rating_Rate = "";      //51
            string Maximum_Exposure_SIR_Date = "";  //52
            string Maximum_Exposure_Amount = "";    //53
            string Enrollment_Date = "";            //54
            string IR_Date = "";                    //55
            string IR_Number = "";                  //56
            string IR_Description = "";             //57
            string Issue_Status = "";               //58


            int updateSuccessCnt = 0; int updateFailedCnt = 0;

            Console.WriteLine(csvContent.ReadLine());
            while ((line = csvContent.ReadLine()) != null)
            {
                row = line.Split('^');
                for (int i = 0; i < row.Length; i++)
                {
                    if (i == 0)
                    {
                        VendorId = row[i].ToString().Trim();
                    }
                    else if (i == 1)
                    {
                        VendorName = row[i].ToString().Trim();
                    }
                    else if (i == 2)
                    {
                        VendorCode = row[i].ToString().Trim();
                    }
                    else if (i == 3)
                    {
                        Accredited = row[i].ToString().Trim();
                    }
                    else if (i == 4)
                    {
                        VendorEmail = row[i].ToString().Trim();
                    }
                    else if (i == 5)
                    {
                        MobileNo = row[i].ToString().Trim();
                    }
                    else if (i == 6)
                    {
                        VendorAddress = row[i].ToString().Trim();
                    }
                    else if (i == 7)
                    {
                        VendorAddress1 = row[i].ToString().Trim();
                    }
                    else if (i == 8)
                    {
                        VendorAddress2 = row[i].ToString().Trim();
                    }
                    else if (i == 9)
                    {
                        VendorAddress3 = row[i].ToString().Trim();
                    }
                    else if (i == 10)
                    {
                        Classification = row[i].ToString().Trim();
                    }
                    else if (i == 11)
                    {
                        AccredDate = row[i].ToString().Trim();
                    }
                    else if (i == 12)
                    {
                        ContactPerson = row[i].ToString().Trim();
                    }
                    else if (i == 13)
                    {
                        SalesPersonTelNo = row[i].ToString().Trim();
                    }
                    else if (i == 14)
                    {
                        VendorCategory = row[i].ToString().Trim();
                    }
                    else if (i == 15)
                    {
                        VendorSubCategory = row[i].ToString().Trim();
                    }
                    else if (i == 16)
                    {
                        Syskey = row[i].ToString().Trim();
                    }
                    else if (i == 17)
                    {
                        TelephoneNo = row[i].ToString().Trim();
                    }
                    else if (i == 18)
                    {
                        Fax = row[i].ToString().Trim();
                    }
                    else if (i == 19)
                    {
                        Extension = row[i].ToString().Trim();
                    }
                    else if (i == 20)
                    {
                        BranchTelephoneNo = row[i].ToString().Trim();
                    }
                    else if (i == 21)
                    {
                        BranchFax = row[i].ToString().Trim();
                    }
                    else if (i == 22)
                    {
                        BranchExtension = row[i].ToString().Trim();
                    }
                    else if (i == 23)
                    {
                        VatRegNo = row[i].ToString().Trim();
                    }
                    else if (i == 24)
                    {
                        TIN = row[i].ToString().Trim();
                    }
                    else if (i == 25)
                    {
                        POBox = row[i].ToString().Trim();
                    }
                    else if (i == 26)
                    {
                        TermsofPayment = row[i].ToString().Trim();
                    }
                    else if (i == 27)
                    {
                        SpecialTerms = row[i].ToString().Trim();
                    }
                    else if (i == 28)
                    {
                        MinOrderValue = row[i].ToString().Trim();
                    }
                    else if (i == 29)
                    {
                        PostalCode = row[i].ToString().Trim();
                    }
                    else if (i == 30)
                    {
                        OwnershipFilipino = row[i].ToString().Trim();
                    }
                    else if (i == 31)
                    {
                        OwnershipOther = row[i].ToString().Trim();
                    }
                    else if (i == 32)
                    {
                        OrgTypeID = row[i].ToString().Trim();
                    }
                    else if (i == 33)
                    {
                        Specialization = row[i].ToString().Trim();
                    }
                    else if (i == 34)
                    {
                        SoleSupplier1 = row[i].ToString().Trim();
                    }
                    else if (i == 35)
                    {
                        SoleSupplier2 = row[i].ToString().Trim();
                    }
                    else if (i == 36)
                    {
                        KeyPersonnel = row[i].ToString().Trim();
                    }
                    else if (i == 37)
                    {
                        KpPosition = row[i].ToString().Trim();
                    }
                    else if (i == 38)
                    {
                        ISOStandard = row[i].ToString().Trim();
                    }
                    else if (i == 39)
                    {
                        PCABClass = row[i].ToString().Trim();
                    }
                    else if (i == 40)
                    {
                        IsBlackListed = row[i].ToString().Trim();
                    }
                    else if (i == 41)
                    {
                        Vendor_Code = row[i].ToString().Trim();
                    }
                    else if (i == 42)
                    {
                        SLA_SIR_Date = row[i].ToString().Trim();
                    }
                    else if (i == 43)
                    {
                        SLA_Date_Approved = row[i].ToString().Trim();
                    }
                    else if (i == 44)
                    {
                        Accreditation_Duration = row[i].ToString().Trim();
                    }
                    else if (i == 45)
                    {
                        Accreditation_From = row[i].ToString().Trim();
                    }
                    else if (i == 46)
                    {
                        Accreditation_To = row[i].ToString().Trim();
                    }
                    else if (i == 47)
                    {
                        Perf_Evaluation_Date = row[i].ToString().Trim();
                    }
                    else if (i == 48)
                    {
                        Perf_Evaluation_Rate = row[i].ToString().Trim();
                    }
                    else if (i == 49)
                    {
                        Perf_Evaluation_Service = row[i].ToString().Trim();
                    }
                    else if (i == 50)
                    {
                        Composite_Rating_SIR_Date = row[i].ToString().Trim();
                    }
                    else if (i == 51)
                    {
                        Composite_Rating_Rate = row[i].ToString().Trim();
                    }
                    else if (i == 52)
                    {
                        Maximum_Exposure_SIR_Date = row[i].ToString().Trim();
                    }
                    else if (i == 53)
                    {
                        Maximum_Exposure_Amount = row[i].ToString().Trim();
                    }
                    else if (i == 54)
                    {
                        Enrollment_Date = row[i].ToString().Trim();
                    }
                    else if (i == 55)
                    {
                        IR_Date = row[i].ToString().Trim();
                    }
                    else if (i == 56)
                    {
                        IR_Number = row[i].ToString().Trim();
                    }
                    else if (i == 57)
                    {
                        IR_Description = row[i].ToString().Trim();
                    }
                    else if (i == 58)
                    {
                        Issue_Status = row[i].ToString().Trim();                         
                    }
                   
                }
                //Response.Write(VendorId + " : " + VendorName + " : " + VendorCode + " : " + Accredited + " : " + VendorEmail + " : " + MobileNo + " : " + VendorAddress + " : " + VendorAddress1 + " : " + VendorAddress2 + " : " + VendorAddress3 + " : " + Classification + " : " + AccredDate + " : " + ContactPerson + " : " + SalesPersonTelNo + " : " + VendorCategory + " : " + VendorSubCategory + " : " + Syskey + " : " + TelephoneNo + " : " + Fax + " : " + Extension + " : " + BranchTelephoneNo + " : " + BranchFax + " : " + BranchExtension + " : " + VatRegNo + " : " + TIN + " : " + POBox + " : " + TermsofPayment + " : " + SpecialTerms + " : " + MinOrderValue + " : " + PostalCode + " : " + OwnershipFilipino + " : " + OwnershipOther + " : " + OrgTypeID + " : " + Specialization + " : " + SoleSupplier1 + " : " + SoleSupplier2 + " : " + KeyPersonnel + " : " + KpPosition + " : " + ISOStandard + " : " + PCABClass + " : " + IsBlackListed + " : " + Vendor_Code + " : " + SLA_SIR_Date + " : " + SLA_Date_Approved + " : " + Accreditation_Duration + " : " + Accreditation_From + " : " + Accreditation_To + " : " + Perf_Evaluation_Date + " : " + Perf_Evaluation_Rate + " : " + Perf_Evaluation_Service + " : " + Composite_Rating_SIR_Date + " : " + Composite_Rating_Rate + " : " + Maximum_Exposure_SIR_Date + " : " + Maximum_Exposure_Amount + " : " + Enrollment_Date + " : " + IR_Date + " : " + IR_Number + " : " + IR_Description + " : " + Issue_Status + "<br>");
                if (UpdateVendorInfoFromCsv(VendorId, VendorName, VendorCode, Accredited, VendorEmail, MobileNo, VendorAddress, VendorAddress1, VendorAddress2, VendorAddress3, Classification, AccredDate, ContactPerson, SalesPersonTelNo, VendorCategory, VendorSubCategory, Syskey, TelephoneNo, Fax, Extension, BranchTelephoneNo, BranchFax, BranchExtension, VatRegNo, TIN, POBox, TermsofPayment, SpecialTerms, MinOrderValue, PostalCode, OwnershipFilipino, OwnershipOther, OrgTypeID, Specialization, SoleSupplier1, SoleSupplier2, KeyPersonnel, KpPosition, ISOStandard, PCABClass, IsBlackListed, Vendor_Code, SLA_SIR_Date, SLA_Date_Approved, Accreditation_Duration, Accreditation_From, Accreditation_To, Perf_Evaluation_Date, Perf_Evaluation_Rate, Perf_Evaluation_Service, Composite_Rating_SIR_Date, Composite_Rating_Rate, Maximum_Exposure_SIR_Date, Maximum_Exposure_Amount, Enrollment_Date, IR_Date, IR_Number, IR_Description, Issue_Status))
                {
                    updateSuccessCnt++;
                }
                else
                {
                    updateFailedCnt++;
                    if (ErrVendorId.Length == 0)
                    {
                        ErrVendorId = VendorId;
                    }
                    else
                    {
                        ErrVendorId = ErrVendorId + '^' + VendorId;
                    }
                }

            }
            csvContent.Close();
            File.Delete(csvPath + "rfcUpdateVendorInfo.csv");

            Session["CategoryMessage"] = "[" + updateSuccessCnt.ToString() + "] Vendors were successfully updated.  [" + updateFailedCnt.ToString() + "] Failed.";
            Response.Redirect("updatevendorinfo.aspx");
        }
        else
        {
            Session["CategoryMessage"] = "No uploaded CVS file to process.";
            Response.Redirect("updatevendorinfo.aspx");
        }
    }

    private bool UpdateVendorInfoFromCsv(string VendorId, string VendorName, string VendorCode, string Accredited, string VendorEmail, string MobileNo, string VendorAddress, string VendorAddress1, string VendorAddress2, string VendorAddress3, string Classification, string AccredDate, string ContactPerson, string SalesPersonTelNo, string VendorCategory, string VendorSubCategory, string Syskey, string TelephoneNo, string Fax, string Extension, string BranchTelephoneNo, string BranchFax, string BranchExtension, string VatRegNo, string TIN, string POBox, string TermsofPayment, string SpecialTerms, string MinOrderValue, string PostalCode, string OwnershipFilipino, string OwnershipOther, string OrgTypeID, string Specialization, string SoleSupplier1, string SoleSupplier2, string KeyPersonnel, string KpPosition, string ISOStandard, string PCABClass, string IsBlackListed, string Vendor_Code, string SLA_SIR_Date, string SLA_Date_Approved, string Accreditation_Duration, string Accreditation_From, string Accreditation_To, string Perf_Evaluation_Date, string Perf_Evaluation_Rate, string Perf_Evaluation_Service, string Composite_Rating_SIR_Date, string Composite_Rating_Rate, string Maximum_Exposure_SIR_Date, string Maximum_Exposure_Amount, string Enrollment_Date, string IR_Date, string IR_Number, string IR_Description, string Issue_Status)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        bool success = false;
        
        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[59];

            sqlParams[0] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[1] = new SqlParameter("@VendorName", SqlDbType.VarChar);
            sqlParams[2] = new SqlParameter("@VendorCode", SqlDbType.VarChar);
            sqlParams[3] = new SqlParameter("@Accredited", SqlDbType.Int);
            sqlParams[4] = new SqlParameter("@VendorEmail", SqlDbType.VarChar);
            sqlParams[5] = new SqlParameter("@MobileNo", SqlDbType.VarChar);
            sqlParams[6] = new SqlParameter("@VendorAddress", SqlDbType.VarChar);
            sqlParams[7] = new SqlParameter("@VendorAddress1", SqlDbType.VarChar);
            sqlParams[8] = new SqlParameter("@VendorAddress2", SqlDbType.VarChar);
            sqlParams[9] = new SqlParameter("@VendorAddress3", SqlDbType.VarChar);
            sqlParams[10] = new SqlParameter("@Classification", SqlDbType.Int);
            sqlParams[11] = new SqlParameter("@AccredDate", SqlDbType.DateTime);
            sqlParams[12] = new SqlParameter("@ContactPerson", SqlDbType.VarChar);
            sqlParams[13] = new SqlParameter("@SalesPersonTelNo", SqlDbType.VarChar);
            sqlParams[14] = new SqlParameter("@VendorCategory", SqlDbType.VarChar);
            sqlParams[15] = new SqlParameter("@VendorSubCategory", SqlDbType.VarChar);
            sqlParams[16] = new SqlParameter("@Syskey", SqlDbType.VarChar);
            sqlParams[17] = new SqlParameter("@TelephoneNo", SqlDbType.VarChar);
            sqlParams[18] = new SqlParameter("@Fax", SqlDbType.VarChar);
            sqlParams[19] = new SqlParameter("@Extension", SqlDbType.VarChar);
            sqlParams[20] = new SqlParameter("@BranchTelephoneNo", SqlDbType.VarChar);
            sqlParams[21] = new SqlParameter("@BranchFax", SqlDbType.VarChar);
            sqlParams[22] = new SqlParameter("@BranchExtension", SqlDbType.VarChar);
            sqlParams[23] = new SqlParameter("@VatRegNo", SqlDbType.VarChar);
            sqlParams[24] = new SqlParameter("@TIN", SqlDbType.VarChar);
            sqlParams[25] = new SqlParameter("@POBox", SqlDbType.VarChar);
            sqlParams[26] = new SqlParameter("@TermsofPayment", SqlDbType.VarChar);
            sqlParams[27] = new SqlParameter("@SpecialTerms", SqlDbType.VarChar);
            sqlParams[28] = new SqlParameter("@MinOrderValue", SqlDbType.Float);
            sqlParams[29] = new SqlParameter("@PostalCode", SqlDbType.VarChar);
            sqlParams[30] = new SqlParameter("@OwnershipFilipino", SqlDbType.Int);
            sqlParams[31] = new SqlParameter("@OwnershipOther", SqlDbType.Int);
            sqlParams[32] = new SqlParameter("@OrgTypeID", SqlDbType.Int);
            sqlParams[33] = new SqlParameter("@Specialization", SqlDbType.VarChar);
            sqlParams[34] = new SqlParameter("@SoleSupplier1", SqlDbType.VarChar);
            sqlParams[35] = new SqlParameter("@SoleSupplier2", SqlDbType.VarChar);
            sqlParams[36] = new SqlParameter("@KeyPersonnel", SqlDbType.VarChar);
            sqlParams[37] = new SqlParameter("@KpPosition", SqlDbType.VarChar);
            sqlParams[38] = new SqlParameter("@ISOStandard", SqlDbType.VarChar);
            sqlParams[39] = new SqlParameter("@PCABClass", SqlDbType.Int);
            sqlParams[40] = new SqlParameter("@IsBlackListed", SqlDbType.SmallInt);
            sqlParams[41] = new SqlParameter("@Vendor_Code", SqlDbType.VarChar);
            sqlParams[42] = new SqlParameter("@SLA_SIR_Date", SqlDbType.DateTime);
            sqlParams[43] = new SqlParameter("@SLA_Date_Approved", SqlDbType.DateTime);
            sqlParams[44] = new SqlParameter("@Accreditation_Duration", SqlDbType.DateTime);
            sqlParams[45] = new SqlParameter("@Accreditation_From", SqlDbType.DateTime);
            sqlParams[46] = new SqlParameter("@Accreditation_To", SqlDbType.DateTime);
            sqlParams[47] = new SqlParameter("@Perf_Evaluation_Date", SqlDbType.DateTime);
            sqlParams[48] = new SqlParameter("@Perf_Evaluation_Rate", SqlDbType.VarChar);
            sqlParams[49] = new SqlParameter("@Perf_Evaluation_Service", SqlDbType.VarChar);
            sqlParams[50] = new SqlParameter("@Composite_Rating_SIR_Date", SqlDbType.VarChar);
            sqlParams[51] = new SqlParameter("@Composite_Rating_Rate", SqlDbType.Int);
            sqlParams[52] = new SqlParameter("@Maximum_Exposure_SIR_Date", SqlDbType.DateTime);
            sqlParams[53] = new SqlParameter("@Maximum_Exposure_Amount", SqlDbType.Float);
            sqlParams[54] = new SqlParameter("@Enrollment_Date", SqlDbType.VarChar);
            sqlParams[55] = new SqlParameter("@IR_Date", SqlDbType.DateTime);
            sqlParams[56] = new SqlParameter("@IR_Number", SqlDbType.Int);
            sqlParams[57] = new SqlParameter("@IR_Description", SqlDbType.VarChar);
            sqlParams[58] = new SqlParameter("@Issue_Status", SqlDbType.Int);
            
            sqlParams[0].Value = VendorId.ToString().Trim();
            sqlParams[1].Value = (VendorName.Length > 0) ? VendorName.ToString().Trim() : null;
            sqlParams[2].Value = (VendorCode.Length > 0) ? VendorCode.ToString().Trim() : null;
            sqlParams[3].Value = (Accredited.Length > 0) ? Accredited.ToString().Trim() : null;
            sqlParams[4].Value = (VendorEmail.Length > 0) ? VendorEmail.ToString().Trim() : null;
            sqlParams[5].Value = (MobileNo.Length > 0) ? MobileNo.ToString().Trim() : null;
            sqlParams[6].Value = (VendorAddress.Length > 0) ? VendorAddress.ToString().Trim() : null;
            sqlParams[7].Value = (VendorAddress1.Length > 0) ? VendorAddress1.ToString().Trim() : null;
            sqlParams[8].Value = (VendorAddress2.Length > 0) ? VendorAddress2.ToString().Trim() : null;
            sqlParams[9].Value = (VendorAddress3.Length > 0) ? VendorAddress3.ToString().Trim() : null;
            sqlParams[10].Value = (Classification.Length > 0) ? Classification.ToString().Trim() : null;
            sqlParams[11].Value = (AccredDate.Length > 0) ? AccredDate.ToString().Trim() : null;
            sqlParams[12].Value = (ContactPerson.Length > 0) ? ContactPerson.ToString().Trim() : null;
            sqlParams[13].Value = (SalesPersonTelNo.Length > 0) ? SalesPersonTelNo.ToString().Trim() : null;
            sqlParams[14].Value = (VendorCategory.Length > 0) ? VendorCategory.ToString().Trim() : null;
            sqlParams[15].Value = (VendorSubCategory.Length > 0) ? VendorSubCategory.ToString().Trim() : null;
            sqlParams[16].Value = (Syskey.Length > 0) ? Syskey.ToString().Trim() : null;
            sqlParams[17].Value = (TelephoneNo.Length > 0) ? TelephoneNo.ToString().Trim() : null;
            sqlParams[18].Value = (Fax.Length > 0) ? Fax.ToString().Trim() : null;
            sqlParams[19].Value = (Extension.Length > 0) ? Extension.ToString().Trim() : null;
            sqlParams[20].Value = (BranchTelephoneNo.Length > 0) ? BranchTelephoneNo.ToString().Trim() : null;
            sqlParams[21].Value = (BranchFax.Length > 0) ? BranchFax.ToString().Trim() : null;
            sqlParams[22].Value = (BranchExtension.Length > 0) ? BranchExtension.ToString().Trim() : null;
            sqlParams[23].Value = (VatRegNo.Length > 0) ? VatRegNo.ToString().Trim() : null;
            sqlParams[24].Value = (TIN.Length > 0) ? TIN.ToString().Trim() : null;
            sqlParams[25].Value = (POBox.Length > 0) ? POBox.ToString().Trim() : null;
            sqlParams[26].Value = (TermsofPayment.Length > 0) ? TermsofPayment.ToString().Trim() : null;
            sqlParams[27].Value = (SpecialTerms.Length > 0) ? SpecialTerms.ToString().Trim() : null;
            sqlParams[28].Value = (MinOrderValue.Length > 0) ? MinOrderValue.ToString().Trim() : null;
            sqlParams[29].Value = (PostalCode.Length > 0) ? PostalCode.ToString().Trim() : null;
            sqlParams[30].Value = (OwnershipFilipino.Length > 0) ? OwnershipFilipino.ToString().Trim() : null;
            sqlParams[31].Value = (OwnershipOther.Length > 0) ? OwnershipOther.ToString().Trim() : null;
            sqlParams[32].Value = (OrgTypeID.Length > 0) ? OrgTypeID.ToString().Trim() : null;
            sqlParams[33].Value = (Specialization.Length > 0) ? Specialization.ToString().Trim() : null;
            sqlParams[34].Value = (SoleSupplier1.Length > 0) ? SoleSupplier1.ToString().Trim() : null;
            sqlParams[35].Value = (SoleSupplier2.Length > 0) ? SoleSupplier2.ToString().Trim() : null;
            sqlParams[36].Value = (KeyPersonnel.Length > 0) ? KeyPersonnel.ToString().Trim() : null;
            sqlParams[37].Value = (KpPosition.Length > 0) ? KpPosition.ToString().Trim() : null;
            sqlParams[38].Value = (ISOStandard.Length > 0) ? ISOStandard.ToString().Trim() : null;
            sqlParams[39].Value = (PCABClass.Length > 0) ? PCABClass.ToString().Trim() : null;
            sqlParams[40].Value = (IsBlackListed.Length > 0) ? IsBlackListed.ToString().Trim() : null;
            sqlParams[41].Value = (Vendor_Code.Length > 0) ? Vendor_Code.ToString().Trim() : null;
            sqlParams[42].Value = (SLA_SIR_Date.Length > 0) ? SLA_SIR_Date.ToString().Trim() : null;
            sqlParams[43].Value = (SLA_Date_Approved.Length > 0) ? SLA_Date_Approved.ToString().Trim() : null;
            sqlParams[44].Value = (Accreditation_Duration.Length > 0) ? Accreditation_Duration.ToString().Trim() : null;
            sqlParams[45].Value = (Accreditation_From.Length > 0) ? Accreditation_From.ToString().Trim() : null;
            sqlParams[46].Value = (Accreditation_To.Length > 0) ? Accreditation_To.ToString().Trim() : null;
            sqlParams[47].Value = (Perf_Evaluation_Date.Length > 0) ? Perf_Evaluation_Date.ToString().Trim() : null;
            sqlParams[48].Value = (Perf_Evaluation_Rate.Length > 0) ? Perf_Evaluation_Rate.ToString().Trim() : null;
            sqlParams[49].Value = (Perf_Evaluation_Service.Length > 0) ? Perf_Evaluation_Service.ToString().Trim() : null;
            sqlParams[50].Value = (Composite_Rating_SIR_Date.Length > 0) ? Composite_Rating_SIR_Date.ToString().Trim() : null;
            sqlParams[51].Value = (Composite_Rating_Rate.Length > 0) ? Composite_Rating_Rate.ToString().Trim() : null;
            sqlParams[52].Value = (Maximum_Exposure_SIR_Date.Length > 0) ? Maximum_Exposure_SIR_Date.ToString().Trim() : null;
            sqlParams[53].Value = (Maximum_Exposure_Amount.Length > 0) ? Maximum_Exposure_Amount.ToString().Trim() : null;
            sqlParams[54].Value = (Enrollment_Date.Length > 0) ? Enrollment_Date.ToString().Trim() : null;
            sqlParams[55].Value = (IR_Date.Length > 0) ? IR_Date.ToString().Trim() : null;
            sqlParams[56].Value = (IR_Number.Length > 0) ? IR_Number.ToString().Trim() : null;
            sqlParams[57].Value = (IR_Description.Length > 0) ? IR_Description.ToString().Trim() : null;
            sqlParams[58].Value = (Issue_Status.Length > 0) ? Issue_Status.ToString().Trim() : null;
            
            SqlHelper.ExecuteNonQuery(sqlTransact, "sp_UpdateVendorInfoFromCsv", sqlParams);

            sqlTransact.Commit();

            success = true;
        }
        catch
        {
            sqlTransact.Rollback();
            success = false;
        }
        finally
        {
            sqlConnect.Close();
        }
        //Response.Write(success);
        return success;
    }

    void ExportCSVfromDB()
    {
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        string sCommand, VendorId, VendorName, VendorCode, Accredited, VendorEmail, MobileNo, VendorAddress, VendorAddress1, VendorAddress2, VendorAddress3, Classification, AccredDate, ContactPerson, SalesPersonTelNo, VendorCategory, VendorSubCategory, Syskey, TelephoneNo, Fax, Extension, BranchTelephoneNo, BranchFax, BranchExtension, VatRegNo, TIN, POBox, TermsofPayment, SpecialTerms, MinOrderValue, PostalCode, OwnershipFilipino, OwnershipOther, OrgTypeID, Specialization, SoleSupplier1, SoleSupplier2, KeyPersonnel, KpPosition, ISOStandard, PCABClass, IsBlackListed, Vendor_Code, SLA_SIR_Date, SLA_Date_Approved, Accreditation_Duration, Accreditation_From, Accreditation_To, Perf_Evaluation_Date, Perf_Evaluation_Rate, Perf_Evaluation_Service, Composite_Rating_SIR_Date, Composite_Rating_Rate, Maximum_Exposure_SIR_Date, Maximum_Exposure_Amount, Enrollment_Date, IR_Date, IR_Number, IR_Description, Issue_Status;
        string csvContent = "";
        SqlDataReader oReader;

        csvContent = "\"VendorId\"^\"VendorName\"^\"VendorCode\"^\"Accredited\"^\"VendorEmail\"^\"MobileNo\"^\"VendorAddress\"^\"VendorAddress1\"^\"VendorAddress2\"^\"VendorAddress3\"^\"Classification\"^\"AccredDate\"^\"ContactPerson\"^\"SalesPersonTelNo\"^\"VendorCategory\"^\"VendorSubCategory\"^\"Syskey\"^\"TelephoneNo\"^\"Fax\"^\"Extension\"^\"BranchTelephoneNo\"^\"BranchFax\"^\"BranchExtension\"^\"VatRegNo\"^\"TIN\"^\"POBox\"^\"TermsofPayment\"^\"SpecialTerms\"^\"MinOrderValue\"^\"PostalCode\"^\"OwnershipFilipino\"^\"OwnershipOther\"^\"OrgTypeID\"^\"Specialization\"^\"SoleSupplier1\"^\"SoleSupplier2\"^\"KeyPersonnel\"^\"KpPosition\"^\"ISOStandard\"^\"PCABClass\"^\"IsBlackListed\"^\"Vendor_Code\"^\"SLA_SIR_Date\"^\"SLA_Date_Approved\"^\"Accreditation_Duration\"^\"Accreditation_From\"^\"Accreditation_To\"^\"Perf_Evaluation_Date\"^\"Perf_Evaluation_Rate\"^\"Perf_Evaluation_Service\"^\"Composite_Rating_SIR_Date\"^\"Composite_Rating_Rate\"^\"Maximum_Exposure_SIR_Date\"^\"Maximum_Exposure_Amount\"^\"Enrollment_Date\"^\"IR_Date\"^\"IR_Number\"^\"IR_Description\"^\"Issue_Status\"" + "\n";

        sCommand = "SELECT * FROM tblVendors ORDER BY VendorId";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        while (oReader.Read())
        {
            VendorId = oReader["VendorId"].ToString();
            VendorName = oReader["VendorName"].ToString();
            VendorCode = oReader["VendorCode"].ToString();
            Accredited = oReader["Accredited"].ToString();
            VendorEmail = oReader["VendorEmail"].ToString();
            MobileNo = oReader["MobileNo"].ToString();
            VendorAddress = oReader["VendorAddress"].ToString();
            VendorAddress1 = oReader["VendorAddress1"].ToString();
            VendorAddress2 = oReader["VendorAddress2"].ToString();
            VendorAddress3 = oReader["VendorAddress3"].ToString();
            Classification = oReader["Classification"].ToString();
            AccredDate = oReader["AccredDate"].ToString();
            ContactPerson = oReader["ContactPerson"].ToString();
            SalesPersonTelNo = oReader["SalesPersonTelNo"].ToString();
            VendorCategory = oReader["VendorCategory"].ToString();
            VendorSubCategory = oReader["VendorSubCategory"].ToString();
            Syskey = oReader["SysKey"].ToString();
            TelephoneNo = oReader["TelephoneNo"].ToString();
            Fax = oReader["Fax"].ToString();
            Extension = oReader["Extension"].ToString();
            BranchTelephoneNo = oReader["BranchTelephoneNo"].ToString();
            BranchFax = oReader["BranchFax"].ToString();
            BranchExtension = oReader["BranchExtension"].ToString();
            VatRegNo = oReader["VatRegNo"].ToString();
            TIN = oReader["TIN"].ToString();
            POBox = oReader["POBox"].ToString();
            TermsofPayment = oReader["TermsofPayment"].ToString();
            SpecialTerms = oReader["SpecialTerms"].ToString();
            MinOrderValue = oReader["MinOrderValue"].ToString();
            PostalCode = oReader["PostalCode"].ToString();
            OwnershipFilipino = oReader["OwnershipFilipino"].ToString();
            OwnershipOther = oReader["OwnershipOther"].ToString();
            OrgTypeID = oReader["OrgTypeID"].ToString();
            Specialization = oReader["Specialization"].ToString();
            SoleSupplier1 = oReader["SoleSupplier1"].ToString();
            SoleSupplier2 = oReader["SoleSupplier2"].ToString();
            KeyPersonnel = oReader["KeyPersonnel"].ToString();
            KpPosition = oReader["KpPosition"].ToString();
            ISOStandard = oReader["ISOStandard"].ToString();
            PCABClass = oReader["PCABClass"].ToString();
            IsBlackListed = oReader["IsBlackListed"].ToString();
            Vendor_Code = oReader["VendorCode"].ToString();
            SLA_SIR_Date = oReader["SLA_SIR_Date"].ToString();
            SLA_Date_Approved = oReader["SLA_Date_Approved"].ToString();
            Accreditation_Duration = oReader["Accreditation_Duration"].ToString();
            Accreditation_From = oReader["Accreditation_From"].ToString();
            Accreditation_To = oReader["Accreditation_To"].ToString();
            Perf_Evaluation_Date = oReader["Perf_Evaluation_Date"].ToString();
            Perf_Evaluation_Rate = oReader["Perf_Evaluation_Rate"].ToString();
            Perf_Evaluation_Service = oReader["Perf_Evaluation_Service"].ToString();
            Composite_Rating_SIR_Date = oReader["Composite_Rating_SIR_Date"].ToString();
            Composite_Rating_Rate = oReader["Composite_Rating_Rate"].ToString();
            Maximum_Exposure_SIR_Date = oReader["Maximum_Exposure_SIR_Date"].ToString();
            Maximum_Exposure_Amount = oReader["Maximum_Exposure_Amount"].ToString();
            Enrollment_Date = oReader["Enrollment_Date"].ToString();
            IR_Date = oReader["IR_Date"].ToString();
            IR_Number = oReader["IR_Number"].ToString();
            IR_Description = oReader["IR_Description"].ToString();
            Issue_Status = oReader["Issue_Status"].ToString();
            
            csvContent = csvContent + VendorId + "^" + VendorName + "^" + VendorCode + "^" + Accredited + "^" + VendorEmail + "^" + MobileNo + "^" + VendorAddress + "^" + VendorAddress1 + "^" + VendorAddress2 + "^" + VendorAddress3 + "^" + Classification + "^" + AccredDate + "^" + ContactPerson + "^" + SalesPersonTelNo + "^" + VendorCategory + "^" + VendorSubCategory + "^" + Syskey + "^" + TelephoneNo + "^" + Fax + "^" + Extension + "^" + BranchTelephoneNo + "^" + BranchFax + "^" + BranchExtension + "^" + VatRegNo + "^" + TIN + "^" + POBox + "^" + TermsofPayment + "^" + SpecialTerms + "^" + MinOrderValue + "^" + PostalCode + "^" + OwnershipFilipino + "^" + OwnershipOther + "^" + OrgTypeID + "^" + Specialization + "^" + SoleSupplier1 + "^" + SoleSupplier2 + "^" + KeyPersonnel + "^" + KpPosition + "^" + ISOStandard + "^" + PCABClass + "^" + IsBlackListed + "^" + Vendor_Code + "^" + SLA_SIR_Date + "^" + SLA_Date_Approved + "^" + Accreditation_Duration + "^" + Accreditation_From + "^" + Accreditation_To + "^" + Perf_Evaluation_Date + "^" + Perf_Evaluation_Rate + "^" + Perf_Evaluation_Service + "^" + Composite_Rating_SIR_Date + "^" + Composite_Rating_Rate + "^" + Maximum_Exposure_SIR_Date + "^" + Maximum_Exposure_Amount + "^" + Enrollment_Date + "^" + IR_Date + "^" + IR_Number + "^" + IR_Description + "^" + Issue_Status + "\n";
        }
        oReader.Close();

        //Download csv
        StringWriter oStringWriter = new StringWriter();
        oStringWriter.WriteLine(csvContent);
        Response.ContentType = "text/plain";
        Response.AddHeader("content-disposition", "attachment;filename=" + string.Format("VendorInformation_{0}.csv", string.Format("{0:yyyy-MM-dd}", DateTime.Today)));
        Response.Clear();
        using (StreamWriter writer = new StreamWriter(Response.OutputStream, Encoding.UTF8))
        {
            writer.Write(oStringWriter.ToString());
        }
        Response.End();
    }
}

