using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

namespace EBid.lib.reportnew
{
    public class BACHistoricalDataReportParameter
    {
        #region Variables
        private String _buyerId;
        private DateTime _startDate;
        private DateTime _endDate;
        private String _buyerName;
        #endregion

        #region Constructor
        public BACHistoricalDataReportParameter()
        {
        }
        #endregion

        #region Properties
        public String BuyerId
        {
            get { return _buyerId; }
            set { _buyerId = value; }
        }

        public DateTime StartDate
        {
            get { return _startDate; }
            set { _startDate = value; }
        }

        public DateTime EndDate
        {
            get { return _endDate; }
            set { _endDate = value; }
        }

        public String BuyerName
        {
            get { return _buyerName; }
            set { _buyerName = value; }
        }

        #endregion
    }


    public class ESourcingValuePassThroughReportParameter
    {
        #region Variables
        private String _buyerId;
        private DateTime _startDate;
        private DateTime _endDate;
        private String _buyerName;
        #endregion

        #region Constructor
        public ESourcingValuePassThroughReportParameter()
        {
        }
        #endregion

        #region Properties
        public String BuyerId
        {
            get { return _buyerId; }
            set { _buyerId = value; }
        }

        public DateTime StartDate
        {
            get { return _startDate; }
            set { _startDate = value; }
        }

        public DateTime EndDate
        {
            get { return _endDate; }
            set { _endDate = value; }
        }

        public String BuyerName
        {
            get { return _buyerName; }
            set { _buyerName = value; }
        }

        #endregion
    }

    public class VendorParticipationStatReportParameter
    {
        #region Variables
        private String _buyerId;
        private DateTime _startDate;
        private DateTime _endDate;
        private String _buyerName;
        #endregion

        #region Constructor
        public VendorParticipationStatReportParameter()
        {
        }
        #endregion

        #region Properties
        public String BuyerId
        {
            get { return _buyerId; }
            set { _buyerId = value; }
        }

        public DateTime StartDate
        {
            get { return _startDate; }
            set { _startDate = value; }
        }

        public DateTime EndDate
        {
            get { return _endDate; }
            set { _endDate = value; }
        }

        public String BuyerName
        {
            get { return _buyerName; }
            set { _buyerName = value; }
        }
        #endregion
    }
}
