using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Text;
using System.Drawing;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EBid.lib.bid.data;
using EBid.lib.bid.trans;
using EBid.lib.constant;
using EBid.lib.auction.data;
using EBid.lib;
using System.IO;
using System.Data.Sql;
using System.Data.SqlClient;





namespace EBid.web.vendor_screens
{
    public partial class tenderDetails : System.Web.UI.Page
    {
        private const string BR = "<br />";
        private const string BULLET = "&#187;";
        private const string BR_BULLET = "<br />&#187;";
        private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();                
            if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.VENDOR)
                Response.Redirect("../unauthorizedaccess.aspx");

            PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Bid Tender Details");

            if (Session[Constant.SESSION_BIDTENDERNO] == null)
            {
                Response.Redirect("bids.aspx");
            }

            litMsg.Text = "";

            if (Session["AsClarified"] != null)
            {
                if (Session["AsClarified"].ToString() == "True")
                {
                    pnlTenderDetails.Visible = true;
                    btnDraft.Visible = false;
                    rfvComment.Enabled = true;
                    btnSubmit.OnClientClick = "return confirm('Are you sure you want to submit this comment?');";
                }
                else
                {
                    pnlEditTenderDetails.Visible = true;
                    btnSubmit.OnClientClick = "return confirm('Are you sure you want to submit this tender?');";
                }
            }
            else
            {
                pnlEditTenderDetails.Visible = true;
                btnSubmit.OnClientClick = "return confirm('Are you sure you want to submit this tender?');";
            }

