using System;
using System.Configuration;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.IO.Compression;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EBid.lib;
using EBid.lib.constant;
using EBid.lib.report;
using System.IO;
using System.Text;
using EBid.lib.bid.trans;
using EBid.lib.bid.data;
using EBid.lib.user.trans;
using EBid.lib.user.data;
using System.Data.Common;
using EBid.lib.auction.data;
using EBid.lib;
using EBid.lib.constant;


public partial class web_buyerscreens_vsfcreate : System.Web.UI.Page
{
    SqlDataReader oReader;
    string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
    string query;
    SqlCommand cmd;
    SqlConnection conn;
    int PurchasingId1;

    protected void TestShowAllSessions()
    {
        //test show all session
        string str = null;
        foreach (string key in HttpContext.Current.Session.Keys)
        {
            str += string.Format("<b>{0}</b>: {1};  ", key, HttpContext.Current.Session[key].ToString());
        }
        Response.Write("<span style='font-size:12px'>" + str + "</span>");
    }

    bool IsNumber(string text)
    {
       Regex regex = new Regex(@"^[-+]?[0-9]*\.?[0-9]+$");
       return regex.IsMatch(text);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //TestShowAllSessions();
        if (Session["pageDetails"] == "" || Session["pageDetails"] == null)
        {
            Session["pageDetails"] = "index.aspx";
        }
        if (Session["VSFId"] == null || Session["VSFId"]== "" || Request.QueryString["create"]=="new")
        {
            SaveToDB_Init();
        }
        if (IsPostBack)
        {
            SaveToDB();
        }
        PopulateFields();
    }



    protected void Page_LoadComplete(object sender, EventArgs e)
    {
    }


