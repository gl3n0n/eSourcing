<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rfidetails.ascx.cs" Inherits="web_usercontrol_rfi_rfidetails" %>
<%@ Register Src="rfidetails_items.ascx" TagName="rfidetails_items" TagPrefix="uc1" %>
<%@ Register Src="rfidetails_suppliers.ascx" TagName="rfidetails_suppliers" TagPrefix="uc2" %>
<%@ Register Src="rfidetails_details.ascx" TagName="rfidetails_details" TagPrefix="uc3" %>
<div align="left">    
    <uc3:rfidetails_details ID="Rfidetails_details1" runat="server" />
   
    <uc1:rfidetails_items ID="Rfidetails_items1" runat="server" />
    
    <uc2:rfidetails_suppliers ID="Rfidetails_suppliers1" runat="server" />
</div>