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
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using EBid.lib;
using EBid.lib.constant;

public partial class web_usercontrol_commentlist_tender : System.Web.UI.UserControl
{
    private string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
    private SqlConnection sqlConnection;
    private SqlDataAdapter sqlAdapter;
    private SqlCommand sqlCommand;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            lblPageSize.Text = ConfigurationManager.AppSettings["CommentsPerPage"];
        
        if (Session[Constant.SESSION_BIDTENDERNO] == null)
            Session[Constant.SESSION_BIDTENDERNO] = 0;
        Bind();
    }

    public void Bind()
    {
        DataSet dSet = new DataSet();

        sqlConnection = new SqlConnection(connstring); 
        
        sqlCommand = new SqlCommand("sp_GetBidTenderComments", sqlConnection);
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.Parameters.Add("@BidTenderNo", SqlDbType.Int);
        sqlCommand.Parameters[0].Value = int.Parse(Session[Constant.SESSION_BIDTENDERNO].ToString());
        sqlCommand.Parameters.Add("@UserType", SqlDbType.Int);
        sqlCommand.Parameters[1].Value = int.Parse(Session[Constant.SESSION_USERTYPE].ToString());

        sqlAdapter = new SqlDataAdapter(sqlCommand);

        using (sqlConnection)
        {
            sqlAdapter.Fill(dSet);
            lblRecordCount.Text = dSet.Tables[0].Rows.Count.ToString();
            dSet = new DataSet();

            sqlAdapter.Fill(dSet, int.Parse(lblCurrentIndex.Text), int.Parse(lblPageSize.Text), "Comments");
            dlComments.DataSource = dSet.Tables["Comments"].DefaultView;
            dlComments.DataBind();
        }
        ShowCounts();
    }    

    protected void ShowCounts()
    {
        int recordCount = int.Parse(lblRecordCount.Text);
        int pageSize = int.Parse(lblPageSize.Text);
        int currentIndex = int.Parse(lblCurrentIndex.Text);

        if (recordCount > 0)
        {
            lblCounts.Text = (currentIndex + 1) + " to ";
            if ((currentIndex + pageSize) <= recordCount)
                lblCounts.Text += (currentIndex + pageSize);
            else
                lblCounts.Text += recordCount;
            
            lblCounts.Text += " out of " + recordCount + " comments";            
            // show or hide page buttons        
            trPagers.Visible = (recordCount > pageSize);
        }
        else
        {
            lblCounts.Text = "No Comments";
            trPagers.Visible = false;
        }
    }

    protected void btnFirstPage_Click(object sender, ImageClickEventArgs e)
    {
        lblCurrentIndex.Text = "0";
        Bind();
    }
    
    protected void btnPreviousPage_Click(object sender, ImageClickEventArgs e)
    {
        lblCurrentIndex.Text = (int.Parse(lblCurrentIndex.Text) - int.Parse(lblPageSize.Text)) + "";
        if (int.Parse(lblCurrentIndex.Text) < 0)
            lblCurrentIndex.Text = "0";
        Bind();
    }
    
    protected void btnNextPage_Click(object sender, ImageClickEventArgs e)
    {
        if ((int.Parse(lblCurrentIndex.Text) + int.Parse(lblPageSize.Text)) < int.Parse(lblRecordCount.Text))
            lblCurrentIndex.Text = (int.Parse(lblCurrentIndex.Text) + int.Parse(lblPageSize.Text)) + "";
        Bind();
    }
    
    protected void btnLastPage_Click(object sender, ImageClickEventArgs e)
    {
        int intMod = int.Parse(lblRecordCount.Text) % int.Parse(lblPageSize.Text);

        if (intMod > 0)
            lblCurrentIndex.Text = (int.Parse(lblRecordCount.Text) - intMod) + "";
        else
            lblCurrentIndex.Text = (int.Parse(lblRecordCount.Text) - int.Parse(lblPageSize.Text)) + "";
        Bind();
    }
}
