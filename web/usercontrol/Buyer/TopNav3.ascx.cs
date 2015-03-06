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
using System.IO;
using EBid.lib.constant;

public partial class WEB_user_control_TopNav31 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            DateTime dt = new DateTime();
            dt = System.DateTime.Now;
            lblDate.Text = "Today is " + dt.ToString("MMMM dd, yyyy  hh:mm:ss tt");
        }
    }
    protected void lnkCreateNewItem_Click(object sender, EventArgs e)
    {
        Session[Constant.SESSION_BIDREFNO] = null;
        Response.Redirect("bidawardingchecklist.aspx");
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        this.Label1.Text = DateTime.Now.ToLongTimeString();
    }
}
