﻿using System;
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
using EBid.lib.constant;

public partial class web_usercontrol_rfi_rfitender_attachments : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gvFileAttachments_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Download":
                {
                    string[] args = e.CommandArgument.ToString().Split(new char[] { '|' });
                    string path = Constant.FILEATTACHMENTSFOLDERDIR + Session["TVendorId"].ToString() + "\\" + Session["RfiRefNo"].ToString() + "\\";
                    FileHelper.DownloadFile(this.Page, path, args[0], args[1]);
                } break;
        }
    }

}