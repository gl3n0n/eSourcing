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

public partial class web_buyer_screens_createNewItem : System.Web.UI.Page
{
    private const string BR = "<br />";
    private const string BULLET = "&#187;";
    private const string BR_BULLET = "<br />&#187;";
    private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
    private string selectedCurrency = "";
    private string groupName = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "Create New Bid Event");


        if (Session["AddBidEventMessage"] != null)
        {
            lblMessage.Visible = true;
            lblMessage.Text = Session["AddBidEventMessage"].ToString();
            Session["AddBidEventMessage"] = null;
        }
        else
            lblMessage.Visible = false;

        if (!IsPostBack)
        {
            if ((Request.QueryString[Constant.QS_TASKTYPE] == "2") && (Session[Constant.SESSION_BIDREFNO] != null))
            {
                // initialize for editing
                InitializeControls();
                InitializeRowsForGridViews();
                FillBidEventComments();
                FillSuppliersB();
            }
            else
            {
                // initialize for adding
                InitializeControls();
                InitializeEmptyRowsForGridViews();

            }

            ViewState["RemovedCtr"] = "0";
        }
        else
        {
            //TextBox tbItem = (TextBox)gvBidItems.FooterRow.FindControl("txtItem");
            //TextBox tbDescription = (TextBox)gvBidItems.FooterRow.FindControl("txtDescription");
            //JSCalendar jc = (JSCalendar)gvBidItems.FooterRow.FindControl("clndrDeliveryDate");
            //TextBox tbQty = (TextBox)gvBidItems.FooterRow.FindControl("txtQuantity");
            //TextBox tbUOM = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitOfMeasure");
            //TextBox tbPrice = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPrice");
            //TextBox tbPriceCents = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPriceCents");

            //tbItem.Text = "";
            //tbDescription.Text = "";
            //tbQty.Text = "0";
            //tbPrice.Text = "0";
            //tbPriceCents.Text = "00";
            //tbUOM.Text = "";
            //jc.Text = "";
            groupName = null;
            GetPrInfo();
        }

        AddOTLS();
        if (Request.Form["__EVENTTARGET"] == "VSF") 
        {
            //Response.Write(GetEstimatedEventCostInPHP().ToString());
            VSFtoSupplierB();
        }
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        DropDownList ddlPrInfo = (DropDownList)gvBidItems.FooterRow.FindControl("PRInfo");
        //if (ddlPrInfo.Items.FindByValue("-1") == null)
        //{
        //    ddlPrInfo.Items.Insert(0, new ListItem("-- SELECT PR --", "-1"));
        //}
        if (ddlPrInfo.Items.FindByValue("0") == null)
        {
            ddlPrInfo.Items.Insert(0, new ListItem("MANUAL PR", "0"));
        }

        RemoveGroupFromPRInfoDropDown();
        
    }

    void RemoveGroupFromPRInfoDropDown()
    {
        DropDownList ddlPrInfo = (DropDownList)gvBidItems.FooterRow.FindControl("PRInfo");
        DataTable dtBidItems = (DataTable)ViewState["BidEventItems"];
        string groupname = "";

        for (int i = 0; i < dtBidItems.Rows.Count; i++)
        {
            groupname = dtBidItems.Rows[i]["PRGroupname"].ToString();
            if (ddlPrInfo.Items.FindByValue(groupname) != null && groupname!="0")
            {
                ddlPrInfo.Items.Remove(ddlPrInfo.Items.FindByValue(groupname));
            }
        }
    }

    void AddGroupFromPRInfoDropDown(string groupname)
    {
        DropDownList ddlPrInfo = (DropDownList)gvBidItems.FooterRow.FindControl("PRInfo");
        ddlPrInfo.Items.Add(groupname);
    }

    void GetPrInfo()
    {
        DropDownList ddlPrInfo = (DropDownList)gvBidItems.FooterRow.FindControl("PRInfo");
        Label lbPrInfoLink = (Label)gvBidItems.FooterRow.FindControl("PRInfoLink");
        if (ddlPrInfo.SelectedValue.ToString() != "0" && ddlPrInfo.SelectedValue.ToString() != "-1")
        {
            AddBidItem(ddlPrInfo.SelectedItem.ToString());
            lbPrInfoLink.Text = "<a href='prItems.aspx?GroupName=" + ddlPrInfo.SelectedItem.ToString() + "' target='_blank'>" + ddlPrInfo.SelectedItem.ToString() + "</a>";
        }
        else
            lbPrInfoLink.Text = "";
    }

    private void AddBidItem(string group)
    {
        TextBox tbItem = (TextBox)gvBidItems.FooterRow.FindControl("txtItem");
        TextBox tbDescription = (TextBox)gvBidItems.FooterRow.FindControl("txtDescription");
        JSCalendar jc = (JSCalendar)gvBidItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvBidItems.FooterRow.FindControl("txtQuantity");
        TextBox tbUOM = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitOfMeasure");
        TextBox tbPrice = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPriceCents");
        groupName = group;
        SqlDataReader reader;
        SqlCommand cmd;
        SqlConnection conn;
        string query = "sp_GetComputedPRItem";
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@BuyerId", SqlDbType.Int));
                cmd.Parameters.Add(new SqlParameter("@Group", SqlDbType.VarChar));
                cmd.Parameters["@BuyerId"].Value = int.Parse(Session[Constant.SESSION_USERID].ToString());
                cmd.Parameters["@Group"].Value = group.ToString();
                conn.Open();
                reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        try
                        {
                            tbItem.Text = reader["Item"].ToString();
                            tbDescription.Text = reader["Description"].ToString();
                            jc.Text = reader["DeliveryDate"].ToString();
                            tbUOM.Text =reader["UOM"].ToString();
                            tbQty.Text = reader["TotalQty"].ToString();
                            tbPrice.Text = reader["UnitPrice"].ToString();
                            tbPriceCents.Text = reader["UnitPriceCents"].ToString();
                        }
                        catch (Exception ex)
                        {
                            //Response.Write(ex.Message);
                        }
                    }
                }
            }
        }
    }

    void VSFtoSupplierB()
    {
        
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        string query;
        SqlDataReader oReader;
        lstSupplierB.Items.Clear();

        query = "SELECT DISTINCT(t1.VendorId),  CASE   WHEN t2.Accredited = 5 THEN    'Due For Renewal - ' +  t2.VendorName  WHEN t2.Accredited = 4 THEN    'Exempted - ' +  t2.VendorName  WHEN t2.Accredited = 3 THEN    'OTS - ' +  t2.VendorName  ELSE t2.VendorName END AS VendorName,    t2.VendorName + ' ( ' + t4.SupplierTypeDesc + ' - ' + cast((CASE WHEN t2.Composite_Rating_Rate is null THEN 0 ELSE t2.Composite_Rating_Rate END) as varchar(10)) + ' - ' + STR(CASE WHEN t2.Maximum_Exposure_Amount is null THEN 0 ELSE t2.Maximum_Exposure_Amount END) + ' - ' + cast((CASE WHEN t2.Perf_Evaluation_Rate is null THEN 0 ELSE t2.Perf_Evaluation_Rate END) as varchar(10)) + ' )' AS VendorLabel, t2.Accredited, t2.VendorName FROM tblVSFDetails t1 INNER JOIN tblVendors t2 ON t1.VendorId = t2.VendorId INNER JOIN rfcSupplierType t4 ON t2.Accredited = t4.SupplierTypeId WHERE t1.VSFId = " + VSF.SelectedValue.ToString() +" AND t1.Selected = 1 ORDER BY t2.VendorName ASC";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, query);
        if (oReader.HasRows)
        {
            while (oReader.Read())
            {
                ListItem li = new ListItem(oReader["VendorLabel"].ToString(), oReader["VendorId"].ToString());
                lstSupplierB.Items.Add(li);
            }
        }
        //RemoveDuplicateB();

        if (VSF.SelectedValue.ToString() != "0")
        {
            VSFLink.Text = "<a href='vsfviewOnly.aspx?VSFId=" + VSF.SelectedValue.ToString() + "' target='_blank'>" + VSF.SelectedItem.ToString() + "</a>";
            SuppliersLst_Disabled();
        }
        else 
        {
            VSFLink.Text = "";
            SuppliersLst_Enabled();
        }
        
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
        //clndrPRDate.Attributes.Add("style", "text-align:center;");

        lstSupplierA.Attributes.Add("ondblclick", "__doPostBack('btnSelectOne','')");
        lstSupplierB.Attributes.Add("ondblclick", "__doPostBack('btnDeselectOne','')");

        //txtPRNumber.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        //txtPRSubLineNumber.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        txtDeadlineHH.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        txtDeadlineMM.Attributes.Add("onkeydown", "return DigitsOnly(event);");
        txtDeadlineSS.Attributes.Add("onkeydown", "return DigitsOnly(event);");        

        txtDeadlineHH.Attributes.Add("onfocusout", "ResetIfEmpty(this);");
        txtDeadlineMM.Attributes.Add("onfocusout", "ResetIfEmpty(this);");
        txtDeadlineSS.Attributes.Add("onfocusout", "ResetIfEmpty(this);");

        ddlIncoterm.SelectedValue = "11";
        ddlCurrency.Attributes.Add("onchange", "ShowPHPConversion();");        
        
        Page.ClientScript.RegisterStartupScript(this.GetType(), "show1", "ShowPHPConversion();", true);
        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "show1", "ShowPHPConversion();", true);
                
        //clndrPRDate.Text = DateTime.Now.ToShortDateString();
        clndrDeadline.Text = DateTime.Now.AddDays(7.0).ToShortDateString();

        txtDeadlineHH.Text = "6";

        lnkAddOTLS.NavigateUrl = "javascript:AddOTLS('" + ddlCategory.ClientID + "', '" + ddlSubCategory.ClientID + "');";
    }
    
    private void InitializeRowsForGridViews()
    {
        FillBidEventDetails();

        #region Bid Items
        DataTable dtBidItems = CreateBidItemsTable();
        // add empty row
        AddEmptyItemsRow(ref dtBidItems);
        // save to viewstate
        ViewState["BidEventItems"] = dtBidItems;
        // bind to gridview
        gvBidItems.DataSource = dtBidItems;
        gvBidItems.DataBind();
        // fill bid event items
        FillBidEventItems(ref dtBidItems);
        // save to viewstate
        ViewState["BidEventItems"] = dtBidItems;
        ViewState["BidEventExistingItems"] = dtBidItems;
        // bind to gridview
        gvBidItems.DataSource = dtBidItems;
        gvBidItems.DataBind();
        #endregion

        #region Attachments
        DataTable dtAttachments = CreateAttachmentsTable();
        // add empty row
        AddEmptyAttachmentRow(ref dtAttachments);
        // save to viewstate
        ViewState["BidEventAttachments"] = dtAttachments;
        // bind to gridview
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
        FillBidEventAttachments(ref dtAttachments);
         // save to viewstate
        ViewState["BidEventAttachments"] = dtAttachments;
        ViewState["BidEventExistingAttachments"] = dtAttachments;
        // bind to gridview
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
        #endregion

        DataTable dtParticipants = CreateParticipantsTable();
        FillBidEventParticipants(ref dtParticipants);
        ViewState["BidEventParticipants"] = dtParticipants;

    }

    private void InitializeEmptyRowsForGridViews()
    {
        #region Bid Items
        DataTable dtBidItems = CreateBidItemsTable();
        // add empty row
        AddEmptyItemsRow(ref dtBidItems);
        // save to viewstate
        ViewState["BidEventItems"] = dtBidItems;
        // bind to gridview
        gvBidItems.DataSource = dtBidItems;
        gvBidItems.DataBind();
        #endregion

        #region Attachments
        DataTable dtAttachments = CreateAttachmentsTable();
        // add empty row
        AddEmptyAttachmentRow(ref dtAttachments);
        // save to viewstate
        ViewState["BidEventAttachments"] = dtAttachments;
        // bind to gridview
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
        #endregion
    }

    #endregion

    private int GetSelectedIndex(DropDownList ddl, string start)
    {
        for(int i = 0; i< ddl.Items.Count; i++)
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

    private void AddEmptyItemsRow(ref DataTable dtBidItems)
    {
        DataRow dr = dtBidItems.NewRow();
        int nxtCounter = 0;
        if (dtBidItems.Rows.Count > 0)
            nxtCounter = int.Parse(dtBidItems.Rows[dtBidItems.Rows.Count - 1]["ID"].ToString()) + 1;

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
        dr["PRGroupName"] = "";
        dtBidItems.Rows.Add(dr);
    }

    #region FILL

    private void FillBidEventDetails()
    {
        IEnumerator iEnum = dsEventDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();

        while (iEnum.MoveNext())
        {
            DataRowView dRView = (DataRowView)iEnum.Current;
            if (dRView["BidRefNo"] != null)
            {
                lblRefNo.Text = dRView["BidRefNo"].ToString();
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
            //txtPRNumber.Text = dRView["PRRefNo"].ToString();
            //txtPRSubLineNumber.Text = dRView["PRSubRefNo"].ToString();
            //clndrPRDate.Text = DateTime.Parse(dRView["PRDate"].ToString()).ToShortDateString();
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
            txtTotalEventPrice.Text = dRView["EstItemValue"].ToString()!="" ? String.Format("{0:#,##0.00}", double.Parse(dRView["EstItemValue"].ToString())) : "0";
            chkQualifiedSourcing.Checked = bool.Parse(dRView["QualifiedSourcing"].ToString());
            VSF.SelectedValue = dRView["VSFId"].ToString();
            //VSFLink.Text = "<a href='vsfviewOnly.aspx?VSFId=" + dRView["VSFId"].ToString() + "' target='_blank'>" + dRView["VSFId"].ToString() + "</a>";
            if (dRView["VSFId"].ToString() != "0")
            { SuppliersLst_Disabled(); }
            else { SuppliersLst_Enabled();  }
            
            ddlCategory.Enabled = false;
            ddlSubCategory.Enabled = false;
        }
    }

    private void FillBidEventSKU()
    {
        IEnumerator iEnum = dsItemDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();
        HiddenField hdSKU = (HiddenField)gvBidItems.FooterRow.FindControl("hdnSKU");

        while (iEnum.MoveNext())
        {
            
            DataRowView dRView = (DataRowView)iEnum.Current;
            hdSKU.Value = dRView["SKU"].ToString();
           
        }
    }

    private void FillBidEventComments()
    {
        IEnumerator iEnum = dsComments.Select(DataSourceSelectArguments.Empty).GetEnumerator();
       
        while (iEnum.MoveNext())
        {

            DataRowView dRView = (DataRowView)iEnum.Current;
            txtComment.Text = dRView["Comment"].ToString();

        }
    }

    private void FillBidEventItems(ref DataTable dtBidItems)
    {
        IEnumerator iEnum = dsItemDetails.Select(DataSourceSelectArguments.Empty).GetEnumerator();
        
        while (iEnum.MoveNext())
        {
            DataRow dr = dtBidItems.NewRow();

            int nxtCounter = 0;
            if (dtBidItems.Rows.Count > 0)
                nxtCounter = int.Parse(dtBidItems.Rows[dtBidItems.Rows.Count - 1]["ID"].ToString()) + 1;
           
            DataRowView dRView = (DataRowView)iEnum.Current;
            dr["BidDetailNo"] = dRView["BidDetailNo"].ToString();
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
            dr["PRGroupName"] = dRView["PRGroupName"].ToString();     
            //hdSKU.Value = dRView["SKU"].ToString();
            dtBidItems.Rows.Add(dr);
        }
    }

    private void FillBidEventAttachments(ref DataTable dtAttachments)
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

    private void FillBidEventParticipants(ref DataTable dtParticipants)
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

    private DataTable CreateBidItemsTable()
    {
        DataTable dtBidItems = new DataTable();
        DataColumn dc;
        dc = new DataColumn("BidDetailNo", typeof(System.Int32));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("ID", typeof(System.Int32));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("Item", typeof(System.String));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("Description", typeof(System.String));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("Quantity", typeof(System.Double));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("UnitOfMeasure", typeof(System.String));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("UnitPrice", typeof(System.Double));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("DeliveryDate", typeof(System.DateTime));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("SKU", typeof(System.String));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("EstimatedTotal", typeof(System.Double));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("IsEmpty", typeof(System.Int32));
        dtBidItems.Columns.Add(dc);
        dc = new DataColumn("PRGroupName", typeof(System.String));
        dtBidItems.Columns.Add(dc);

        return dtBidItems;
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
                                    //string actual = FileUploadHelper.GetAlternativeFileName(fInfo.Extension);
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

    protected void gvBidItems_DataBound(object sender, EventArgs e)
    {
        // get controls
        JSCalendar jc = (JSCalendar)gvBidItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvBidItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvBidItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvBidItems.FooterRow.FindControl("txtItem");        
        HtmlAnchor lnkSelectProducts = (HtmlAnchor)gvBidItems.FooterRow.FindControl("lnkSelectProduct");
        LinkButton lnkAddItem = (LinkButton)gvBidItems.FooterRow.FindControl("lnkAddItem");

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
        DataTable dtAttachments = (DataTable)ViewState["BidEventAttachments"];

        DataRow dr = dtAttachments.NewRow();
        int nxtCounter = 0;
        if (dtAttachments.Rows.Count > 0)
            nxtCounter = int.Parse(dtAttachments.Rows[dtAttachments.Rows.Count - 1]["ID"].ToString()) + 1;

        dr["ID"] = nxtCounter;
        dr["Original"] = original;
        dr["Actual"] = actual;
        dr["Attached"] = 1;
        dtAttachments.Rows.Add(dr);

        ViewState["BidEventAttachments"] = dtAttachments;
        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }

    private void Remove(int id)
    {
        DataTable dtAttachments = (DataTable)ViewState["BidEventAttachments"];
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

        ViewState["BidEventAttachments"] = dtAttachments;

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

    protected void gvBidItems_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Literal litMsg = (Literal)gvBidItems.FooterRow.FindControl("addItemMsg");
        switch (e.CommandName)
        {
            case "Add":
                {
                    litMsg.Text = AddToBidItemsList();
                }
                break;
            case "Remove":
                {
                    RemoveFromBidItemList(int.Parse(e.CommandArgument.ToString()));
                }
                break;
            case "EditItem":
                {
                    EditItem(int.Parse(e.CommandArgument.ToString()));
                }
                break;
            case "UpdateItem":
                {
                    UpdateBidEventItem();
                }
                break;
            case "CancelUpdate":
                {
                    CancelUpdateItem();
                }
                break;
        }
    }

    private string AddToBidItemsList()
    {
        // get controls        
        TextBox tbItem = (TextBox)gvBidItems.FooterRow.FindControl("txtItem");
        TextBox tbDescription = (TextBox)gvBidItems.FooterRow.FindControl("txtDescription");
        HiddenField hdSKU = (HiddenField)gvBidItems.FooterRow.FindControl("hdnSKU");
        JSCalendar jc = (JSCalendar)gvBidItems.FooterRow.FindControl("clndrDeliveryDate");                
        TextBox tbQty = (TextBox)gvBidItems.FooterRow.FindControl("txtQuantity");
        TextBox tbUOF = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitOfMeasure");
        TextBox tbPrice = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPrice");        
        TextBox tbPriceCents = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvBidItems.FooterRow.FindControl("txtTotalPrice");
        DropDownList tbPRInfo = (DropDownList)gvBidItems.FooterRow.FindControl("PRInfo");

        string msg = "";

        if (IsBidItemInputsValid(tbItem.Text.Trim(), tbDescription.Text.Trim(), hdSKU.Value.Trim(), jc.Text.Trim(), 
            tbQty.Text.Trim(), tbUOF.Text.Trim(), tbPrice.Text.Trim() + "." + tbPriceCents.Text.Trim(), tbTotal.Text.Trim(), ref msg))
        {   // if input is ok, proceed to adding of items in the list
            DataTable dtBidItems = (DataTable)ViewState["BidEventItems"];

            DataRow dr = dtBidItems.NewRow();
            int nxtCounter = 0;
            if (dtBidItems.Rows.Count > 0)
                nxtCounter = int.Parse(dtBidItems.Rows[dtBidItems.Rows.Count - 1]["ID"].ToString()) + 1;

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
            dr["PRGroupName"] = tbPRInfo.SelectedValue;
            dtBidItems.Rows.Add(dr);

            //remove item from PR group dropdown
            //RemoveGroupFromPRInfoDropDown(tbPRInfo.SelectedValue);

            tbPRInfo.Items.Remove(tbPRInfo.Items.FindByValue("test3"));
            // add to total event cost
            double newTotal = total + double.Parse(txtTotalEventPrice.Text.Trim());
            txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);            

            ViewState["BidEventItems"] = dtBidItems;
            gvBidItems.DataSource = dtBidItems;
            gvBidItems.DataBind();

            ddlCategory.Enabled = false;
            ddlSubCategory.Enabled = false;
        }
        else
        {   // if input is not ok
        }

        return msg;
    }

    private void EditItem(int id)
    {      
        JSCalendar jc = (JSCalendar)gvBidItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvBidItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvBidItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvBidItems.FooterRow.FindControl("txtItem");
        TextBox tbDesc = (TextBox)gvBidItems.FooterRow.FindControl("txtDescription");
        TextBox tbUnitOfMeasure = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitOfMeasure");
        HiddenField hfSKU = (HiddenField)gvBidItems.FooterRow.FindControl("hdnSKU");
        HiddenField hfID = (HiddenField)gvBidItems.FooterRow.FindControl("hdnID");
        LinkButton lnkAddItem = (LinkButton)gvBidItems.FooterRow.FindControl("lnkAddItem");
        LinkButton lnkUpdate = (LinkButton)gvBidItems.FooterRow.FindControl("lnkUpdateItem");
        LinkButton lnkCancel = (LinkButton)gvBidItems.FooterRow.FindControl("lnkCancelUpdate");
        DropDownList PRInfo = (DropDownList)gvBidItems.FooterRow.FindControl("PRInfo");
        //LinkButton lnkEdit = (LinkButton)gvBidItems.FindControl("lnkEditItem");
        //LinkButton lnkRemove = (LinkButton)gvBidItems.FindControl("lnkRemove");
        
        DataTable dtBidItems = (DataTable)ViewState["BidEventItems"];
        int toBeEdited = -1;
 
        for (int i = 0; i < dtBidItems.Rows.Count; i++)
        {
            if (dtBidItems.Rows[i]["ID"].ToString() == id.ToString())
            {
                toBeEdited = i;
                break;
            }
        }

        //string item = dtBidItems.Rows[i]["Item"].ToString().Trim();
        //string[] splitItem = item.Split(new Char[] { '-' });
        string unitprice = dtBidItems.Rows[toBeEdited]["UnitPrice"].ToString().Trim();
        string up = String.Format("{0:F}", Double.Parse(unitprice));
        string[] splitUnitPrice = up.Split(new Char[] { '.' });

        tbItem.Text = dtBidItems.Rows[toBeEdited]["Item"].ToString().Trim();
        tbDesc.Text = dtBidItems.Rows[toBeEdited]["Description"].ToString().Trim();
        jc.Text = DateTime.Parse(dtBidItems.Rows[toBeEdited]["DeliveryDate"].ToString().Trim()).ToShortDateString();
        tbUnitOfMeasure.Text = dtBidItems.Rows[toBeEdited]["UnitOfMeasure"].ToString().Trim();
        tbQty.Text = dtBidItems.Rows[toBeEdited]["Quantity"].ToString().Trim();
        tbPrice.Text = splitUnitPrice[0];
        tbPriceCents.Text = splitUnitPrice[1];
        tbTotal.Text = dtBidItems.Rows[toBeEdited]["EstimatedTotal"].ToString().Trim();
        hfSKU.Value = dtBidItems.Rows[toBeEdited]["SKU"].ToString().Trim();
        hfID.Value = id.ToString();
        PRInfo.Items.Add(dtBidItems.Rows[toBeEdited]["PRGroupName"].ToString().Trim());
        PRInfo.SelectedValue = dtBidItems.Rows[toBeEdited]["PRGroupName"].ToString().Trim();
        if (dtBidItems.Rows[toBeEdited]["PRGroupName"].ToString().Trim() != "0")
        {
            PRInfo.Enabled = false;
        }
        //lnkEdit.Visible = false;
        //lnkRemove.Visible = false;
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
        JSCalendar jc = (JSCalendar)gvBidItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvBidItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvBidItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvBidItems.FooterRow.FindControl("txtItem");
        TextBox tbDesc = (TextBox)gvBidItems.FooterRow.FindControl("txtDescription");
        TextBox tbUnitOfMeasure = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitOfMeasure");
        HiddenField hfSKU = (HiddenField)gvBidItems.FooterRow.FindControl("hdnSKU");
        HiddenField hfID = (HiddenField)gvBidItems.FooterRow.FindControl("hdnID");
        LinkButton lnkAddItem = (LinkButton)gvBidItems.FooterRow.FindControl("lnkAddItem");
        LinkButton lnkUpdate = (LinkButton)gvBidItems.FooterRow.FindControl("lnkUpdateItem");
        LinkButton lnkCancel = (LinkButton)gvBidItems.FooterRow.FindControl("lnkCancelUpdate");
        DropDownList PRInfo = (DropDownList)gvBidItems.FooterRow.FindControl("PRInfo");
        PRInfo.Enabled = true ;
        if (PRInfo.Items.FindByValue("-1") == null)
        {
            PRInfo.SelectedValue = "-1";
        } 
        //LinkButton lnkEdit = (LinkButton)gvBidItems.FindControl("lnkEditItem");
        //LinkButton lnkRemove = (LinkButton)gvBidItems.FindControl("lnkRemove");

        tbItem.Text = "";
        tbDesc.Text = "";
        jc.Text = "";
        tbUnitOfMeasure.Text = "";
        tbQty.Text = "0";
        tbPrice.Text = "0";
        tbPriceCents.Text = "00";
        tbTotal.Text = "0:00";
        hfSKU.Value = "";
       
        //lnkEdit.Visible = true;
        //lnkRemove.Visible = true;
        lnkAddItem.Visible = true;
        lnkUpdate.Visible = false;
        lnkCancel.Visible = false;
    }

    private void RemoveFromBidItemList(int id)
    {
        DataTable dtBidItems = (DataTable)ViewState["BidEventItems"];
        int toBeRemoved = -1;
        double itemCost = 0.0;
        int ctr = 0;

        for (int i = 0; i < dtBidItems.Rows.Count; i++)
        {
            if (dtBidItems.Rows[i]["ID"].ToString() == id.ToString())
            {
                toBeRemoved = i;             
                itemCost = double.Parse(dtBidItems.Rows[i]["EstimatedTotal"].ToString());
                break;              
            }
        }

        // subtract to total event cost
        double newTotal = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
        txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);

        if (toBeRemoved > -1)
            dtBidItems.Rows.RemoveAt(toBeRemoved);

        if (ViewState["RemovedCtr"] != null)
        {
            ctr = int.Parse(ViewState["RemovedCtr"].ToString());
            ctr = ctr + 1;
        }

        ViewState["RemovedCtr"] = ctr;
        ViewState["BidEventItems"] = dtBidItems;

        gvBidItems.DataSource = dtBidItems;
        gvBidItems.DataBind();

        if (gvBidItems.Rows.Count == 1)
        {
            ddlCategory.Enabled = true;
            ddlSubCategory.Enabled = true;
        }

    }
        
    private bool IsBidItemInputsValid(string item, string description, string sku, string deliverydate, 
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
                    Session["AddBidEventMessage"] = Save(ref isSuccessful);
                }
                else
                {
                    isSuccessful = false;
                }
                break;
            case "Draft":
                ViewState["command"] = "draft";
                if (IsValid)
                {
                    Session["AddBidEventMessage"] = SaveAsDraft(ref isSuccessful);
                }
                else
                {
                    isSuccessful = false;
                }
                break;
            case "Cancel":
                Response.Redirect("bids.aspx");
                break;
        }

        if (isSuccessful)
        {
            Session["AddBidEventMessage"] = null;
            if (ViewState["command"].ToString() == "draft")
            {
                Response.Redirect("bids.aspx");
            }
            else
                if ((GetEstimatedEventCostInPHP() < Constant.BIDLIMIT_BEFOREAPPROVAL) && (lstSupplierB.Items.Count >= 3))
                {
                    Response.Redirect("approvedbiditems.aspx"); //Approved Bid Events 
                }
                else
                {
                    if(SendEmailNotification())
                    {
                        Response.Redirect("submittedbiditems.aspx"); //Bid Events For Approval
                    }
                }
        }
            
        if (Session["AddBidEventMessage"] != null)
        {
            lblMessage.Visible = true;
            lblMessage.Text = Session["AddBidEventMessage"].ToString();            
        }
        else
            lblMessage.Visible = false;

    }

    private string Save(ref bool isSuccessful)
    {
        int brf = 0;
        string msg = string.Empty;
     
        isSuccessful = false;

        //Edit bid events
        if (Request.QueryString[Constant.QS_TASKTYPE] == "2")
        {
            try
            {
                int stat = Constant.BID_STATUS_APPROVED;
                double d = GetEstimatedEventCostInPHP();
                
                if ((d >= Constant.BIDLIMIT_BEFOREAPPROVAL) || ((lstSupplierB.Items.Count < 3) & (d < Constant.BIDLIMIT_BEFOREAPPROVAL)))
                    stat = Constant.BID_STATUS_SUBMITTED;

                if (d > Constant.BIDLIMIT_BEFOREAPPROVAL & VSF.SelectedValue == "0" & chkQualifiedSourcing.Checked == false)
                {
                    msg = "Total Event Cost is equal or more than 4,000,000 (Php). Please select a VSF.";
                    return msg;
                }

                if (UpdateBidEvent(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), stat))
                {
                    //Delete All
                    DeleteExistingBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                    if (SaveBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString())))
                    {
                        //Delete All
                        DeleteExistingBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                        if (SaveBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString())))
                        {
                            //Delete All
                            DeleteExistingBidEventParticipants(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                            if (SaveBidEventParticipants(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString())))
                            {
                                if (stat == Constant.BID_STATUS_APPROVED)
                                {
                                    UpdateBidEventComments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()));
                                    msg = "Bid event was successfully saved.";
                                }
                                else
                                {
                                    UpdateBidEventComments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()));
                                    msg = "Bid event was successfully submitted for approval.";
                                }
                                isSuccessful = true;
                            }
                            else
                            {   // participants were not saved
                                msg = "There was an error saving the partcipants for this bid event. Please try again or contact administrator for help.";
                                //roll back, delete created bid event
                            }
                        }
                        else
                        {   // attachments were not saved
                            msg = "There was an error saving the attachments for this bid event. Please try again or contact administrator for help.";
                            //roll back, delete created bid event attachments
                            DeleteCurrentBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                        }
                    }
                    else
                    {   // bid items were not saved
                        msg = "There was an error saving the bid items for this bid event. Please try again or contact administrator for help.";
                        // roll back, delete created bid event items
                        DeleteCurrentBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));

                    }
                }
                else
                {   // bid event was not saved successfully
                    msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
                }
            }
            catch
            {
                // error saving
                msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
            }

            return msg;

        }
        //Add new bid events
        else
        {
            try
            {
                int stat = Constant.BID_STATUS_APPROVED;
                double d = GetEstimatedEventCostInPHP();
                
                if ((d >= Constant.BIDLIMIT_BEFOREAPPROVAL) || ((lstSupplierB.Items.Count < 3) & (d < Constant.BIDLIMIT_BEFOREAPPROVAL)))
                    stat = Constant.BID_STATUS_SUBMITTED;

                if (d > Constant.BIDLIMIT_BEFOREAPPROVAL & VSF.SelectedValue == "0" & chkQualifiedSourcing.Checked == false)
                {
                    msg = "Total Event Cost is equal or more than 4,000,000 (Php). Please select a VSF.";
                    return msg;
                }

                if (SaveBidEvent(ref brf, stat))
                {   // bid event was saved 
                    if (SaveBidEventItems(brf))
                    {
                        if (SaveBidEventAttachments(brf))
                        {
                            if (SaveBidEventParticipants(brf))
                            {
                                if (stat == Constant.BID_STATUS_APPROVED)
                                {
                                    if (txtComment.Text.Trim() != string.Empty)
                                        SaveBidEventComments(brf, int.Parse(Session[Constant.SESSION_USERID].ToString()), txtComment.Text.Trim());
                                    msg = "Bid event was successfully saved.";
                                }
                                else
                                {

                                    if (txtComment.Text.Trim() != string.Empty)
                                        SaveBidEventComments(brf, int.Parse(Session[Constant.SESSION_USERID].ToString()), txtComment.Text.Trim());
                                    msg = "Bid event was successfully submitted for approval.";
                                    // email immediate superior
                                }
                                isSuccessful = true;
                            }
                            else
                            {   // participants were not saved
                                msg = "There was an error saving the partcipants for this bid event. Please try again or contact administrator for help.";
                                // roll back, delete created bid event
                            }
                        }
                        else
                        {   // attachments were not saved
                            msg = "There was an error saving the attachments for this bid event. Please try again or contact administrator for help.";
                            // roll back, delete created bid event attachments
                            DeleteCurrentBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                        }
                    }
                    else
                    {   // bid items were not saved
                        msg = "There was an error saving the bid items for this bid event. Please try again or contact administrator for help.";
                        // roll back, delete created bid event items
                        DeleteCurrentBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                    }
                }
                else
                {   // bid event was not saved successfully
                    msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
                }

            }
            catch
            {   // error saving
                msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
            }

            return msg;
        }
    }
            
    private string SaveAsDraft(ref bool isSuccessful)
    {
        int brf = 0;
        string msg = string.Empty;
        isSuccessful = false;

        //Edit bid events as draft
        if (Request.QueryString[Constant.QS_TASKTYPE] == "2")
        {
            int stat = Constant.BID_STATUS_DRAFT;

            try
            {
                if (UpdateBidEvent(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), stat))
                {
                    //Delete All
                    DeleteExistingBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                    if (SaveBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString())))
                    {
                        //Delete All
                        DeleteExistingBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                        if (SaveBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString())))
                        {
                            //Delete All
                            DeleteExistingBidEventParticipants(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                            if (SaveBidEventParticipants(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString())))
                            {
                                UpdateBidEventComments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()), int.Parse(Session[Constant.SESSION_USERID].ToString()));
                                msg = "Bid event was successfully saved as draft.";
                                isSuccessful = true;
                              
                            }
                            else
                            {   // participants were not saved
                                msg = "There was an error saving the partcipants for this bid event. Please try again or contact administrator for help.";
                                //roll back, delete created bid event
                            }
                        }
                        else
                        {   // attachments were not saved
                            msg = "There was an error saving the attachments for this bid event. Please try again or contact administrator for help.";
                            //roll back, delete created bid event attachments
                            DeleteCurrentBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));                          
                        }
                    }
                    else
                    {   // bid items were not saved
                        msg = "There was an error saving the bid items for this bid event. Please try again or contact administrator for help.";
                        // roll back, delete created bid event items
                        DeleteCurrentBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                    }
                }
                else
                {   // bid event was not saved successfully
                    msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
                }
            }
            catch
            {  // bid event was not saved successfully
                msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
            }

            return msg;
            
        }
        //Add bid events as draft
        else
        {
            try
            {
                int stat = Constant.BID_STATUS_DRAFT;

                    if (SaveBidEvent(ref brf, stat))
                    {   // bid event was saved 
                        if (SaveBidEventItems(brf))
                        {
                            if (SaveBidEventAttachments(brf))
                            {
                                if (SaveBidEventParticipants(brf))
                                {
                                    if (txtComment.Text.Trim() != string.Empty)
                                        SaveBidEventComments(brf, int.Parse(Session[Constant.SESSION_USERID].ToString()), txtComment.Text.Trim());
                                    msg = "Bid event was successfully saved as draft.";
                                    isSuccessful = true;
                                }
                                else
                                {   // participants were not saved
                                    msg = "There was an error saving the partcipants for this bid event. Please try again or contact administrator for help.";
                                    // roll back, delete created bid event
                                }
                            }
                            else
                            {   // attachments were not saved
                                msg = "There was an error saving the attachments for this bid event. Please try again or contact administrator for help.";
                                // roll back, delete created bid event attachments
                                DeleteCurrentBidEventAttachments(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                            }
                        }
                        else
                        {   // bid items were not saved
                            msg = "There was an error saving the bid items for this bid event. Please try again or contact administrator for help.";
                            // roll back, delete created bid event items
                            DeleteCurrentBidEventItems(int.Parse(Session[Constant.SESSION_BIDREFNO].ToString()));
                        }
                    }
                    else
                    {   // bid event was not saved successfully
                        msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
                    }
                
            }
            catch
            {   // error saving
                msg = "There was an error saving this bid event. Please try again or contact administrator for help.";
            }

            return msg;
        }
    }

    #region SAVE

    /// <summary>
    /// Save the bid event
    /// </summary>
    /// <param name="bidrefno"></param>
    /// <returns></returns>
    private bool SaveBidEvent(ref int bidrefno, int stat)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        bool isSuccessful = false;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[20];
            sqlParams[0] = new SqlParameter("@PRRefNo", SqlDbType.BigInt);
            //sqlParams[0].Value = Int64.Parse(txtPRNumber.Text.Trim());
            sqlParams[0].Value = 0;
            sqlParams[1] = new SqlParameter("@Requestor", SqlDbType.VarChar);
            sqlParams[1].Value = txtRequestor.Text.Trim();
            sqlParams[2] = new SqlParameter("@ItemDesc", SqlDbType.VarChar);
            sqlParams[2].Value = txtItemDesc.Text.Trim();
            sqlParams[3] = new SqlParameter("@Deadline", SqlDbType.DateTime);
            if (int.Parse(txtDeadlineHH.Text) > 12)
            {
                sqlParams[3].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + "PM");
            }
            else
            {
                sqlParams[3].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + ddlDeadline.SelectedValue);
            } 
            sqlParams[4] = new SqlParameter("@PRDate", SqlDbType.DateTime);
            sqlParams[4].Value = DateTime.Now.ToShortDateString();
            sqlParams[5] = new SqlParameter("@BuyerId", SqlDbType.Int);
            sqlParams[5].Value = int.Parse(Session[Constant.SESSION_USERID].ToString());
            sqlParams[6] = new SqlParameter("@GroupDeptSec", SqlDbType.Int);
            sqlParams[6].Value = int.Parse(ddlGroupDeptSec.SelectedValue);
            sqlParams[7] = new SqlParameter("@Category", SqlDbType.NVarChar);
            sqlParams[7].Value = ddlCategory.SelectedValue;
            sqlParams[8] = new SqlParameter("@SubCategory", SqlDbType.Int);
            if (ddlSubCategory.SelectedValue.Trim() == "")
                sqlParams[8].Value = System.DBNull.Value;
            else
                sqlParams[8].Value = ddlSubCategory.SelectedValue.Trim();
            sqlParams[9] = new SqlParameter("@Status", SqlDbType.Int);
            sqlParams[9].Value = stat;
            sqlParams[10] = new SqlParameter("@CompanyId", SqlDbType.Int);
            sqlParams[10].Value = int.Parse(ddlCompany.SelectedValue);
            sqlParams[11] = new SqlParameter("@ForAuction", SqlDbType.Int);
            sqlParams[11].Value = 0;
            sqlParams[12] = new SqlParameter("@DeliverTo", SqlDbType.VarChar);
            sqlParams[12].Value = txtDeliverTo.Text.Trim();
            sqlParams[13] = new SqlParameter("@Incoterm", SqlDbType.Int);
            sqlParams[13].Value = int.Parse(ddlIncoterm.SelectedValue);
            sqlParams[14] = new SqlParameter("@Currency", SqlDbType.Char);
            sqlParams[14].Value = ddlCurrency.SelectedValue.Substring(0, 3);
            sqlParams[15] = new SqlParameter("@EstItemValue", SqlDbType.Float);            
            sqlParams[15].Value = GetEstimatedEventCostInPHP();// double.Parse(txtTotalEventPrice.Text.Trim());
            sqlParams[16] = new SqlParameter("@QualifiedSourcing", SqlDbType.Int);
            sqlParams[16].Value = int.Parse(chkQualifiedSourcing.Checked  ? "1" : "0" );
            sqlParams[17] = new SqlParameter("@PRSubRefNo", SqlDbType.BigInt);
            //sqlParams[17].Value = Int64.Parse(txtPRSubLineNumber.Text.Trim());
            sqlParams[17].Value = 0;
            sqlParams[18] = new SqlParameter("@VSFId", SqlDbType.Int);
            sqlParams[18].Value = int.Parse(VSF.SelectedValue);
            sqlParams[19] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[19].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "s3p_Ebid_InsertBid", sqlParams);

            sqlTransact.Commit();

            bidrefno = int.Parse(sqlParams[19].Value.ToString().Trim());
            isSuccessful = (bidrefno <= 0 ? false : true);
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

    /// <summary>
    /// Save bid items for this bid event
    /// </summary>
    /// <param name="bidrefno"></param>
    /// <returns></returns>
    private bool SaveBidEventItems(int bidrefno)
    {
        bool isSuccessful = false;

        try
        {
            DataTable dtBidItems = (DataTable)ViewState["BidEventItems"];
            string s = string.Empty;

            for (int i = 1; i < dtBidItems.Rows.Count; i++)
            {
                s += SaveBidEventItems(bidrefno, dtBidItems.Rows[i]["SKU"].ToString().Length == 0 ? Constant.DEFAULTPRODUCTITEM.ToString() : dtBidItems.Rows[i]["SKU"].ToString(),
                    dtBidItems.Rows[i]["Description"].ToString(), double.Parse(dtBidItems.Rows[i]["Quantity"].ToString()),
                    dtBidItems.Rows[i]["UnitOfMeasure"].ToString(), DateTime.Parse(dtBidItems.Rows[i]["DeliveryDate"].ToString()),
                    double.Parse(dtBidItems.Rows[i]["UnitPrice"].ToString()), dtBidItems.Rows[i]["PRGroupName"].ToString());
            }

            isSuccessful = s.IndexOf("0") >= 0 ? false : true;
        }
        catch
        {            
            isSuccessful = false;
        }        
        return isSuccessful;
    }

    private string SaveBidEventItems(int bidrefno, string item, string description, double quantity, string unitofmeasure, DateTime deliverydate, double unitprice, string groupName)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        string isSuccessful = string.Empty;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[9];
            sqlParams[0] = new SqlParameter("@Item", SqlDbType.VarChar);
            sqlParams[0].Value = item;
            sqlParams[1] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[1].Value = bidrefno;
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
            sqlParams[7] = new SqlParameter("@Group", SqlDbType.VarChar);
            sqlParams[7].Value = groupName.ToString();
            sqlParams[8] = new SqlParameter("@BidDetailNo", SqlDbType.Int);
            sqlParams[8].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "s3p_Ebid_InsertBidDetail", sqlParams);

            sqlTransact.Commit();

            int r = int.Parse(sqlParams[8].Value.ToString().Trim());
            isSuccessful = (r <= 0 ? "0" : "1");

            SaveBidDetailToGroup(r, groupName);
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
    
    /// <summary>
    /// Save attachments for this bid event
    /// </summary>
    /// <param name="bidrefno"></param>
    /// <returns></returns>
    private bool SaveBidEventAttachments(int bidrefno)
    {
        bool isSuccessful = false;
        try
        {            
            DataTable dtAttachments = (DataTable)ViewState["BidEventAttachments"];
            string s = string.Empty;            

            for (int i = 1; i < dtAttachments.Rows.Count; i++)
            {
                s += SaveBidEventAttachments(bidrefno, int.Parse(Session[Constant.SESSION_USERID].ToString()), dtAttachments.Rows[i]["Original"].ToString(), dtAttachments.Rows[i]["Actual"].ToString());
            }
            isSuccessful = s.IndexOf("0") >= 0 ? false : true;
        }
        catch
        {
            isSuccessful = false;
        }        
        return isSuccessful;
    }

    private string SaveBidEventAttachments(int bidrefno, int buyerid, string originalfilename, string actualfilename)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        string isSuccessful = string.Empty;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[5];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = bidrefno;
            sqlParams[1] = new SqlParameter("@BuyerId", SqlDbType.Int);
            sqlParams[1].Value = buyerid;
            sqlParams[2] = new SqlParameter("@OriginalFileName", SqlDbType.VarChar);
            sqlParams[2].Value = originalfilename;
            sqlParams[3] = new SqlParameter("@ActualFileName", SqlDbType.VarChar);
            sqlParams[3].Value = actualfilename;
            sqlParams[4] = new SqlParameter("@FileUploadID", SqlDbType.Int);
            sqlParams[4].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "s3p_Ebid_InsertBidAttachment", sqlParams);

            sqlTransact.Commit();            
            
            int r = int.Parse(sqlParams[4].Value.ToString().Trim());
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


    /// <summary>
    /// Save the participants for this bid event
    /// </summary>
    /// <param name="bidrefno"></param>
    /// <returns></returns>
    private bool SaveBidEventParticipants(int bidrefno)
    {
        bool isSuccessful = false;
        try
        {
            string s = string.Empty;

            for (int i = 0; i < lstSupplierB.Items.Count; i++)
            {
                s += SaveBidEventParticipants(bidrefno, int.Parse(lstSupplierB.Items[i].Value));
            }

            isSuccessful = s.IndexOf("0") >= 0 ? false : true;
        }
        catch
        {
            isSuccessful = false;
        }        
        return isSuccessful;
    }

    private string SaveBidEventParticipants(int bidrefno, int vendorid)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        string isSuccessful = string.Empty;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = bidrefno;
            sqlParams[1] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[1].Value = vendorid;
            sqlParams[2] = new SqlParameter("@VendorInBidsId", SqlDbType.Int);
            sqlParams[2].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "s3p_Ebid_InsertBidParticipants", sqlParams);

            sqlTransact.Commit();

            int r = int.Parse(sqlParams[2].Value.ToString().Trim());
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

    private void SaveBidEventComments(int bidrefno, int userid, string comment)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
       
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[5];
            sqlParams[0] = new SqlParameter("@RefNo", SqlDbType.Int);
            sqlParams[0].Value = bidrefno;
            sqlParams[1] = new SqlParameter("@UserId", SqlDbType.Int);
            sqlParams[1].Value = userid;
            sqlParams[2] = new SqlParameter("@UserType", SqlDbType.Int);
            sqlParams[2].Value = 1;
            sqlParams[3] = new SqlParameter("@IsAuction", SqlDbType.Int);
            sqlParams[3].Value = 0;
            sqlParams[4] = new SqlParameter("@Comment", SqlDbType.NVarChar);
            sqlParams[4].Value = comment;
            

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertBidItemsComments", sqlParams);
            sqlTransact.Commit();

        }

    private void SaveBidDetailToGroup(int biddetailno, string group)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@BidDetailNo", SqlDbType.Int);
            sqlParams[0].Value = biddetailno;
            sqlParams[1] = new SqlParameter("@Group", SqlDbType.VarChar);
            sqlParams[1].Value = group.ToString();
            sqlParams[2] = new SqlParameter("@BuyerId", SqlDbType.Int);
            sqlParams[2].Value = int.Parse(Session[Constant.SESSION_USERID].ToString());

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_InsertBidDetailNoToPR", sqlParams);
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

    #endregion

    #region UPDATE
    private void UpdateBidEventComments(int bidrefno, int userid)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("refNo", SqlDbType.Int);
            sqlParams[0].Value = bidrefno;
            sqlParams[1] = new SqlParameter("@userId", SqlDbType.Int);
            sqlParams[1].Value = userid;
            sqlParams[2] = new SqlParameter("@comment", SqlDbType.NVarChar);
            sqlParams[2].Value = txtComment.Text;


            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_UpdateBidItemsComments", sqlParams);
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
    /// Update the bid event
    /// </summary>
    /// <param name="bidrefno"></param>
    /// <returns></returns>
    
    private bool UpdateBidEvent(int bidrefno, int stat)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        bool isSuccessful = false;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[20];
            sqlParams[0] = new SqlParameter("@PRRefNo", SqlDbType.BigInt);
            sqlParams[0].Value = 0;
            sqlParams[1] = new SqlParameter("@Requestor", SqlDbType.VarChar);
            sqlParams[1].Value = txtRequestor.Text.Trim();
            sqlParams[2] = new SqlParameter("@ItemDesc", SqlDbType.VarChar);
            sqlParams[2].Value = txtItemDesc.Text.Trim();
            sqlParams[3] = new SqlParameter("@Deadline", SqlDbType.DateTime);
            if (int.Parse(txtDeadlineHH.Text) > 12)
            {
                sqlParams[3].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + "PM");
            }
            else
            {
                sqlParams[3].Value = DateTime.Parse(clndrDeadline.Text.Trim() + ' ' + txtDeadlineHH.Text.Trim() + ':' + txtDeadlineMM.Text.Trim() + ':' + txtDeadlineSS.Text.Trim() + ' ' + ddlDeadline.SelectedValue);
            }
            sqlParams[4] = new SqlParameter("@PRDate", SqlDbType.DateTime);
            sqlParams[4].Value = DateTime.Now.ToShortDateString();
            sqlParams[5] = new SqlParameter("@BuyerId", SqlDbType.Int);
            sqlParams[5].Value = int.Parse(Session[Constant.SESSION_USERID].ToString());
            sqlParams[6] = new SqlParameter("@GroupDeptSec", SqlDbType.Int);
            sqlParams[6].Value = int.Parse(ddlGroupDeptSec.SelectedValue);
            sqlParams[7] = new SqlParameter("@Category", SqlDbType.NVarChar);
            sqlParams[7].Value = ddlCategory.SelectedValue;
            sqlParams[8] = new SqlParameter("@SubCategory", SqlDbType.Int);
            if (ddlSubCategory.SelectedValue.Trim() == "")
                sqlParams[8].Value = System.DBNull.Value;
            else
                sqlParams[8].Value = ddlSubCategory.SelectedValue.Trim();
            sqlParams[9] = new SqlParameter("@Status", SqlDbType.Int);
            sqlParams[9].Value = stat;
            sqlParams[10] = new SqlParameter("@CompanyId", SqlDbType.Int);
            sqlParams[10].Value = int.Parse(ddlCompany.SelectedValue);
            sqlParams[11] = new SqlParameter("@ForAuction", SqlDbType.Int);
            sqlParams[11].Value = 0;
            sqlParams[12] = new SqlParameter("@DeliverTo", SqlDbType.VarChar);
            sqlParams[12].Value = txtDeliverTo.Text.Trim();
            sqlParams[13] = new SqlParameter("@Incoterm", SqlDbType.Int);
            sqlParams[13].Value = int.Parse(ddlIncoterm.SelectedValue);
            sqlParams[14] = new SqlParameter("@EstItemValue", SqlDbType.Float);
            sqlParams[14].Value = GetEstimatedEventCostInPHP();//double.Parse(txtTotalEventPrice.Text.Trim());
            sqlParams[15] = new SqlParameter("@Currency", SqlDbType.Char);
            sqlParams[15].Value = ddlCurrency.SelectedValue.Substring(0, 3);
            sqlParams[16] = new SqlParameter("@QualifiedSourcing", SqlDbType.Char);
            sqlParams[16].Value = int.Parse(chkQualifiedSourcing.Checked ? "1" : "0");
            sqlParams[17] = new SqlParameter("@VSFId", SqlDbType.Int);
            sqlParams[17].Value = int.Parse(VSF.SelectedValue);
            sqlParams[18] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[18].Value = bidrefno;
            sqlParams[19] = new SqlParameter("@Result", SqlDbType.Int);
            sqlParams[19].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "s3p_Ebid_UpdateBid", sqlParams);

            sqlTransact.Commit();
            int result;

            result = int.Parse(sqlParams[19].Value.ToString().Trim());
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

    private void UpdateBidItemsTable(ref DataTable dtBidItems,
            string id, string item, string description, string quantity,
                string unitofmeasure, string unitprice, string deliverydate, string SKU, string estimatedtotal)
    {
        for (int i = 0; i < dtBidItems.Rows.Count; i++)
        {
            if (dtBidItems.Rows[i]["ID"].ToString() == id.ToString())
            {
                dtBidItems.Rows[i]["Item"] = item;
                dtBidItems.Rows[i]["Description"] = description;
                dtBidItems.Rows[i]["Quantity"] = quantity;
                dtBidItems.Rows[i]["UnitOfMeasure"] = unitofmeasure;
                dtBidItems.Rows[i]["UnitPrice"] = unitprice;
                dtBidItems.Rows[i]["DeliveryDate"] = deliverydate;
                dtBidItems.Rows[i]["SKU"] = SKU;
                dtBidItems.Rows[i]["EstimatedTotal"] = estimatedtotal;
            }
        }
    }

    private void UpdateBidEventItem()
    {

        JSCalendar jc = (JSCalendar)gvBidItems.FooterRow.FindControl("clndrDeliveryDate");
        TextBox tbQty = (TextBox)gvBidItems.FooterRow.FindControl("txtQuantity");
        TextBox tbPrice = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPrice");
        TextBox tbPriceCents = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitPriceCents");
        TextBox tbTotal = (TextBox)gvBidItems.FooterRow.FindControl("txtTotalPrice");
        TextBox tbItem = (TextBox)gvBidItems.FooterRow.FindControl("txtItem");
        TextBox tbDesc = (TextBox)gvBidItems.FooterRow.FindControl("txtDescription");
        TextBox tbUnitOfMeasure = (TextBox)gvBidItems.FooterRow.FindControl("txtUnitOfMeasure");
        HiddenField hfSKU = (HiddenField)gvBidItems.FooterRow.FindControl("hdnSKU");
        HiddenField hfID = (HiddenField)gvBidItems.FooterRow.FindControl("hdnID");
        
         DataTable dtBidItems = (DataTable)ViewState["BidEventItems"];

         if (hfID.Value.Length > 0)
         {
             if (dtBidItems.Rows.Count == 2)
             {                
                 double itemCost = double.Parse(dtBidItems.Rows[1]["EstimatedTotal"].ToString());
                 double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                 double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                 txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
             }
             else
             {
                 if (int.Parse(hfID.Value) - int.Parse(ViewState["RemovedCtr"].ToString()) == 0)
                 {
                     double itemCost = double.Parse(dtBidItems.Rows[1]["EstimatedTotal"].ToString());
                     double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                     double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                     txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
                 }
                 else if (int.Parse(hfID.Value) - int.Parse(ViewState["RemovedCtr"].ToString()) < 0)
                 {
                     double itemCost = double.Parse(dtBidItems.Rows[int.Parse(hfID.Value)]["EstimatedTotal"].ToString());
                     double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                     double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                     txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
                 }
                 else
                 {
                     double itemCost = double.Parse(dtBidItems.Rows[int.Parse(hfID.Value) - int.Parse(ViewState["RemovedCtr"].ToString())]["EstimatedTotal"].ToString());
                     double TotalEventCost = double.Parse(txtTotalEventPrice.Text.Trim()) - itemCost;
                     double newTotal = TotalEventCost + double.Parse(tbTotal.Text.ToString());
                     txtTotalEventPrice.Text = String.Format("{0:#,##0.00}", newTotal);
                 }
             }

             UpdateBidItemsTable(ref dtBidItems, hfID.Value.ToString().Trim(), tbItem.Text.Trim(), tbDesc.Text.Trim(), tbQty.Text.Trim(), tbUnitOfMeasure.Text.Trim(),
                    tbPrice.Text.Trim() + "." + tbPriceCents.Text.Trim(), jc.Text.Trim(), hfSKU.Value.Trim(), tbTotal.Text.Trim());

         }

         ViewState["BidEventItems"] = dtBidItems;
         gvBidItems.DataSource = dtBidItems;
         gvBidItems.DataBind();

         ClearAllItemInfo();
    }

    #endregion

    #region DELETE

    private void DeleteAttachmentsFiles(int id)
    {
        DataTable dtAttachments = (DataTable)ViewState["BidEventAttachments"];
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
            //dtAttachments.Rows.RemoveAt(toBeRemoved);

            // remove the actual file
            FileInfo fInfo = new FileInfo(actualfilepath);
            if (fInfo.Exists)
                fInfo.Delete();
        }

        //ViewState["BidEventAttachments"] = dtAttachments;

        gvFileAttachment.DataSource = dtAttachments;
        gvFileAttachment.DataBind();
    }

    private void DeleteExistingBidEventItems(int bidrefno)
    {
        try
        {
        DataTable dtBidItems = (DataTable)ViewState["BidEventExistingItems"];

            for (int i = 0; i < dtBidItems.Rows.Count; i++)
            {
                string bdno = dtBidItems.Rows[i]["BidDetailNo"].ToString();
                if (bdno != "")
                    DeleteBidEventItems(bidrefno, int.Parse(bdno));
            }

        }
        catch
        {

        }
    }

    private void DeleteCurrentBidEventItems(int bidrefno)
    {
        try
        {
            DataTable dtBidItems = (DataTable)ViewState["BidEventItems"];

            for (int i = 0; i < dtBidItems.Rows.Count; i++)
            {
                string bdno = dtBidItems.Rows[i]["BidDetailNo"].ToString();
                if (bdno != "")
                    DeleteBidEventItems(bidrefno, int.Parse(bdno));
            }

        }
        catch
        {

        }
    }

    private void DeleteBidEventItems(int bidrefno, int bidetailno)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = bidrefno;
            sqlParams[1] = new SqlParameter("@BidDetailNo", SqlDbType.Int);
            sqlParams[1].Value = bidetailno;
            sqlParams[2] = new SqlParameter("@Result", SqlDbType.Int);
            sqlParams[2].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteBidItemDetails", sqlParams);

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

    private void DeleteExistingBidEventParticipants(int bidrefno)
    {

        DataTable dtParticipants = (DataTable)ViewState["BidEventParticipants"];

        for (int i = 0; i < dtParticipants.Rows.Count; i++)
        {
            string vid = dtParticipants.Rows[i]["VendorId"].ToString();

            if (vid != "")
            {
                DeleteBidEventParticipants(bidrefno, int.Parse(vid));
            }
        }

       
    }

    private void DeleteBidEventParticipants(int bidrefno, int vendorid)
    {

        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
         try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = bidrefno;
            sqlParams[1] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[1].Value = vendorid;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteBidEventParticipants", sqlParams);

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

    private void DeleteExistingBidEventAttachments(int bidrefno)
    {
        try
        {
        DataTable dtAttachments = (DataTable)ViewState["BidEventExistingAttachments"];

        for (int i = 0; i < dtAttachments.Rows.Count; i++)
        {
            string fid = dtAttachments.Rows[i]["ID"].ToString();
           
            if (fid != "")
            {
                DeleteBidEventAttachments(bidrefno, int.Parse(fid));
                //DeleteAttachmentsFiles(int.Parse(fid));
            }
        }

        }
        catch
        {

        }

    }

    private void DeleteCurrentBidEventAttachments(int bidrefno)
    {
        try
        {
            DataTable dtAttachments = (DataTable)ViewState["BidEventAttachments"];

            for (int i = 0; i < dtAttachments.Rows.Count; i++)
            {
                string fid = dtAttachments.Rows[i]["ID"].ToString();

                if (fid != "")
                {
                    DeleteBidEventAttachments(bidrefno, int.Parse(fid));
                    DeleteAttachmentsFiles(int.Parse(fid));
                }
            }

        }
        catch
        {

        }

    }

    private void DeleteBidEventAttachments(int bidrefno, int fileuploadid)
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[3];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = bidrefno;
            sqlParams[1] = new SqlParameter("@FileUploadID", SqlDbType.Int);
            sqlParams[1].Value = fileuploadid;
            sqlParams[2] = new SqlParameter("@Result", SqlDbType.Int);
            sqlParams[2].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_DeleteBidEventAttachments", sqlParams);

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
        foreach (ListItem itemInList in lstSupplierA.Items)
        {
            SqlDataReader oReader;
            string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
            string query;
            SqlCommand cmd;
            SqlConnection conn;

            string txtitemInList = itemInList.Text;
            if (txtitemInList.Contains(": WITH ISSUE"))
            {
                itemInList.Attributes.Add("style", "background-color:#FFBE93;border-top:1px solid #fff;");
                string alertThis = "";
                string tooltipThis = "";
                query = "s3p_EBid_SearchVendorIdWithIssue";
                using (conn = new SqlConnection(connstring))
                {
                    using (cmd = new SqlCommand(query, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@VendorId", Convert.ToInt32(itemInList.Value.Trim()));
                        conn.Open();

                        oReader = cmd.ExecuteReader();
                        if (oReader.HasRows)
                        {
                            while (oReader.Read())
                            {
                                alertThis = alertThis + oReader["CompanyName"].ToString().Replace("'", "\\'") + "\\n";
                                alertThis = alertThis + "Date Created: " + oReader["DateCreated"].ToString() + "\\n";
                                alertThis = alertThis + "Issue: " + oReader["Description"].ToString() + "\\n";
                                alertThis = alertThis + "Remarks: " + oReader["Remarks"].ToString().Replace("'", "\\'").Replace("\r\n", "\\n") + "\\n";
                                alertThis = alertThis + "Status: " + oReader["StatusDescription"].ToString() + "\\n\\n\\n";

                                tooltipThis = tooltipThis + "• Issue: " + oReader["DateCreated"].ToString() + " - " + oReader["Description"].ToString() + "    ";
                            }
                        }
                    }
                }
                itemInList.Attributes.Add("oncontextmenu", "javascript:alert('" + alertThis + "');return false;");
                itemInList.Attributes.Add("title", tooltipThis);
            }
        }
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

        if (gvBidItems.Rows.Count <= 1)
        {
            sb.Append(BR + " Please select atleast one(1) item.");
        }

        if (!chkQualifiedSourcing.Checked)
        {
            if (lstSupplierB.Items.Count < 3)
            {
                sb.Append(BR + " Please select atleast three(3) supplier/participant.");
            }
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

    private bool SendEmailNotification()
    {
        //"Judith Mercado. Ponce" <email@globetel.com.ph>
        //"Consolacion G.. Lim" <email@globetel.com.ph>
        string sCommand;
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;
        bool success = false;


        string fromName = "";
        string fromEmail = "";
        string from = "";
        string toName = "";
        string toEmail = "";
        string to = "";
        string subject = "Bid Event For Approval";


        //GET BUYER EMAIL AS THE SENDER
        sCommand = "SELECT t1.BuyerFirstName + ' ' + t1.BuyerMidName + ' ' + t1.BuyerLastName  AS Name1, t1.EmailAdd FROM tblBuyers t1 WHERE t1.BuyerID=" + Session["UserId"].ToString();
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            fromName = oReader["Name1"].ToString();
            fromEmail = oReader["EmailAdd"].ToString();
            from = '"' + oReader["Name1"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";

        } oReader.Close();

        //GET PURCHASING EMAIL AS THE RECEPIENT
        sCommand = "SELECT t1.PurchasingID, t2.FirstName + ' ' + t2.MiddleName + ' ' + t2.LastName AS Name1, t2.EmailAdd  FROM tblSupervisor t1, tblPurchasing t2  WHERE t1.PurchasingID = t2.PurchasingID and t1.BuyerId = " + Session["UserId"].ToString();
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            toName = oReader["Name1"].ToString();
            toEmail = oReader["EmailAdd"].ToString();
            to = '"' + oReader["Name1"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";
        } oReader.Close();

        try
        {
            if (!MailHelper.SendEmail(MailTemplate.GetDefaultSMTPServer(),
                    from,
                    to,
                    subject,
                    CreateNotificationBody(fromName, toName),
                    MailTemplate.GetTemplateLinkedResources(this)))
            {	//if sending failed					
                LogHelper.EventLogHelper.Log("Bid > Send Notification : Sending Failed to " + from, System.Diagnostics.EventLogEntryType.Error);
            }
            else
            {	//if sending successful
                LogHelper.EventLogHelper.Log("Bid > Send Notification : Email Sent to " + from, System.Diagnostics.EventLogEntryType.Information);

            }
            success = true;
        }
        catch (Exception ex)
        {
            success = false;
            LogHelper.EventLogHelper.Log("Bid > Send Notification : " + ex.Message, System.Diagnostics.EventLogEntryType.Error);
        }

        return success;
    }
    private string CreateNotificationBody(string fromName, string toName)
    {
        StringBuilder sb = new StringBuilder();

        string sCommand;
        string sTxt = "";
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;

        // Awarded To
        sTxt = "<table border='1' style='font-size:12px'><tr>";
        sTxt = sTxt + "<td><strong>&nbsp;Bid Reference No:</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Description:</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;PR Ref No:</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Date Submitted: </strong></td>";
        sTxt = sTxt + "</tr>";
        sCommand = "SELECT TOP 1 BidRefNo, ItemDesc, PRRefNo, CONVERT(varchar,DateSubmitted,100) as DateSubmitted FROM tblBidItems WHERE BuyerId = " + Session["UserId"].ToString() + " AND Status = 1 ORDER BY DateSubmitted DESC";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            while (oReader.Read())
            {
                sTxt = sTxt + "<tr>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["BidRefNo"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["ItemDesc"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["PRRefNo"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["DateSubmitted"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "</tr>";
            }
        }
        sTxt = sTxt + "<tr></table>";
        //contents = contents.Replace("[BidAwardedTo]", sTxt);

        //sb.Append("<tr><td align='right'><h5>" + DateTime.Now.ToLongDateString() + "</h5></td></tr>");
        sb.Append("<tr><td>");
        sb.Append("<p><strong>Bid Event for Approval</strong> <br>");
        sb.Append("Sent: " + DateTime.Now.ToLongDateString() + "</p>");
        sb.Append("<p>");
        sb.Append("From: " + fromName + "<br><br> ");
        sb.Append("To: " + toName + "<br><br>");
        sb.Append("Subject: Request for Bid Event Approval.<br><br>");
        sb.Append("Dear Bid Event Approver, <br><br>");
        sb.Append("Re: Request for Bid Event Approval.  <strong>" + txtItemDesc.Text + "</strong><br><br> ");
        sb.Append("This is to request your approval on the ff:<br><br>");
        //sb.Append("<b>Bid Reference Number:</b> " + "na" + "<br>");
        //sb.Append("<b>Description:</b> " + txtItemDesc.Text + "<br>");
        //sb.Append("<b>PR Ref No.:</b> " + txtPRNumber.Text + "<br>");
        sb.Append("</p>");
        sb.Append(sTxt);
        sb.Append("<p>Very truly yours,<br><br><br> <strong>e-Sourcing Procurement</strong></p><p>&nbsp;</p> ");
        sb.Append("<p><strong>Instructions:</strong></p> <ol> ");
        sb.Append("<li style='font-size:12px'>Go to <a href='https://e-sourcing.globe.com.ph/'>https://e-sourcing.globe.com.ph</a></li> ");
        sb.Append("<li style='font-size:12px'>Enter your Username and Password then  click Login</li> ");
        sb.Append("<li style='font-size:12px'>Click Bid Events For Approval</li> ");
        sb.Append("<li style='font-size:12px'>Click Bid Events Name</li>");
        sb.Append("<li style='font-size:12px'>Reject / Approve Bid Event</li> ");
        sb.Append("<li style='font-size:12px'>Click 'Re-Edit' if you have clarification,'Approve' to approve or 'Reject' to disapprove the Bid Event.</li> ");
        sb.Append("</ol> Please do not reply to this auto-generated  message.&nbsp;");
        sb.Append("</td></tr>");

        return MailTemplate.IntegrateBodyIntoTemplate(sb.ToString());
    }

}
