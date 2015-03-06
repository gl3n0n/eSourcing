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
using EBid.lib.constant;
using EBid.lib;

public partial class web_user_control_GlobalLinksNav : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
		FormsAuthenticationHelper.AuthenticateUserWithReturnUrl();
	
        if ((Session[Constant.SESSION_USERTYPE] != null) && (Session[Constant.SESSION_USERTYPE].ToString() != ""))
            btnSearch.Attributes.Add("OnClick", "ShowResults(" + Session[Constant.SESSION_USERTYPE].ToString().Trim() + ")");
        else
        {
            HttpCookie cookie = Request.Cookies["tempCookie"];            
            Session[Constant.SESSION_USERTYPE] = cookie.Values[Constant.SESSION_USERTYPE];
            btnSearch.Attributes.Add("OnClick", "ShowResults(" + Session[Constant.SESSION_USERTYPE].ToString().Trim() + ")");            
        }        
    }    
}
