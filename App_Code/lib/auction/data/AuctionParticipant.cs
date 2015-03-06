using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace EBid.lib.auction.data
{
	/// <summary>
	/// By GA S. 07132006
	/// </summary>
	public class AuctionParticipant
	{
		private int _ID;
		private string _Name;
		private string _Username;
		private string _Alias;
		private string _EncryptedTicket;
		private string _EmailAddress;
        private int _EmailSent;
        private string _MobileNo;

		public AuctionParticipant()
		{
			_ID = _EmailSent = 0;
			_Name = _Username = _Alias = _EncryptedTicket = _EmailAddress = string.Empty;
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

		public string Alias
		{
			get { return _Alias; }
			set { _Alias = value; }
		}

		public string EncryptedTicket
		{
			get { return _EncryptedTicket; }
			set { _EncryptedTicket = value; }
		}

		public string EmailAddress
		{
			get { return _EmailAddress; }
			set { _EmailAddress = value; }
        }

        public int EmailSent
        {
            get { return _EmailSent; }
            set { _EmailSent = value; }
        }

        /// <summary>
        /// Gets or sets the mobile number of the AuctionParticipant
        /// </summary>
        public string MobileNo
        {
            get { return _MobileNo; }
            set { _MobileNo = value; }
        }
	}

    public class BidParticipant
    {
        private int _ID;
        private string _Name;
        private string _Username;
        private string _EmailAddress;
        private string _MobileNo;

        public BidParticipant()
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

        /// <summary>
        /// Gets or sets the mobile number of the BidParticipant
        /// </summary>
        public string MobileNo
        {
            get { return _MobileNo; }
            set { _MobileNo = value; }
        }
    }
}