using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;
using EBid.lib;
using EBid.lib.utils;
using EBid.lib.bid.data;
using EBid.lib.constant;
using System.Configuration;

/// <summary>
/// Created By: Edrick Tan 12/17/2012
/// </summary>
namespace EBid.lib.rfi
{
    public class RfiTender
    {
        string _rfitenderno = string.Empty;
        string _rfidetailno = string.Empty;
        string _vendorid = string.Empty;
        string _status = string.Empty;
        string _amount = string.Empty;
        string _deliverycost = string.Empty;
        string _discount = string.Empty;
        string _warranty = string.Empty;
        string _remarks = string.Empty;
        string _comment = string.Empty;

        public string RfiTenderNo
        {
            get { return _rfitenderno; }
            set { _rfitenderno = value; }
        }

        public string RfiDetailNo
        {
            get { return _rfidetailno; }
            set { _rfidetailno = value; }
        }

        public string VendorId
        {
            get { return _vendorid; }
            set { _vendorid = value; }
        }

        public string Status
        {
            get { return _status; }
            set { _status = value; }
        }

        public string Amount
        {
            get { return _amount; }
            set { _amount = value; }
        }

        public string DeliveryCost
        {
            get { return _deliverycost; }
            set { _deliverycost = value; }
        }

        public string Discount
        {
            get { return _discount; }
            set { _discount = value; }
        }

        public string Warranty
        {
            get { return _warranty; }
            set { _warranty = value; }
        }

        public string Remarks
        {
            get { return _remarks; }
            set { _remarks = value; }
        }

        public string Comment
        {
            get { return _comment; }
            set { _comment = value; }
        }
    }

    public class RfiEventTransaction
    {

        public static bool ConfirmRfiInvitation(int rfirefno, int vendorid)
        {
            string cnEbid = ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
            bool success = false;
            int confirm = 1;
            try
            {
                SqlParameter[] sqlParams = new SqlParameter[3];
                sqlParams[0] = new SqlParameter("@RfiRefNo", rfirefno);
                sqlParams[1] = new SqlParameter("@VendorId", vendorid);
                sqlParams[2] = new SqlParameter("@ToDo", confirm);

                int i = (int)SqlHelper.ExecuteScalar(cnEbid, "sp_ConfirmRfiInvitation", sqlParams);

                if (i == 1)
                    success = true;
                else
                    success = false;
            }
            catch
            {
                success = false;
            }
            return success;
        }
    }
}