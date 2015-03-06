using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EBid.lib.bid.data;
using EBid.lib.bid.trans;
using EBid.lib.constant;
using EBid.lib;
using EBid.lib.rfi;
using System.IO;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Text;

public partial class web_vendorscreens_submitrfitender : System.Web.UI.Page
{
    private const string BR = "<br />";
    private const string BULLET = "&#187;";
    private const string BR_BULLET = "<br />&#187;";
    private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.VENDOR)
            Response.Redirect("../unauthorizedaccess.aspx");

        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "RFI Tender Creation / Submission");
        
        if (Session["RfiRefNo"] == null)
            Response.Redirect("rfi.aspx");
        if (!IsPostBack)
        {
            if (Request.QueryString[Constant.QS_TASKTYPE] == "2")
            {
                InitializeGridViews();
            }
            else if (Request.QueryString[Constant.QS_TASKTYPE] == "3")
            {
                InitializeGridViewsWithFilter();
            }
            else
            {
                Session["RfiTenderNo"] = 0;
                InitializeGridViews();
            }
        }
        litMsg.Text = "";
        litErrMsg.Text = "";
    }

    #region Initializations
    private void InitializeGridViewsWithFilter()
    {
        InitializeRfiTendersWithFilter();
        InitializeFileAttachments();
    }

    private void InitializeGridViews()
    {
        InitializeRfiTenders();
        InitializeFileAttachments();
    }

    // GET RFI TENDERS OF THIS VENDOR FOR THIS RFI EVENT
    private void InitializeRfiTendersWithFilter()
    { 
        IEnumerator iEnum = dsItemDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();
        DataTable dtRfiTenders = (DataTable)ViewState["RfiTenders"];
        if (dtRfiTenders == null)
            dtRfiTenders = CreateEmptyRfiTendersTable();
        int selected = 0, ctr = 0;

        while (iEnum.MoveNext())
        {
            DataRowView dr = (DataRowView)iEnum.Current;

            AddRfiTenderRow(ref dtRfiTenders,
                int.Parse(dr["RfiTenderNo"].ToString()),
                int.Parse(dr["RfiDetailNo"].ToString()),
                dr["SKU"].ToString(),
                dr["DetailDesc"].ToString(),
                dr["UnitOfMeasure"].ToString(),
                int.Parse(dr["Qty"].ToString()),
                double.Parse(dr["Amount"].ToString()),
                double.Parse(dr["DeliveryCost"].ToString()),
                double.Parse(dr["Discount"].ToString()),
                dr["Warranty"].ToString(),
                dr["Remarks"].ToString(),
                DateTime.Parse(dr["DeliveryDate"].ToString()));

            if (
                        ((dr["ConversionStatus"].ToString() != "2") &&
                        (dr["ConversionStatus"].ToString() != "4")) &&
                        ((dr["WithdrawalStatus"].ToString() != "2") &&
                        (dr["WithdrawalStatus"].ToString() != "4"))
                        )
            {
                selected = ctr;
            }
            ctr++;
        }

        ViewState["RfiTenders"] = dtRfiTenders;
        dvRfiTender.DataSource = dtRfiTenders;
        dvRfiTender.DataBind();
        gvRfiItemDetails.SelectedIndex = 0;
        dvRfiTender.PageIndex = 0;
        dvRfiTender.DataSource = dtRfiTenders;
        dvRfiTender.DataBind();
    }

    // GET RFI TENDERS OF THIS VENDOR FOR THIS RFI EVENT
    private void InitializeRfiTenders()
    {   
        IEnumerator iEnum = dsItemDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();
        DataTable dtRfiTenders = (DataTable)ViewState["RfiTenders"];
        if (dtRfiTenders == null)
            dtRfiTenders = CreateEmptyRfiTendersTable();
        int selected = 0, ctr = 0;

        while (iEnum.MoveNext())
        {
            DataRowView dr = (DataRowView)iEnum.Current;

            AddRfiTenderRow(ref dtRfiTenders,
                int.Parse(dr["RfiTenderNo"].ToString()),
                int.Parse(dr["RfiDetailNo"].ToString()),
                dr["SKU"].ToString(),
                dr["DetailDesc"].ToString(),
                dr["UnitOfMeasure"].ToString(),
                int.Parse(dr["Qty"].ToString()),
                double.Parse(dr["Amount"].ToString()),
                double.Parse(dr["DeliveryCost"].ToString()),
                double.Parse(dr["Discount"].ToString()),
                dr["Warranty"].ToString(),
                dr["Remarks"].ToString(),
                DateTime.Parse(dr["DeliveryDate"].ToString()));

            if (Session["RfiTenderNo"] != null)
            {
                if (selected == 0)
                    selected = (dr["RfiTenderNo"].ToString() == Session["RfiTenderNo"].ToString()) ? ctr : 0;
            }
            ctr++;
        }
        ViewState["RfiTenders"] = dtRfiTenders;
        dvRfiTender.DataSource = dtRfiTenders;
        dvRfiTender.DataBind();
        gvRfiItemDetails.SelectedIndex = 0;
        dvRfiTender.PageIndex = 0;
        dvRfiTender.DataSource = dtRfiTenders;
        dvRfiTender.DataBind();
    }

    // GET VENDOR FILE ATTACHMENTS FOR THIS RFI EVENT
    private void InitializeFileAttachments()
    {   
        IEnumerator iEnum = dsFileAttachments.Select(DataSourceSelectArguments.Empty).GetEnumerator();
        DataTable dtAttachments = (DataTable)ViewState["RfiTenderAttachments"];
        if (dtAttachments == null)
        {
            dtAttachments = CreateAttachmentsTable();
        }
        // ADD EMPTY ROW
        AddEmptyAttachmentRow(ref dtAttachments);

        while (iEnum.MoveNext())
        {
            DataRowView dr = (DataRowView)iEnum.Current;
            AddAttachmentRow(ref dtAttachments, dr["OriginalFileName"].ToString(), dr["ActualFileName"].ToString(), dr["IsDetachable"].ToString() == "True" ? "1" : "0", dr["FileAttachment"].ToString(), dr["AsDraft"].ToString() == "True" ? "1" : "0");
        }

        // SAVE TO VIEWSTATE
        ViewState["RfiTenderAttachments"] = dtAttachments;
        // bind to gridview
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }
    #endregion

    #region ACTION
    // SUBMIT TENDER FOR APPROVAL
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (isAllowSubmit())
        {
            string msg = string.Empty;
            if (IsValid)
            {
                RfiTender[] _rfitenders = new RfiTender[int.Parse(ViewState["RFITENDERCOUNT"].ToString())];
                // GET INPUTS HERE, STORE IN A CLASS
                GetRfiTenders(ref _rfitenders, Constant.BID_TENDER_STATUS_SUBMITTED);
                if (Request.QueryString[Constant.QS_TASKTYPE] == "2")
                {   // UPDATE AND SUBMIT
                    if (UpdateRfiTender(_rfitenders))
                    {
                        // UPDATE WAS SUCCESSFUL
                        if (UpdateRfiTenderAttachments(int.Parse(Session["RfiRefNo"].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()), 0))
                        {
                            int rfi1 = int.Parse(Session["RfiRefNo"].ToString());
                            int uid1 = int.Parse(Session[Constant.SESSION_USERID].ToString());
                            RfiEventTransaction.ConfirmRfiInvitation(rfi1, uid1);
                            Response.Redirect("submittedrfitenders.aspx");
                        }
                        else
                        {
                            // UPDATING OF RFI TENDER ATTACHMENTS WAS UNSUCCESSFUL
                            litErrMsg.Text = "<p style='color:red;'>" + "RFI tender attachments were not updated successfully." + "</p>";
                        }
                    }
                    else
                    {   // UPDATE WAS NOT SUCCESSFUL
                        litErrMsg.Text = "<p style='color:red;'>" + "RFI tender was not updated successfully." + "</p>";
                    }
                }
                else
                {
                    // SAVE AND SUBMIT
                    if (SaveRfiTender(_rfitenders))
                    {
                        // SAVING WAS SUCCESSFUL
                        if (SaveRfiTenderAttachments(int.Parse(Session["RfiRefNo"].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()), 0))
                        {
                            int rfi2 = int.Parse(Session["RfiRefNo"].ToString());
                            int uid2 = int.Parse(Session[Constant.SESSION_USERID].ToString());
                            RfiEventTransaction.ConfirmRfiInvitation(rfi2, uid2);
                            Response.Redirect("submittedrfitenders.aspx");
                        }
                        else
                        {
                            // UPDATING OF RFI TENDER ATTACHMENTS WAS UNSUCCESSFUL
                            litErrMsg.Text = "<p style='color:red;'>" + "RFI tender attachments were not saved successfully." + "</p>";
                        }
                    }
                    else
                    {   // SAVING WAS NOT SUCCESSFUL
                        litErrMsg.Text = "<p style='color:red;'>" + "RFI tender was not saved successfully." + "</p>";
                    }
                }
            }
        }
        else
        {
            litErrMsg.Text = "<p style='color:red; align:center;'>" + "RFI submission deadline (" + GetSubmissionDeadline().ToString() + ") has been reached." + "</p>";
        }
    }

    // CANCEL SUBMISSION / CREATION OF RFI EVENT
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Session[Constant.SESSION_LASTPAGE] != null)
            Response.Redirect(Session[Constant.SESSION_LASTPAGE].ToString());
        Response.Redirect("rfi.aspx");
    }
    #endregion

    #region RFI Tender
    private bool SaveRfiTender(RfiTender[] rfitenders)
    {
        string s = string.Empty;

        for (int i = 0; i < rfitenders.Length; i++)
        {
            RfiTender rt = rfitenders[i];

            if (!AddEditTender(rt.RfiTenderNo, rt.RfiDetailNo, rt.VendorId, rt.Status, rt.Amount, rt.DeliveryCost, rt.Discount, rt.Warranty, rt.Remarks, rt.Comment))
                s += "0";
        }
        return (s.Length == 0);
    }

    private bool UpdateRfiTender(RfiTender[] rfitenders)
    {
        string s = string.Empty;

        for (int i = 0; i < rfitenders.Length; i++)
        {
            RfiTender rt = rfitenders[i];

            if (!AddEditTender(rt.RfiTenderNo, rt.RfiDetailNo, rt.VendorId, rt.Status, rt.Amount, rt.DeliveryCost, rt.Discount, rt.Warranty, rt.Remarks, rt.Comment))
                s += "0";
        }
        return (s.Length == 0);
    }

    public bool AddEditTender(string vRfiTenderNo, string vRfiDetailNo, string vVendorId, string vStatus, string vAmount,
            string vDeliveryCost, string vDiscount, string vWarranty, string vRemarks, string vComments)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        bool isSuccessful = false;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlparams = new SqlParameter[11];
            sqlparams[0] = new SqlParameter("@RfiTenderNo", SqlDbType.Int);
            sqlparams[0].Value = Int32.Parse(vRfiTenderNo);
            sqlparams[1] = new SqlParameter("@RfiDetailNo", SqlDbType.Int);
            sqlparams[1].Value = Int32.Parse(vRfiDetailNo);
            sqlparams[2] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlparams[2].Value = Int32.Parse(vVendorId);
            sqlparams[3] = new SqlParameter("@Status", SqlDbType.Int);
            sqlparams[3].Value = Int32.Parse(vStatus);
            sqlparams[4] = new SqlParameter("@Amount", SqlDbType.Money);
            sqlparams[4].Value = Convert.ToDouble(vAmount);
            sqlparams[5] = new SqlParameter("@DeliveryCost", SqlDbType.Money);
            sqlparams[5].Value = Convert.ToDouble(vDeliveryCost);
            sqlparams[6] = new SqlParameter("@Discount", SqlDbType.Money);
            sqlparams[6].Value = Convert.ToDouble(vDiscount);
            sqlparams[7] = new SqlParameter("@Warranty", SqlDbType.VarChar);
            sqlparams[7].Value = vWarranty;
            sqlparams[8] = new SqlParameter("@Remarks", SqlDbType.VarChar);
            sqlparams[8].Value = vRemarks;
            sqlparams[9] = new SqlParameter("@Comment", SqlDbType.VarChar);
            sqlparams[9].Value = vComments;
            sqlparams[10] = new SqlParameter("@Result", SqlDbType.Int);
            sqlparams[10].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(sqlTransact, CommandType.StoredProcedure, "sp_AddEditRfiTender", sqlparams);
            sqlTransact.Commit();
            Session["LastRfiTenderNo"] = sqlparams[9].Value;
            isSuccessful = true;
        }
        catch
        {
            sqlTransact.Rollback();
            isSuccessful = false;
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }

    private void GetRfiTenders(ref RfiTender[] rfitenders, int status)
    {   //ASSUME THAT THERE IS ALREADY AT LEAST ONE RFI TENDER TO SUBMIT
        DataTable dtRfiTenders = (DataTable)ViewState["RfiTenders"];
        int ctr = 0;

        if (dtRfiTenders.Rows.Count > 0)
        {
            foreach (DataRow dr in dtRfiTenders.Rows)
            {
                if (double.Parse(dr["Amount"].ToString()) > 0)
                {
                    RfiTender rt = new RfiTender();
                    rt.Amount = dr["Amount"].ToString();
                    rt.RfiDetailNo = dr["RfiDetailNo"].ToString();
                    rt.RfiTenderNo = dr["RfiTenderNo"].ToString();
                    rt.DeliveryCost = dr["DeliveryCost"].ToString();
                    rt.Discount = dr["Discount"].ToString();
                    rt.Remarks = dr["Remarks"].ToString();
                    rt.Status = status.ToString();
                    rt.VendorId = Session[Constant.SESSION_USERID].ToString();
                    rt.Warranty = dr["Warranty"].ToString();
                    rt.Comment = dr["Comment"].ToString();
                    rfitenders[ctr] = rt;
                    ctr++;
                }
            }
        }
    }
    #endregion

    #region RFI Tender Attachments
    private bool SaveRfiTenderAttachments(int rfiRefNo, int vendorId, int asDraft)
    {
        bool isSuccessful = false;
        try
        {
            DataTable dtAttachments = (DataTable)ViewState["RfiTenderAttachments"];
            string s = string.Empty;

            for (int i = 1; i < dtAttachments.Rows.Count; i++)
            {
                if (asDraft == 1)
                {
                    if (int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()) == 1)
                    {
                        s += SaveRfiTenderAttachments(rfiRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 1);
                    }
                    else
                    {
                        s += SaveRfiTenderAttachments(rfiRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), int.Parse(dtAttachments.Rows[i]["AsDraft"].ToString()));
                    }
                }
                else
                {
                    s += SaveRfiTenderAttachments(rfiRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 0);
                }
            }
            isSuccessful = s.IndexOf("0") >= 0 ? false : true;
        }
        catch
        {
            isSuccessful = false;
        }
        return isSuccessful;
    }

    private string SaveRfiTenderAttachments(int rfiRefNo, int vendorId, string originalFileName, string actualFileName, int isDetachable, int asDraft)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        string isSuccessful = string.Empty;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[7];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = rfiRefNo;
            sqlParams[1] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[1].Value = vendorId;
            sqlParams[2] = new SqlParameter("@OriginalFileName", SqlDbType.VarChar);
            sqlParams[2].Value = originalFileName;
            sqlParams[3] = new SqlParameter("@ActualFileName", SqlDbType.VarChar);
            sqlParams[3].Value = actualFileName;
            sqlParams[4] = new SqlParameter("@IsDetachable", SqlDbType.Int);
            sqlParams[4].Value = isDetachable;
            sqlParams[5] = new SqlParameter("@AsDraft", SqlDbType.Int);
            sqlParams[5].Value = asDraft;
            sqlParams[6] = new SqlParameter("@FileUploadID", SqlDbType.Int);
            sqlParams[6].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_AddVendorRFITenderFileAttachment", sqlParams);

            sqlTransact.Commit();

            int r = int.Parse(sqlParams[6].Value.ToString().Trim());
            isSuccessful = (r <= 0 ? "0" : "1");
        }
        catch
        {
            sqlTransact.Rollback();
            isSuccessful = "0";
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }

    private bool UpdateRfiTenderAttachments(int rfiRefNo, int vendorId, int asDraft)
    {
        // DELETE ALL PREVIOUS ATTACHMENS OF THIS VENDOR
        if (DeleteRfiTenderAttachments(rfiRefNo, vendorId))
        {
            // THEN ADD THEM AGAIN               
            return SaveRfiTenderAttachments(rfiRefNo, vendorId, asDraft);
        }
        else
            return false;
    }

    private bool DeleteRfiTenderAttachments(int rfiRefNo, int vendorId)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        bool isSuccessful = false;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[2];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = rfiRefNo;
            sqlParams[1] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[1].Value = vendorId;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteVendorRfiEventFileAttachments", sqlParams);

            sqlTransact.Commit();

            isSuccessful = true;
        }
        catch
        {
            sqlTransact.Rollback();
            isSuccessful = false;
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }
    #endregion

    #region RFI ITEMS
    protected void gvRfiItemDetails_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dtRfiTenders = (DataTable)ViewState["RfiTenders"];

        if (dtRfiTenders != null)
        {
            Session["RfiTenderNo"] = gvRfiItemDetails.DataKeys[gvRfiItemDetails.SelectedIndex].Values["RfiTenderNo"].ToString();
            dvRfiTender.DataSource = dtRfiTenders;
            dvRfiTender.PageIndex = gvRfiItemDetails.SelectedIndex;
            dvRfiTender.DataBind();
        }
    }



    #endregion

    #region RFI Tenders
    private DataTable CreateEmptyRfiTendersTable()
    {
        DataTable dtRfiTenders = new DataTable();
        DataColumn dc;

        dc = new DataColumn("RfiTenderNo", typeof(System.Int32));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("RfiDetailNo", typeof(System.Int32));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("SKU", typeof(System.String));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("Description", typeof(System.String));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("UnitOfMeasure", typeof(System.String));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("Quantity", typeof(System.Int32));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("Amount", typeof(System.Double));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("DeliveryCost", typeof(System.Double));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("Discount", typeof(System.Double));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("Warranty", typeof(System.String));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("Remarks", typeof(System.String));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("DeliveryDate", typeof(System.DateTime));
        dtRfiTenders.Columns.Add(dc);
        dc = new DataColumn("Comment", typeof(System.String));
        dtRfiTenders.Columns.Add(dc);

        return dtRfiTenders;
    }

    private void AddEmptyRfiTenderRow(ref DataTable dtRfiTenders, int rfidetailno, int quantity, string sku)
    {
        // query all bid items for this bid event
        DataRow dr = dtRfiTenders.NewRow();

        dr["RfiTenderNo"] = 0;
        dr["RfiDetailNo"] = rfidetailno;
        dr["SKU"] = sku;
        dr["Quantity"] = quantity;
        dr["Amount"] = 0.00;
        dr["DeliveryCost"] = 0.00;
        dr["Discount"] = 0.00;
        dr["Warranty"] = "";
        dr["Remarks"] = "";
        dr["DeliveryDate"] = DateTime.Now;
        dr["Comment"] = "";
        dtRfiTenders.Rows.Add(dr);
    }

    private void AddEmptyRfiTenderRow(ref DataTable dtRfiTenders, int rfidetailno,
            int quantity, string sku,
            string description, string uom)
    {
        // QUERY ALL RFI ITEMS FOR THIS RFI EVENT
        DataRow dr = dtRfiTenders.NewRow();

        dr["RfiTenderNo"] = 0;
        dr["RfiDetailNo"] = rfidetailno;
        dr["SKU"] = sku;
        dr["Description"] = description;
        dr["UnitOfMeasure"] = uom;
        dr["Quantity"] = quantity;
        dr["Amount"] = 0.00;
        dr["DeliveryCost"] = 0.00;
        dr["Discount"] = 0.00;
        dr["Warranty"] = "";
        dr["Remarks"] = "";
        dr["DeliveryDate"] = DateTime.Now;
        dr["Comment"] = "";
        dtRfiTenders.Rows.Add(dr);
    }

    private void AddRfiTenderRow(ref DataTable dtRfiTenders, int rfitenderno, int rfidetailno,
    string sku, string description, string uom, int quantity, double amount, double deliverycost,
    double discount, string warranty, string remarks, DateTime deliverydate)
    {
        // QUERY ALL RFI ITEMS FOR THIS RFI EVENT
        DataRow dr = dtRfiTenders.NewRow();

        dr["RfiTenderNo"] = rfitenderno;
        dr["RfiDetailNo"] = rfidetailno;
        dr["SKU"] = sku;
        dr["Description"] = description;
        dr["UnitOfMeasure"] = uom;
        dr["Quantity"] = quantity;
        dr["Amount"] = amount;
        dr["DeliveryCost"] = deliverycost;
        dr["Discount"] = discount;
        dr["Warranty"] = warranty;
        dr["Remarks"] = remarks;
        dr["DeliveryDate"] = deliverydate;
        
        dtRfiTenders.Rows.Add(dr);
    }

    private void UpdateRfiTenderRow(ref DataTable dtRfiTenders, int rowindex,
    double amount, double discount, double deliverycost,
    string warranty, string remarks, string comment)
    {
        // QUERY ALL RFI ITEMS FOR THIS RFI EVENT
        DataRow dr = dtRfiTenders.Rows[rowindex];

        dr["Amount"] = amount;
        dr["DeliveryCost"] = deliverycost;
        dr["Discount"] = discount;
        dr["Warranty"] = warranty;
        dr["Remarks"] = remarks;
        dr["Comment"] = comment;
    }

    protected void dvRfiTender_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            if (isAllowSubmit())
            {
                int i = dvRfiTender.PageIndex;
                bool success = false;
                string errMsg = string.Empty;

                DataTable dtRfiTenders = (DataTable)ViewState["RfiTenders"];

                // GET CONTROLS
                TextBox tbAmount = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtAmount");
                TextBox tbAmountCents = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtAmountCents");
                TextBox tbDiscount = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtDiscount");
                TextBox tbDiscountCents = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtDiscountCents");
                TextBox tbDeliveryCost = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtDeliveryCost");
                TextBox tbDeliveryCostCents = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtDeliveryCostCents");
                TextBox tbWarranty = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtWarranty");
                TextBox tbRemarks = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtRemarks");
                TextBox tbTotal = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtTotalRfiTenderPrice");
                TextBox tbComment = (TextBox)FindControlFromDetailsView(dvRfiTender, "txtComment");
                Label lbAmount = (Label)FindControlFromDetailsView(dvRfiTender, "lblAmount");
                Label lbWarranty = (Label)FindControlFromDetailsView(dvRfiTender, "lblWarranty");

                string amount = tbAmount.Text.Trim() + "." + tbAmountCents.Text.Trim();
                string discount = tbDiscount.Text.Trim() + "." + tbDiscountCents.Text.Trim();
                string deliverycost = tbDeliveryCost.Text.Trim() + "." + tbDeliveryCostCents.Text.Trim();
                if (AreRfiTenderInputsValid(ref errMsg, amount, discount, deliverycost,
                        tbTotal.Text.Trim(), tbWarranty.Text.Trim(), tbComment.Text.Trim()))
                {
                    // update table
                    try
                    {
                        UpdateRfiTenderRow(ref dtRfiTenders, i,
                            double.Parse(amount),
                            double.Parse(discount),
                            double.Parse(deliverycost),
                            tbWarranty.Text.Trim(),
                            tbRemarks.Text.Trim(),
                            tbComment.Text.Trim());

                        success = true;
                    }
                    catch
                    {
                        success = false;
                    }

                    ViewState["RfiTenders"] = dtRfiTenders;
                    dvRfiTender.DataSource = dtRfiTenders;
                    dvRfiTender.DataBind();
                }
                else
                    success = false;

                string style = "style='color:red;font-family:arial;font-size:11px;padding-left:15px;'";

                if (!success)
                {
                    litMsg.Text = "<div " + style + ">" + BR + "Please check the following:" + errMsg + "</div>";

                    if ((tbAmount.Text == "0") || (tbAmount.Text == ""))
                    {
                        lbAmount.Text = "* Required";
                    }
                    else
                    {
                        lbAmount.Text = "";
                    }

                    if ((tbWarranty.Text == "0") || (tbWarranty.Text == ""))
                    {
                        lbWarranty.Text = "* Required";
                    }
                    else
                    {
                        lbWarranty.Text = "";
                    }
                }
                else
                {
                    litMsg.Text = "<div " + style + ">" + BR + "Changes saved.</div>";
                }
            }
            else
            {
                litMsg.Text = "<p style='color:red;'>" + "RFI submission deadline (" + GetSubmissionDeadline().ToString() + ") has been reached." + "</p>";
            }
        }
    }

    private bool AreRfiTenderInputsValid(ref string msg,
            string amount, string discount, string deliverycost, string total,
            string warranty, string comment)
    {
        StringBuilder sb = new StringBuilder();
        if (!FormattingHelper.IsNumeric(amount, System.Globalization.NumberStyles.Float | System.Globalization.NumberStyles.AllowThousands))
        {   // AMOUNT IS NOT VALID
            sb.Append(BR_BULLET + " Unit price is invalid.");
        }
        if (!FormattingHelper.IsNumeric(discount, System.Globalization.NumberStyles.Float | System.Globalization.NumberStyles.AllowThousands))
        {   // DISCOUNT IS NOT VALID
            sb.Append(BR_BULLET + " Discount is invalid.");
        }
        if (!FormattingHelper.IsNumeric(deliverycost, System.Globalization.NumberStyles.Float | System.Globalization.NumberStyles.AllowThousands))
        {   // DELIVERY COST IS NOT VALID
            sb.Append(BR_BULLET + " Delivery Cost is invalid.");
        }
        if (!FormattingHelper.IsNumeric(total, System.Globalization.NumberStyles.Float | System.Globalization.NumberStyles.AllowThousands))
        {   // TOTAL IS NOT VALID
            sb.Append(BR_BULLET + " Total is invalid.");
        }
        if (double.Parse(amount) <= 0)
        {   // TOTAL IS NOT VALID
            sb.Append(BR_BULLET + " Unit price is required.");
        }
        else if (double.Parse(total) == 0)
        {   // TOTAL IS NOT VALID
            sb.Append(BR_BULLET + " Unit price is required.");
        }
        if (double.Parse(total) < 0)
        {   // TOTAL IS NOT VALID
            sb.Append(BR_BULLET + " Please check your inputs.");
        }
        if (String.IsNullOrEmpty(warranty))
        {   // WARRANTY IS REQUIRED
            sb.Append(BR_BULLET + " Warranty is required.");
        }
        msg = sb.ToString();
        return !(sb.ToString().Length > 0);
    }

    protected void dvRfiTender_DataBound(object sender, EventArgs e)
    {
        HiddenField hdnQuantity = (HiddenField)FindControl(dvRfiTender, "hdnQuantity");
        Label lbQuantity = (Label)FindControl(dvRfiTender, "lblQuantity");
        TextBox tbAmount = (TextBox)FindControl(dvRfiTender, "txtAmount");
        TextBox tbAmountCents = (TextBox)FindControl(dvRfiTender, "txtAmountCents");
        TextBox tbDiscount = (TextBox)FindControl(dvRfiTender, "txtDiscount");
        TextBox tbDiscountCents = (TextBox)FindControl(dvRfiTender, "txtDiscountCents");
        TextBox tbDeliveryCost = (TextBox)FindControl(dvRfiTender, "txtDeliveryCost");
        TextBox tbDeliveryCostCents = (TextBox)FindControl(dvRfiTender, "txtDeliveryCostCents");
        TextBox tbSubTotalPrice = (TextBox)FindControl(dvRfiTender, "txtSubTotalPrice");
        TextBox tbTotalRfiTenderPrice = (TextBox)FindControl(dvRfiTender, "txtTotalRfiTenderPrice");

        int i = dvRfiTender.PageIndex;
        DataTable dtRfiTenders = (DataTable)ViewState["RfiTenders"];
        DataRow dr = dtRfiTenders.Rows[i];

        string computeTotal = "ComputeGrossTotal(" + hdnQuantity.ClientID + "," + tbAmount.ClientID + "," + tbAmountCents.ClientID + "," + tbDiscount.ClientID + "," + tbDiscountCents.ClientID + "," + tbDeliveryCost.ClientID + "," + tbDeliveryCostCents.ClientID + "," + tbSubTotalPrice.ClientID + "," + tbTotalRfiTenderPrice.ClientID + ");";

        tbAmount.Attributes.Add("style", "text-align: right;");
        tbAmountCents.Attributes.Add("style", "text-align: center;");
        tbDiscount.Attributes.Add("style", "text-align: right;");
        tbDiscountCents.Attributes.Add("style", "text-align: center;");
        tbDeliveryCost.Attributes.Add("style", "text-align: right;");
        tbDeliveryCostCents.Attributes.Add("style", "text-align: center;");

        tbAmount.Attributes.Add("onkeydown", "return DigitsOnlyAndTransferFocus(event, " + tbAmountCents.ClientID + ");");
        tbAmountCents.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        tbDiscount.Attributes.Add("onkeydown", "return DigitsOnlyAndTransferFocus(event, " + tbDiscountCents.ClientID + ");");
        tbDiscountCents.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        tbDeliveryCost.Attributes.Add("onkeydown", "return DigitsOnlyAndTransferFocus(event, " + tbDeliveryCostCents.ClientID + ");");
        tbDeliveryCostCents.Attributes.Add("onkeydown", "return DigitsOnly(event);");

        tbAmount.Attributes.Add("onkeyup", computeTotal);
        tbAmountCents.Attributes.Add("onkeyup", computeTotal);
        tbDeliveryCost.Attributes.Add("onkeyup", computeTotal);
        tbDeliveryCostCents.Attributes.Add("onkeyup", computeTotal);
        tbDiscount.Attributes.Add("onkeyup", computeTotal);
        tbDiscountCents.Attributes.Add("onkeyup", computeTotal);
        tbAmountCents.Attributes.Add("onkeypress", "return DigitsOnlyAndTransferFocus(event, " + tbAmountCents.ClientID + ");");

        tbAmountCents.Attributes.Add("onfocus", tbAmountCents.ClientID + ".select();");
        tbDiscountCents.Attributes.Add("onfocus", tbDiscountCents.ClientID + ".select();");
        tbDeliveryCostCents.Attributes.Add("onfocus", tbDeliveryCostCents.ClientID + ".select();");

        tbAmount.Attributes.Add("onfocusout", "ResetIfEmpty2(this);");
        tbAmountCents.Attributes.Add("onfocusout", "ResetIfEmpty(this);");
        tbDeliveryCost.Attributes.Add("onfocusout", "ResetIfEmpty2(this);");
        tbDeliveryCostCents.Attributes.Add("onfocusout", "ResetIfEmpty(this);");
        tbDiscount.Attributes.Add("onfocusout", "ResetIfEmpty2(this);");
        tbDiscountCents.Attributes.Add("onfocusout", "ResetIfEmpty(this);");

        tbAmount.Attributes.Add("onfocus", computeTotal);
    }

    protected string GetWholeNumberPart(string input)
    {
        string[] s = input.Split(new char[] { '.' }, 2);
        return s[0];
    }

    protected string GetDecimalPart(string input)
    {
        string[] s = input.Split(new char[] { '.' }, 2);
        return s.Length >= 2 ? s[1] : "00";
    }

    #endregion

    #region FINDCONTROL
    private Control FindControlFromDetailsView(DetailsView dv, string ctrlName)
    {
        Control ctrl = null;

        for (int i = 0; i < dv.Rows.Count; i++)
        {
            DetailsViewRow dr = dv.Rows[i];
            for (int j = 0; j < dr.Cells.Count; j++)
            {
                TableCell tc = dr.Cells[j];
                for (int k = 0; k < tc.Controls.Count; k++)
                {
                    if (tc.Controls[k].FindControl(ctrlName) != null)
                        return tc.Controls[k].FindControl(ctrlName);
                }
            }
        }
        return ctrl;
    }

    private Control FindControl(Control parent, string ctrlName)
    {
        Control ctrl = null;

        ctrl = parent.FindControl(ctrlName);

        if (ctrl != null)
            return ctrl;

        for (int i = 0; i < parent.Controls.Count; i++)
        {
            ctrl = FindControl(parent.Controls[i], ctrlName);

            if (ctrl != null)
                return ctrl;
        }

        return ctrl;
    }
    #endregion

    #region ATTACHMENTS
    private DataTable CreateAttachmentsTable()
    {
        DataTable dtAttachments = new DataTable();
        DataColumn dc;
        dc = new DataColumn("ID", typeof(System.Int32));
        dtAttachments.Columns.Add(dc);
        dc = new DataColumn("Original", typeof(System.String));
        dtAttachments.Columns.Add(dc);
        dc = new DataColumn("Actual", typeof(System.String));
        dtAttachments.Columns.Add(dc);
        dc = new DataColumn("Attached", typeof(System.Int32));
        dtAttachments.Columns.Add(dc);
        dc = new DataColumn("IsDetachable", typeof(System.Int32));
        dtAttachments.Columns.Add(dc);
        dc = new DataColumn("AsDraft", typeof(System.Int32));
        dtAttachments.Columns.Add(dc);
        dc = new DataColumn("FileAttachment", typeof(System.String));
        dtAttachments.Columns.Add(dc);

        return dtAttachments;
    }

    private void AddEmptyAttachmentRow(ref DataTable dtAttachments)
    {
        DataRow dr = dtAttachments.NewRow();
        int nxtCounter = 0;
        if (dtAttachments.Rows.Count > 0)
            nxtCounter = int.Parse(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["ID"].ToString()) + 1;

        dr["ID"] = nxtCounter;
        dr["Original"] = "";
        dr["Actual"] = "";
        dr["Attached"] = 0;
        dr["IsDetachable"] = 0;
        dr["AsDraft"] = 1;
        dr["FileAttachment"] = "";
        dtAttachments.Rows.Add(dr);
    }

    private void AddAttachmentRow(ref DataTable dtAttachments, string originalFileName, string actualFileName, string isDetachable, string fileAttachment, string asDraft)
    {
        DataRow dr = dtAttachments.NewRow();
        int nxtCounter = 0;
        if (dtAttachments.Rows.Count > 0)
            nxtCounter = int.Parse(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["ID"].ToString()) + 1;

        dr["ID"] = nxtCounter;
        dr["Original"] = originalFileName;
        dr["Actual"] = actualFileName;
        dr["Attached"] = 1;
        dr["IsDetachable"] = isDetachable;
        dr["AsDraft"] = asDraft;
        dr["FileAttachment"] = fileAttachment;
        dtAttachments.Rows.Add(dr);
    }

    protected bool IsAttached(string isattached)
    {
        return isattached == "1" ? true : false;
    }

    protected bool IsRemovable(string isattached, string isdetachable)
    {
        if ((isattached == "1") && (isdetachable == "1"))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    private void Attach(string original, string actual)
    {
        DataTable dtAttachments = (DataTable)ViewState["RfiTenderAttachments"];

        DataRow dr = dtAttachments.NewRow();
        int nxtCounter = 0;
        if (dtAttachments.Rows.Count > 0)
            nxtCounter = int.Parse(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["ID"].ToString()) + 1;

        dr["ID"] = nxtCounter;
        dr["Original"] = original;
        dr["Actual"] = actual;
        dr["Attached"] = 1;
        dr["IsDetachable"] = 1;
        dr["AsDraft"] = 1;
        dr["FileAttachment"] = actual + "|" + original;
        dtAttachments.Rows.Add(dr);

        ViewState["RfiTenderAttachments"] = dtAttachments;
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }

    private void Remove(int id)
    {
        DataTable dtAttachments = (DataTable)ViewState["RfiTenderAttachments"];
        int toBeRemoved = -1;
        string actualfilepath = Constant.FILEATTACHMENTSFOLDERDIR;

        for (int i = 0; i < dtAttachments.Rows.Count; i++)
        {
            if (dtAttachments.Rows[i]["ID"].ToString() == id.ToString())
            {
                toBeRemoved = i;
                actualfilepath += dtAttachments.Rows[i]["Actual"].ToString();
                break;
            }
        }
        if (toBeRemoved > -1)
        {
            // REMOVE FROM DATATABLE
            dtAttachments.Rows.RemoveAt(toBeRemoved);
            // REMOVE THE ACTUAL FILE
            FileInfo fInfo = new FileInfo(actualfilepath);
            if (fInfo.Exists)
                fInfo.Delete();
        }

        ViewState["RfiTenderAttachments"] = dtAttachments;

        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }

    protected void gvFileAttachment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Attach":
                {
                    if (gvFileAttachment.FooterRow != null)
                    {
                        FileUpload fu = (FileUpload)gvFileAttachment.FooterRow.FindControl("fileUpload");
                        Literal litMsg = (Literal)gvFileAttachment.FooterRow.FindControl("addAttachmentMsg");
                        if (fu.HasFile)
                        {
                            FileInfo fInfo = new FileInfo(fu.PostedFile.FileName);

                            if (!FileUploadHelper.IsFileForbidden(fInfo.Extension))
                            {
                                int fileSize = (fu.PostedFile.ContentLength + 512) / 1024;
                                int maxFileSize = int.Parse(ConfigurationManager.AppSettings["MaxFileSize"].ToString());

                                if (fileSize < maxFileSize)
                                {
                                    string original = fu.FileName.ToString().Trim();
                                    string actual = FileUploadHelper.GetNewAlternativeFileName(Constant.FILEATTACHMENTSFOLDERDIR + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session["RfiRefNo"].ToString() + "\\", Session[Constant.SESSION_USERID.ToString()].ToString() + "_" + Session["RfiRefNo"].ToString() + "_", fInfo.Extension);

                                    try
                                    {
                                        if (!Directory.Exists((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session["RfiRefNo"]))
                                        {
                                            Directory.CreateDirectory((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session["RfiRefNo"]);
                                            fu.SaveAs((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session["RfiRefNo"].ToString() + "\\" + actual);
                                            Attach(original, actual);
                                        }
                                        else
                                        {
                                            fu.SaveAs((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session["RfiRefNo"].ToString() + "\\" + actual);
                                            Attach(original, actual);

                                        }
                                    }
                                    catch
                                    {
                                        litMsg.Text = BR + "&nbsp;&nbsp;&nbsp;" + BULLET + " File cannot be uploaded.";
                                    }
                                }
                                else
                                    litMsg.Text = BR + "&nbsp;&nbsp;&nbsp;" + BULLET + " File size exceeds limit(" + maxFileSize + "KB).";
                            }
                            else
                            {
                                litMsg.Text = BR + "&nbsp;&nbsp;&nbsp;" + BULLET + " File cannot be uploaded. The file type is forbidden to be uploaded.";
                            }
                        }
                    }
                } break;
            case "Remove":
                {
                    Remove(int.Parse(e.CommandArgument.ToString()));
                } break;
            case "Download":
                {
                    string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                    string path = Constant.FILEATTACHMENTSFOLDERDIR + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session["RfiRefNo"].ToString();
                    FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                } break;
        }
    }

    protected void gvFileAttachment_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    #endregion

    protected void cvCheckRfiTender_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (isAllowSubmit())
        {
            // CHECK IF THERE IS A TENDER TO BE SUBMITTED
            DataTable dtRfiTenders = (DataTable)ViewState["RfiTenders"];
            if (dtRfiTenders.Rows.Count > 0)
            {
                int ctr = 0;
                foreach (DataRow dr in dtRfiTenders.Rows)
                {
                    if (double.Parse(dr["Amount"].ToString()) > 0)
                        ctr++;
                }
                // if ctr > 0, then there is a bid tender.. :)
                ViewState["RFITENDERCOUNT"] = ctr;
                args.IsValid = ctr > 0;
            }
            else
                args.IsValid = false;
        }
    }

    protected bool isConverted(object item_status)
        {
            return (
                (int.Parse(item_status.ToString()) == 2) ||
                (int.Parse(item_status.ToString()) == 4)
                );
        }

    protected bool isWithdrawn(object item_status)
        {
            return (
                (int.Parse(item_status.ToString()) == 2) ||
                (int.Parse(item_status.ToString()) == 4)
                );

        }

    private string GetSubmissionDeadline()
        {
            SqlParameter[] sqlParams = new SqlParameter[1];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = int.Parse(Session["RfiRefNo"].ToString());

            return Convert.ToString(SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetRfiEventSubmissionDeadline", sqlParams));
        }

    protected bool isAllowSubmit()
        {
            if ((GetSubmissionDeadline().ToString() != ""))
            {
                DateTime sdate = DateTime.Parse(GetSubmissionDeadline().ToString());
                DateTime dtnow = DateTime.Now;

                if (DateTime.Compare(sdate, dtnow) > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

    //#region EMAIL

    //private bool SendEmailConfirmation(ref int failedCount, ref int successCount)
    //{
    //    bool success = false;
    //    string subject = "Globe Telecom Incorporated / Innove Communications : RFI Confirmation";
    //    failedCount = 0;
    //    successCount = 0;

    //    return success;
    //}

    //private string CreateEmailBody(RfiDetails rfiDetails, RfiParticipant participant)
    //{
    //    StringBuilder sb = new StringBuilder();

    //    sb.Append("<tr><td align='right'><h5>" + DateTime.Now.ToLongDateString() + "</h5></td></tr>");

    //    sb.Append("<tr><td align='center'><h3>RFI CONFIRMED</h3></td></tr>");
    //    sb.Append("<tr>");
    //    sb.Append("<td valign='top'>");
    //    sb.Append("<p>");
    //    sb.Append("<b>TO&nbsp&nbsp;:&nbsp&nbsp;<u>" + "BUYERNAME" +"</u></b>");
    //    sb.Append("<br /><br />");
    //    sb.Append("Good Day!");
    //    sb.Append("<br /><br />");
    //    sb.Append("We are glad to inform you that your submitted RFI event has been confirmed by" +"VENDORNAME");
    //    sb.Append("</p>");
    //    return MailTemplate.IntegrateBodyIntoTemplate(sb.ToString());
    //}

    //private string CreateSMSBody()
    //{
    //    return String.Format("Your submitted RFI event has been confirmed; Ref. No. :{0}, by vendor {1} on {2}");
    //}
    //#endregion
}