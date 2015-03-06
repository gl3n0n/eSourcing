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


public partial class web_purchasing_vsfview : System.Web.UI.Page
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
        if (Session["VSFId"] == null || Session["VSFId"]== "")
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
                        lblApprovedDate.Text = oReader["ApprovedDt"].ToString();
                        ApprovedMemo.Checked = oReader["ApprovedMemo"].ToString()=="1" ? true : false;
                        BoardApproval.Checked = oReader["BoardApproval"].ToString() == "1" ? true : false;
                        EndorsementMemo.Checked = oReader["EndorsementMemo"].ToString() == "1" ? true : false;
                        ExcomApproval.Checked = oReader["ExcomApproval"].ToString() == "1" ? true : false;
                        Others.Checked = oReader["Others"].ToString() == "1" ? true : false;
                        OthersDesc.Text  = oReader["OthersDesc"].ToString();
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

        if(Request.Form["__EVENTTARGET"] == "HistoryBack")
        {
            Session["VSFId"] = "";
            Response.Redirect(Session["pageDetails"].ToString());
        }

        if(Request.Form["__EVENTTARGET"] == "Reject")
        {
            query = "UPDATE tblVendorShortlistingForm SET Status=4 WHERE VSFId=@VSFId";
            //query = "sp_GetVendorInformation"; //##storedProcedure
            using (conn = new SqlConnection(connstring))
            {
                using (cmd = new SqlCommand(query, conn))
                {
                    //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                    cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                    conn.Open(); cmd.ExecuteNonQuery();
                }
            }
            Session["VSFId"] = "";
            Response.Redirect("vsfrejected.aspx");
        }

        if(Request.Form["__EVENTTARGET"] == "Clarify")
        {
            query = "UPDATE tblVendorShortlistingForm SET Status=2, Recomendatation=@Recomendatation WHERE VSFId=@VSFId";
            //query = "sp_GetVendorInformation"; //##storedProcedure
            using (conn = new SqlConnection(connstring))
            {
                using (cmd = new SqlCommand(query, conn))
                {
                    //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                    cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                    cmd.Parameters.AddWithValue("@Recomendatation", Recomendatation.Value);
                    conn.Open(); cmd.ExecuteNonQuery();
                }
            }

            if(Request.Form["Comment"].ToString()!=""){
                query = "INSERT INTO tblVSFComments (VSFId, UserId, Name, Comment, DateCreated) VALUES (@VSFId, @UserId, @Name, @Comment, getdate())";
                //query = "sp_GetVendorInformation"; //##storedProcedure
                using (conn = new SqlConnection(connstring))
                {
                    using (cmd = new SqlCommand(query, conn))
                    {
                        //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                        cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                        cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"].ToString()));
                        cmd.Parameters.AddWithValue("@Name", Session["UserFullName"].ToString());
                        cmd.Parameters.AddWithValue("@Comment", Request.Form["Comment"].ToString());
                        conn.Open(); cmd.ExecuteNonQuery();
                    }
                }
            }

            Session["VSFId"] = "";
            Response.Redirect(Session["pageDetails"].ToString());
        }

        if(Request.Form["__EVENTTARGET"] == "Approve")
        {

            query = "UPDATE tblVendorShortlistingForm SET Status=3, Recommendation=@Recomendatation, ApprovedDt=getdate() WHERE VSFId=@VSFId";
            //query = "sp_GetVendorInformation"; //##storedProcedure
            using (conn = new SqlConnection(connstring))
            {
                using (cmd = new SqlCommand(query, conn))
                {
                    //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                    cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                    cmd.Parameters.AddWithValue("@Recomendatation", Recomendatation.Value);
                    conn.Open(); cmd.ExecuteNonQuery();
                }
            }

            if (Request.Form["Comment"].ToString() != "")
            {
                query = "INSERT INTO tblVSFComments (VSFId, UserId, Name, Comment, DateCreated) VALUES (@VSFId, @UserId, @Name, @Comment, getdate())";
                //query = "sp_GetVendorInformation"; //##storedProcedure
                using (conn = new SqlConnection(connstring))
                {
                    using (cmd = new SqlCommand(query, conn))
                    {
                        //cmd.CommandType = CommandType.StoredProcedure; //##storedProcedure
                        cmd.Parameters.AddWithValue("@VSFId", Convert.ToInt32(Session["VSFId"].ToString()));
                        cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"].ToString()));
                        cmd.Parameters.AddWithValue("@Name", Session["UserFullName"].ToString());
                        cmd.Parameters.AddWithValue("@Comment", Request.Form["Comment"].ToString());
                        conn.Open(); cmd.ExecuteNonQuery();
                    }
                }
            }

            Session["VSFId"] = "";
            Response.Redirect("vsfapproved.aspx");
        }
        
    }

    void SaveToDB_Init()
    {
        
    }


    protected void repeaterVSFDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
             //System.Web.UI.HtmlControls.HtmlInputHidden oHiddenVendors = ((System.Web.UI.HtmlControls.HtmlInputHidden)e.Item.FindControl("VendorId"));
            //((System.Web.UI.WebControls.Image)e.Item.FindControl("imgVendor")).Attributes.Add("onclick", "javascript: __doPostBack('deleteVendor', '" + ((DataRowView)e.Item.DataItem)["VendorID"].ToString() + "');");
        }
    }

}