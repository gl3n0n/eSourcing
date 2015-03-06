<%@ control language="C#" autoeventwireup="true" inherits="web_usercontrol_bids_biddetails" CodeFile="biddetails_buyer.ascx.cs" %>
<%@ Register Src="biddetails_items.ascx" TagName="biddetails_items" TagPrefix="uc1" %>
<%@ Register Src="biddetails_suppliers.ascx" TagName="biddetails_suppliers" TagPrefix="uc2" %>
<%@ Register Src="biddetails_details.ascx" TagName="biddetails_details" TagPrefix="uc3" %>
<div align="left">    
    <uc3:biddetails_details ID="Biddetails_details1" runat="server" />
   
    <uc1:biddetails_items ID="Biddetails_items1" runat="server" />
    
    <uc2:biddetails_suppliers ID="Biddetails_suppliers1" runat="server" />
</div>
