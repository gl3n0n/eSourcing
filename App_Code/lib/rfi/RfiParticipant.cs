using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// By Edrick Tan 01262013
/// </summary>
public class RfiParticipant
{
    private int _ID;
    private string _Name;
    private string _Username;
    private string _EmailAddress;
    private string _MobileNo;

	public RfiParticipant()
	{
        _ID = 0;
        _Name = _EmailAddress = _Username = string.Empty;
	}

    public int ID
    {
        get { return _ID; }
        set { _ID = value; }
    }

    public string Name
    {
        get { return _Name; }
        set { _Name = value; }
    }

    public string Username
    {
        get { return _Username; }
        set { _Username = value; }
    }

    public string EmailAddress
    {
        get { return _EmailAddress; }
        set { _EmailAddress = value; }
    }

    public string MobileNo
    {
        get { return _MobileNo; }
        set { _MobileNo = value; }
    }
}