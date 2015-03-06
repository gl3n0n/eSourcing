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
using EBid.lib;

public partial class web_user_control_auctiondate : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
		string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
		string serverTimeInSeconds = SqlHelper.ExecuteScalar(connstring, CommandType.StoredProcedure, "sp_GetServerTimeInSeconds").ToString();

		this.Page.ClientScript.RegisterStartupScript(GetType(), "onload", "<script>var tis = " + serverTimeInSeconds + ";</script>");
		lblDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");
    }	
}
