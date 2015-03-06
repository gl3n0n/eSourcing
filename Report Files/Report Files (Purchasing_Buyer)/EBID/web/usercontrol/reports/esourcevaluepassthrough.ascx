<%@ Control Language="C#" AutoEventWireup="true" CodeFile="esourcevaluepassthrough.ascx.cs" Inherits="usercontrol_reports_esourcevaluepassthrough" %>
<%@ Register Assembly="Calendar" Namespace="CalendarControl" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        font-size: small;
        width: 70px;
    }
    .style2
    {
        height: 16px;
        width: 70px;
        font-size: small;
        font-weight: 700;
    }
    #actions
    {
        text-align: center;
    }
</style>
<table border="0" cellpadding="0" cellspacing="0" style="font-size: 11px; font-family: Arial; width: 100%">
    <tr>
        <td style="width: 896px; height: 260px;">
            <table style="width: 650px; font-size: 11px; font-family: Arial">
            <tr align="Left">
                <td valign="top" height="30px">                                                            
                    &nbsp;<strong><asp:Label ID="lblBuyerName" runat="server" Text="View By Buyer:" Font-Names="Arial"
                        Font-Size="8pt" Width="122px" style="width: 150px" /></strong>
                    <asp:DropDownList ID="ddlBuyerList" runat="server" DataSourceID="dsBuyerList" DataTextField="BuyerName"
                        DataValueField="BuyerId" Width="500px" AppendDataBoundItems="true">
                    </asp:DropDownList>&nbsp;                                  
                    <asp:SqlDataSource ID="dsBuyerList" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                        SelectCommand="sp_GetAllBuyerNames" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </td>
            </tr>
           
         </table> 
            
            <table style="width: 300px; font-size: 11px; font-family: Arial">
                <tr>
                    &nbsp;<td style="width: 60px">
                        <strong>Start Date</strong></td>
                    <td>
                        <cc1:JSCalendar ID="clndrStartDate" runat="server" ImageURL="../../calendar/img.gif" EnableViewState="true" ScriptsBasePath="../../calendar/" DateFormat="MM/dd/yyyy" Width="178px" ReadOnly="false" MaxLength="10"
                                                                        TabIndex="-1"></cc1:JSCalendar></td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        <strong>End Date</strong></td>
                    <td style="height: 16px">
                        <cc1:JSCalendar ID="clndrEndDate" runat="server" ImageURL="../../calendar/img.gif" EnableViewState="true" ScriptsBasePath="../../calendar/" DateFormat="MM/dd/yyyy" Width="178px" ReadOnly="false" MaxLength="10"
                                                                        TabIndex="-1"></cc1:JSCalendar>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="height: 10px;">
        </td>
    </tr>
    <tr>
        <td colspan="2" id="actions">
            <br />
            <asp:LinkButton ID="lnkViewReport" runat="server" OnClick="lnkViewReport_Click" 
                Width="100px" style="text-align: center">View Report</asp:LinkButton>
        </td>
    </tr>
</table>