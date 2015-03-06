<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_auctiondate, App_Web_auctiondate.ascx.317b4283" %>
<script type="text/javascript">
<!--
function DisplayTime()
{
	if (tis != null)
	{
		tis++;

		lblServerTime.innerHTML = ConvertSecondsToDateTimeString(tis);
		
		setTimeout("DisplayTime()",1000);
	}
}
//-->
</script>
<div id="tasks" onload="DisplayTime();">
	<span style="padding-left: 10px; float: left">
		Today is&nbsp;<asp:Label ID="lblDate" runat="server"></asp:Label>&nbsp;<label id="lblServerTime"></label>
	</span>
</div>