            if (!IsPostBack)
            {
                InitializeFileAttachments();
            }
            
        }

        #region Action
        protected void btnDraft_Click(object sender, EventArgs e)
        {
            if (isAllowSubmit())
            {
                if (IsValid)
                {
                    if (UpdateTender(0) == false)
                    {
                        //unable to save
                    }
                    else
                    {
                        UpdateBidTenderAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()), 1);
					    
						if ((Session[Constant.SESSION_LASTPAGE].ToString()) == "~/web/vendorscreens/submittedtenders.aspx")
                        {
                            SaveVendorAuditTrail(1);
                        }
                        else if ((Session[Constant.SESSION_LASTPAGE].ToString()) == "~/web/vendorscreens/tenderdrafts.aspx")
                        {                            
                           SaveVendorAuditTrail(3);                            
                        }
                        else if ((Session[Constant.SESSION_LASTPAGE].ToString()) == "~/web/vendorscreens/bidsforrenegotiation.aspx")
                        {
                            SaveVendorAuditTrail(5);
                        }

                        Response.Redirect("tenderDrafts.aspx");
                    }
                }
            }
            else
            {
                if (Session["Renegotiated"] != null)
                {
                    if (Session["Renegotiated"].ToString() == "1")
                    {
                        litErrMsg.Text = "<p style='color:red; align:center;'>" + "Renegotiation deadline (" + GetRenegotiationDeadline().ToString() + ") has been reached." + "</p>";
                    }
                }
                else
                {
                    litErrMsg.Text = "<p style='color:red; align:center;'>" + "Bid submission deadline (" + GetSubmissionDeadline().ToString() + ") has been reached." + "</p>";
                }
            }
        }

        // submit tender for approval / awarding
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (isAllowSubmit())
            {
                if (Session["AsClarified"] != null)
                {
                    if (Session["AsClarified"].ToString() == "True")
                    {
                        if (IsValid)
                        {
                            // bool updateOk = BidTransaction.UpdateBidTenderStatus(Int32.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString()), Constant.BIDTENDER_STATUS.STATUS.SUBMITTED);
                            bool updateOk = BidTransaction.UpdateBidTenderRenegotiationStatus(Int32.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString()), Constant.BIDTENDER_STATUS.RENEGOTIATION_STATUS.VENDOR_TO_BUYER);

                            if (updateOk)
                            {
                                InsertVendorsComments();
                            }

                            if (Session["Renegotiated"] != null)
                            {
                                Response.Redirect("bidsforrenegotiation.aspx");
                            }
                            else
                            {
                                Response.Redirect("submittedtenders.aspx");
                            }
                        }
                    }
                    else
                    {
                        if (IsValid)
                        {

                            bool updateOk = BidTransaction.UpdateBidTenderRenegotiationStatus(Int32.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString()), Constant.BIDTENDER_STATUS.RENEGOTIATION_STATUS.VENDOR_TO_BUYER);

                            if (UpdateTender(1) == false)
                            {
                                //unable to save
                            }
                            else
                            {
                                if (Session["Renegotiated"] != null)
                                {
                                    UpdateBidTenderAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()), 0);
                                    SaveVendorAuditTrail(4);
									Response.Redirect("bidsforrenegotiation.aspx");
                                }
                                else
                                {
                                    UpdateBidTenderAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()), 0);
                                    Response.Redirect("submittedtenders.aspx");
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (IsValid)
                    {
                        if (UpdateTender(1) == false)
                        {
                            //unable to save
                        }
                        else
                        {
                            if (Session["Renegotiated"] != null)
                            {
                                UpdateBidTenderAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()), 0);
                                Response.Redirect("bidsforrenegotiation.aspx");
                            }
                            else
                            {
                                UpdateBidTenderAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()), 0);
                                
								if ((Session[Constant.SESSION_LASTPAGE].ToString()) == "~/web/vendorscreens/submittedtenders.aspx")
                                {
                                    SaveVendorAuditTrail(0);
                                }
                                else if ((Session[Constant.SESSION_LASTPAGE].ToString()) == "~/web/vendorscreens/tenderdrafts.aspx")
                                {
                                        SaveVendorAuditTrail(2);
                                }
                                else if ((Session[Constant.SESSION_LASTPAGE].ToString()) == "~/web/vendorscreens/bidsforrenegotiation.aspx")
                                {                                    
                                        SaveVendorAuditTrail(4);
                                }
								
								Response.Redirect("submittedtenders.aspx");
                            }
                        }
                    }
                }
            }
            else
            {
                if (Session["Renegotiated"] != null)
                {
                    if (Session["Renegotiated"].ToString() == "1")
                    {
                        litErrMsg.Text = "<p style='color:red; align:center;'>" + "Renegotiation deadline (" + GetRenegotiationDeadline().ToString() + ") has been reached." + "</p>";
                    }
                }
                else
                {
                    litErrMsg.Text = "<p style='color:red; align:center;'>" + "Bid submission deadline (" + GetSubmissionDeadline().ToString() + ") has been reached." + "</p>";
                }
            }
        }

        // cancel submission/creation of bid tender
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Session[Constant.SESSION_LASTPAGE] != null)
                Response.Redirect(Session[Constant.SESSION_LASTPAGE].ToString());
            Response.Redirect("bids.aspx");
        }

        private bool CheckInputs()
        {
            return true;
        }
        #endregion

        #region Bid Tenders
        private Boolean UpdateTender(Int32 tenderstatus)
        {
            if (tenderstatus > 1)
            {
                tenderstatus = 1;
            }

            Boolean success = false;

            TextBox tbAmount = (TextBox)FindControlFromDetailsView(dvBidTender, "txtAmount");
            TextBox tbAmountCents = (TextBox)FindControlFromDetailsView(dvBidTender, "txtAmountCents");
            TextBox tbDiscount = (TextBox)FindControlFromDetailsView(dvBidTender, "txtDiscount");
            TextBox tbDiscountCents = (TextBox)FindControlFromDetailsView(dvBidTender, "txtDiscountCents");
            TextBox tbDeliveryCost = (TextBox)FindControlFromDetailsView(dvBidTender, "txtDeliveryCost");
            TextBox tbDeliveryCostCents = (TextBox)FindControlFromDetailsView(dvBidTender, "txtDeliveryCostCents");
            TextBox tbWarranty = (TextBox)FindControlFromDetailsView(dvBidTender, "txtWarranty");
            TextBox tbRemarks = (TextBox)FindControlFromDetailsView(dvBidTender, "txtRemarks");
            TextBox tbTotal = (TextBox)FindControlFromDetailsView(dvBidTender, "txtTotalBidTenderPrice");

            // todo: input checking
            if (tbTotal.Text.Trim() != "0.00")
            {
                // update table
                try
                {
                    UpdateBidTenderRow(double.Parse(tbAmount.Text.Trim() + "." + tbAmountCents.Text.Trim()),
                        double.Parse(tbDiscount.Text.Trim() + "." + tbDiscountCents.Text.Trim()),
                        double.Parse(tbDeliveryCost.Text.Trim() + "." + tbDeliveryCostCents.Text.Trim()),
                        tbWarranty.Text.Trim(), tbRemarks.Text.Trim(), tenderstatus.ToString());

                    success = true;
                }
                catch
                {
                    success = false;
                }
            }
            return success;
        }

        /// <summary>
        /// Updates the Selected BID TENDER and inserts a new comment..
        /// </summary>
        /// <param name="amount"></param>
        /// <param name="discount"></param>
        /// <param name="deliverycost"></param>
        /// <param name="warranty"></param>
        /// <param name="remarks"></param>
        /// <param name="status"></param>
        private void UpdateBidTenderRow(double amount, double discount, double deliverycost,
            string warranty, string remarks, string status)
        {
            //status argument: 0 for Drafts and 1 for Submitted
            // query all bid items for this bid event

            SqlConnection sqlConnect = new SqlConnection(connstring);

            sqlConnect.Open();

            if (Session["Renegotiated"] != null)
            {
                #region Renegotiated
                SqlParameter[] sqlparams = new SqlParameter[7];
                sqlparams[0] = new SqlParameter("@Amount", SqlDbType.Float);
                sqlparams[0].Value = amount;

                sqlparams[1] = new SqlParameter("@Discount", SqlDbType.Float);
                sqlparams[1].Value = discount;

                sqlparams[2] = new SqlParameter("@DeliveryCost", SqlDbType.Float);
                sqlparams[2].Value = deliverycost;

                sqlparams[3] = new SqlParameter("@Warranty", SqlDbType.VarChar);
                sqlparams[3].Value = warranty;

                sqlparams[4] = new SqlParameter("@Remarks", SqlDbType.VarChar);
                sqlparams[4].Value = remarks;

                sqlparams[5] = new SqlParameter("@Status", SqlDbType.Int);
                sqlparams[5].Value = status;

                sqlparams[6] = new SqlParameter("@BidTenderNo", SqlDbType.Int);
                sqlparams[6].Value = Int32.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString());

                SqlHelper.ExecuteNonQuery(sqlConnect, CommandType.StoredProcedure, "sp_UpdateTenderDetailsAndRenegotiationStatus", sqlparams);
                #endregion
            }
            else
            {
                #region Not Renegotiated
                SqlParameter[] sqlparams = new SqlParameter[7];
                sqlparams[0] = new SqlParameter("@Amount", SqlDbType.Float);
                sqlparams[0].Value = amount;

                sqlparams[1] = new SqlParameter("@Discount", SqlDbType.Float);
                sqlparams[1].Value = discount;

                sqlparams[2] = new SqlParameter("@DeliveryCost", SqlDbType.Float);
                sqlparams[2].Value = deliverycost;

                sqlparams[3] = new SqlParameter("@Warranty", SqlDbType.VarChar);
                sqlparams[3].Value = warranty;

                sqlparams[4] = new SqlParameter("@Remarks", SqlDbType.VarChar);
                sqlparams[4].Value = remarks;

                sqlparams[5] = new SqlParameter("@Status", SqlDbType.Int);
                sqlparams[5].Value = status;

                sqlparams[6] = new SqlParameter("@BidTenderNo", SqlDbType.Int);
                sqlparams[6].Value = Int32.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString());

                SqlHelper.ExecuteNonQuery(sqlConnect, CommandType.StoredProcedure, "sp_UpdateTenderDetails", sqlparams);
                #endregion
            }

            sqlConnect.Close();
            InsertVendorsComments();
        }

        private void InsertVendorsComments()
        {
            SqlConnection sqlConnect = new SqlConnection(connstring);
            SqlParameter[] sqlparams_comment = new SqlParameter[4];
            sqlparams_comment[0] = new SqlParameter("@BidTenderNo", SqlDbType.Float);
            sqlparams_comment[0].Value = Int32.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString());

            sqlparams_comment[1] = new SqlParameter("@UserId", SqlDbType.Float);
            sqlparams_comment[1].Value = Int32.Parse(Session[Constant.SESSION_USERID].ToString());

            sqlparams_comment[2] = new SqlParameter("@Comment", SqlDbType.VarChar);

            sqlparams_comment[2].Value = txtComment.Text.Trim() == "" ? null : txtComment.Text.Trim();

            sqlparams_comment[3] = new SqlParameter("@CommentType", SqlDbType.VarChar);
            sqlparams_comment[3].Value = Constant.BIDTENDERCOMMENT_VENDOR_TO_BUYER;

            SqlHelper.ExecuteNonQuery(sqlConnect, CommandType.StoredProcedure, "sp_AddBidTenderComment", sqlparams_comment);

            sqlConnect.Close();
        }

        protected void dvBidTender_DataBound(object sender, EventArgs e)
        {
            HiddenField hdnQuantity = (HiddenField)FindControl(dvBidTender, "hdnQuantity");
            Label lbQuantity = (Label)FindControl(dvBidTender, "lblQuantity");
            TextBox tbAmount = (TextBox)FindControl(dvBidTender, "txtAmount");
            TextBox tbAmountCents = (TextBox)FindControl(dvBidTender, "txtAmountCents");
            TextBox tbDiscount = (TextBox)FindControl(dvBidTender, "txtDiscount");
            TextBox tbDiscountCents = (TextBox)FindControl(dvBidTender, "txtDiscountCents");
            TextBox tbDeliveryCost = (TextBox)FindControl(dvBidTender, "txtDeliveryCost");
            TextBox tbDeliveryCostCents = (TextBox)FindControl(dvBidTender, "txtDeliveryCostCents");
            TextBox tbSubTotalPrice = (TextBox)FindControl(dvBidTender, "txtSubTotalPrice");
            TextBox tbTotalBidTenderPrice = (TextBox)FindControl(dvBidTender, "txtTotalBidTenderPrice");

            string computeTotal = "ComputeGrossTotal(" + hdnQuantity.ClientID + "," + tbAmount.ClientID + "," + tbAmountCents.ClientID + "," + tbDiscount.ClientID + "," + tbDiscountCents.ClientID + "," + tbDeliveryCost.ClientID + "," + tbDeliveryCostCents.ClientID + "," + tbSubTotalPrice.ClientID + "," + tbTotalBidTenderPrice.ClientID + ");";

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

            //tbAmount.Attributes.Add("onkeypress", "return DigitsOnlyAndTransferFocus(event, " + tbAmountCents.ClientID + ");");

            //tbAmount.Attributes.Add("onkeyup", "AutoComma(this);" + computeTotal);
            //tbDeliveryCost.Attributes.Add("onkeyup", "AutoComma(this);" + computeTotal);
            //tbDiscount.Attributes.Add("onkeyup", "AutoComma(this);" + computeTotal);
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

        #region FindControl
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

        private void InitializeFileAttachments()
        {   // get vendor file attachments for this bid event
            
            IEnumerator iEnum = dsFileAttachments.Select(DataSourceSelectArguments.Empty).GetEnumerator();
            DataTable dtAttachments = (DataTable)ViewState["BidTenderAttachments"];
            if (dtAttachments == null)
            {
                dtAttachments = CreateAttachmentsTable();
            }
            // add empty row
            AddEmptyAttachmentRow(ref dtAttachments);

            while (iEnum.MoveNext())
            {
                DataRowView dr = (DataRowView)iEnum.Current;

                AddAttachmentRow(ref dtAttachments, dr["FileUploadId"].ToString(), dr["OriginalFileName"].ToString(), dr["ActualFileName"].ToString(), dr["IsDetachable"].ToString() == "True" ? "1" : "0", dr["FileAttachment"].ToString(), dr["AsDraft"].ToString() == "True" ? "1" : "0");

            }

            // save to viewstate
            ViewState["BidTenderAttachments"] = dtAttachments;
           
            // bind to gridview
            gvFileAttachment.DataSource = dtAttachments;
            gvFileAttachment.DataBind();

        }


        #region Bid Tender Attachments
        private bool SaveBidTenderAttachments(int bidRefNo, int vendorId, int asDraft)
        {
            bool isSuccessful = false;
            try
            {
                DataTable dtAttachments = (DataTable)ViewState["BidTenderAttachments"];
                string s = string.Empty;

                for (int i = 1; i < dtAttachments.Rows.Count; i++)
                {
                    if (asDraft == 1)
                    {
                        if (int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()) == 1)
                        {
                            s += SaveBidTenderAttachments(bidRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 1);
                        }
                        else
                        {
                            s += SaveBidTenderAttachments(bidRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), int.Parse(dtAttachments.Rows[i]["AsDraft"].ToString()));
                        }
                    }
                    else
                    {
                        s += SaveBidTenderAttachments(bidRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 0);
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

        private bool UpdateVendorBidTenderAttachments(int bidRefNo, int vendorId, int asDraft)
        {
            bool isSuccessful = false;
            try
            {
                DataTable dtAttachments = (DataTable)ViewState["BidTenderAttachments"];
                string s = string.Empty;

                for (int i = 1; i < dtAttachments.Rows.Count; i++)
                {
                    if (int.Parse(dtAttachments.Rows[i]["UploadId"].ToString()) == 1)
                    {
                        if (asDraft == 1)
                            {
                                if (int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()) == 1)
                                {
                                    s += SaveBidTenderAttachments(bidRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 1);
                                }
                                else
                                {
                                    s += SaveBidTenderAttachments(bidRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), int.Parse(dtAttachments.Rows[i]["AsDraft"].ToString()));
                                }
                            }
                            else
                            {
                                s += SaveBidTenderAttachments(bidRefNo, vendorId, dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString(), int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 0);
                            }
                    }
					else
                    {
                        if (asDraft == 1)
                        {
                            if (int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()) == 1)
                            {
                                s += UpdateBidTenderAttachments_Vendor(int.Parse(dtAttachments.Rows[i]["UploadId"].ToString()), bidRefNo, vendorId, int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 1);
                            }
                            else
                            {
                                s += UpdateBidTenderAttachments_Vendor(int.Parse(dtAttachments.Rows[i]["UploadId"].ToString()), bidRefNo, vendorId, int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), int.Parse(dtAttachments.Rows[i]["AsDraft"].ToString()));
                            }
                        }
                        else
                        {
                            s += UpdateBidTenderAttachments_Vendor(int.Parse(dtAttachments.Rows[i]["UploadId"].ToString()), bidRefNo, vendorId, int.Parse(dtAttachments.Rows[i]["isDetachable"].ToString()), 0);
                        }
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

        private string SaveBidTenderAttachments(int bidRefNo, int vendorId, string originalFileName, string actualFileName, int isDetachable, int asDraft)
        {
            SqlConnection sqlConnect = new SqlConnection(connstring);
            SqlTransaction sqlTransact = null;
            string isSuccessful = string.Empty;

            try
            {
                sqlConnect.Open();
                sqlTransact = sqlConnect.BeginTransaction();

                SqlParameter[] sqlParams = new SqlParameter[7];
                sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
                sqlParams[0].Value = bidRefNo;
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

                SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_AddVendorTenderFileAttachment", sqlParams);

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
		
		private string UpdateBidTenderAttachments_Vendor(int fileUploadId, int bidRefNo, int vendorId, int isDetachable, int asDraft)
        {
            SqlConnection sqlConnect = new SqlConnection(connstring);
            SqlTransaction sqlTransact = null;
            string isSuccessful = string.Empty;

            try
            {
                sqlConnect.Open();
                sqlTransact = sqlConnect.BeginTransaction();
                                
                SqlParameter[] sqlParams = new SqlParameter[5];
                sqlParams[0] = new SqlParameter("@FileUploadId", SqlDbType.Int);
                sqlParams[0].Value = fileUploadId;
                sqlParams[1] = new SqlParameter("@BidRefNo", SqlDbType.Int);
                sqlParams[1].Value = bidRefNo;
                sqlParams[2] = new SqlParameter("@VendorId", SqlDbType.Int);
                sqlParams[2].Value = vendorId;                
                sqlParams[3] = new SqlParameter("@IsDetachable", SqlDbType.Int);
                sqlParams[3].Value = isDetachable;
                sqlParams[4] = new SqlParameter("@AsDraft", SqlDbType.Int);
                sqlParams[4].Value = asDraft;
                
                SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_UpdateVendorTenderFileAttachment", sqlParams);

                sqlTransact.Commit();
                                
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

        //private bool UpdateBidTenderAttachments(int bidRefNo, int vendorId, int asDraft)
        //{
        //    // just delete all previos attachments of this vendor
        //    if (DeleteBidTenderAttachments(bidRefNo, vendorId))
        //    {
        //        // then add them again                
        //        return SaveBidTenderAttachments(bidRefNo, vendorId, asDraft);
        //    }
        //    else
        //        return false;
        //}

        private bool UpdateBidTenderAttachments(int bidRefNo, int vendorId, int asDraft)
        {

            if (UpdateVendorBidTenderAttachments(bidRefNo, vendorId, asDraft))
            {
                return true;
            }
            else
                return false;
        }

        private bool DeleteBidTenderAttachments(int bidRefNo, int vendorId)
        {
            SqlConnection sqlConnect = new SqlConnection(connstring);
            SqlTransaction sqlTransact = null;
            bool isSuccessful = false;

            try
            {
                sqlConnect.Open();
                sqlTransact = sqlConnect.BeginTransaction();

                SqlParameter[] sqlParams = new SqlParameter[2];
                sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
                sqlParams[0].Value = bidRefNo;
                sqlParams[1] = new SqlParameter("@VendorId", SqlDbType.Int);
                sqlParams[1].Value = vendorId;

                SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteVendorBidEventFileAttachments", sqlParams);

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

        #region Attachments
        private DataTable CreateAttachmentsTable()
        {
            DataTable dtAttachments = new DataTable();
            DataColumn dc;
            dc = new DataColumn("ID", typeof(System.Int32));
            dtAttachments.Columns.Add(dc);
            dc = new DataColumn("UploadId", typeof(System.Int32));
            dtAttachments.Columns.Add(dc);
            dc = new DataColumn("Original", typeof(System.String));
            dtAttachments.Columns.Add(dc);
            dc = new DataColumn("Actual", typeof(System.String));
            dtAttachments.Columns.Add(dc);
            dc = new DataColumn("Attached", typeof(System.Int32));
            dtAttachments.Columns.Add(dc);
            dc = new DataColumn("IsDetachable", typeof(System.Int32));
            dtAttachments.Columns.Add(dc);
            dc = new DataColumn("FileAttachment", typeof(System.String));
            dtAttachments.Columns.Add(dc);
            dc = new DataColumn("AsDraft", typeof(System.String));
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
            dr["UploadId"] = 0;
            dr["Original"] = "";
            dr["Actual"] = "";
            dr["Attached"] = 0;
            dr["IsDetachable"] = 0;
            dr["FileAttachment"] = "";
            dr["AsDraft"] = 1;
            dtAttachments.Rows.Add(dr);
        }

        private void AddAttachmentRow(ref DataTable dtAttachments, string fileUploadId, string originalFileName, string actualFileName, string isDetachable, string fileAttachment, string asDraft)
        {
            DataRow dr = dtAttachments.NewRow();
            int nxtCounter = 0;
            if (dtAttachments.Rows.Count > 0)
                nxtCounter = int.Parse(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["ID"].ToString()) + 1;

            dr["ID"] = nxtCounter;
            dr["UploadId"] = fileUploadId;
            dr["Original"] = originalFileName;
            dr["Actual"] = actualFileName;
            dr["Attached"] = 1;
            dr["IsDetachable"] = isDetachable;
            dr["FileAttachment"] = fileAttachment;
            dr["AsDraft"] = asDraft;
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

        //protected bool IsUpdatedAttachment(string fileuploadid)
        //{
        //    GetFileAttachmentDateUpload(fileuploadid);
            
        //    DateTime sdate = DateTime.Parse(GetSubmissionDeadline().ToString());
        //    DateTime udate = DateTime.Parse(GetFileAttachmentDateUpload(fileuploadid).ToString());

        //    if (DateTime.Compare(udate, sdate) > 0)
        //    {
        //        return true;
        //    }
        //    else
        //    {
        //        return false;
        //    }
        //}
        
        protected bool IsUpdatedAttachment(string attachmentfile)
        {
            if ((GetBidTenderStatus() == "3") || (GetBidTenderStatus() == "0") && (GetBidTenderRenegotiationStatus() == "3"))
            {
                string sCommand;
                string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
                SqlDataReader oReader;

                sCommand = "SELECT t1.DateUploaded, t1.ActualFileName, t2.Deadline from tblVendorFileUploads t1, tblBidItems t2 Where t1.ActualFileName = '" + attachmentfile + "' AND t2.BidRefNo = " + Session[Constant.SESSION_BIDREFNO.ToString()].ToString();
                oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);

                if (oReader.HasRows)
                {
                    oReader.Read();
					
					
					
                    DateTime deadline = DateTime.Parse(oReader["Deadline"].ToString().Trim());
                    DateTime dateUpload = DateTime.Parse(oReader["DateUploaded"].ToString().Trim());
					//DateTime dateRenegotiate = DateTime.ParseExact(oReader["DateRenegotiated"].ToString().Trim(), "M/d/yyyy h:mm:ss tt", CultureInfo.InvariantCulture);
					//DateTime dateUpload = DateTime.ParseExact(oReader["DateUploaded"].ToString().Trim(), "M/d/yyyy h:mm:ss tt", CultureInfo.InvariantCulture);

                    if (dateUpload > deadline)
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
                    return true;
                } oReader.Close();
            }
            //else if ((GetBidTenderStatus() == "1") || (GetBidTenderStatus() == "2") || (GetBidTenderStatus() == "4") || (GetBidTenderStatus() == "5") || (GetBidTenderStatus() == "6") || (GetBidTenderStatus() == "7") || (GetBidTenderStatus() == "0") && (GetBidTenderRenegotiationStatus() != "3"))
            else if ((GetBidTenderStatus() != "3") || (GetBidTenderStatus() == "0") && (GetBidTenderRenegotiationStatus() != "3"))
            {
                return true;
            }
            else
                return false;
        }

        protected bool IsNotForClarification()
        {
            if (GetBidTenderStatus() == "3")
            {
                return false;
            }
            else if (GetBidTenderStatus() == "0")
            {
                if (GetBidTenderRenegotiationStatus() == "3")
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                return true;
            }
        }

        private void Attach(string original, string actual)
        {
            DataTable dtAttachments = (DataTable)ViewState["BidTenderAttachments"];

            DataRow dr = dtAttachments.NewRow();
            int nxtCounter = 0;
            if (dtAttachments.Rows.Count > 0)
                nxtCounter = int.Parse(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["ID"].ToString()) + 1;

            dr["ID"] = nxtCounter;
            dr["UploadId"] = 1;
            dr["Original"] = original;
            dr["Actual"] = actual;
            dr["Attached"] = 1;
            dr["IsDetachable"] = 1;
            dr["FileAttachment"] = actual + "|" + original;
            dr["AsDraft"] = 1;
            dtAttachments.Rows.Add(dr);
			
			Session["AttachmentFileName"] = dr["Original"].ToString();
            SaveVendorAuditTrail(8);

            ViewState["BidTenderAttachments"] = dtAttachments;
            gvFileAttachment.DataSource = dtAttachments;
            gvFileAttachment.DataBind();
        }

        private void Remove(int id)
        {
            DataTable dtAttachments = (DataTable)ViewState["BidTenderAttachments"];
            int toBeRemoved = -1;
            string actualfilepath = Constant.FILEATTACHMENTSFOLDERDIR;

            for (int i = 0; i < dtAttachments.Rows.Count; i++)
            {
                if (dtAttachments.Rows[i]["ID"].ToString() == id.ToString())
                {
                    toBeRemoved = i;
                    actualfilepath += dtAttachments.Rows[i]["Actual"].ToString();
                    Session["AttachmentFileName"] = dtAttachments.Rows[i]["Original"].ToString();
                    break;
                }
            }
            if (toBeRemoved > -1)
            {
                if (dtAttachments.Rows[toBeRemoved]["UploadId"].ToString() != "1")
                {
                    //int removeAttachment = int.Parse(dtAttachments.Rows[toBeRemoved]["UploadId"].ToString());
                    if (DeleteVendorFileAttachment(int.Parse(dtAttachments.Rows[toBeRemoved]["UploadId"].ToString())))
                    {
                        // remove from datatable
                        dtAttachments.Rows.RemoveAt(toBeRemoved);
                        // remove the actual file
                        FileInfo fInfo = new FileInfo(actualfilepath);
                        if (fInfo.Exists)
                        {
                            fInfo.Delete();
                        }
                    }

                }
                else
                {
                    // remove from datatable
                    dtAttachments.Rows.RemoveAt(toBeRemoved);
                    // remove the actual file
                    FileInfo fInfo = new FileInfo(actualfilepath);
                    if (fInfo.Exists)
                    {
                        fInfo.Delete();
                    }
                }
                SaveVendorAuditTrail(9);
            }

            ViewState["BidTenderAttachments"] = dtAttachments;

            gvFileAttachment.DataSource = dtAttachments;
            gvFileAttachment.DataBind();
        }
        
        private bool DeleteVendorFileAttachment(int uploadid)
        {
            SqlConnection sqlConnect = new SqlConnection(connstring);
            SqlTransaction sqlTransact = null;
            bool isSuccessful = false;

            try
            {
                sqlConnect.Open();
                sqlTransact = sqlConnect.BeginTransaction();

                SqlParameter[] sqlParams = new SqlParameter[1];
                sqlParams[0] = new SqlParameter("@FileUploadID", SqlDbType.Int);
                sqlParams[0].Value = uploadid;

                SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteVendorFileAttachments", sqlParams);

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
                                        string actual = FileUploadHelper.GetNewAlternativeFileName(Constant.FILEATTACHMENTSFOLDERDIR + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\", Session[Constant.SESSION_USERID.ToString()].ToString() + "_" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "_", fInfo.Extension);
                                        try
                                        {
                                            if (!Directory.Exists((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()]))
                                            {
                                                Directory.CreateDirectory((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()]);
                                                fu.SaveAs((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\" + actual);
                                                Attach(original, actual);
                                            }
                                            else
                                            {
                                                fu.SaveAs((Constant.FILEATTACHMENTSFOLDERDIR) + "\\" + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\" + actual);
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
                        string path = Constant.FILEATTACHMENTSFOLDERDIR + Session[Constant.SESSION_USERID.ToString()].ToString() + "\\" + Session[Constant.SESSION_BIDREFNO.ToString()].ToString() + "\\";
                        FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                    } break;
            }
        }


        #endregion

        private string GetSubmissionDeadline()
        {
            SqlParameter[] sqlParams = new SqlParameter[1];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = int.Parse(Session[Constant.SESSION_BIDREFNO].ToString());

            return Convert.ToString(SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetBidEventSubmissionDeadline", sqlParams));
        }

        private string GetFileAttachmentDateUpload(string fileuploadid)
        {
            SqlParameter[] sqlParams = new SqlParameter[2];
            sqlParams[0] = new SqlParameter("@FileUploadId", SqlDbType.Int);
            sqlParams[0].Value = int.Parse(fileuploadid);
            
            return Convert.ToString(SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetFileAttachmentDateUpload", sqlParams));
        }

        private string GetRenegotiationDeadline()
        {
            SqlParameter[] sqlParams = new SqlParameter[1];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = int.Parse(Session[Constant.SESSION_BIDREFNO].ToString());

            return Convert.ToString(SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetBidEventRenegotiationDeadline", sqlParams));
        }
                
        private string GetBidTenderStatus()
        {
            SqlParameter[] sqlParams = new SqlParameter[1];
            sqlParams[0] = new SqlParameter("@BidTenderNo", SqlDbType.Int);
            sqlParams[0].Value = int.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString());

            return Convert.ToString(SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetBidTenderStatus", sqlParams));
        }

        private string GetBidTenderRenegotiationStatus()
        {
            SqlParameter[] sqlParams = new SqlParameter[1];
            sqlParams[0] = new SqlParameter("@BidTenderNo", SqlDbType.Int);
            sqlParams[0].Value = int.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString());

            return Convert.ToString(SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetBidTenderRenegotiationStatus", sqlParams));
        }

        protected bool isAllowSubmit()
        {
            if (Session["Renegotiated"] != null)
            {
                if (Session["Renegotiated"].ToString() == "1")
                {
                    if ((GetRenegotiationDeadline().ToString() != ""))
                    {
                        DateTime sdate = DateTime.Parse(GetRenegotiationDeadline().ToString());
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
                else
                {
                    return false;
                }
            }
            else
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
        }

        protected void cvAmount_ServerValidate(object source, ServerValidateEventArgs args)
        {
            TextBox tbAmount = (TextBox)FindControlFromDetailsView(dvBidTender, "txtAmount");

            if ((tbAmount.Text == "0") || (tbAmount.Text == ""))
            {
                args.IsValid = false;
            }

        }
        protected void cvDiscount_ServerValidate(object source, ServerValidateEventArgs args)
        {
            TextBox tbAmount = (TextBox)FindControlFromDetailsView(dvBidTender, "txtAmount");
            TextBox tbAmountCents = (TextBox)FindControlFromDetailsView(dvBidTender, "txtAmountCents");
            TextBox tbDiscount = (TextBox)FindControlFromDetailsView(dvBidTender, "txtDiscount");
            TextBox tbDiscountCents = (TextBox)FindControlFromDetailsView(dvBidTender, "txtDiscountCents");

            string Amount = tbAmount.Text.ToString().Replace(",", "") + "." + tbAmountCents.Text.ToString();
            string Discount = tbDiscount.Text.ToString().Replace(",", "") + "." + tbDiscountCents.Text.ToString();

            if (Double.Parse(Discount) >= Double.Parse(Amount))
            {
                args.IsValid = false;
            }
        }
        private void CreateFolderByUserId()
        {
            if (!Directory.Exists(Constant.SESSION_USERID.ToString()))
                Directory.CreateDirectory(Constant.SESSION_USERID.ToString());
        }
        private void CreateFolderByBidRefNo()
        {
            if (!Directory.Exists(Constant.SESSION_BIDREFNO.ToString()))
                Directory.CreateDirectory(Constant.SESSION_BIDREFNO.ToString());
        }
		
		private int SaveVendorAuditTrail(int DraftSubmit)
        {
            System.Web.HttpBrowserCapabilities browser = Request.Browser;
            string Browser = "Type = " + browser.Type + " Name = " + browser.Browser + " Version = " + browser.Version;
            string url = HttpContext.Current.Request.Url.AbsoluteUri;
            DateTime DateAccessed = DateTime.Now;

            SqlConnection sqlConnect = new SqlConnection(connstring);
            SqlTransaction sqlTransact = null;
            int value = 0;
            string Activity = "";

           switch (DraftSubmit)
            {
                case 0:
                    Activity = "Submitted updated bid tender for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 1:
                    Activity = "Drafted submitted bid tender update for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;                                    
                case 2:
                    Activity = "Submitted drafted bid tender for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 3:
                    Activity = "Updated drafted bid tender for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 4:
                    Activity = "Submitted bid tender for clarification for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 5:
                    Activity = "Drafted bid tender for clarification for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 6:
                    Activity = "Submitted drafted bid tender for clarification for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 7:
                    Activity = "Updated drafted bid tender for clarification for Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 8:
                    Activity = "Attached file with FileName: " + Session["AttachmentFileName"] + " to Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
                case 9:
                    Activity = "Removed file with FileName: " + Session["AttachmentFileName"] + " to Bid Event with BidRefNo: " + Session[Constant.SESSION_BIDREFNO].ToString() + ".";
                    break;
            }
            
            try
            {
                sqlConnect.Open();
                sqlTransact = sqlConnect.BeginTransaction();

                SqlParameter[] sqlParams = new SqlParameter[5];
                sqlParams[0] = new SqlParameter("@UserId", SqlDbType.Int);
                sqlParams[1] = new SqlParameter("@AccessedPage", SqlDbType.NVarChar);
                sqlParams[2] = new SqlParameter("@DateAccessed", SqlDbType.DateTime);
                sqlParams[3] = new SqlParameter("@BrowserType", SqlDbType.NVarChar);
                sqlParams[4] = new SqlParameter("@ActivityDetails", SqlDbType.NVarChar);


                sqlParams[0].Value = Int32.Parse(Session[Constant.SESSION_USERID].ToString());
                sqlParams[1].Value = url;
                sqlParams[2].Value = DateAccessed;
                sqlParams[3].Value = Browser;
                sqlParams[4].Value = Activity;


                value = Convert.ToInt32(SqlHelper.ExecuteScalar(sqlTransact, "sp_AddVendorAuditTrail", sqlParams));

                sqlTransact.Commit();
            }
            catch
            {
                sqlTransact.Rollback();
                value = 0;
            }
            finally
            {
                sqlConnect.Close();
            }

            return value;
        }
        
}
}