    void PopulateFields()
    {
        query = "SELECT t1.*, t2.BuyerFirstName + ' ' + t2.BuyerMidName + ' ' + t2.BuyerLastName AS BuyerName, t3.FirstName + ' ' + t3.MiddleName + ' ' + t3.LastName AS PurchasingName FROM tblVendorShortlistingForm t1, tblBuyers t2, tblPurchasing t3 WHERE t1.VSFId=@VSFId AND t2.BuyerId = t1.BuyerId AND t3.PurchasingId = t1.PurchasingId";
        //query = "sp_GetVendorInformation"; //##storedProcedure
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"]));
                conn.Open();
                //Process results
                oReader = cmd.ExecuteReader();
                if (oReader.HasRows)
                {
                    while (oReader.Read())
                    {
                        VSFDate.Text = oReader["VSFDate"].ToString();
                        ProponentName.Text = oReader["ProponentName"].ToString();
                        PRNo.Text = oReader["PRNo"].ToString();
                        GroupDept.Text = oReader["GroupDept"].ToString();
                        ProjectName.Text = oReader["ProjectName"].ToString();
                        NumPotentialVendor.Text = oReader["NumPotentialVendor"].ToString();
                        PRAmount.Text = oReader["PRAmount"].ToString();
                        NumShortlistedVendor.Text = oReader["NumShortlistedVendor"].ToString();
                        PRDescription.Text = oReader["PRDescription"].ToString();
                        lblPreparedDate.Text = oReader["PreparedDt"].ToString();
                        ApprovedMemo.Checked = oReader["ApprovedMemo"].ToString()=="1" ? true : false;
                        BoardApproval.Checked = oReader["BoardApproval"].ToString() == "1" ? true : false;
                        EndorsementMemo.Checked = oReader["EndorsementMemo"].ToString() == "1" ? true : false;
                        ExcomApproval.Checked = oReader["ExcomApproval"].ToString() == "1" ? true : false;
                        Others.Checked = oReader["Others"].ToString() == "1" ? true : false;
                        OthersDesc.Value  = oReader["OthersDesc"].ToString();
                        Recomendatation.Value = oReader["Recomendatation"].ToString();
                        lblBuyer.Text = oReader["BuyerName"].ToString();
                        lblPurchasing.Text = oReader["PurchasingName"].ToString();
                    }
                }
            }
        }
    }


    void SaveToDB()
    {

        //Response.Write(Request.Form["__EVENTTARGET"] + "=" + Request.Form["__EVENTARGUMENT"]);
        if (Request.Form["__EVENTTARGET"] == "deleteVendor")
        {
            query = "DELETE FROM tblVSFDetails WHERE VendorId = " + Request.Form["__EVENTARGUMENT"] + " AND VSFId = " + Session["VSFId"].ToString();
            SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, query);
            repeaterVSFDetails.DataBind();
        }
        if (Request.Form["__EVENTTARGET"] == "deleteVendorAll")
        {
            query = "DELETE FROM tblVSFDetails WHERE VSFId = " + Session["VSFId"].ToString();
            SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, query);
            repeaterVSFDetails.DataBind();
        }
        else if (Request.Form["__EVENTTARGET"] == "Cancel")
        {
            query = "DELETE FROM tblVSFDetails WHERE VSFId = " + Session["VSFId"].ToString();
            SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, query);
            query = "DELETE FROM tblVendorShortlistingForm WHERE VSFId = " + Session["VSFId"].ToString();
            SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, query);
            Session["VSFId"] = "";
            Response.Redirect(Session["pageDetails"].ToString());
        }
        else if(Request.Form["__EVENTTARGET"] == "HistoryBack")
        {
            Session["VSFId"] = "";
            Response.Redirect(Session["pageDetails"].ToString());
        }
        else if (Request.Form["__EVENTTARGET"] == "SearchVendors")
        {
            //Response.Write(ddlCategory.SelectedValue + "," + ddlSubCategory.SelectedValue + "," + ddlBrands.SelectedValue);
            query = "sp_InsertIntoVSFDetails_1"; //##storedProcedure
            using (conn = new SqlConnection(connstring))
            {
                using (cmd = new SqlCommand(query, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                    cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                    cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@SubCategoryId", ddlSubCategory.SelectedValue!=" " ? Convert.ToInt32(ddlSubCategory.SelectedValue) : 0);
                    cmd.Parameters.AddWithValue("@BrandId", ddlBrands.SelectedValue != " " ? Convert.ToInt32(ddlBrands.SelectedValue) : 0);
                    conn.Open(); cmd.ExecuteNonQuery();
                }
            }
            repeaterVSFDetails.DataBind();
        }
        else if (Request.Form["__EVENTTARGET"] == "txtVendorName")
        {
            query = "sp_InsertIntoVSFDetails"; //##storedProcedure
            using (conn = new SqlConnection(connstring))
            {
                using (cmd = new SqlCommand(query, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                    cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                    cmd.Parameters.AddWithValue("@VendorId", Convert.ToInt32(txtVendorName.SelectedValue));
                    conn.Open(); cmd.ExecuteNonQuery();
                }
            }
            repeaterVSFDetails.DataBind();
        }
        else
        {
            Repeater oRpt = (Repeater)this.form1.FindControl("repeaterVSFDetails");
            foreach (RepeaterItem oItem in oRpt.Items)
            {
                System.Web.UI.HtmlControls.HtmlInputHidden VendorId = ((System.Web.UI.HtmlControls.HtmlInputHidden)oItem.FindControl("VendorId"));
                System.Web.UI.HtmlControls.HtmlInputText SAPRatingScore = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("SAPRatingScore"));
                System.Web.UI.HtmlControls.HtmlInputText SAPRatingRank = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("SAPRatingRank"));
                System.Web.UI.HtmlControls.HtmlInputText MaxExposureLimit = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("MaxExposureLimit"));
                System.Web.UI.HtmlControls.HtmlInputText AmountUnservedPO = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("AmountUnservedPO"));
                System.Web.UI.HtmlControls.HtmlInputText AvailBalance = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("AvailBalance"));
                System.Web.UI.HtmlControls.HtmlInputText FCRank = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("FCRank"));
                //System.Web.UI.HtmlControls.HtmlInputText EndoresedBy = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("EndoresedBy"));
                //RadioButtonList ProductTypeApproval = ((RadioButtonList)oItem.FindControl("ProductTypeApproval"));
                System.Web.UI.HtmlControls.HtmlInputText OverallRanking = ((System.Web.UI.HtmlControls.HtmlInputText)oItem.FindControl("OverallRanking"));


                query = "UPDATE tblVSFDetails SET SAPRatingScore=@SAPRatingScore, SAPRatingRank=@SAPRatingRank, MaxExposureLimit=@MaxExposureLimit, AmountUnservedPO=@AmountUnservedPO, AvailBalance=@AvailBalance, FCRank=@FCRank, EndoresedBy=@EndoresedBy, ProductTypeApproval=@ProductTypeApproval, OverallRanking=@OverallRanking WHERE VendorId = @VendorId AND VSFId=@VSFId";
                //query = "sp_GetVendorInformation"; //##storedProcedure
                using (conn = new SqlConnection(connstring))
                {
                    using (cmd = new SqlCommand(query, conn))
                    {
                        //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                        cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                        cmd.Parameters.AddWithValue("@VendorId", Convert.ToInt32(VendorId.Value));
                        cmd.Parameters.AddWithValue("@SAPRatingScore", SAPRatingScore.Value != "" ? Convert.ToDouble(SAPRatingScore.Value.Replace(",", "")) : 0);
                        cmd.Parameters.AddWithValue("@SAPRatingRank", SAPRatingRank.Value != "" ? Convert.ToInt32(SAPRatingRank.Value.Replace(",", "")) : 0);
                        cmd.Parameters.AddWithValue("@MaxExposureLimit", MaxExposureLimit.Value != "" ? Convert.ToDouble(MaxExposureLimit.Value.Replace(",", "")) : 0);
                        cmd.Parameters.AddWithValue("@AmountUnservedPO", AmountUnservedPO.Value != "" ? Convert.ToDouble(AmountUnservedPO.Value.Replace(",", "")) : 0);
                        cmd.Parameters.AddWithValue("@AvailBalance", AvailBalance.Value != "" ? Convert.ToDouble(AvailBalance.Value.Replace(",", "")) : 0);
                        cmd.Parameters.AddWithValue("@FCRank", FCRank.Value != "" ? Convert.ToInt32(FCRank.Value.Replace(",", "")) : 0);
                        cmd.Parameters.AddWithValue("@EndoresedBy", ((DropDownList)oItem.FindControl("EndoresedBy")).SelectedValue);
                        cmd.Parameters.AddWithValue("@ProductTypeApproval", ((DropDownList)oItem.FindControl("ProductTypeApproval")).SelectedValue);
                        cmd.Parameters.AddWithValue("@OverallRanking", OverallRanking.Value != "" ? Convert.ToDouble(OverallRanking.Value.Replace(",", "")) : 0);
                        conn.Open(); cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        query = "SELECT t1.PurchasingID, t2.FirstName + ' ' + t2.MiddleName + ' ' + t2.LastName AS Name1, t2.EmailAdd  FROM tblSupervisor t1, tblPurchasing t2 WHERE t1.PurchasingID=t2.PurchasingID and t1.BuyerId = " + Session["UserId"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, query);
        if (oReader.HasRows)
        {
            oReader.Read();
            PurchasingId1 = Convert.ToInt32(oReader["PurchasingID"].ToString());
        }

        query = "UPDATE tblVendorShortlistingForm SET VSFDate=@VSFDate, ApprovedMemo=@ApprovedMemo, BoardApproval=@BoardApproval, EndorsementMemo=@EndorsementMemo, ExcomApproval=@ExcomApproval, Others=@Others, OthersDesc=@OthersDesc, Recomendatation=@Recomendatation, ProponentName=@ProponentName, PRNo=@PRNo, GroupDept=@GroupDept, ProjectName=@ProjectName, NumPotentialVendor=@NumPotentialVendor, PRAmount=@PRAmount, NumShortlistedVendor=@NumShortlistedVendor, PRDescription=@PRDescription, BuyerId=@BuyerId, PurchasingId=@PurchasingId WHERE VSFId=@VSFId";
        //query = "sp_GetVendorInformation"; //##storedProcedure
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                cmd.Parameters.AddWithValue("@VSFDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@ProponentName", Request.Form["ProponentName"].ToString());
                cmd.Parameters.AddWithValue("@ApprovedMemo", ApprovedMemo.Checked== true ? 1 : 0);
                cmd.Parameters.AddWithValue("@BoardApproval", BoardApproval.Checked == true ? 1 : 0);
                cmd.Parameters.AddWithValue("@EndorsementMemo", EndorsementMemo.Checked == true ? 1 : 0);
                cmd.Parameters.AddWithValue("@ExcomApproval", ExcomApproval.Checked == true ? 1 : 0);
                cmd.Parameters.AddWithValue("@Others", Others.Checked == true ? 1 : 0);
                cmd.Parameters.AddWithValue("@OthersDesc", Request.Form["OthersDesc"].ToString());
                cmd.Parameters.AddWithValue("@Recomendatation", Recomendatation.Value);
                cmd.Parameters.AddWithValue("@PRNo", Request.Form["PRNo"].ToString());
                cmd.Parameters.AddWithValue("@GroupDept", Request.Form["GroupDept"].ToString());
                cmd.Parameters.AddWithValue("@ProjectName", Request.Form["ProjectName"].ToString());
                cmd.Parameters.AddWithValue("@NumPotentialVendor", Request.Form["NumPotentialVendor"].ToString()!="" ? Convert.ToInt32(Request.Form["NumPotentialVendor"].ToString().Replace(",","")) : 0);
                cmd.Parameters.AddWithValue("@PRAmount", Request.Form["PRAmount"].ToString() != "" ? Convert.ToDouble(Request.Form["PRAmount"].ToString().Replace(",", "")) : 0);
                cmd.Parameters.AddWithValue("@NumShortlistedVendor", Request.Form["NumShortlistedVendor"].ToString() != "" ? Convert.ToInt32(Request.Form["NumShortlistedVendor"].ToString().Replace(",", "")) : 0);
                cmd.Parameters.AddWithValue("@PRDescription", Request.Form["PRDescription"].ToString());
                cmd.Parameters.AddWithValue("@BuyerId", Convert.ToInt32(Session["UserId"]));
                cmd.Parameters.AddWithValue("@PurchasingId", PurchasingId1);
                conn.Open(); cmd.ExecuteNonQuery();
            }
        }
        if (Request.Form["__EVENTTARGET"] == "Endorse") 
        {
            query = "UPDATE tblVendorShortlistingForm SET Status=1 WHERE VSFId = " + Session["VSFId"].ToString();
            SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, query);
            Session["VSFId"] = "";
            Response.Redirect(Session["pageDetails"].ToString());
        }
        
    }

    void SaveToDB_Init()
    {
        string sCommand;

        //GET PURCHASING
        query = "SELECT t1.PurchasingID, t2.FirstName + ' ' + t2.MiddleName + ' ' + t2.LastName AS Name1, t2.EmailAdd  FROM tblSupervisor t1, tblPurchasing t2 WHERE t1.PurchasingID=t2.PurchasingID and t1.BuyerId = " + Session["UserId"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, query);
        if (oReader.HasRows)
        {
            oReader.Read();
            PurchasingId1 = Convert.ToInt32(oReader["PurchasingID"].ToString());
        }

        query = "INSERT INTO tblVendorShortlistingForm (VSFDate, ProponentName, PRNo, GroupDept, ProjectName, NumPotentialVendor, PRAmount, NumShortlistedVendor, PRDescription, BuyerId, PurchasingId) VALUES (@VSFDate, @ProponentName, @PRNo, @GroupDept, @ProjectName, @NumPotentialVendor, @PRAmount, @NumShortlistedVendor, @PRDescription, @BuyerId, @PurchasingId)";
        //query = "sp_GetVendorInformation"; //##storedProcedure
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                cmd.Parameters.AddWithValue("@VSFDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@ProponentName", "");
                cmd.Parameters.AddWithValue("@PRNo", "");
                cmd.Parameters.AddWithValue("@GroupDept", "");
                cmd.Parameters.AddWithValue("@ProjectName", "");
                cmd.Parameters.AddWithValue("@NumPotentialVendor", 0);
                cmd.Parameters.AddWithValue("@PRAmount", 0);
                cmd.Parameters.AddWithValue("@NumShortlistedVendor", 0);
                cmd.Parameters.AddWithValue("@PRDescription", "");
                cmd.Parameters.AddWithValue("@BuyerId", Convert.ToInt32(Session["UserId"]));
                cmd.Parameters.AddWithValue("@PurchasingId", PurchasingId1);
                conn.Open(); cmd.ExecuteNonQuery();
            }

            sCommand = "SELECT MAX(VSFId) as LastInsertId FROM tblVendorShortlistingForm";
            oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
            if (oReader.HasRows)
            {
                oReader.Read();
                Session["VSFId"] = oReader["LastInsertId"].ToString();
            }
        }

        Response.Redirect("vsfcreate.aspx");
    }



    //############################################################
    //############################################################
    protected void repeaterVSFDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
             System.Web.UI.HtmlControls.HtmlInputHidden oHiddenVendors = ((System.Web.UI.HtmlControls.HtmlInputHidden)e.Item.FindControl("VendorId"));
            ((System.Web.UI.WebControls.Image)e.Item.FindControl("imgVendor")).Attributes.Add("onclick", "javascript: __doPostBack('deleteVendor', '" + ((DataRowView)e.Item.DataItem)["VendorID"].ToString() + "');");
            ((DropDownList)e.Item.FindControl("ProductTypeApproval")).SelectedValue = (((DataRowView)e.Item.DataItem)["ProductTypeApproval"].ToString());
            ((DropDownList)e.Item.FindControl("EndoresedBy")).SelectedValue = (((DataRowView)e.Item.DataItem)["EndoresedBy"].ToString());
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        //lstSupplierB.Items.Clear();
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

    protected void ddlBrands_DataBound(object sender, EventArgs e)
    {
        ddlBrands.Items.Insert(0, new ListItem("---- ALL BRANDS ----", " "));

        if (ViewState["brands"] != null)

            ddlBrands.SelectedValue = ViewState["subcategory"].ToString();

    }

}