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
using System.Data.Sql;
using System.Data.SqlClient;

public partial class web_buyerscreens_rfieventdetails : System.Web.UI.Page
{
    private string connstring = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
        if (Int32.Parse(Session[Constant.SESSION_USERTYPE].ToString().Trim()) != (int)Constant.USERTYPE.BUYER)
            Response.Redirect("../unauthorizedaccess.aspx");

        if (Session["RfiRefNo"] == null)
            Response.Redirect("rfiforeval.aspx");
        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "RFI Event Details");

        if (Session[Constant.SESSION_LASTPAGE] != null)
        {
            if (Session[Constant.SESSION_LASTPAGE].ToString() == "~/web/buyerscreens/rfiforeval.aspx")
            {
                lnkViewReport.Visible = false;
            }
            else
            {
                lnkViewReport.Visible = false;
            }
        }

        if (!IsPostBack)
        {
            lnkViewReport.NavigateUrl = "javascript://";
            lnkViewReport.Attributes.Add("onclick", "window.open('../reports/eventtenderscomparison.aspx?brn=" + Session["RfiRefNo"].ToString().Trim() + "','r1', 'toolbar=no, menubar=no, width=800; height=600, top=80, left=80, resizable=yes , scrollbars=yes');");
            lnkViewReport.Enabled = !isEnabledComparison();
            Session["ViewOption"] = "AsBuyer";
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        if (Session[Constant.SESSION_LASTPAGE] != null)
            Response.Redirect(Session[Constant.SESSION_LASTPAGE].ToString());
        else
            Response.Redirect("index.aspx");
    }

    protected bool isEnabledComparison()
    {
        if ((GetRfiEventRenegotiationDeadline().ToString() != ""))
        {
            DateTime rdate = DateTime.Parse(GetRfiEventRenegotiationDeadline().ToString());
            DateTime dtnow = DateTime.Now;

            if (DateTime.Compare(rdate, dtnow) > 0)
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

    private string GetRfiEventRenegotiationDeadline()
    {
        SqlParameter[] sqlParams = new SqlParameter[1];
        sqlParams[0] = new SqlParameter("@RfiRefNo", SqlDbType.Int);
        sqlParams[0].Value = Int32.Parse(Session["RfiRefNo"].ToString());

        return SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetRFIEventRenegotiationDeadline", sqlParams).ToString().Trim();
    }
}