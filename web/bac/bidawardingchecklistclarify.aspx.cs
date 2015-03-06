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

public partial class web_bac_bidawardingchecklistclarify : System.Web.UI.Page
{
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

    public float iTotal;
    int iApproverCount = 0;
    int iVendor;
    int iVendorCnt = 0, iAccreditation = 0, iTechComp = 0, iCommComp = 0, iContComp = 0, iPRating = 0;
    int iC0 = 0, iC1 = 0, iC2 = 0, iC3 = 0, iC4 = 0, iC5 = 0, iC6 = 0, iC7 = 0, iC8 = 0, iC9 = 0;
    int iQty = 0, iUnitMeasure = 0, iUnitCost = 0, iTotal1 = 0, iCurrency = 0, iRanking = 0, iAwarded = 0;

    bool IsNumber(string text)
    {
        Regex regex = new Regex(@"^[-+]?[0-9]*\.?[0-9]+$");
        return regex.IsMatch(text);
    }


    protected void doBuyerBidForBac()
    {
        
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        //TestShowAllSessions();
        //determine and show who is clarifying
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        string sCommand = "SELECT FirstName+' '+LastName as ResponseClarifyTo from tblBidAwardingCommittee where BACId=" + Session["ClarifiedBy"];
        SqlDataReader oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            ResponseClarifyTo.Value = oReader["ResponseClarifyTo"].ToString();
        }
        oReader.Close();

        if (IsPostBack)
        {
            string control1 = Request.Form["__EVENTTARGET"];
            //Response.Write(control1);
            if (control1 == "BuyerBidForBac")
            {
               // ShowBidItemTenders();
            }
            else if (control1 == "Clarify")
            {
                doClarify();
            }
            else if (control1 == "Approve")
            {
                doApprove();
            }
            else if (control1 == "Reject")
            {
                doReject();
            }
        }

        //dsApprover.SelectCommand = "SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t1.ApprovingMaxLimit FROM tblBidAwardingCommittee t1 JOIN tblUsers t2 ON (t1.BACId=t2.UserId AND t2.IsAuthenticated=1) WHERE t1.ApprovingMaxLimit >= " + lblTotalAll.Value.ToString() + " ORDER BY t1.ApprovingMaxLimit ASC";
        //dsApprover.DataBind();

        // show approver
        ShowApprover();

        //clarify4.Attributes.Add("onClick", "ShowClarify();");
        //approved4.Attributes.Add("onClick", "ShowApprove();");

