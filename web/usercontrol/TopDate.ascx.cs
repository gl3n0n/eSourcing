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

public partial class web_user_control_TopDate : System.Web.UI.UserControl
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
}
