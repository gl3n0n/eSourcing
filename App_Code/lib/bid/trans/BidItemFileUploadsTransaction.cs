using System;
using System.Data.OleDb;
using EBid.lib.utils;
using EBid.lib.bid.trans;
using EBid.lib.bid.data;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using EBid.lib;
using EBid.lib.constant;

namespace EBid.lib.bid.trans
{
    public static class BidItemFileUploadsTransaction
    {
        private static string CONNECTION_STRING = System.Configuration.ConfigurationManager.ConnectionStrings["EBidConnectionString"].ConnectionString;
       
        public static bool InsertBidItemFileUploads(int BidRefNo, 
            int BuyerId, 
            string OriginalFileName, 
            string ActualFileName)
        {
            bool success = false;

            try
            {
                SqlParameter[] sqlParams = new SqlParameter[4];
                sqlParams[0] = new SqlParameter("@BidRefNo", SqlDbType.Int);
                sqlParams[0].Value = BidRefNo;
                sqlParams[1] = new SqlParameter("@BuyerId", SqlDbType.Int);
                sqlParams[1].Value = BuyerId;
                sqlParams[2] = new SqlParameter("@OriginalFileName", SqlDbType.NVarChar);
                sqlParams[2].Value = OriginalFileName;
                sqlParams[3] = new SqlParameter("@ActualFileName", SqlDbType.NVarChar);
                sqlParams[3].Value = ActualFileName;
                SqlHelper.ExecuteNonQuery(CONNECTION_STRING, CommandType.StoredProcedure, "sp_AddBidItemFileAttachment", sqlParams);
                success = true;
            }
            catch
            {
                success = false;
            }
            return success;
        }

    }
}