        // awarding committee
        SqlDataSource dsApprover = (SqlDataSource)bac_bidApprovingCommittee1.FindControl("dsApprover");
        dsApprover.SelectCommand = "select BACId, NAME1, ApprovingLimit, ApprovedDt from ( SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_1 ApprovedDt, 1 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_1 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_2 ApprovedDt, 2 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_2 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_3 ApprovedDt, 3 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_3 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_4 ApprovedDt, 4 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_4 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_5 ApprovedDt, 5 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_5 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_6 ApprovedDt, 6 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_6 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_7 ApprovedDt, 7 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_7 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_8 ApprovedDt,  8 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_8 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_9 ApprovedDt,  9 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_9 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_10 ApprovedDt, 10 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2 WHERE t1.BACId = t2.Approver_10 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + ") as table_1 order by ApprovingLimit";
        dsApprover.DataBind();
        Repeater RepeaterApprover1 = (Repeater)bac_bidApprovingCommittee1.FindControl("RepeaterApprover1");
        RepeaterApprover1.DataSourceID = null;
        RepeaterApprover1.DataBind();
        RepeaterApprover1.DataSourceID = "dsApprover";
        RepeaterApprover1.DataBind();
    }

    protected void doClarify()
    {

        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        string sCommand;
        string sLastCommented = ""; SqlDataReader oReader;


        //string xApprovedDt = "";
        //string query; SqlCommand cmd; SqlConnection conn;
        //query = "sp_get_clarification_list"; 
        //using (conn = new SqlConnection(connstring))
        //{
        //    using (cmd = new SqlCommand(query, conn))
        //    {
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@ClarifyTo", Convert.ToInt32(Session["UserId"]));
        //        cmd.Parameters.AddWithValue("@ClarifyBy", Convert.ToInt32(Session["ClarifiedBy"]));
        //        cmd.Parameters.AddWithValue("@BidRefNo", Convert.ToInt32(Session["BuyerBidForBac"]));
        //        //cmd.Parameters.AddWithValue("@BacId", Convert.ToInt32(Request.Form["__EVENTARGUMENT"].ToString()));
        //        conn.Open(); oReader = cmd.ExecuteReader();
        //        if (oReader.HasRows)
        //        {
        //            while (oReader.Read())
        //            {
        //                if (oReader["BacId"].ToString() == Request.Form["__EVENTARGUMENT"].ToString().Trim())
        //                {
        //                    xApprovedDt = oReader["ApprovedDt"].ToString();
        //                }
        //            }
        //        }
        //    }
        //}

        int fromId = Convert.ToInt32(Session["UserId"].ToString());
        int toId = Convert.ToInt32(Request.Form["__EVENTARGUMENT"].ToString().Trim());

        if (InsertClarification() == 2)
        {
            //// add row to tblBACClarifications table
            //sCommand = "INSERT INTO tblBACClarifications (BidRefNo, FrUserId, Comment, ToUserId, DatePosted) VALUES (";
            //sCommand = sCommand + Session["BuyerBidForBac"].ToString() + ", " + Session["UserId"] + ", '" + Request.Form["txtClarify"].ToString().Replace("'", "''") +"', " + Request.Form["__EVENTARGUMENT"].ToString().Trim() + ", GETDATE())";
            //SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);

            //// Clear Approved and Clarfied from tblBacBidItems table
            //sCommand = "UPDATE tblBacBidItems SET Status=2 WHERE BacRefNo=" + Session["BuyerBacRefNo"];
            //SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);

            if (SendEmailNotificationClarify(fromId, toId))
            {
                Session["Message"] = "Notification sent successfully.";
            }
            else
            {
                // failed
                Session["Message"] = "Failed to send notification. Please try again or contact adminitrator for assistance.";
            }
        }
        else
        {
            //// add row to tblBACClarifications table
            //sCommand = "INSERT INTO tblBACComments (BidRefNo, UserId, Comment, DatePosted) VALUES (";
            //sCommand = sCommand + Session["BuyerBidForBac"].ToString() + ", " + Session["UserId"] + ", '" + Request.Form["txtClarify"].ToString().Replace("'", "''") + "', GETDATE())";
            //SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);

            //sCommand = "UPDATE tblBACClarifications SET Status = 1 WHERE BidRefNo = " + Session["BuyerBidForBac"].ToString();
            //SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);

            //// Clear Approved and Clarfied from tblBacBidItems table
            //sCommand = "UPDATE tblBacBidItems SET ClarifyDt_0=NULL, ClarifyDt_1=NULL, ClarifyDt_2=NULL, ClarifyDt_3=NULL, ClarifyDt_4=NULL, ClarifyDt_5=NULL, ClarifyDt_6=NULL, ClarifyDt_7=NULL, ClarifyDt_8=NULL, ClarifyDt_9=NULL, ClarifyDt_10=NULL, Status=1 WHERE BacRefNo=" + Session["BuyerBacRefNo"];
            //sCommand = "UPDATE tblBacBidItems SET ClarifyDt_0=NULL, ClarifyDt_1=NULL, ClarifyDt_2=NULL, ClarifyDt_3=NULL, ClarifyDt_4=NULL, ClarifyDt_5=NULL, ClarifyDt_6=NULL, ClarifyDt_7=NULL, ClarifyDt_8=NULL, ClarifyDt_9=NULL, ClarifyDt_10=NULL, Status=1 WHERE BacRefNo=" + Session["BuyerBacRefNo"];
            //SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);


            //int toId = Convert.ToInt32(Request.Form["__EVENTARGUMENT"].ToString().Trim());
            if (SendEmailNotificationApprove(fromId, toId))
            {
                Session["Message"] = "Notification sent successfully.";
            }
            else
            {
                // failed
                Session["Message"] = "Failed to send notification. Please try again or contact adminitrator for assistance.";
            }
        }


        this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "ClearSavedCookies", "<script>ClearSavedCookies();</script>");
        Session["Message"] = "";
        Response.Redirect("bacforclarifications.aspx");
    }


    private int InsertClarification()
    {
        SqlConnection sqlConnect = new SqlConnection(connstring);
        SqlTransaction sqlTransact = null;
        int isSuccessful = 2;

        try
        {
            sqlConnect.Open();
            sqlTransact = sqlConnect.BeginTransaction();

            SqlParameter[] sqlParams = new SqlParameter[6];
            sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
            sqlParams[0].Value = Convert.ToInt32(Session["BuyerBidForBac"].ToString());
            sqlParams[1] = new SqlParameter("@UserID", SqlDbType.Int);
            sqlParams[1].Value = Convert.ToInt32(Session["UserId"].ToString());
            sqlParams[2] = new SqlParameter("@ClarifyBy", SqlDbType.Int);
            sqlParams[2].Value = Convert.ToInt32(Session["ClarifiedBy"].ToString());
            sqlParams[3] = new SqlParameter("@ClarifyTo", SqlDbType.Int);
            sqlParams[3].Value = Convert.ToInt32(Request.Form["__EVENTARGUMENT"].ToString().Trim());
            sqlParams[4] = new SqlParameter("@Comments", SqlDbType.Text);
            sqlParams[4].Value = Request.Form["txtClarify"].ToString().Replace("'", "''");
            sqlParams[5] = new SqlParameter("@BIdStatus", SqlDbType.Int);
            sqlParams[5].Direction = ParameterDirection.Output;

            SqlHelper.ExecuteNonQuery(connstring, CommandType.StoredProcedure, "sp_insert_clarification", sqlParams);

            sqlTransact.Commit();

            int r = int.Parse(sqlParams[5].Value.ToString().Trim());
            isSuccessful = (r <= 1 ? 1 : 2);
            //isSuccessful = r;
            //Response.Write(sqlParams[4].Value.ToString().Trim());
        }
        catch (Exception ex)
        {
            sqlTransact.Rollback();
            isSuccessful = 2;
            //Response.Write(ex.ToString());
        }
        finally
        {
            sqlConnect.Close();
        }
        return isSuccessful;
    }


    protected void doReject()
    {
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        string sCommand;

        // add row to tblBACComments table
        sCommand = "INSERT INTO tblBACComments (BidRefNo, UserId, Comment, DatePosted) VALUES (";
        sCommand = sCommand + Session["BuyerBidForBac"].ToString() + ", " + Session["UserId"] + ", '" + Request.Form["txtClarify"].ToString().Replace("'", "''") + "', GETDATE())";
        SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);

        sCommand = "UPDATE tblBacBidItems SET Status=4 WHERE BacRefNo=" + Session["BuyerBacRefNo"];
        SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);
        
        if (SendEmailNotificationReject()){
            Session["Message"] = "Notification sent successfully.";
        }
        else
        {
            // failed
            Session["Message"] = "Failed to send notification. Please try again or contact adminitrator for assistance.";
        }
        Session["Message"] = "";
        Response.Redirect("bacrejected.aspx");
    }


    protected void doApprove()
    {
        //string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        //string sCommand;

        //// add row to tblBACComments table
        //sCommand = "INSERT INTO tblBACClarifications (BidRefNo, FrUserId, Comment, ToUserId, DatePosted) VALUES (";
        //sCommand = sCommand + Session["BuyerBidForBac"].ToString() + ", " + Session["UserId"] + ", '" + Request.Form["txtClarify"] + "', 0 , GETDATE())";
        //SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);

        //int myStat = 4;
        //bool bUnchecked = false;
        //foreach (RepeaterItem oItem in RepeaterApprover.Items)
        //{
        //    if (((CheckBox)oItem.FindControl("approved1")).Checked == false)
        //    {
        //        bUnchecked = true;
        //        break;
        //    }
        //}

        //if (bUnchecked == true)
        //    myStat = 3;

        //// update tblBacBidItems table
        //sCommand = "UPDATE tblBacBidItems SET Status=" + myStat + ", ApprovedDt_" + Session["ApproverNumber"] + "=GETDATE(), Approver_" + Session["ApproverNumber"] + " = " + Session["UserId"] + " WHERE BacRefNo=" + Session["BuyerBacRefNo"];
        //SqlHelper.ExecuteNonQuery(connstring, CommandType.Text, sCommand);

        //Response.Redirect("bacapprovedpurchasing.aspx");
    }

    protected void ShowApprover()
    {
        //string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        //string sCommand;
        //SqlDataReader oReader;

        //// buyer
        //sCommand = "SELECT BuyerLastName + ', ' + BuyerFirstName + ' ' + BuyerMidName AS Name1 FROM tblBuyers WHERE BuyerID=" + Session["BuyerBuyerId"].ToString();
        //oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        //if (oReader.HasRows)
        //{
        //    oReader.Read();
        //    lblBuyer.Text = oReader["Name1"].ToString();
        //}
        //oReader.Close();

        //// approver 4: purchasing
        //sCommand = "SELECT t1.PurchasingID, t2.LastName + ', ' + t2.FirstName + ' ' + t2.MiddleName AS Name1 FROM tblSupervisor t1 ";
        //sCommand = sCommand + "INNER JOIN tblPurchasing t2 ON t1.PurchasingID=t2.PurchasingID WHERE BuyerID=" + Session["BuyerBuyerId"].ToString();
        //oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        //if (oReader.HasRows)
        //{
        //    //oReader.Read();
        //    //lblApprover4.Text = oReader["Name1"].ToString();
        //    //if (oReader["PurchasingID"].ToString() == Session["UserId"].ToString())
        //    //{
        //    //    clarify4.Disabled = false;
        //    //    approved4.Disabled = false;
        //    //}
        //    //else
        //    //{
        //    //    clarify4.Disabled = true;
        //    //    approved4.Disabled = true;
        //    //}
        //}
        //oReader.Close();
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        string sCommand;
        SqlDataReader oReader;

        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        //get position of approving user
        Session["approverPosition"] = "";
        Session["approverNext"] = "";
        sCommand = "SELECT * FROM tblBacBidItems WHERE BacRefNo=" + Session["BuyerBacRefNo"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            //string i = oReader["ItemDesc"].ToString();
            if (oReader["Approver_0"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 0;
            if (oReader["Approver_1"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 1;
            if (oReader["Approver_2"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 2;
            if (oReader["Approver_3"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 3;
            if (oReader["Approver_4"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 4;
            if (oReader["Approver_5"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 5;
            if (oReader["Approver_6"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 6;
            if (oReader["Approver_7"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 7;
            if (oReader["Approver_8"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 8;
            if (oReader["Approver_9"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 9;
            if (oReader["Approver_10"].ToString() == Session["UserId"].ToString()) Session["approverPosition"] = 10;
            int approverNext = Convert.ToInt32(Session["approverPosition"].ToString().Trim()) + 1;
            Session["approverNext"] = (oReader["Approver_" + approverNext].ToString() != "") ? 1 : 0;
        }
        oReader.Close();
    }


    protected void RepeaterApprover_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        
    }

    private string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    private bool SendEmailNotificationApprove(int FromId, int ToId)
    {
        //"Fistname Lastname" <email@globetel.com.ph>
        //"Fistname Lastname" <email@globetel.com.ph>
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
        string subject = "BAC For Approval";

        ////GET STATUS IF FOR APPROVAL OR ALREADY AWARDED
        //string Status = "";
        //sCommand = "SELECT Status FROM tblBacBidItems WHERE BidRefNo=" + Session["BuyerBidForBac"];
        //oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        //if (oReader.HasRows)
        //{
        //    oReader.Read();
        //    Status = oReader["Status"].ToString();
        //} oReader.Close();

        string query; SqlCommand cmd; SqlConnection conn;

        //GET DETAILS OF FROM
        query = "sp_GetUserDetails";
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", FromId);
                conn.Open(); oReader = cmd.ExecuteReader();
                if (oReader.HasRows)
                {
                    while (oReader.Read())
                    {
                        fromName = oReader["FullName"].ToString();
                        fromEmail = oReader["EmailAdd"].ToString();
                        from = '"' + oReader["FullName"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";
                    }
                }
            }
        } conn.Close();

        //GET DETAILS OF TO
        query = "sp_GetUserDetails";
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", ToId);
                conn.Open(); oReader = cmd.ExecuteReader();
                if (oReader.HasRows)
                {
                    while (oReader.Read())
                    {
                        toName = oReader["FullName"].ToString();
                        toEmail = oReader["EmailAdd"].ToString();
                        to = '"' + oReader["FullName"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";
                    }
                }
            }
        } conn.Close();


        try
        {
            if (!MailHelper.SendEmail(MailTemplate.GetDefaultSMTPServer(),
                    from,
                    to,
                    subject,
                    CreateNotificationBodyApprove(fromName, toName),
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

    private bool SendEmailNotificationReject()
    {
        //"Fistname Lastname" <email@globetel.com.ph>
        //"Fistname Lastname" <email@globetel.com.ph>
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
        string subject = "Rejected BAC";


        //GET BAC EMAIL AS THE SENDER
        sCommand = "SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t1.EmailAdd  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_" + Session["approverNext"] + " AND t2.BidRefNo = " + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            fromName = oReader["Name1"].ToString();
            fromEmail = oReader["EmailAdd"].ToString();
            from = '"' + oReader["Name1"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";
        } oReader.Close();


        //GET BUYER EMAIL AS THE RECEPIENT
        sCommand = "SELECT t1.BuyerFirstName + ' ' + t1.BuyerMidName + ' ' + t1.BuyerLastName AS Name1, t1.EmailAdd  FROM tblBuyers t1, tblBacBidItems t2 WHERE t1.BuyerID=t2.BuyerId AND t2.BidRefNo=" + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            toName = oReader["Name1"].ToString();
            toEmail = oReader["EmailAdd"].ToString();
            to = '"' + oReader["Name1"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";
        } oReader.Close();

        //Response.Write(from + "<br>");
        //Response.Write(to + "<br>");
        //Response.Write(subject + "<br>");
        //Response.Write(CreateNotificationBodyReject() + "<br>");
        //Response.Write(MailTemplate.GetTemplateLinkedResources(this) + "<br>");
        try
        {
            if (!MailHelper.SendEmail(MailTemplate.GetDefaultSMTPServer(),
                    from,
                    to,
                    subject,
                    CreateNotificationBodyReject(),
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

    private bool SendEmailNotificationClarify(int FromId, int ToId)
    {

        string fromName = "";
        string fromEmail = "";
        string from = "";
        string toName = "";
        string toEmail = "";
        string to = "";
        string subject = "BAC For Clarification";
        //"Fistname Lastname" <email@globetel.com.ph>
        //"Fistname Lastname" <email@globetel.com.ph>
        string sCommand;
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;
        bool success = false;

        string query; SqlCommand cmd; SqlConnection conn;

        //GET DETAILS OF FROM
        query = "sp_GetUserDetails";
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", FromId);
                conn.Open(); oReader = cmd.ExecuteReader();
                if (oReader.HasRows)
                {
                    while (oReader.Read())
                    {
                        fromName = oReader["FullName"].ToString();
                        fromEmail = oReader["EmailAdd"].ToString();
                        from = '"' + oReader["FullName"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";
                    }
                }
            }
        } conn.Close();

        //GET DETAILS OF TO
        query = "sp_GetUserDetails";
        using (conn = new SqlConnection(connstring))
        {
            using (cmd = new SqlCommand(query, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", ToId);
                conn.Open(); oReader = cmd.ExecuteReader();
                if (oReader.HasRows)
                {
                    while (oReader.Read())
                    {
                        toName = oReader["FullName"].ToString();
                        toEmail = oReader["EmailAdd"].ToString();
                        to = '"' + oReader["FullName"].ToString() + '"' + " <" + oReader["EmailAdd"].ToString() + ">";
                    }
                }
            }
        } conn.Close();


        try
        {
            if (!MailHelper.SendEmail(MailTemplate.GetDefaultSMTPServer(),
                    from,
                    to,
                    subject,
                    CreateNotificationBodyClarify(fromName, toName),
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

    private string CreateNotificationBodyApprove(string fromName1, string toName1)
    {
        StringBuilder sb = new StringBuilder();

        string sCommand;
        string FromName = fromName1;
        string ToName = toName1;
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;

        // Awarded To
        string sTxt = "<table border='1' style='font-size:12px'><tr>";
        sTxt = sTxt + "<td><strong>&nbsp;Item #</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Item Details</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Vendor Name</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Qty</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Total</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Ranking</strong></td>";
        sTxt = sTxt + "</tr>";
        sCommand = "SELECT BidDetailNo, ItemName, VendorName, Qty, CONVERT(VARCHAR(20), CONVERT(MONEY, TotalCost), 1) TotalCost, Ranking ";
        sCommand = sCommand + "FROM tblBACEvaluationDetails WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND Chkd=1";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            while (oReader.Read())
            {
                sTxt = sTxt + "<tr>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["BidDetailNo"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["ItemName"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["VendorName"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["Qty"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["TotalCost"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["Ranking"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "</tr>";
            }
        }
        sTxt = sTxt + "<tr></table>";

        string ItemDesc = "";
        sCommand = "SELECT ItemDesc FROM tblBacBidItems WHERE BidRefNo=" + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            ItemDesc = oReader["ItemDesc"].ToString();
        } oReader.Close();

        //sb.Append("<tr><td align='right'><h5>" + DateTime.Now.ToLongDateString() + "</h5></td></tr>");
        sb.Append("<tr><td><p><strong>BAC for Approval</strong> <br> Sent: " + DateTime.Now.ToLongDateString() + "</p> <p>From: " + FromName + "<br><br> To: " + ToName + "<br><br> Subject: " + ItemDesc + "<br><br> Dear Bid Award Approvers, <br><br> Re: Request for Bid Award Approval - <strong>" + ItemDesc + "</strong><br><br> This is to request for your Bid Award Approval of the ff:<br><br> <b>Bid Reference Number:</b> " + Session["BuyerBidForBac"] + "<br> <b>Bid Event Name:</b> " + ItemDesc + "<br> </p> " + sTxt + "  <p>Very truly yours,<br><br><br> <strong>e-Sourcing Procurement</strong></p><p>&nbsp;</p> <p><strong>Instructions:</strong></p> <ol> <li>Go to <a href='https://e-sourcing.globe.com.ph/'>https://e-sourcing.globe.com.ph</a></li> <li>Enter your Username and Password then  click Login</li> <li>Click Received Bid Events for Awarding</li> <li>Click Bid Events Name</li> <li>Review / Endorse / Approve Bid event  for Awarding</li> <li>Click Clarify if you have clarification  or click Approved to award Bid Events</li> </ol> Please do not reply to this auto-generated  message.&nbsp;</td></tr>");

        return MailTemplate.IntegrateBodyIntoTemplate(sb.ToString());
    }




    private string CreateNotificationBodyAwarded()
    {
        StringBuilder sb = new StringBuilder();

        string sCommand;
        string BuyersName1 = "";
        string ApproverName1 = "";
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;

        sCommand = "SELECT t1.BuyerFirstName + ' ' + t1.BuyerMidName + ' ' + t1.BuyerLastName AS Name1 FROM tblBuyers t1, tblBacBidItems t2 WHERE t1.BuyerID=t2.BuyerId AND t2.BidRefNo=" + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            BuyersName1 = oReader["Name1"].ToString();
        } oReader.Close();

        sCommand = "SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t1.EmailAdd  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_" + Session["approverNext"] + " AND t2.BidRefNo = " + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            ApproverName1 = oReader["Name1"].ToString();
        } oReader.Close();

        // Awarded To
        string sTxt = "<table border='1' style='font-size:12px'><tr>";
        sTxt = sTxt + "<td><strong>&nbsp;Item #</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Item Details</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Vendor Name</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Qty</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Total</strong></td>";
        sTxt = sTxt + "<td><strong>&nbsp;Ranking</strong></td>";
        sTxt = sTxt + "</tr>";
        sCommand = "SELECT BidDetailNo, ItemName, VendorName, Qty, CONVERT(VARCHAR(20), CONVERT(MONEY, TotalCost), 1) TotalCost, Ranking ";
        sCommand = sCommand + "FROM tblBACEvaluationDetails WHERE BidRefNo=" + Session["BuyerBidForBac"] + " AND Chkd=1";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            while (oReader.Read())
            {
                sTxt = sTxt + "<tr>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["BidDetailNo"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["ItemName"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["VendorName"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["Qty"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["TotalCost"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "<td>";
                sTxt = sTxt + "&nbsp;" + oReader["Ranking"].ToString() + "&nbsp;";
                sTxt = sTxt + "</td>";
                sTxt = sTxt + "</tr>";
            }
        }
        oReader.Close();
        sTxt = sTxt + "<tr></table>";

        // Approvers
        string oApprovers = "";
        sCommand = "select BACId, NAME1, ApprovingLimit, ApprovedDt from ( SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_1 ApprovedDt, 1 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_1 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_2 ApprovedDt, 2 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_2 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_3 ApprovedDt, 3 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_3 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_4 ApprovedDt, 4 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_4 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_5 ApprovedDt, 5 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_5 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_6 ApprovedDt, 6 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_6 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_7 ApprovedDt, 7 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_7 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_8 ApprovedDt,  8 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_8 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_9 ApprovedDt,  9 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_9 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_10 ApprovedDt, 10 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2 WHERE t1.BACId = t2.Approver_10 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.PurchasingID BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_0 ApprovedDt, 0 AS ApprovingLimit FROM tblPurchasing t1, tblBacBidItems t2 WHERE t1.PurchasingID=t2.Approver_0 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + ") as table_1 order by ApprovingLimit";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            while (oReader.Read())
            {
                if (oReader["ApprovingLimit"].ToString() == "0")
                {
                    oApprovers = oApprovers + "Purchasing: " + oReader["Name1"].ToString() + "<br>";
                }
                else
                {
                    oApprovers = oApprovers + "Approver " + oReader["ApprovingLimit"].ToString() + ": " + oReader["Name1"].ToString() + "<br>";
                }
            }
        }
        oReader.Close();

        string ItemDesc = "";
        sCommand = "SELECT ItemDesc FROM tblBacBidItems WHERE BidRefNo=" + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            ItemDesc = oReader["ItemDesc"].ToString();
        } oReader.Close();

        sb.Append("<tr><td><p><strong>BAC Approved to Award</strong> <br> Sent: " + DateTime.Now.ToLongDateString() + "</p> <p>From: " + BuyersName1 + "<br><br> To: " + BuyersName1 + "<br><br> Dear " + BuyersName1 + ", <br><br> Re: Approved to Award – <strong>" + ItemDesc + "</strong><br><br> We are pleased to inform you that your Bid for Award was approved as follows:<br><br> <b>Bid Reference Number:</b> " + Session["BuyerBidForBac"] + "<br> <b>Bid Event Name:</b> " + ItemDesc + "<br> </p> " + sTxt + "  <p>Very truly yours,<br><br><br> <strong>" + oApprovers + "</strong></p><p>&nbsp;</p> Please do not reply to this auto-generated  message.&nbsp;</td></tr>");

        return MailTemplate.IntegrateBodyIntoTemplate(sb.ToString());
    }

    private string CreateNotificationBodyReject()
    {
        StringBuilder sb = new StringBuilder();

        string sCommand;
        string BuyersName1 = "";
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;

        sCommand = "SELECT t1.BuyerFirstName + ' ' + t1.BuyerMidName + ' ' + t1.BuyerLastName AS Name1 FROM tblBuyers t1, tblBacBidItems t2 ";
        sCommand = sCommand + "WHERE t1.BuyerID=t2.BuyerId AND t2.BidRefNo=" + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            BuyersName1 = oReader["Name1"].ToString();
        } oReader.Close();

        // Approvers
        string oApprovers = "";
        sCommand = "select BACId, NAME1, ApprovingLimit, ApprovedDt from ( SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_1 ApprovedDt, 1 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_1 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_2 ApprovedDt, 2 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_2 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_3 ApprovedDt, 3 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_3 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_4 ApprovedDt, 4 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_4 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_5 ApprovedDt, 5 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_5 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_6 ApprovedDt, 6 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_6 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_7 ApprovedDt, 7 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_7 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_8 ApprovedDt,  8 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_8 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_9 ApprovedDt,  9 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2   WHERE t1.BACId = t2.Approver_9 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_10 ApprovedDt, 10 AS ApprovingLimit  FROM tblBidAwardingCommittee t1, tblBacBidItems t2 WHERE t1.BACId = t2.Approver_10 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + " UNION SELECT t1.PurchasingID BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t2.ApprovedDt_0 ApprovedDt, 0 AS ApprovingLimit FROM tblPurchasing t1, tblBacBidItems t2 WHERE t1.PurchasingID=t2.Approver_0 AND t2.BidRefNo = " + Session["BuyerBidForBac"] + ") as table_1 order by ApprovingLimit";
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            while (oReader.Read())
            {
                if (oReader["ApprovingLimit"].ToString() == "0")
                {
                    oApprovers = oApprovers + "Purchasing: " + oReader["Name1"].ToString() + "<br>";
                }
                else
                {
                    oApprovers = oApprovers + "Approver " + oReader["ApprovingLimit"].ToString() + ": " + oReader["Name1"].ToString() + "<br>";
                }
            }
        }
        oReader.Close();

        string ItemDesc = "";
        sCommand = "SELECT ItemDesc FROM tblBacBidItems WHERE BidRefNo=" + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            ItemDesc = oReader["ItemDesc"].ToString();
        } oReader.Close();

        sb.Append("<tr><td><p><strong>BAC Rejected</strong> <br> Sent: " + DateTime.Now.ToLongDateString() + "</p> <p>From: Reviewers<br><br>  Dear " + BuyersName1 + ", <br><br> Re: Notice of Rejected BAC – " + ItemDesc + "<br><br> This is to inform all Bid Award reviewers and approvers that the following Bid was rejected:<br><br> <b>Bid Reference Number:</b> " + Session["BuyerBidForBac"] + "<br> <b>Bid Event Name:</b> " + ItemDesc + "<br><br> Very truly yours,<br><br><br> <strong>" + oApprovers + "</strong></p><p>&nbsp;</p>  Please do not reply to this auto-generated  message.&nbsp;</td></tr>");

        return MailTemplate.IntegrateBodyIntoTemplate(sb.ToString());
    }

    private string CreateNotificationBodyClarify(string FromName, string ToName)
    {
        StringBuilder sb = new StringBuilder();

        string sCommand;
        string WhoClarifyName1 = FromName;
        string ClarifyToName1 = ToName;
        string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
        SqlDataReader oReader;

        string ItemDesc = "";
        sCommand = "SELECT ItemDesc FROM tblBacBidItems WHERE BidRefNo=" + Session["BuyerBidForBac"];
        oReader = SqlHelper.ExecuteReader(connstring, CommandType.Text, sCommand);
        if (oReader.HasRows)
        {
            oReader.Read();
            ItemDesc = oReader["ItemDesc"].ToString();
        } oReader.Close();

        //sb.Append("<tr><td align='right'><h5>" + DateTime.Now.ToLongDateString() + "</h5></td></tr>");
        sb.Append("<tr><td><p><strong>BAC for Clarification</strong> <br> Sent: " + DateTime.Now.ToLongDateString() + "</p> <p>From: " + WhoClarifyName1 + "<br><br> To: " + ClarifyToName1 + "<br><br> Attention:<br> Re: Request for Clarification - " + ItemDesc + "<br><br> Dear " + ClarifyToName1 + ", <br><br> There is a request for clarification on Bid for Award as follows:<br><br> <b>Bid Reference Number:</b> " + Session["BuyerBidForBac"] + "<br> <b>Bid Event Name:</b> " + ItemDesc + "<br><br></p>  <p>Very truly yours,<br><br><br> <strong>e-Sourcing Procurement</strong></p><p>&nbsp;</p> <p><strong>Instructions:</strong></p> <ol> <li>Go to <a href='https://e-sourcing.globe.com.ph/'>https://e-sourcing.globe.com.ph</a></li> <li>Enter your Username and Password then  click Login</li> <li>Click Bid Award for clarification</li> <li>Click Bid Events Name</li> <li>See Remarks / Comments box for items to clarify</li> <li>Click Clarify & provide response to Clarification</li> </ol> Please do not reply to this auto-generated  message.&nbsp;</td></tr>");

        return MailTemplate.IntegrateBodyIntoTemplate(sb.ToString());
    }
}