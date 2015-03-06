using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using EBid.Exceptions;

/// <summary>
/// By Edrick Tan 01262013
/// </summary>
public class RfiDetails
{
    private int _BuyerID;
    private int _ID;
    private string _Description;
    private DateTime _SubmissionDeadline;
    private string _Creator;
    private string _CreatorEmail;
    private string _Company;
    private string _Sender;

	public RfiDetails()
	{
        _ID = 0;
        _BuyerID = 0;
        _Description = string.Empty;
	}

    /// <summary>
    /// Converts a source row's data to RFI details
    /// </summary>
    /// <param name="dr">Source row</param>
    public RfiDetails(DataRow dr)
    {
        RfiDetails rd = new RfiDetails();
        rd = ConvertRow(dr);
        BuyerID = rd.BuyerID;
        ID = rd.ID;
        Description = rd.Description;
        SubmissionDeadline = rd.SubmissionDeadline;
        Creator = rd.Creator;
        CreatorEmail = rd.CreatorEmail;
        Company = rd.Company;
        Sender = rd.Sender;
        
    }

    public int BuyerID
    {
        get
        {
            return _BuyerID;
        }
        set
        {
            _BuyerID = value;
        }
    }

    public int ID
    {
        get
        {
            return _ID;
        }
        set
        {
            _ID = value;
        }
    }

    public string Description
    {
        get
        {
            return _Description;
        }
        set
        {
            _Description = value;
        }
    }

    public DateTime SubmissionDeadline
    {
        get
        {
            return _SubmissionDeadline;
        }
        set
        {
            _SubmissionDeadline = value;
        }
    }

    public string Creator
    {
        get
        {
            return _Creator;
        }
        set
        {
            _Creator = value;
        }
    }

    public string CreatorEmail
    {
        get
        {
            return _CreatorEmail;
        }
        set
        {
            _CreatorEmail = value;
        }
    }

    public string Company
    {
        get
        {
            return _Company;
        }
        set
        {
            _Company = value;
        }
    }

    public string Sender
    {
        get
        {
            return _Sender;
        }
        set
        {
            _Sender = value;
        }
    }

    protected RfiDetails ConvertRow(DataRow dr)
    {
        RfiDetails rd = new RfiDetails();

        if (dr != null)
        {
            if (dr.Table.Columns.Count != 0)
            {
                if (dr.Table.Columns.Contains("BuyerID"))
                    rd.BuyerID = int.Parse(dr.Table.Rows[0]["BuyerID"].ToString());
                if (dr.Table.Columns.Contains("ID"))
                    rd.ID = int.Parse(dr.Table.Rows[0]["ID"].ToString());
                if (dr.Table.Columns.Contains("Description"))
                    rd.Description = dr.Table.Rows[0]["Description"].ToString();
                if (dr.Table.Columns.Contains("SubmissionDeadline"))
                    rd.SubmissionDeadline = DateTime.Parse(dr.Table.Rows[0]["SubmissionDeadline"].ToString());
                if (dr.Table.Columns.Contains("Creator"))
                    rd.Creator = dr.Table.Rows[0]["Creator"].ToString();
                if (dr.Table.Columns.Contains("CreatorEmail"))
                    rd.CreatorEmail = dr.Table.Rows[0]["CreatorEmail"].ToString();
                if (dr.Table.Columns.Contains("Company"))
                    rd.Company = dr.Table.Rows[0]["Company"].ToString();
                if (dr.Table.Columns.Contains("Sender"))
                    rd.Sender = dr.Table.Rows[0]["Sender"].ToString();
            }
            else
                throw new EmptyInputException("Data row contains no columns");
        }
        else
            throw new EmptyInputException("Data row is null.");
        return rd;
    }
}