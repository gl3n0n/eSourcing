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
using EBid.lib;
using EBid.lib.constant;
using System.Data.SqlClient;

public partial class web_buyer_screens_SupplierDetails : System.Web.UI.Page
{
    private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.BUYER)
            Response.Redirect("../unauthorizedaccess.aspx");

        if (!(Page.IsPostBack))
        {
            if (Session["VendorId"]!=null)
            {
            ViewState["VendorId"] = Session["VendorId"].ToString().Trim();
            SupplierTransaction st = new SupplierTransaction();
            Supplier s = st.QuerySuppliers(ViewState["VendorId"].ToString().Trim());
            lblCompanyName.Text = s.VendorName.Trim();
            lblAddressHeadOffice.Text = s.VendorAddress.Trim() + " " + s.VendorAddress1.Trim();
            lblTelephone.Text = s.TelephoneNumber.Trim();
            lblFax.Text = s.Fax.Trim();
            lblExtension.Text = s.Extension.Trim();
            lblAddressBranch.Text = s.VendorAddress2.Trim() + " " + s.VendorAddress3.Trim();
            lblTelephone1.Text = s.BranchTelephoneNo.Trim();
            lblFax1.Text = s.BranchFax.Trim();
            lblExtension1.Text = s.BranchExtension.Trim();
            lblVatRegNo.Text = s.VatRegNo.Trim();
            lblTin.Text = s.TIN.Trim();
            lblPOBox.Text = s.POBOX.Trim();
            lblPostalCode.Text = s.PostalCode.Trim();
            lblEmail.Text = s.VendorEmail.Trim();
            lblStandardTerms.Text = s.TermsOfPayment.Trim();
            lblSpecialTerms.Text = s.SpecialTerms.Trim();
            lblMinimumOrderValue.Text = s.MinOrderValue.Trim();
            lblSalesPerson.Text = s.ContactPerson.Trim();
            lblTelephone2.Text = s.SalesPersonTelNo.Trim();
            lblTypeOfBusinessOrganization.Text = s.OrgTypeId;
            lblFilipino.Text = s.OwnershipFilipino.Trim();
            lblOtherNationality.Text = s.OwnershipOther.Trim();
            lblCompanyClassification.Text = "";
            lblSoleSupplier.Text = s.SoleSupplier1.Trim() + " " + s.SoleSupplier2.Trim();
            lblSpecialization.Text = s.Specialization.Trim();

            SupplierType sut = new SupplierType();
            lblSupplierType.Text = sut.GetSupplierType(s.Accredited.Trim());
            PCABClassTransaction pcab = new PCABClassTransaction();
                lblPCABClass.Text = pcab.GetPCABClasName(s.PCABClass.Trim());
            switch (s.ISOStandard.Trim())
            {
                case "01":
                    lblISOStandard.Text = "ISO 9002";
                    break;
                case "10":
                    lblISOStandard.Text = "ISO 9001";
                    break;
                case "11":
                    lblISOStandard.Text = "ISO 9001<br />ISO 9002";
                    break;
            }
             
            DataSet ds = st.QueryCategoryAndSubCategory(ViewState["VendorId"].ToString().Trim());
            string strcategory = "";
            string strsubcategory = "";
    
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0] != null)
                    {
                        DataTable dtCategory = ds.Tables[0];
                        if (dtCategory.Rows.Count > 0)
                        {
                            
                            for (int i = 0; i < dtCategory.Rows.Count; i++)
                            {
                                strcategory = (strcategory == "" ? dtCategory.Rows[i]["CategoryName"].ToString() : strcategory +  "<br />" + dtCategory.Rows[i]["CategoryName"].ToString());
                            }
                        }
                    }
                    if (ds.Tables[1] != null)
                    {
                        DataTable dtSubCategory = ds.Tables[1];
                        if (dtSubCategory.Rows.Count > 0)
                        {

                            for (int i = 0; i < dtSubCategory.Rows.Count; i++)
                            {
                                strsubcategory = (strsubcategory == "" ? dtSubCategory.Rows[i]["CompleteName"].ToString() : strsubcategory + "<br />" + dtSubCategory.Rows[i]["CompleteName"].ToString());
                            }
                        }
                    }
                }
                lblCategory.Text = strcategory;
                lblSubCategory.Text = strsubcategory;
             


            gvKeyPersonnel.DataSource = CreateKeyPersonell(s.KeyPersonnel.Trim(), s.KeyPosition.Trim());
            gvKeyPersonnel.DataBind();

            gvPresentServices.DataSource = st.QueryPresentServices(ViewState["VendorId"].ToString().Trim());
            gvPresentServices.DataBind();

            DataTable dt = st.QueryMajorCustomers(ViewState["VendorId"].ToString().Trim());
            if (dt.Rows.Count == 0)
                dt = CreateEmptyMajorCustomers();
            gvMajorCustomers.DataSource = dt;
            gvMajorCustomers.DataBind();

             dt = st.QueryBanks(ViewState["VendorId"].ToString().Trim());
                if (dt.Rows.Count==0)
                    dt = CreateEmptyBanks();
            gvBanks.DataSource = dt;
            gvBanks.DataBind();


             dt = st.QueryAffiliatedCompanies(ViewState["VendorId"].ToString().Trim());
            if (dt.Rows.Count == 0)
                dt = CreateEmptyAffiliatedCompanies();
            gvAffiliatedCompanies.DataSource = dt;
            gvAffiliatedCompanies.DataBind();

             dt = st.QueryExternalAuditors(ViewState["VendorId"].ToString().Trim());
            if (dt.Rows.Count == 0)
                dt = CreateEmptyExternalAuditor();
            gvExternalAuditors.DataSource = dt;
            gvExternalAuditors.DataBind();

             dt = st.QueryEquipment(ViewState["VendorId"].ToString().Trim());
            if (dt.Rows.Count == 0)
                dt = CreateEmptyEquipment();
            gvEquipment.DataSource = dt;
            gvEquipment.DataBind();

             dt = st.QueryRelatives(ViewState["VendorId"].ToString().Trim());
            if (dt.Rows.Count == 0)
                dt = CreateEmptyRelativesTable();
            gvRelatives.DataSource = dt;
            gvRelatives.DataBind();

            DataTable dtBrands = st.QueryBrandsByVendorId(Session["VendorId"].ToString().Trim());
            gvBrands.DataSource = dtBrands;
            gvBrands.DataBind();

            DataTable dtItems = st.QueryItemsCarriedByVendorId(Session["VendorId"].ToString().Trim());
            gvItems.DataSource = dtItems;
            gvItems.DataBind();

            DataTable dtLocations = st.QueryLocationsByVendorId(Session["VendorId"].ToString().Trim());
            gvLocations.DataSource = dtLocations; 
            gvLocations.DataBind();

            DataTable dtServices = st.QueryServicesByVendorId(Session["VendorId"].ToString().Trim());
            gvServices.DataSource = dtServices;
            gvServices.DataBind();


            int vendorId = Convert.ToInt32(Session["VendorId"].ToString().Trim());
            SqlParameter[] sqlParams = new SqlParameter[2];
            sqlParams[0] = new SqlParameter("@VendorId", SqlDbType.Int);
            sqlParams[0].Value = vendorId;

            DataTable dtVendorData = SqlHelper.ExecuteDataset(connstring, CommandType.StoredProcedure, "s3p_EBid_QueryVendor_Addl_Info", sqlParams).Tables[0];

                if (dtVendorData.Rows.Count > 0)
                {
                    tbSLASIRDate.Text = Convert.ToDateTime(dtVendorData.Rows[0]["SLA_SIR_Date"].ToString().Trim()).ToShortDateString().ToString();
                    tbSLADateApproved.Text = Convert.ToDateTime(dtVendorData.Rows[0]["SLA_Date_Approved"].ToString().Trim()).ToShortDateString().ToString();
                    tbSLAAccredited.Text = Convert.ToDateTime(dtVendorData.Rows[0]["Accreditation_Duration"].ToString().Trim()).ToShortDateString().ToString();
                    tbAccrFrom.Text = Convert.ToDateTime(dtVendorData.Rows[0]["Accreditation_From"].ToString().Trim()).ToShortDateString().ToString();
                    tbAccrTo.Text = Convert.ToDateTime(dtVendorData.Rows[0]["Accreditation_To"].ToString().Trim()).ToShortDateString().ToString();
                    tbPerfDate.Text = Convert.ToDateTime(dtVendorData.Rows[0]["Perf_Evaluation_Date"].ToString().Trim()).ToShortDateString().ToString();
                    tbPerfRate.Text = dtVendorData.Rows[0]["Perf_Evaluation_Rate"] == null ? "" : dtVendorData.Rows[0]["Perf_Evaluation_Rate"].ToString().Trim();
                    tbCompSIRDate.Text = Convert.ToDateTime(dtVendorData.Rows[0]["Composite_Rating_SIR_Date"].ToString().Trim()).ToShortDateString().ToString();
                    tbCompRate.Text = dtVendorData.Rows[0]["Composite_Rating_Rate"] == null ? "" : dtVendorData.Rows[0]["Composite_Rating_Rate"].ToString().Trim();
                    tbMaxSIRDate.Text = Convert.ToDateTime(dtVendorData.Rows[0]["Maximum_Exposure_SIR_Date"].ToString().Trim()).ToShortDateString().ToString();
                    tbMaxRate.Text = dtVendorData.Rows[0]["Maximum_Exposure_Amount"] == null ? "" : dtVendorData.Rows[0]["Maximum_Exposure_Amount"].ToString().Trim();
                    //tbEnrollmentDate.Text = Convert.ToDateTime(dtVendorData.Rows[0]["Enrollment_Date"].ToString().Trim()).ToShortDateString().ToString();
                    tbIRDate.Text = Convert.ToDateTime(dtVendorData.Rows[0]["IR_Date"].ToString().Trim()).ToShortDateString().ToString();
                    tbIRNumber.Text = dtVendorData.Rows[0]["IR_Number"] == null ? "" : dtVendorData.Rows[0]["IR_Number"].ToString().Trim();
                    tbIRDescription.Text = dtVendorData.Rows[0]["IR_Description"] == null ? "" : dtVendorData.Rows[0]["IR_Description"].ToString().Trim();
                }


            }
            else
            {
                    Response.Redirect("suppliers.aspx");
            }

        }

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Session["VendorId"] = ViewState["VendorId"].ToString().Trim();
        Response.Redirect("supplieredit.aspx");
    }

    private DataTable CreateKeyPersonell(string strKeyPersonnel, string strKeyPosition)
    {

        string[] strKeyPersonnel1 = strKeyPersonnel.Split(Convert.ToChar("|"));
        string[] strKeyPosition1 = strKeyPosition.Split(Convert.ToChar("|"));
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Name", typeof(System.String));
        dt.Columns.Add(dcol1);
        DataColumn dcol2 = new DataColumn("Position", typeof(System.String));
        dt.Columns.Add(dcol2);

        for (int i = 0; i < strKeyPersonnel1.Length; i++)
        {
            DataRow dr = dt.NewRow();
            dr["Name"] = ((strKeyPersonnel1[i].Trim() == "") ? "&nbsp;" : strKeyPersonnel1[i].Trim());
            dr["Position"] = ((strKeyPosition1[i].Trim() == "") ? "&nbsp;" : strKeyPosition1[i].Trim());
            dt.Rows.Add(dr);
        }

        return dt;
    }

    private DataTable CreateEmptyPresentServices()
    {
        DataTable dt = new DataTable();
        DataColumn dcol = new DataColumn("Plan", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("AcctNo", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("CreditLimit", typeof(System.String));
        dt.Columns.Add(dcol);

        DataRow dr = dt.NewRow();
        dr["Plan"] = "test";
        dr["AcctNo"] = "test";
        dr["CreditLimit"] = "test";
        dt.Rows.Add(dr);

        return dt;
    }



    private DataTable CreateEmptyMajorCustomers()
    {
        DataTable dt = new DataTable();
        DataColumn dcol = new DataColumn("Customer", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("Sale", typeof(System.String));
        dt.Columns.Add(dcol);

        DataRow dr = dt.NewRow();
        dr["Customer"] = "&nbsp;";
        dr["Sale"] = "&nbsp;";
        dt.Rows.Add(dr);

        return dt;
    }

    private DataTable CreateEmptyBanks()
    {
        DataTable dt = new DataTable();
        DataColumn dcol = new DataColumn("Bank", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("CreditLine", typeof(System.String));
        dt.Columns.Add(dcol);

        DataRow dr = dt.NewRow();
        dr["Bank"] = "&nbsp;";
        dr["CreditLine"] = "&nbsp;";
        dt.Rows.Add(dr);

        return dt;
    }

    private DataTable CreateEmptyAffiliatedCompanies()
    {
        DataTable dt = new DataTable();
        DataColumn dcol = new DataColumn("Company", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("Business", typeof(System.String));
        dt.Columns.Add(dcol);

        DataRow dr = dt.NewRow();
        dr["Company"] = "&nbsp;";
        dr["Business"] = "&nbsp;";
        dt.Rows.Add(dr);

        return dt;
    }

    private DataTable CreateEmptyExternalAuditor()
    {
        DataTable dt = new DataTable();
        DataColumn dcol = new DataColumn("Auditor", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("Counsel", typeof(System.String));
        dt.Columns.Add(dcol);

        DataRow dr = dt.NewRow();
        dr["Auditor"] = "&nbsp;";
        dr["Counsel"] = "&nbsp;";
        dt.Rows.Add(dr);

        return dt;
    }


    private DataTable CreateEmptyEquipment()
    {
        DataTable dt = new DataTable();
        DataColumn dcol = new DataColumn("Type", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("Unit", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("Remarks", typeof(System.String));
        dt.Columns.Add(dcol);

        DataRow dr = dt.NewRow();
        dr["Type"] = "&nbsp;";
        dr["Unit"] = "&nbsp;";
        dr["Remarks"] = "&nbsp;";
        dt.Rows.Add(dr);

        return dt;
    }


    private DataTable CreateEmptyRelativesTable()
    {
        DataTable dt = new DataTable();
        DataColumn dcol = new DataColumn("Name", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("TitlePosition", typeof(System.String));
        dt.Columns.Add(dcol);
        dcol = new DataColumn("Relationship", typeof(System.String));
        dt.Columns.Add(dcol);

        DataRow dr = dt.NewRow();
        dr["Name"] = "&nbsp;";
        dr["TitlePosition"] = "&nbsp;";
        dr["Relationship"] = "&nbsp;";
        dt.Rows.Add(dr);

        return dt;
    }

}
