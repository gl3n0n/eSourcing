using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_buyer_timer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime dt = DateTime.Now;
        String strDate = "";
        strDate = dt.ToString("ddd, MMM-dd-yyyy HH':'mm':'ss 'GMT'"); // Sat, 21 Jul 2007 15:12:16 GMT
        //string custom = String.ToString("r", theDate);
        Response.Write("<b>"+strDate + "+8:00"+"</b>");

    }
}