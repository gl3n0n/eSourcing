using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;

namespace EBid.lib
{
	public static class FormattingHelper
	{
		/// <summary>
		/// Format: (day of the week), (month) (day), (year)  (base 24 hour):(minute) (AM/PM)
		/// </summary>
		/// <param name="date">Date to format</param>
		/// <returns>Formatted string</returns>
		public static string FormatDateToString(DateTime date)
		{
			return date.ToLongDateString() + " " + date.ToString("HH:mm tt");
		}

		/// <summary>
		/// Format: (day of the week), (month) (day), (year)  (base 24 hour):(minute):(seconds) (AM/PM)
		/// </summary>
		/// <param name="date">Date to format</param>
		/// <returns>Formatted string</returns>
		public static string FormatDateToLongString(DateTime date)
		{
			return date.ToLongDateString() + " " + date.ToString("HH:mm:ss tt");
		}

        public static bool IsNumeric(string val)
        {
            Double result;
            return Double.TryParse(val, out result);
        }

        public static bool IsNumeric(string val, System.Globalization.NumberStyles NumberStyle)
        {
            Double result;
            return Double.TryParse(val, NumberStyle, System.Globalization.CultureInfo.CurrentCulture, out result);
        }

        public static bool IsInt(string val)
        {
            Int32 result;
            return Int32.TryParse(val, out result);
        }

        public static bool IsInt(string val, System.Globalization.NumberStyles NumberStyle)
        {
            Int32 result;
            return Int32.TryParse(val, NumberStyle, System.Globalization.CultureInfo.CurrentCulture, out result);
        }

        // Function to test for Positive Integers.
        public static bool IsNaturalNumber(String strNumber)
        {
            Regex objNotNaturalPattern = new Regex("[^0-9]");
            Regex objNaturalPattern = new Regex("0*[1-9][0-9]*");

            return !objNotNaturalPattern.IsMatch(strNumber) &&
                    objNaturalPattern.IsMatch(strNumber);
        }

        // Function to test for Positive Integers with zero inclusive
        public static bool IsWholeNumber(String strNumber)
        {
            Regex objNotWholePattern = new Regex("[^0-9]");

            return !objNotWholePattern.IsMatch(strNumber);
        }

        // Function to Test for Integers both Positive & Negative
        public static bool IsInteger(String strNumber)
        {
            Regex objNotIntPattern = new Regex("[^0-9-]");
            Regex objIntPattern = new Regex("^-[0-9]+$|^[0-9]+$");

            return !objNotIntPattern.IsMatch(strNumber) &&
                    objIntPattern.IsMatch(strNumber);
        }

        // Function to Test for Positive Number both Integer & Real
        public static bool IsPositiveNumber(String strNumber)
        {
            Regex objNotPositivePattern = new Regex("[^0-9.]");
            Regex objPositivePattern = new Regex("^[.][0-9]+$|[0-9]*[.]*[0-9]+$");
            Regex objTwoDotPattern = new Regex("[0-9]*[.][0-9]*[.][0-9]*");

            return !objNotPositivePattern.IsMatch(strNumber) &&
                   objPositivePattern.IsMatch(strNumber) &&
                   !objTwoDotPattern.IsMatch(strNumber);
        }

        // Function to test whether the string is valid number or not
        public static bool IsNumber(String strNumber)
        {
            Regex objNotNumberPattern = new Regex("[^0-9.-]");
            Regex objTwoDotPattern = new Regex("[0-9]*[.][0-9]*[.][0-9]*");
            Regex objTwoMinusPattern = new Regex("[0-9]*[-][0-9]*[-][0-9]*");
            String strValidRealPattern = "^([-]|[.]|[-.]|[0-9])[0-9]*[.]*[0-9]+$";
            String strValidIntegerPattern = "^([-]|[0-9])[0-9]*$";
            Regex objNumberPattern = new Regex("(" + strValidRealPattern + ")|(" + strValidIntegerPattern + ")");

            return !objNotNumberPattern.IsMatch(strNumber) &&
                   !objTwoDotPattern.IsMatch(strNumber) &&
                   !objTwoMinusPattern.IsMatch(strNumber) &&
                   objNumberPattern.IsMatch(strNumber);
        }

        // Function To test for Alphabets.
        public static bool IsAlpha(String strToCheck)
        {
            Regex objAlphaPattern = new Regex("[^a-zA-Z]");

            return !objAlphaPattern.IsMatch(strToCheck);
        }

        // Function to Check for AlphaNumeric.
        public static bool IsAlphaNumeric(String strToCheck)
        {
            Regex objAlphaNumericPattern = new Regex("[^a-zA-Z0-9]");

            return !objAlphaNumericPattern.IsMatch(strToCheck);
        }

        public static string DecryptQueryString(string queryString)
        {
            queryString = HttpUtility.UrlDecode(queryString);
            queryString = queryString.Replace("$QSTN", "?");
            queryString = queryString.Replace("$AMP", "&");
            queryString = queryString.Replace("$PLUS", "+");
            queryString = queryString.Replace("$EQL", "=");            
            try
            {
                queryString = EncryptionHelper.Decrypt(queryString);
            }
            catch
            {
                queryString = null;
            }
            return queryString;
        }

        public static string EncryptQueryString(string queryString)
        {
            queryString = EncryptionHelper.Encrypt(queryString);
            queryString = queryString.Replace("=", "$EQL");
            queryString = queryString.Replace("+", "$PLUS");
            queryString = queryString.Replace("&", "$AMP");
            queryString = queryString.Replace("?", "$QSTN");            
            queryString = HttpUtility.UrlEncode(queryString);
            return queryString;
        }
	}       
}