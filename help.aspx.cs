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
using System.Text;
using System.Net.Mail;
using EBid.lib;
using EBid.lib.constant;

public partial class help : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserType"] != null) {
           if (Session["UserType"].ToString() == "1")
           {
               //BUYER
               helpFrame.Attributes.Add("src", "http://docs.google.com/viewer?url=http%3A%2F%2F120.28.39.82%2Febid_manual%2FEBID_Buyers_Manual.pdf&embedded=true");
           }
           else if (Session["UserType"].ToString() == "2")
           {
               //VENDOR
               helpFrame.Attributes.Add("src", "http://docs.google.com/viewer?url=http%3A%2F%2F120.28.39.82%2Febid_manual%2FEBID_Vendors_Manual.pdf&embedded=true");
           }
           else if (Session["UserType"].ToString() == "3")
           {
               //PURCHASING
               helpFrame.Attributes.Add("src", "http://docs.google.com/viewer?url=http%3A%2F%2F120.28.39.82%2Febid_manual%2FEBID_Purchasing_Manual.pdf&embedded=true");
           }
           else if (Session["UserType"].ToString() == "5")
           {
               //BOC
               helpFrame.Attributes.Add("src", "http://docs.google.com/viewer?url=http%3A%2F%2F120.28.39.82%2Febid_manual%2FEBID_BOC_Manual.pdf&embedded=true");
           }
           else if (Session["UserType"].ToString() == "6")
           {
               //BAC
               helpFrame.Attributes.Add("src", "http://docs.google.com/viewer?url=http%3A%2F%2F120.28.39.82%2Febid_manual%2FEBID_BAC_Manual.pdf&embedded=true");
           }
        }

        if (!IsPostBack)
            Title = String.Format(Constant.TITLEFORMAT, "Help");

        //lblClientInfo.Text = String.Format("You are logged on at: {0}", Request.UserHostAddress);        
    }    

    //protected void btnSend_Click(object sender, EventArgs e)
    //{
    //    if (SMSHelper.AreValidMobileNumbers(txtRecipients.Text.Trim()))
    //    {
    //        if (SMSHelper.SendSMS(new SMSMessage(txtMessage.Text.Trim(), txtRecipients.Text.Trim())))
    //            Response.Redirect("help.aspx");
    //    }
    //}

    //protected void btnCheckPassword_Click(object sender, EventArgs e)
    //{
    //    lblIsStrong.Text = PasswordChecker.IsStrongPassword(txtPassword.Text.Trim()) ? "Password is strong" : "Password is weak";
    //}
}
