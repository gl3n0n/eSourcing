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
using Microsoft.Reporting.WebForms;
using System.IO;
using System.Text;
using EBid.lib;
using EBid.lib.report;
using EBid.lib.constant;
using EBid.lib.reportnew;
using EBid.lib.constantnew;

public partial class web_reports_esourcevaluepassthrough : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session[ConstantNew.PARAMETER_ESOURCINGVALUEPASSTHROUGH] == null)
            {
                return;
            }

            ESourcingValuePassThroughReportParameter param = (ESourcingValuePassThroughReportParameter)Session[ConstantNew.PARAMETER_ESOURCINGVALUEPASSTHROUGH];

            ObjectDataSource1.SelectParameters[0].DefaultValue = param.BuyerId;
            ObjectDataSource1.SelectParameters[1].DefaultValue = param.StartDate.ToString();
            ObjectDataSource1.SelectParameters[2].DefaultValue = param.EndDate.ToString();
            
            ReportParameter[] RequestorParameter = new ReportParameter[4];

            RequestorParameter[0] = new ReportParameter("BuyerId", param.BuyerId);
            RequestorParameter[1] = new ReportParameter("StartDate", param.StartDate.ToString());
            RequestorParameter[2] = new ReportParameter("EndDate", param.EndDate.ToString());
            RequestorParameter[3] = new ReportParameter("BuyerName", param.BuyerName);


            rvESourcingValuePassThrough.LocalReport.ReportPath = Request.PhysicalApplicationPath + @"web\reports\esourcevaluepassthrough.rdlc";
            rvESourcingValuePassThrough.LocalReport.SetParameters(RequestorParameter);
            rvESourcingValuePassThrough.ShowReportBody = true;
            
        }
        PageTitle.InnerText = String.Format(Constant.TITLEFORMAT, "E-Sourcing Value Pass Through");
    }

    protected void lnkExportToPdf_Click(object sender, EventArgs e)
    {
        PDFDeviceInfo deviceInfo = new PDFDeviceInfo("11in", "8.5in", "0.5in", "0.5in", "0.25in", "0.25in");
        ReportHelper.ExportToPDF(this, rvESourcingValuePassThrough, "E-Sourcing Value Pass Through.pdf", deviceInfo);
    }

    protected void lnkExportToExcel_Click(object sender, EventArgs e)
    {
        ReportHelper.ExportToExcel(this, rvESourcingValuePassThrough, "E-Sourcing Value Pass Through.xls");
    }

    protected void lnkRefresh_Click(object sender, EventArgs e)
    {
        rvESourcingValuePassThrough.LocalReport.Refresh();
    }

}