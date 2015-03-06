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
using EBid.lib.bid.trans;
using EBid.lib.bid.data;
using EBid.lib.constant;
using EBid.lib;
using System.IO;
using System.Xml;
using System.Text;
using CalendarControl;
using System.Data.Sql;
using System.Data.SqlClient;

/// <summary>
/// Creates RFI
/// Created By: E.Tan
/// Date Created: 12/28/2012
/// </summary>

public partial class web_buyerscreens_createnewrfi : System.Web.UI.Page
{
    private const string BR = "<br />";
    private const string BULLET = "&#187;";
    private const string BR_BULLET = "<br />&#187;";
    private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
    private string selectedCurrency = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Create New RFI Event");

        if (Session["AddRfiEventMessage"] != null)
        {
            lblMessage.Visible = true;
            lblMessage.Text = Session["AddRfiEventMessage"].ToString();
            Session["AddRfiEventMessage"] = null;
        }
        else
            lblMessage.Visible = false;

        if (!IsPostBack)
        {
            //INITIALIZE FOR ADDING
            InitializeControls();
            InitializeEmptyRowsForGridViews();
            ViewState["RemovedCtr"] = "0";
        }
        AddOTLS();
    }

    void SuppliersLst_Disabled()
    {
        lstSupplierB.Enabled = false;
        btnSelectAll.Disabled = true;
        btnSelectOne.Disabled = true;
        btnDeselectOne.Disabled = true;
        btnDeselectAll.Disabled = true;
        lstSupplierA.Enabled = false;
    }

    void SuppliersLst_Enabled()
    {
        lstSupplierB.Enabled = true;
        btnSelectAll.Disabled = false;
        btnSelectOne.Disabled = false;
        btnDeselectOne.Disabled = false;
        btnDeselectAll.Disabled = false;
        lstSupplierA.Enabled = true;
    }

    protected void Page_Unload(object sender, EventArgs e)
    {
        double s = GetEstimatedEventCostInPHP();
    }

    #region INITIALIZE
    private void InitializeControls()
    {
        txtDeadlineHH.Attributes.Add("onfocus", txtDeadlineHH.ClientID + ".select();");
        txtDeadlineMM.Attributes.Add("onfocus", txtDeadlineMM.ClientID + ".select();");
        txtDeadlineSS.Attributes.Add("onfocus", txtDeadlineSS.ClientID + ".select();");
        txtDeadlineHH.Attributes.Add("style", "text-align:center;");
        txtDeadlineMM.Attributes.Add("style", "text-align:center;");
        txtDeadlineSS.Attributes.Add("style", "text-align:center;");
        ddlDeadline.SelectedValue = "PM";
        clndrDeadline.Attributes.Add("style", "text-align:center;");
        lstSupplierA.Attributes.Add("ondblclick", "__doPostBack('btnSelectOne','')");
        lstSupplierB.Attributes.Add("ondblclick", "__doPostBack('btnDeselectOne','')");
        txtDeadlineHH.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        txtDeadlineMM.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        txtDeadlineSS.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        txtDeadlineHH.Attributes.Add("onfocusout", "ResetIfEmpty(this);");
        txtDeadlineMM.Attributes.Add("onfocusout", "ResetIfEmpty(this);");
        txtDeadlineSS.Attributes.Add("onfocusout", "ResetIfEmpty(this);");
        ddlIncoterm.SelectedValue = "11";
        ddlCurrency.Attributes.Add("onchange", "ShowPHPConversion();");
        Page.ClientScript.RegisterStartupScript(this.GetType(), "show1", "ShowPHPConversion();", true);
        clndrDeadline.Text = DateTime.Now.AddDays(7.0).ToShortDateString();
        txtDeadlineHH.Text = "6";
        lnkAddOTLS.NavigateUrl = "javascript:AddOTLS('" + ddlCategory.ClientID + "', '" + ddlSubCategory.ClientID + "');";
    }

    private void InitializeRowsForGridViews()
    {
        FillRfiEventDetails();

        #region RFI Items
        DataTable dtRfiItems = CreateRfiItemsTable();
        // Add empty row
        AddEmptyItemsRow(ref dtRfiItems);
        // Save to viewstate
        ViewState["RfiEventItems"] = dtRfiItems;
        // Bind to gridview
        gvRfiItems.DataSource = dtRfiItems;
        gvRfiItems.DataBind();
        // Fill RFI event items
        FillRfiEventItems(ref dtRfiItems);
        // Save to viewstate
        ViewState["RfiEventItems"] = dtRfiItems;
        ViewState["RfiEventExistingItems"] = dtRfiItems;
        // Bind to gridview
        gvRfiItems.DataSource = dtRfiItems;
        gvRfiItems.DataBind();
        #endregion

        #region Attachments
        DataTable dtAttachments = CreateAttachmentsTable();
        // Add empty row
        AddEmptyAttachmentRow(ref dtAttachments);
        // Save to viewstate
        ViewState["RfiEventAttachments"] = dtAttachments;
        // Bind to gridview
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
        FillRfiEventAttachments(ref dtAttachments);
        // Save to viewstate
        ViewState["RfiEventAttachments"] = dtAttachments;
        ViewState["RfiEventExistingAttachments"] = dtAttachments;
        // Bind to gridview
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
        #endregion

        DataTable dtParticipants = CreateParticipantsTable();
        FillRfiEventParticipants(ref dtParticipants);
        ViewState["RfiEventParticipants"] = dtParticipants;
    }

    private void InitializeEmptyRowsForGridViews()
    {
        #region RFI Items
        DataTable dtRfiItems = CreateRfiItemsTable();
        // add empty row
        AddEmptyItemsRow(ref dtRfiItems);
        // save to viewstate
        ViewState["RfiEventItems"] = dtRfiItems;
        // bind to gridview
        gvRfiItems.DataSource = dtRfiItems;
        gvRfiItems.DataBind();
        #endregion

        #region Attachments
        DataTable dtAttachments = CreateAttachmentsTable();
        // add empty row
        AddEmptyAttachmentRow(ref dtAttachments);
        // save to viewstate
        ViewState["RfiEventAttachments"] = dtAttachments;
        // bind to gridview
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
        #endregion
    }
    #endregion

    private int GetSelectedIndex(DropDownList ddl, string start)
    {
        for (int i = 0; i < ddl.Items.Count; i++)
        {
            ListItem item = ddl.Items[i];
            if (item.Value.StartsWith(start))
                return i;
        }
        return 0;
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
        dtAttachments.Rows.Add(dr);
    }

    private void AddEmptyItemsRow(ref DataTable dtRfiItems)
    {
        DataRow dr = dtRfiItems.NewRow();
        int nxtCounter = 0;
        if (dtRfiItems.Rows.Count > 0)
            nxtCounter = int.Parse(dtRfiItems.Rows[dtRfiItems.Rows.Count - 1]["ID"].ToString()) + 1;

        dr["ID"] = nxtCounter;
        dr["Item"] = "";
        dr["Description"] = "";
        dr["Quantity"] = 0.0;
        dr["UnitOfMeasure"] = "";
        dr["UnitPrice"] = 0.0;
        dr["DeliveryDate"] = DateTime.Now;
        dr["SKU"] = "";
        dr["EstimatedTotal"] = 0.0;
        dr["IsEmpty"] = 0;
        dtRfiItems.Rows.Add(dr);
    }

    #region FILL METHODS
    private void FillRfiEventDetails()
    {
        IEnumerator iEnum = dsEventDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {
            DataRowView dRView = (DataRowView)iEnum.Current;
            //txtRefNo.Text = dRView["RfiRefNo"].ToString();
            if (dRView["RfiRefNo"] != null)
            {
                lblRefNo.Text = dRView["RfiRefNo"].ToString();
                lblRefNo.ForeColor = System.Drawing.Color.Black;
                lblRefNo.Font.Bold = true;
            }
            else
            {
                lblRefNo.Text = "NONE";
                lblRefNo.ForeColor = System.Drawing.Color.Gray;
                lblRefNo.Font.Bold = false;
            }
            
            txtItemDesc.Text = dRView["ItemDesc"].ToString();
            txtRequestor.Text = dRView["Requestor"].ToString();
            ddlCompany.SelectedValue = dRView["CompanyId"].ToString();
            ddlGroupDeptSec.SelectedValue = dRView["GroupDeptSec"].ToString();
            ddlCategory.SelectedValue = dRView["Category"].ToString();
            if (dRView["SubCategory"].ToString().Length > 0)
                ViewState["subcategory"] = dRView["SubCategory"].ToString().Trim();
            clndrDeadline.Text = DateTime.Parse(dRView["Deadline"].ToString()).ToShortDateString();
            txtDeadlineHH.Text = DateTime.Parse(dRView["Deadline"].ToString()).ToString("hh");
            txtDeadlineMM.Text = DateTime.Parse(dRView["Deadline"].ToString()).Minute.ToString();
            txtDeadlineSS.Text = DateTime.Parse(dRView["Deadline"].ToString()).Second.ToString();
            ddlDeadline.SelectedValue = DateTime.Parse(dRView["Deadline"].ToString()).ToString("tt");
            txtDeliverTo.Text = dRView["DeliverTo"].ToString();
            ddlIncoterm.SelectedValue = dRView["IncotermId"].ToString();
            selectedCurrency = dRView["CurrencyId"].ToString();
            txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", double.Parse(dRView["EstItemValue"].ToString()));
            ddlCategory.Enabled = true;
            ddlSubCategory.Enabled = true;
        }
    }

    private void FillRfiEventSKU()
    {
        IEnumerator iEnum = dsItemDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();
        HiddenField hdSKU = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnSKU");

        while (iEnum.MoveNext())
        {

            DataRowView dRView = (DataRowView)iEnum.Current;
            hdSKU.Value = dRView["SKU"].ToString();

        }
    }

    private void FillRfiEventComments()
    {
        IEnumerator iEnum = dsComments.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {

            DataRowView dRView = (DataRowView)iEnum.Current;
            txtComment.Text = dRView["Comment"].ToString();
        }
    }

    private void FillRfiEventItems(ref DataTable dtRfiItems)
    {
        IEnumerator iEnum = dsItemDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {
            DataRow dr = dtRfiItems.NewRow();

            int nxtCounter = 0;
            if (dtRfiItems.Rows.Count > 0)
                nxtCounter = int.Parse(dtRfiItems.Rows[dtRfiItems.Rows.Count - 1]["ID"].ToString()) + 1;

            DataRowView dRView = (DataRowView)iEnum.Current;
            dr["RfiDetailNo"] = dRView["RfiDetailNo"].ToString();
            dr["ID"] = nxtCounter;
            dr["Item"] = dRView["Item"].ToString();
            dr["Description"] = dRView["DetailDesc"].ToString();
            dr["Quantity"] = dRView["Qty"].ToString();
            dr["UnitOfMeasure"] = dRView["UnitOfMeasure"].ToString();
            dr["UnitPrice"] = dRView["UnitPrice"].ToString();
            dr["DeliveryDate"] = dRView["DeliveryDate"].ToString();
            dr["SKU"] = dRView["SKU"].ToString();
            dr["EstimatedTotal"] = dRView["TotalUnitCost"].ToString();
            dr["IsEmpty"] = 1;
            dtRfiItems.Rows.Add(dr);
        }
    }

    private void FillRfiEventAttachments(ref DataTable dtAttachments)
    {
        IEnumerator iEnum = dsAttachments.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {
            DataRow dr = dtAttachments.NewRow();
            DataRowView dRView = (DataRowView)iEnum.Current;
            dr["ID"] = dRView["FileUploadId"].ToString();
            dr["Original"] = dRView["OriginalFileName"].ToString();
            dr["Actual"] = dRView["ActualFileName"].ToString();
            dr["Attached"] = 1;
            dtAttachments.Rows.Add(dr);
        }
    }

    private void FillRfiEventParticipants(ref DataTable dtParticipants)
    {
        IEnumerator iEnum = dsParticipants.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {
            DataRow dr = dtParticipants.NewRow();
            DataRowView dRView = (DataRowView)iEnum.Current;
            dr["VendorId"] = dRView["VendorId"].ToString();
            dtParticipants.Rows.Add(dr);
        }
    }

    private void FillSuppliersB()
    {
        IEnumerator iEnum = dsParticipants.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {
            DataRowView dRView = (DataRowView)iEnum.Current;

            ListItem li = new ListItem(dRView["AccType"].ToString() + dRView["Supplier"].ToString(), dRView["VendorId"].ToString());

            lstSupplierA.Items.Remove(li);
            lstSupplierB.Items.Add(li);
        }
    }

    #endregion

    #region CREATE DATATABLES
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

        return dtAttachments;
    }

    private DataTable CreateParticipantsTable()
    {
        DataTable dtParticipants = new DataTable();
        DataColumn dc;
        dc = new DataColumn("VendorId", typeof(System.String));
        dtParticipants.Columns.Add(dc);

        return dtParticipants;
    }

    private DataTable CreateRfiItemsTable()
    {
        DataTable dtRfiItems = new DataTable();
        DataColumn dc;
        dc = new DataColumn("RfiDetailNo", typeof(System.Int32));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("ID", typeof(System.Int32));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("Item", typeof(System.String));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("Description", typeof(System.String));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("Quantity", typeof(System.Double));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("UnitOfMeasure", typeof(System.String));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("UnitPrice", typeof(System.Double));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("DeliveryDate", typeof(System.DateTime));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("SKU", typeof(System.String));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("EstimatedTotal", typeof(System.Double));
        dtRfiItems.Columns.Add(dc);
        dc = new DataColumn("IsEmpty", typeof(System.Int32));
        dtRfiItems.Columns.Add(dc);

        return dtRfiItems;
    }
    #endregion

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
                                    string actual = FileUploadHelper.GetNewAlternativeFileName(Session[Constant.SESSION_USERID].ToString(), fInfo.Extension);

                                    try
                                    {
                                        fu.SaveAs((Constant.FILEATTACHMENTSFOLDERDIR) + actual);
                                        Attach(original, actual);
                                    }
                                    catch
                                    {
                                        litMsg.Text = BR + "&nbsp;&nbsp;&nbsp;" + BULLET + " File cannot be uploaded.";
                                    }
                                }
                                else
                                {
                                    litMsg.Text = BR + "&nbsp;&nbsp;&nbsp;" + BULLET + " File size exceeds limit(" + maxFileSize + "KB).";
                                }
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
        }
    }

    protected void ddlCategory_DataBound(object sender, EventArgs e)
    {
        ddlCategory.Items.Insert(0, new ListItem("---- SELECT CATEGORY ----", " "));
    }

    protected void ddlSubCategory_DataBound(object sender, EventArgs e)
    {
        ddlSubCategory.Items.Insert(0, new ListItem("---- ALL SUB CATEGORIES ----", " "));

        if (ViewState["subcategory"] != null)

            ddlSubCategory.SelectedValue = ViewState["subcategory"].ToString();

    }

    protected void gvRfiItems_DataBound(object sender, EventArgs e)
    {
        // Get controls
        JSCalendar jc = (JSCalendar)gvRfiItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvRfiItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvRfiItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvRfiItems.FooterRow.FindControl("txtItem");
        HtmlAnchor lnkSelectProducts = (HtmlAnchor)gvRfiItems.FooterRow.FindControl("lnkSelectProduct");
        LinkButton lnkAddItem = (LinkButton)gvRfiItems.FooterRow.FindControl("lnkAddItem");

        if (jc != null)
            jc.Attributes.Add("style", "text-align:center;");

        string ctrlid = tbQty.ClientID.Split(new char[] { '_' })[1];
        lnkSelectProducts.Attributes.Add("onclick", "ShowProducts(" + ddlCategory.ClientID + "," + ddlSubCategory.ClientID + "," + tbItem.ClientID + ",'" + ctrlid + "');");

        tbPriceCents.Attributes.Add("style", "text-align: center;");
        tbPrice.Attributes.Add("style", "text-align: right;");
        tbQty.Attributes.Add("style", "text-align: right;");

        string computeTotal = "ComputeTotal(" + tbQty.ClientID + "," + tbPrice.ClientID + "," + tbPriceCents.ClientID + "," + tbTotal.ClientID + ");";

        tbQty.Attributes.Add("onkeydown", "return DigitsOnly(event);" + computeTotal);
        tbPrice.Attributes.Add("onkeydown", "return DigitsOnlyAndTransferFocus(event, " + tbPriceCents.ClientID + ");" + computeTotal);
        tbPriceCents.Attributes.Add("onkeydown", "return DigitsOnly(event);" + computeTotal);

        tbQty.Attributes.Add("onkeyup", computeTotal);
        tbPrice.Attributes.Add("onkeyup", computeTotal);
        tbPriceCents.Attributes.Add("onkeyup", computeTotal);

        tbQty.Attributes.Add("onfocus", tbQty.ClientID + ".select();");
        tbPrice.Attributes.Add("onfocus", tbPrice.ClientID + ".select();");
        tbPriceCents.Attributes.Add("onfocus", tbPriceCents.ClientID + ".select();");

        tbQty.Attributes.Add("onkeypress", "return DigitsOnly(event);");
        tbPrice.Attributes.Add("onkeypress", "return DigitsOnlyAndTransferFocus(event, " + tbPriceCents.ClientID + ");");
        tbPriceCents.Attributes.Add("onkeypress", "return DigitsOnly(event);");

        tbQty.Attributes.Add("onfocusout", "ResetIfEmpty2(this);" + computeTotal);
        tbPrice.Attributes.Add("onfocusout", "ResetIfEmpty2(this);" + computeTotal);
        tbPriceCents.Attributes.Add("onfocusout", "ResetIfEmpty(this);" + computeTotal);

        tbQty.Attributes.Add("onblur", "ResetIfEmpty2(this);" + computeTotal);
        tbPrice.Attributes.Add("onblur", "ResetIfEmpty2(this);" + computeTotal);
        tbPriceCents.Attributes.Add("onblur", "ResetIfEmpty(this);" + computeTotal);

        txtItemDesc.Attributes.Add("onfocus", computeTotal);

        if (lnkAddItem != null)
            lnkAddItem.Attributes.Add("onclick", "ShowPHPConversion();");
    }

    private void Attach(string original, string actual)
    {
        DataTable dtAttachments = (DataTable)ViewState["RfiEventAttachments"];

        DataRow dr = dtAttachments.NewRow();
        int nxtCounter = 0;
        if (dtAttachments.Rows.Count > 0)
            nxtCounter = int.Parse(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["ID"].ToString()) + 1;

        dr["ID"] = nxtCounter;
        dr["Original"] = original;
        dr["Actual"] = actual;
        dr["Attached"] = 1;
        dtAttachments.Rows.Add(dr);

        ViewState["RfiEventAttachments"] = dtAttachments;
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }

    private void Remove(int id)
    {
        DataTable dtAttachments = (DataTable)ViewState["RfiEventAttachments"];
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
            // remove from datatable
            dtAttachments.Rows.RemoveAt(toBeRemoved);

            // remove the actual file
            FileInfo fInfo = new FileInfo(actualfilepath);
            if (fInfo.Exists)
                fInfo.Delete();
        }

        ViewState["RfiEventAttachments"] = dtAttachments;

        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }

    protected bool IsAttached(string isattached)
    {
        return isattached == "1" ? true : false;
    }

    protected void btnSelectAll_ServerClick(object sender, EventArgs e)
    {
        while (lstSupplierA.Items.Count > 0)
        {
            // get topmost item, at a time
            ListItem li = lstSupplierA.Items[0];
            li.Selected = false;
            // add to the right list
            lstSupplierB.Items.Add(li);
            // remove from left list
            lstSupplierA.Items.Remove(li);
        }
    }

    protected void btnDeselectAll_ServerClick(object sender, EventArgs e)
    {
        while (lstSupplierB.Items.Count > 0)
        {
            // get topmost item, at a time
            ListItem li = lstSupplierB.Items[0];
            li.Selected = false;
            // add to the left list
            lstSupplierA.Items.Add(li);
            // remove from right list
            lstSupplierB.Items.Remove(li);
        }
    }

    protected void btnSelectOne_ServerClick(object sender, EventArgs e)
    {
        ListItemCollection listCollection = new ListItemCollection();
        // get selected items
        for (int i = 0; i < lstSupplierA.Items.Count; i++)
        {
            ListItem li = lstSupplierA.Items[i];
            if (li.Selected)
                listCollection.Add(li);
        }
        // add selected items to the right, then remove it from the left
        for (int j = 0; j < listCollection.Count; j++)
        {
            ListItem li = listCollection[j];
            li.Selected = false;
            // add to the right
            lstSupplierB.Items.Add(li);
            // remove from the left
            lstSupplierA.Items.Remove(li);
        }
    }

    protected void btnDeselectOne_ServerClick(object sender, EventArgs e)
    {
        ListItemCollection listCollection = new ListItemCollection();
        // get selected items
        for (int i = 0; i < lstSupplierB.Items.Count; i++)
        {
            ListItem li = lstSupplierB.Items[i];
            if (li.Selected)
                listCollection.Add(li);
        }
        // add selected items to the left, then remove it from the right
        for (int j = 0; j < listCollection.Count; j++)
        {
            ListItem li = listCollection[j];
            li.Selected = false;
            // add to the left
            lstSupplierA.Items.Add(li);
            // remove from the right
            lstSupplierB.Items.Remove(li);
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        lstSupplierB.Items.Clear();
    }

    protected void gvRfiItems_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Literal litMsg = (Literal)gvRfiItems.FooterRow.FindControl("addItemMsg");
        switch (e.CommandName)
        {
            case "Add":
                {
                    litMsg.Text = AddToRfiItemsList();
                }
                break;
            case "Remove":
                {
                    RemoveFromRfiItemList(int.Parse(e.CommandArgument.ToString()));
                }
                break;
            case "EditItem":
                {
                    EditItem(int.Parse(e.CommandArgument.ToString()));
                }
                break;
            case "UpdateItem":
                {
                    UpdateRfiEventItem();
                }
                break;
            case "CancelUpdate":
                {
                    CancelUpdateItem();
                }
                break;
        }
    }

    private string AddToRfiItemsList()
    {
        // GET CONTROLS       
        TextBox tbItem = (TextBox)gvRfiItems.FooterRow.FindControl("txtItem");
        TextBox tbDescription = (TextBox)gvRfiItems.FooterRow.FindControl("txtDescription");
        HiddenField hdSKU = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnSKU");
        JSCalendar jc = (JSCalendar)gvRfiItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvRfiItems.FooterRow.FindControl("txtQuantity");
        TextBox tbUOF = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitOfMeasure");
        TextBox tbPrice = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvRfiItems.FooterRow.FindControl("txtTotalPrice");

        string msg = "";

        if (IsRfiItemInputsValid(tbItem.Text.Trim(), tbDescription.Text.Trim(), hdSKU.Value.Trim(), jc.Text.Trim(),
            tbQty.Text.Trim(), tbUOF.Text.Trim(), tbPrice.Text.Trim() + "." + tbPriceCents.Text.Trim(), tbTotal.Text.Trim(), ref msg))
        {   // if input is ok, proceed to adding of items in the list
            DataTable dtRfiItems = (DataTable)ViewState["RfiEventItems"];

            DataRow dr = dtRfiItems.NewRow();
            int nxtCounter = 0;
            if (dtRfiItems.Rows.Count > 0)
                nxtCounter = int.Parse(dtRfiItems.Rows[dtRfiItems.Rows.Count - 1]["ID"].ToString()) + 1;

            dr["ID"] = nxtCounter;
            dr["Item"] = tbItem.Text.Trim();
            dr["Description"] = tbDescription.Text.Trim();
            dr["Quantity"] = double.Parse(tbQty.Text.Trim());
            dr["UnitOfMeasure"] = tbUOF.Text.Trim();
            dr["UnitPrice"] = double.Parse(tbPrice.Text.Trim() + "." + tbPriceCents.Text.Trim());
            dr["DeliveryDate"] = DateTime.Parse(jc.Text.Trim());
            dr["SKU"] = hdSKU.Value.Trim();
            double total = double.Parse(tbQty.Text.Trim()) * double.Parse(tbPrice.Text.Trim() + "." + tbPriceCents.Text.Trim());
            dr["EstimatedTotal"] = total;
            dr["IsEmpty"] = 1;
            dtRfiItems.Rows.Add(dr);

            // add to total event cost
            double newTotal = total + double.Parse(txtTotalEventPrice.Text.Trim());
            txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);

            ViewState["RfiEventItems"] = dtRfiItems;
            gvRfiItems.DataSource = dtRfiItems;
            gvRfiItems.DataBind();

            ddlCategory.Enabled = true;
            ddlSubCategory.Enabled = true;
        }
        else
        {   // if input is not ok
        }

        return msg;
    }

    private void EditItem(int id)
    {
        JSCalendar jc = (JSCalendar)gvRfiItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvRfiItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvRfiItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvRfiItems.FooterRow.FindControl("txtItem");
        TextBox tbDesc = (TextBox)gvRfiItems.FooterRow.FindControl("txtDescription");
        TextBox tbUnitOfMeasure = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitOfMeasure");
        HiddenField hfSKU = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnSKU");
        HiddenField hfID = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnID");
        LinkButton lnkAddItem = (LinkButton)gvRfiItems.FooterRow.FindControl("lnkAddItem");
        LinkButton lnkUpdate = (LinkButton)gvRfiItems.FooterRow.FindControl("lnkUpdateItem");
        LinkButton lnkCancel = (LinkButton)gvRfiItems.FooterRow.FindControl("lnkCancelUpdate");

        DataTable dtRfiItems = (DataTable)ViewState["RfiEventItems"];
        int toBeEdited = -1;

        for (int i = 0; i < dtRfiItems.Rows.Count; i++)
        {
            if (dtRfiItems.Rows[i]["ID"].ToString() == id.ToString())
            {
                toBeEdited = i;
                break;
            }
        }

        string unitprice = dtRfiItems.Rows[toBeEdited]["UnitPrice"].ToString().Trim();
        string up = String.Format("{0:F}", Double.Parse(unitprice));
        string[] splitUnitPrice = up.Split(new Char[] { '.' });

        tbItem.Text = dtRfiItems.Rows[toBeEdited]["Item"].ToString().Trim();
        tbDesc.Text = dtRfiItems.Rows[toBeEdited]["Description"].ToString().Trim();
        jc.Text = DateTime.Parse(dtRfiItems.Rows[toBeEdited]["DeliveryDate"].ToString().Trim()).ToShortDateString();
        tbUnitOfMeasure.Text = dtRfiItems.Rows[toBeEdited]["UnitOfMeasure"].ToString().Trim();
        tbQty.Text = dtRfiItems.Rows[toBeEdited]["Quantity"].ToString().Trim();
        tbPrice.Text = splitUnitPrice[0];
        tbPriceCents.Text = splitUnitPrice[1];
        tbTotal.Text = dtRfiItems.Rows[toBeEdited]["EstimatedTotal"].ToString().Trim();
        hfSKU.Value = dtRfiItems.Rows[toBeEdited]["SKU"].ToString().Trim();
        hfID.Value = id.ToString();
        lnkAddItem.Visible = false;
        lnkUpdate.Visible = true;
        lnkCancel.Visible = true;
    }

    private void CancelUpdateItem()
    {
        ClearAllItemInfo();
    }

    private void ClearAllItemInfo()
    {
        JSCalendar jc = (JSCalendar)gvRfiItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvRfiItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvRfiItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvRfiItems.FooterRow.FindControl("txtItem");
        TextBox tbDesc = (TextBox)gvRfiItems.FooterRow.FindControl("txtDescription");
        TextBox tbUnitOfMeasure = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitOfMeasure");
        HiddenField hfSKU = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnSKU");
        HiddenField hfID = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnID");
        LinkButton lnkAddItem = (LinkButton)gvRfiItems.FooterRow.FindControl("lnkAddItem");
        LinkButton lnkUpdate = (LinkButton)gvRfiItems.FooterRow.FindControl("lnkUpdateItem");
        LinkButton lnkCancel = (LinkButton)gvRfiItems.FooterRow.FindControl("lnkCancelUpdate");
        tbItem.Text = "";
        tbDesc.Text = "";
        jc.Text = "";
        tbUnitOfMeasure.Text = "";
        tbQty.Text = "0";
        tbPrice.Text = "0";
        tbPriceCents.Text = "00";
        tbTotal.Text = "0:00";
        hfSKU.Value = "";
        lnkAddItem.Visible = true;
        lnkUpdate.Visible = false;
        lnkCancel.Visible = false;
    }

    private void RemoveFromRfiItemList(int id)
    {
        DataTable dtRfiItems = (DataTable)ViewState["RfiEventItems"];
        int toBeRemoved = -1;
        double itemCost = 0.0;
        int ctr = 0;

        for (int i = 0; i < dtRfiItems.Rows.Count; i++)
        {
            if (dtRfiItems.Rows[i]["ID"].ToString() == id.ToString())
            {
                toBeRemoved = i;
                itemCost = double.Parse(dtRfiItems.Rows[i]["EstimatedTotal"].ToString());
                break;
            }
        }

        // SUBTRACT TO TOTAL EVENT COST
        double newTotal = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
        txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);

        if (toBeRemoved > -1)
            dtRfiItems.Rows.RemoveAt(toBeRemoved);

        if (ViewState["RemovedCtr"] != null)
        {
            ctr = int.Parse(ViewState["RemovedCtr"].ToString());
            ctr = ctr + 1;
        }

        ViewState["RemovedCtr"] = ctr;
        ViewState["RfiEventItems"] = dtRfiItems;

        gvRfiItems.DataSource = dtRfiItems;
        gvRfiItems.DataBind();

        if (gvRfiItems.Rows.Count == 1)
        {
            ddlCategory.Enabled = true;
            ddlSubCategory.Enabled = true;
        }
    }

    private bool IsRfiItemInputsValid(string item, string description, string sku, string deliverydate,
       string qty, string uom, string price, string total, ref string msg)
    {
        StringBuilder sb = new StringBuilder();

        if (String.IsNullOrEmpty(item))
            sb.Append(BR_BULLET + " Item required.");
        if (String.IsNullOrEmpty(description))
            sb.Append(BR_BULLET + " Description required.");
        if (String.IsNullOrEmpty(deliverydate))
            sb.Append(BR_BULLET + " Delivery date required.");
        if (String.IsNullOrEmpty(qty))
            sb.Append(BR_BULLET + " Quantity required.");
        if (String.IsNullOrEmpty(price))
            sb.Append(BR_BULLET + " Estimated unit price required.");
        if (double.Parse(qty) <= 0.0)
            sb.Append(BR_BULLET + " Quantity required.");
        if (double.Parse(price) <= 0.0)
            sb.Append(BR_BULLET + " Estimated unit price required.");

        if (sb.ToString().Trim().Length > 0)
        {
            msg = BR + "Please check the following:" + sb.ToString().Trim();
            return false;
        }
        else
            return true;
    }

    protected void btn_Command(object sender, CommandEventArgs e)
    {
        bool isSuccessful = false;


        switch (e.CommandName)
        {
            case "Submit":
                ViewState["command"] = "submit";
                if (IsValid)
                {
                    Session["AddRfiEventMessage"] = Save(ref isSuccessful);
                }
                else
                {
                    isSuccessful = false;
                }
                break;
            case "Cancel":
                Response.Redirect("submittedrfiitems.aspx");
                break;
        }
        if (isSuccessful)
        {
            Session["AddRfiEventMessage"] = null;
            Response.Redirect("submittedrfiitems.aspx"); //SUBMITTED RFI ITEMS                      
        }
        if (Session["AddRfiEventMessage"] != null)
        {
            lblMessage.Visible = true;
            lblMessage.Text = Session["AddRfiEventMessage"].ToString();
        }
        else
            lblMessage.Visible = false;
    }

    private string Save(ref bool isSuccessful)
    {
        int rrf = 0;
        string msg = string.Empty;

        isSuccessful = false;

        //ADD NEW RFI EVENT
        try
        {
            int stat = Constant.BID_STATUS_APPROVED;
            double d = GetEstimatedEventCostInPHP();

            if (SaveRfiEvent(ref rrf, stat))
            {   // RFI EVENT WAS SAVED 
                if (SaveRfiEventItems(rrf))
                {
                    if (SaveRfiEventAttachments(rrf))
                    {
                        if (SaveRfiEventParticipants(rrf))
                        {
                            if (stat == Constant.BID_STATUS_APPROVED)
                            {
                                if (txtComment.Text.Trim() != string.Empty)
                                    SaveRfiEventComments(rrf, int.Parse(Session[Constant.SESSION_USERID].ToString()), txtComment.Text.Trim());
                                msg = "RFI event was successfully saved.";

                                if (SendEmailToVendors(rrf))
                                    msg = "Email and SMS was sent successfully";
                                else
                                    msg = "Sending of Email failed.";
                            }
                            else
                            {

                                if (txtComment.Text.Trim() != string.Empty)
                                    SaveRfiEventComments(rrf, int.Parse(Session[Constant.SESSION_USERID].ToString()), txtComment.Text.Trim());
                                msg = "RFI event was successfully saved.";
                                // EMAIL IMMEDIATE SUPERVISOR
                            }
                            isSuccessful = true;
                        }
                        else
                        {   // PARTICIPANTS WERE NOT SAVED
                            msg = "Participants - There was an error saving the partcipants for this RFI event. Please try again or contact administrator for help.";
                            // ROLL BACK, DELETE CREATED RFI EVENT
                        }
                    }
                    else
                    {   // ATTACHMENTS WERE NOT SAVED
                        msg = "Attachments - There was an error saving the attachments for this RFI event. Please try again or contact administrator for help.";
                        // ROLL BACK, DELETE CREATED RFI EVENT ATTACHMENTS
                        DeleteCurrentRfiEventAttachments(int.Parse(Session["RfiRefNo"].ToString()));
                    }
                }
                else
                {   // RFI ITEMS WERE NOT SAVED
                    msg = "Items - There was an error saving the bid items for this RFI event. Please try again or contact administrator for help.";
                    // ROLL BACK, DELETE CREATED RFI EVENT ITEMS
                    DeleteCurrentRfiEventItems(int.Parse(Session["RfiRefNo"].ToString()));
                }
            }
            else
            {   // RFI EVENT WAS NOT SUCCESSFULLY SAVED
                msg = "Event - There was an error saving this RFI event. Please try again or contact administrator for help.";
            }

        }
        catch
        {   // ERROR SAVING
            msg = "There was an error saving this RFI event. Please try again or contact administrator for help.";
        }
        return msg;
    }

    #region SAVE RFI
    /// <summary>
    /// SAVE THE RFI EVENT
    /// </summary>
    /// <param name="rfirefno"></param>
    /// <param name="stat"></param>
    /// <returns></returns>
    private bool SaveRfiEvent(ref int rfirefno, int stat)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        bool isSuccessful = false;
        //rfirefno = int.Parse(txtRefNo.Text.Trim());
        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[15];
            //sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            //sqlParams[0].Value = rfirefno;
            sqlParams[0] = new SqlParameter("@Requestor", SqlDbType.VarChar);
            sqlParams[0].Value = txtRequestor.Text.Trim();
            sqlParams[1] = new SqlParameter("@ItemDesc", SqlDbType.VarChar);
            sqlParams[1].Value = txtItemDesc.Text.Trim();
            sqlParams[2] = new SqlParameter("@Deadline", SqlDbType.DateTime);
            if (int.Parse(txtDeadlineHH.Text) > 12)
            {
                sqlParams[2].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + "PM");
            }
            else
            {
                sqlParams[2].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + ddlDeadline.SelectedValue);
            }
            sqlParams[3] = new SqlParameter("@BuyerId", SqlDbType.Int);
            sqlParams[3].Value = int.Parse(Session[Constant.SESSION_USERID].ToString());
            sqlParams[4] = new SqlParameter("@GroupDeptSec", SqlDbType.Int);
            sqlParams[4].Value = int.Parse(ddlGroupDeptSec.SelectedValue);
            sqlParams[5] = new SqlParameter("@Category", SqlDbType.NVarChar);
            sqlParams[5].Value = ddlCategory.SelectedValue;
            sqlParams[6] = new SqlParameter("@SubCategory", SqlDbType.Int);
            if (ddlSubCategory.SelectedValue.Trim() == "")
                sqlParams[6].Value = System.DBNull.Value;
            else
                sqlParams[6].Value = ddlSubCategory.SelectedValue.Trim();
            sqlParams[7] = new SqlParameter("@Status", SqlDbType.Int);
            sqlParams[7].Value = stat;
            sqlParams[8] = new SqlParameter("@CompanyId", SqlDbType.Int);
            sqlParams[8].Value = int.Parse(ddlCompany.SelectedValue);
            sqlParams[9] = new SqlParameter("@ForAuction", SqlDbType.Int);
            sqlParams[9].Value = 0;
            sqlParams[10] = new SqlParameter("@DeliverTo", SqlDbType.VarChar);
            sqlParams[10].Value = txtDeliverTo.Text.Trim();
            sqlParams[11] = new SqlParameter("@Incoterm", SqlDbType.Int);
            sqlParams[11].Value = int.Parse(ddlIncoterm.SelectedValue);
            sqlParams[12] = new SqlParameter("@Currency", SqlDbType.Char);
            sqlParams[12].Value = ddlCurrency.SelectedValue.Substring(0, 3);
            sqlParams[13] = new SqlParameter("@EstItemValue", SqlDbType.Float);
            sqlParams[13].Value = GetEstimatedEventCostInPHP();
            sqlParams[14] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[14].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertRFI", sqlParams);
            sqlTransact.Commit();
            rfirefno = int.Parse(sqlParams[14].Value.ToString().Trim());
            isSuccessful = (rfirefno <= 0 ? false : true);
        }
        catch(Exception ex)
        {
            sqlTransact.Rollback();
            isSuccessful = false;
            Response.Write(ex.Message);
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }

    /// <summary>
    /// SAVE RFI ITEMS FOR THIS RFI EVENT
    /// </summary>
    /// <param name="rfirefno"></param>
    /// <returns></returns>
    private bool SaveRfiEventItems(int rfirefno)
    {
        bool isSuccessful = false;

        try
        {
            DataTable dtRfiItems = (DataTable)ViewState["RfiEventItems"];
            string s = string.Empty;

            for (int i = 1; i < dtRfiItems.Rows.Count; i++)
            {
                s += SaveRfiEventItems(rfirefno, dtRfiItems.Rows[i]["SKU"].ToString().Length == 0 ? Constant.DEFAULTPRODUCTITEM.ToString() : dtRfiItems.Rows[i]["SKU"].ToString(),
                    dtRfiItems.Rows[i]["Description"].ToString(), double.Parse(dtRfiItems.Rows[i]["Quantity"].ToString()),
                    dtRfiItems.Rows[i]["UnitOfMeasure"].ToString(), DateTime.Parse(dtRfiItems.Rows[i]["DeliveryDate"].ToString()),
                    double.Parse(dtRfiItems.Rows[i]["UnitPrice"].ToString()));
            }
            isSuccessful = s.IndexOf("0") >= 0 ? false : true;
        }
        catch (Exception ex)
        {
            isSuccessful = false;
            Response.Write(ex.Message);
        }
        return isSuccessful;
    }

    private string SaveRfiEventItems(int rfirefno, string item, string description, double quantity, string unitofmeasure, DateTime deliverydate, double unitprice)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        string isSuccessful = string.Empty;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[8];
            sqlParams[0] = new SqlParameter("@Item", SqlDbType.VarChar);
            sqlParams[0].Value = item;
            sqlParams[1] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[1].Value = rfirefno;
            sqlParams[2] = new SqlParameter("@DetailDesc", SqlDbType.VarChar);
            sqlParams[2].Value = description;
            sqlParams[3] = new SqlParameter("@Qty", SqlDbType.Float);
            sqlParams[3].Value = quantity;
            sqlParams[4] = new SqlParameter("@UnitOfMeasure", SqlDbType.VarChar);
            sqlParams[4].Value = unitofmeasure;
            sqlParams[5] = new SqlParameter("@DeliveryDate", SqlDbType.DateTime);
            sqlParams[5].Value = deliverydate;
            sqlParams[6] = new SqlParameter("@UnitPrice", SqlDbType.Float);
            sqlParams[6].Value = unitprice;
            sqlParams[7] = new SqlParameter("@RfiDetailNo", SqlDbType.Int);
            sqlParams[7].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertRFIDetail", sqlParams);

            sqlTransact.Commit();

            int r = int.Parse(sqlParams[7].Value.ToString().Trim());
            isSuccessful = (r <= 0 ? "0" : "1");
        }
        catch (Exception ex)
        {
            sqlTransact.Rollback();
            isSuccessful = "0";
            Response.Write(ex.Message);
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }

    /// <summary>
    /// SAVE ATTACHMETNS FOR THIS RFI EVENT
    /// </summary>
    /// <param name="rfirefno"></param>
    /// <returns></returns>
    private bool SaveRfiEventAttachments(int rfirefno)
    {
        bool isSuccessful = false;
        try
        {
            DataTable dtAttachments = (DataTable)ViewState["RfiEventAttachments"];
            string s = string.Empty;

            for (int i = 1; i < dtAttachments.Rows.Count; i++)
            {
                s += SaveRfiEventAttachments(rfirefno, int.Parse(Session[Constant.SESSION_USERID].ToString()), dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString());
            }
            isSuccessful = s.IndexOf("0") >= 0 ? false : true;
        }
        catch
        {
            isSuccessful = false;
        }
        return isSuccessful;
    }

    private string SaveRfiEventAttachments(int rfirefno, int buyerid, string originalfilename, string actualfilename)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        string isSuccessful = string.Empty;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[5];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = rfirefno;
            sqlParams[1] = new SqlParameter("@BuyerId", SqlDbType.Int);
            sqlParams[1].Value = buyerid;
            sqlParams[2] = new SqlParameter("@OriginalFileName", SqlDbType.VarChar);
            sqlParams[2].Value = originalfilename;
            sqlParams[3] = new SqlParameter("@ActualFileName", SqlDbType.VarChar);
            sqlParams[3].Value = actualfilename;
            sqlParams[4] = new SqlParameter("@FileUploadID", SqlDbType.Int);
            sqlParams[4].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertRFIAttachment", sqlParams);

            sqlTransact.Commit();

            int r = int.Parse(sqlParams[4].Value.ToString().Trim());
            isSuccessful = (r <= 0 ? "0" : "1");
        }
        catch (Exception ex)
        {
            sqlTransact.Rollback();
            isSuccessful = "0";
            Response.Write(ex.Message);
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }

    /// <summary>
    /// SAVE THE PARTICIPANTS FOR THIS RFI EVENT
    /// </summary>
    /// <param name="rfirefno"></param>
    /// <returns></returns>
    private bool SaveRfiEventParticipants(int rfirefno)
    {
        bool isSuccessful = false;
        try
        {
            string s = string.Empty;

            for (int i = 0; i < lstSupplierB.Items.Count; i++)
            {
                s += SaveRfiEventParticipants(rfirefno, int.Parse(lstSupplierB.Items[i].Value));
            }

            isSuccessful = s.IndexOf("0") >= 0 ? false : true;
        }
        catch
        {
            isSuccessful = false;
        }
        return isSuccessful;
    }

    private string SaveRfiEventParticipants(int rfirefno, int vendorid)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        string isSuccessful = string.Empty;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = rfirefno;
            sqlParams[1] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[1].Value = vendorid;
            sqlParams[2] = new SqlParameter("@VendorInRfiId", SqlDbType.Int);
            sqlParams[2].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertRFIParticipants", sqlParams);

            sqlTransact.Commit();

            int r = int.Parse(sqlParams[2].Value.ToString().Trim());
            isSuccessful = (r <= 0 ? "0" : "1");
        }
        catch (Exception ex)
        {
            sqlTransact.Rollback();
            isSuccessful = "0";
            Response.Write(ex.Message);
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }

    private void SaveRfiEventComments(int rfirefno, int userid, string comment)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        sqlConnect.Open();
        sqlTransact = sqlConnect.BeginTransaction();

        SqlParameter[] sqlParams = new SqlParameter[5];
        sqlParams[0] = new SqlParameter("@refNo", SqlDbType.Int);
        sqlParams[0].Value = rfirefno;
        Response.Write(rfirefno + "\n");
        sqlParams[1] = new SqlParameter("@userId", SqlDbType.Int);
        sqlParams[1].Value = userid;
        Response.Write(userid + "\n");
        sqlParams[2] = new SqlParameter("@usertype", SqlDbType.Int);
        sqlParams[2].Value = 1;
        sqlParams[3] = new SqlParameter("@isAuction", SqlDbType.Int);
        sqlParams[3].Value = 0;
        sqlParams[4] = new SqlParameter("@comment", SqlDbType.NVarChar);
        sqlParams[4].Value = comment;
        Response.Write(comment + "\n");

        SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertRFIItemsComments", sqlParams);
        sqlTransact.Commit();

    }

    /// <summary>
    /// SENDS EMAIL AND SMS TO VENDORS
    /// </summary>
    /// <param name="rfirefno"></param>
    /// <returns></returns>
    private bool SendEmailToVendors(int rfirefno)
    {
        bool isSuccessful = false;
        try
        {
            ArrayList list = GetSelectedSuppliers(rfirefno);
            RfiDetails details = GetRfiItemDetails(rfirefno);
            int failedCount = 0, successCount = 0;

            if (list.Count > 0)
            {
                if (SendEmailInvitation(rfirefno, details, list, ref failedCount, ref successCount))
                {
                    if ((failedCount == 0) && (successCount > 0))
                    {
                        // SUCCESS
                        Session["Message"] = (successCount == 1 ? "Invitation" : "Invitations") + " were sent successfully.";
                    }
                    else
                    {
                        // FAILED
                        Session["Message"] = "Failed to send " + (list.Count == 1 ? "invitation" : "invitations") + " to " + failedCount + " out of " + list.Count + (list.Count == 1 ? " recipient" : " recipients") + ". Please try again or contact adminitrator for assistance.";
                    }
                }
                else
                {
                    //FAILED
                    Session["Message"] = "Failed to send invitations. Please try again or contact adminitrator for assistance.";
                }
            }
            else
            {
                Session["Message"] = "No invitations sent. Please select suppliers from the given list.";
            }
            isSuccessful = true;
        }
        catch
        {
            // FAILED
            Session["Message"] = "Failed to send invitations. Please try again or contact adminitrator for assistance.";
            isSuccessful = false;
        }

        return isSuccessful;
    }
    #endregion

    #region EMAIL
    private RfiDetails GetRfiItemDetails(int rfirefno)
    {
        DataTable dt = SqlHelper.ExecuteDataset(connstring, "sp_GetRfiInvitationInfo", new SqlParameter[] { new SqlParameter("@RfiRefNo", rfirefno) }).Tables[0];

        RfiDetails item = new RfiDetails();
        if (dt.Rows.Count > 0)
            item = new RfiDetails(dt.Rows[0]);

        return item;
    }

    private ArrayList GetSelectedSuppliers(int rfirefno)
    {
        ArrayList suppliersList = new ArrayList();

        SqlParameter[] sqlParams = new SqlParameter[1];
        sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
        sqlParams[0].Value = rfirefno;
        DataTable dt = new DataTable();

        dt = SqlHelper.ExecuteDataset(connstring, CommandType.StoredProcedure, "sp_RFIGetEmailAddresses", sqlParams).Tables[0];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            RfiParticipant participant = new RfiParticipant();
            participant.ID = int.Parse(dt.Rows[i]["VendorId"].ToString().Trim());
            participant.Name = dt.Rows[i]["VendorName"].ToString().Trim();
            participant.EmailAddress = dt.Rows[i]["VendorEmail"].ToString().Trim();
            participant.MobileNo = dt.Rows[i]["MobileNo"].ToString().Trim();
            suppliersList.Add(participant);
        }
        return suppliersList;
    }

    private bool SendEmailInvitation(int rfirefno, RfiDetails rfiDetails, ArrayList recipients, ref int failedCount, ref int successCount)
    {
        bool success = false;
        string subject = "Globe Telecom Incorporated / Innove Communications : Invitation to RFI";
        failedCount = 0;
        successCount = 0;

        try
        {
            for (int i = 0; i < recipients.Count; i++ )
            {
                RfiParticipant p = (RfiParticipant)recipients[i];

                if(!MailHelper.SendEmail(MailTemplate.GetDefaultSMTPServer(), MailHelper.ChangeToFriendlyName(rfiDetails.Creator, rfiDetails.CreatorEmail), MailHelper.ChangeToFriendlyName(p.Name, p.EmailAddress), subject, CreateInvitationBody(rfiDetails, p), MailTemplate.GetTemplateLinkedResources(this)))
                {
                    //IF SENDING FAILED
                    failedCount++;
                    LogHelper.EventLogHelper.Log("RFI Event > Send Invitation : Sending Failed to " + p.EmailAddress, System.Diagnostics.EventLogEntryType.Error);
                }
                else
                {
                    //IF SENDING WAS SUCCESSFUL
                    successCount++;
                    LogHelper.EventLogHelper.Log("RFI Event > Send Invitation : Email Sent to " + p.EmailAddress , System.Diagnostics.EventLogEntryType.Information);

                    //ADDS 1 TO EMAIL SENT FIELD BASED ON vendorID AND RfiRefNo
                    SqlParameter[] sqlparams = new SqlParameter[2];
                    sqlparams[0] = new SqlParameter("@VendorId", SqlDbType.Int);
                    sqlparams[0].Value = p.ID;
                    sqlparams[1] = new SqlParameter("@RfiRefNo", SqlDbType.VarChar);
                    sqlparams[1].Value = rfirefno;
                    SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_RfiInvitationAddEmailSent", sqlparams);
                }
            }
            success = true;
        }
        catch (Exception ex)
        {
            success = false;
            LogHelper.EventLogHelper.Log("RFI Event > Send Invitation : " + ex.Message, System.Diagnostics.EventLogEntryType.Error);
        }

        try
        {
            for (int j = 0; j < recipients.Count; j++)
            {
                RfiParticipant p = (RfiParticipant)recipients[j];
                if (SMSHelper.AreValidMobileNumbers(p.MobileNo.Trim()))
                {
                    SMSHelper.SendSMS(new SMSMessage(CreateInvitationSmsBody(rfiDetails, p).Trim(), p.MobileNo.Trim())).ToString();
                }
            }
        }
        catch (Exception ex)
        {
            LogHelper.EventLogHelper.Log("RFI Event > Send SMS Invitation : " + ex.Message, System.Diagnostics.EventLogEntryType.Error);
        }
        return success;

    }

    private string CreateInvitationSmsBody(RfiDetails rfiDetails, RfiParticipant participant)
    {
        return String.Format("You are invited to participate in a RFI Event; Ref. No. :{0}, initiated by Globe Telecom. Deadline: {1}", rfiDetails.ID, rfiDetails.SubmissionDeadline.ToString("MM/dd/yyyy hh:mm:ss tt"));
    }

    private string CreateInvitationBody(RfiDetails rfiDetails, RfiParticipant participant)
    {
        StringBuilder sb = new StringBuilder();

        sb.Append("<tr><td align='right'><h5>" + DateTime.Now.ToLongDateString() + "</h5></td></tr>");
        sb.Append("<tr><td align='center'><h3>INVITATION TO RFI</h3></td></tr>");
        sb.Append("<tr>");
        sb.Append("<td valign='top'>");
        sb.Append("<p>");
        sb.Append("<b>TO&nbsp&nbsp;:&nbsp&nbsp;<u>" + participant.Name + "</u></b>");
        sb.Append("<br /><br />");
        sb.Append("Good Day!");
        sb.Append("<br /><br />");
        sb.Append("We are glad to inform you that you have been invited to participate in an online RFI event which was initiated by Globe Telecom Incorporated/Innove Commnunications.");
        sb.Append("</p>");

        sb.Append("<table style='font-size: 12px;width:100%;'>");
        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>1.</td>");
        sb.Append("<td style='font-weight:bold;'>RFI Description</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>" + rfiDetails.Description + "</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>2.</td>");
        sb.Append("<td style='font-weight:bold;'>Schedule of RFI</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>");
        sb.Append("Submission Deadline : " + rfiDetails.SubmissionDeadline + "<br />");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>3.</td>");
        sb.Append("<td style='font-weight:bold;'>Payment Details</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>");
        sb.Append("<ul>");
        sb.Append("<li>Payment Terms - indicate applicable terms.</li>");
        sb.Append("</ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>4.</td>");
        sb.Append("<td style='font-weight:bold;'>RFI Price Details</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>The RFI price submitted by the supplier shall be exclusive of VAT.</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>5.</td>");
        sb.Append("<td style='font-weight:bold;'>Price Validity</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>");
        sb.Append("The price quoted must be valid and firm for a period of 90 days.");
        sb.Append("No change in price quoted shall be allowed after RFI submission unless negotiated by Globe Telecom Incorporated/Innove Commnunications");
        sb.Append("</td.");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>6.</td>");
        sb.Append("<td style='font-weight:bold;'>Price Confirmation</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>");
        sb.Append("Responses to the Invitation to RFI/Tender shall be sent by the vendors using the e-Sourcing Portal.");
        sb.Append("Price schedules (details) and other attachments shall be in Acrobat Format(i.e. PDF),"); ;
        sb.Append("or in any password-protected file (e.g. MS Word, Excel)");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>7.</td>");
        sb.Append("<td style='font-weight:bold;'>Grounds for Invalidating RFI</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>");
        sb.Append("A supplier's RFI may be invalidated under any of the following circumstances:");
        sb.Append("<ul>");
        sb.Append("<li>Incomplete RFI documents</li>");
        sb.Append("<li>Scanned Summary documents without bidder's signature</li>");
        sb.Append("</ul>");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>8.</td>");
        sb.Append("<td style='font-weight:bold;'>Awarding of RFI</td>");
        sb.Append("</tr>");
        sb.Append("<tr>");
        sb.Append("<td width='30px' colspan='2'></td>");
        sb.Append("<td>");
        sb.Append("The lowest/highest bidder is not necessarily the winning bidder. Globe Telecom Incorporated/Innove Commnunications shall not be bound to assign any reason for not accepting any RFI or accepting it in part.");
        sb.Append("RFI are still subject to further evaluation. Globe Telecom Incorporated/Innove Commnunications shall award the winning supplier through a Purchase Order.");
        sb.Append("</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");

        sb.Append("<tr>");
        sb.Append("<td width='10px'></td>");
        sb.Append("<td style='font-weight:bold;width:20px;'>9.</td>");
        sb.Append("<td style='font-weight:bold;'>Penalties (depends on the items to be purchased)</td>");
        sb.Append("</tr>");
        sb.Append("<tr><td height='10px' colspan='3'></td></tr>");
        sb.Append("</table>");

        sb.Append("<p>");
        sb.Append("<br /><br />");
        sb.Append("######################################################################################<br />");
        sb.Append("&nbsp;Credentials:<br />");
        sb.Append("&nbsp;&nbsp;&nbsp;Username: " + participant.Username + "<br /><br />");
        sb.Append("&nbsp;Notes:<br />");
        sb.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Password is for login.<br />");
        sb.Append("&nbsp;&nbsp;&nbsp;Username is NOT CASE SENSITIVE.<br />");
        sb.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you don't know or forgot your password, go to eBid login page and click forgot password.<br />");
        sb.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Use the username provided. Click Send. Your password will be sent to this email address.<br />");
        sb.Append("######################################################################################<br />");
        sb.Append("<br /><br /><br />");
        sb.Append("Sincerely Yours,");
        sb.Append("<br /><br />");
        sb.Append(rfiDetails.Creator);
        sb.Append("<br /><br />");
        sb.Append("</p>");
        sb.Append("</td>");
        sb.Append("</tr>");

        return MailTemplate.IntegrateBodyIntoTemplate(sb.ToString());
    }
    #endregion

    #region UPDATE RFI
    private void UpdateRfiEventComments(int rfirefno, int userid)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("refNo", SqlDbType.Int);
            sqlParams[0].Value = rfirefno;
            sqlParams[1] = new SqlParameter("@userId", SqlDbType.Int);
            sqlParams[1].Value = userid;
            sqlParams[2] = new SqlParameter("@comment", SqlDbType.NVarChar);
            sqlParams[2].Value = txtComment.Text;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_UpdateRFIItemsComments", sqlParams);
            sqlTransact.Commit();
        }
        catch
        {
            sqlTransact.Rollback();
        }
        finally
        {
            sqlConnect.Close();
        }
    }

    /// <summary>
    /// UPDATE THE RFI EVENT
    /// </summary>
    /// <param name="rfirefno"></param>
    /// <param name="stat"></param>
    /// <returns></returns>
    private bool UpdateRfiEvent(int rfirefno, int stat)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        bool isSuccessful = false;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[16];
            //sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            //sqlParams[0].Value = rfirefno;
            sqlParams[0] = new SqlParameter("@Requestor", SqlDbType.VarChar);
            sqlParams[0].Value = txtRequestor.Text.Trim();
            sqlParams[1] = new SqlParameter("@ItemDesc", SqlDbType.VarChar);
            sqlParams[1].Value = txtItemDesc.Text.Trim();
            sqlParams[2] = new SqlParameter("@Deadline", SqlDbType.DateTime);
            if (int.Parse(txtDeadlineHH.Text) > 12)
            {
                sqlParams[2].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + "PM");
            }
            else
            {
                sqlParams[2].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + ddlDeadline.SelectedValue);
            }
            sqlParams[3] = new SqlParameter("@BuyerId", SqlDbType.Int);
            sqlParams[3].Value = int.Parse(Session[Constant.SESSION_USERID].ToString());
            sqlParams[4] = new SqlParameter("@GroupDeptSec", SqlDbType.Int);
            sqlParams[4].Value = int.Parse(ddlGroupDeptSec.SelectedValue);
            sqlParams[5] = new SqlParameter("@Category", SqlDbType.NVarChar);
            sqlParams[5].Value = ddlCategory.SelectedValue;
            sqlParams[6] = new SqlParameter("@SubCategory", SqlDbType.Int);
            if (ddlSubCategory.SelectedValue.Trim() == "")
                sqlParams[6].Value = System.DBNull.Value;
            else
                sqlParams[6].Value = ddlSubCategory.SelectedValue.Trim();
            sqlParams[7] = new SqlParameter("@Status", SqlDbType.Int);
            sqlParams[7].Value = stat;
            sqlParams[8] = new SqlParameter("@CompanyId", SqlDbType.Int);
            sqlParams[8].Value = int.Parse(ddlCompany.SelectedValue);
            sqlParams[9] = new SqlParameter("@ForAuction", SqlDbType.Int);
            sqlParams[9].Value = 0;
            sqlParams[10] = new SqlParameter("@DeliverTo", SqlDbType.VarChar);
            sqlParams[10].Value = txtDeliverTo.Text.Trim();
            sqlParams[11] = new SqlParameter("@Incoterm", SqlDbType.Int);
            sqlParams[11].Value = int.Parse(ddlIncoterm.SelectedValue);
            sqlParams[12] = new SqlParameter("@EstItemValue", SqlDbType.Float);
            sqlParams[12].Value = GetEstimatedEventCostInPHP();
            sqlParams[13] = new SqlParameter("@Currency", SqlDbType.Char);
            sqlParams[13].Value = ddlCurrency.SelectedValue.Substring(0, 3);
            sqlParams[14] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[14].Value = rfirefno;
            sqlParams[15] = new SqlParameter("@Result", SqlDbType.Int);
            sqlParams[15].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_UpdateRFI", sqlParams);
            sqlTransact.Commit();
            int result;
            //rfirefno = int.Parse(txtRefNo.Text.Trim());
            //isSuccessful = (rfirefno > 0 ? false : true);
            //isSuccessful = true;
            result = int.Parse(sqlParams[15].Value.ToString().Trim());
            isSuccessful = (result > 0 ? false : true);
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

    private void UpdateRfiItemsTable(ref DataTable dtRfiItems,
        string id, string item, string description, string quantity,
            string unitofmeasure, string unitprice, string deliverydate, string SKU, string estimatedtotal)
    {
        for (int i = 0; i < dtRfiItems.Rows.Count; i++)
        {
            if (dtRfiItems.Rows[i]["ID"].ToString() == id.ToString())
            {
                dtRfiItems.Rows[i]["Item"] = item;
                dtRfiItems.Rows[i]["Description"] = description;
                dtRfiItems.Rows[i]["Quantity"] = quantity;
                dtRfiItems.Rows[i]["UnitOfMeasure"] = unitofmeasure;
                dtRfiItems.Rows[i]["UnitPrice"] = unitprice;
                dtRfiItems.Rows[i]["DeliveryDate"] = deliverydate;
                dtRfiItems.Rows[i]["SKU"] = SKU;
                dtRfiItems.Rows[i]["EstimatedTotal"] = estimatedtotal;
            }
        }
    }

    private void UpdateRfiEventItem()
    {

        JSCalendar jc = (JSCalendar)gvRfiItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvRfiItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvRfiItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvRfiItems.FooterRow.FindControl("txtItem");
        TextBox tbDesc = (TextBox)gvRfiItems.FooterRow.FindControl("txtDescription");
        TextBox tbUnitOfMeasure = (TextBox)gvRfiItems.FooterRow.FindControl("txtUnitOfMeasure");
        HiddenField hfSKU = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnSKU");
        HiddenField hfID = (HiddenField)gvRfiItems.FooterRow.FindControl("hdnID");

        DataTable dtRfiItems = (DataTable)ViewState["RfiEventItems"];

        if (hfID.Value.Length > 0)
        {
            if (dtRfiItems.Rows.Count == 2)
            {
                double itemCost = double.Parse(dtRfiItems.Rows[1]["EstimatedTotal"].ToString());
                double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
            }
            else
            {
                if (int.Parse(hfID.Value) - int.Parse(ViewState["RemovedCtr"].ToString()) == 0)
                {
                    double itemCost = double.Parse(dtRfiItems.Rows[1]["EstimatedTotal"].ToString());
                    double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                    double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                    txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
                }
                else if (int.Parse(hfID.Value) - int.Parse(ViewState["RemovedCtr"].ToString()) < 0)
                {
                    double itemCost = double.Parse(dtRfiItems.Rows[int.Parse(hfID.Value)]["EstimatedTotal"].ToString());
                    double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                    double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                    txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
                }
                else
                {
                    double itemCost = double.Parse(dtRfiItems.Rows[int.Parse(hfID.Value) - int.Parse(ViewState["RemovedCtr"].ToString())]["EstimatedTotal"].ToString());
                    double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                    double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                    txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
                }
            }

            UpdateRfiItemsTable(ref dtRfiItems, hfID.Value.ToString().Trim(), tbItem.Text.Trim(), tbDesc.Text.Trim(), tbQty.Text.Trim(), tbUnitOfMeasure.Text.Trim(),
                   tbPrice.Text.Trim() + "." + tbPriceCents.Text.Trim(), jc.Text.Trim(), hfSKU.Value.Trim(), tbTotal.Text.Trim());

        }
        ViewState["RfiEventItems"] = dtRfiItems;
        gvRfiItems.DataSource = dtRfiItems;
        gvRfiItems.DataBind();

        ClearAllItemInfo();
    }
    #endregion

    #region DELETE RFI
    private void DeleteAttachmentsFiles(int id)
    {
        DataTable dtAttachments = (DataTable)ViewState["RfiEventAttachments"];
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
            // REMOVE THE ACTUAL FILE
            FileInfo fInfo = new FileInfo(actualfilepath);
            if (fInfo.Exists)
                fInfo.Delete();
        }

        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }

    private void DeleteExistingRfiEventItems(int rfirefno)
    {
        try
        {
            DataTable dtRfiItems = (DataTable)ViewState["RfiEventExistingItems"];

            for (int i = 0; i < dtRfiItems.Rows.Count; i++)
            {
                string rdno = dtRfiItems.Rows[i]["RfiDetailNo"].ToString();
                if (rdno != "")
                    DeleteRfiEventItems(rfirefno, int.Parse(rdno));
            }
        }
        catch
        {

        }
    }

    private void DeleteCurrentRfiEventItems(int rfirefno)
    {
        try
        {
            DataTable dtRfiItems = (DataTable)ViewState["RfiEventItems"];

            for (int i = 0; i < dtRfiItems.Rows.Count; i++)
            {
                string rdno = dtRfiItems.Rows[i]["RfiDetailNo"].ToString();
                if (rdno != "")
                    DeleteRfiEventItems(rfirefno, int.Parse(rdno));
            }
        }
        catch
        {

        }
    }

    private void DeleteRfiEventItems(int rfirefno, int rfidetailno)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = rfirefno;
            sqlParams[1] = new SqlParameter("@RfiDetailNo", SqlDbType.Int);
            sqlParams[1].Value = rfidetailno;
            sqlParams[2] = new SqlParameter("@Result", SqlDbType.Int);
            sqlParams[2].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DelteRFIItemDetails", sqlParams);

            sqlTransact.Commit();
            sqlConnect.Close();
        }
        catch
        {
            sqlTransact.Rollback();
        }
        finally
        {
            sqlConnect.Close();
        }
    }

    private void DeleteExistingRfiEventParticipants(int rfirefno)
    {
        DataTable dtParticipants = (DataTable)ViewState["RfiEventParticipants"];

        for (int i = 0; i < dtParticipants.Rows.Count; i++)
        {
            string vid = dtParticipants.Rows[i]["VendorId"].ToString();

            if (vid != "")
            {
                DeleteRfiEventParticipants(rfirefno, int.Parse(vid));
            }
        }
    }

    private void DeleteRfiEventParticipants(int rfirefno, int vendorid)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = rfirefno;
            sqlParams[1] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[1].Value = vendorid;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteRFIEventParticipants", sqlParams);

            sqlTransact.Commit();
            sqlConnect.Close();
        }
        catch
        {
            sqlTransact.Rollback();
        }
        finally
        {
            sqlConnect.Close();
        }
    }

    private void DeleteExistingRfiEventAttachments(int rfirefno)
    {
        try
        {
            DataTable dtAttachments = (DataTable)ViewState["RfiEventExistingAttachments"];

            for (int i = 0; i < dtAttachments.Rows.Count; i++)
            {
                string fid = dtAttachments.Rows[i]["ID"].ToString();

                if (fid != "")
                {
                    DeleteRfiEventAttachments(rfirefno, int.Parse(fid));
                }
            }
        }
        catch
        {

        }
    }

    private void DeleteCurrentRfiEventAttachments(int rfirefno)
    {
        try
        {
            DataTable dtAttachments = (DataTable)ViewState["RfiEventAttachments"];

            for (int i = 0; i < dtAttachments.Rows.Count; i++)
            {
                string fid = dtAttachments.Rows[i]["ID"].ToString();

                if (fid != "")
                {
                    DeleteRfiEventAttachments(rfirefno, int.Parse(fid));
                    DeleteAttachmentsFiles(int.Parse(fid));
                }
            }
        }
        catch
        {

        }
    }

    private void DeleteRfiEventAttachments(int rfirefno, int fileuploadid)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
            sqlParams[0].Value = rfirefno;
            sqlParams[1] = new SqlParameter("@FileUploadID", SqlDbType.Int);
            sqlParams[1].Value = fileuploadid;
            sqlParams[2] = new SqlParameter("@Result", SqlDbType.Int);
            sqlParams[2].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteRFIEventAttachments", sqlParams);
            sqlTransact.Commit();
            sqlConnect.Close();
        }
        catch
        {
            sqlTransact.Rollback();
        }
        finally
        {
            sqlConnect.Close();
        }


    }
    #endregion

    private double GetEstimatedEventCostInPHP()
    {
        if (ddlCurrency.SelectedValue != "")
        {
            double d = double.Parse(ddlCurrency.SelectedValue.Split(new char[] { ':' })[1]);
            double amt = double.Parse(txtTotalEventPrice.Text.Trim());
            return amt * d;
        }
        else
            return 0.0;
    }

    private void AddOTLS()
    {
        if (hdnVendor.Value != "")
        {
            string vendor = hdnVendor.Value.ToString();

            string[] arrvendor = vendor.Split(new char[] { ';' });

            ListItem li = new ListItem(arrvendor[1].ToString(), arrvendor[0].ToString());

            lstSupplierB.Items.Add(li);
            hdnVendor.Value = "";
        }
    }

    private void RemoveDuplicateB()
    {
        if (lstSupplierB.Items.Count > 1)
        {
            for (int i = 0; i < lstSupplierB.Items.Count; i++)
            {
                for (int j = i; i < lstSupplierB.Items.Count; i++)
                {
                    if (lstSupplierB.Items[i].Value == lstSupplierB.Items[j].Value)
                    {
                        lstSupplierB.Items.RemoveAt(j);
                    }
                }
            }
        }
    }

    protected void lstSupplierA_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString[Constant.QS_TASKTYPE] == "2")
            {
                RemoveDuplicateA();
            }
        }
    }

    private void RemoveDuplicateA()
    {
        IEnumerator iEnum = dsParticipants.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {
            DataRowView dRView = (DataRowView)iEnum.Current;

            ListItem li = new ListItem(dRView["Supplier"].ToString(), dRView["VendorId"].ToString());

            lstSupplierA.Items.Remove(li);
        }
    }

    protected void lstSupplierB_DataBound(object sender, EventArgs e)
    {

    }

    protected void cfvSuppliers_ServerValidate(object source, ServerValidateEventArgs args)
    {
        StringBuilder sb = new StringBuilder();

        if (gvRfiItems.Rows.Count <= 1)
        {
            sb.Append(BR + " Please select atleast one(1) item.");
        }
        cfvSuppliers.Text = sb.ToString().Trim();
        args.IsValid = sb.ToString().Trim().Length <= 0;
    }

    protected void ddlCurrency_DataBound(object sender, EventArgs e)
    {
        if (Request.QueryString[Constant.QS_TASKTYPE] != "2")
            ddlCurrency.SelectedIndex = GetSelectedIndex(ddlCurrency, "PHP");
        else
            ddlCurrency.SelectedIndex = GetSelectedIndex(ddlCurrency, selectedCurrency);
    }

    protected void ddlCompany_DataBound(object sender, EventArgs e)
    {
        ddlCompany.Items.Insert(0, new ListItem("---- SELECT COMPANY ----", "-1"));
    }

    
}