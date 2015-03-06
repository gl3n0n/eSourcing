<%@ control language="C#" autoeventwireup="true" inherits="web_user_control_GlobalLinksNav, App_Web_globallinksnav.ascx.317b4283" %>
<link type="text/css" href="../css/style.css" rel="stylesheet" />
<script language="javascript" src="../include/generalJSFunctions.js"></script>
<script type="text/javascript">
<!--	
	function ShowResults(usertype)
	{
		var searchstring = document.getElementById("GlobalLinksNav_tbSearch").value;
		var DDList = document.getElementById("GlobalLinksNav_ddlSearchOpt");
	    
		var dList = DDList.selectedIndex;
		var selValue = DDList.options[dList].value;

		if(trim(searchstring) != '')        
			//window.open('../../searchResults.aspx?searchstring=' + trim(searchstring) + '&usertype=' + usertype + '&searchType='+selValue , 'x', 'toolbar=no, statusbar = 1, menubar=no, width=450; height=650, top=150, left=325, resizable = 1');
			window.open('../../searchResults.aspx?searchstring=' + trim(searchstring) + '&usertype=' + usertype + '&searchType='+selValue , 'x', 'toolbar=no, status = 1, menubar=no, width=400, height=400, resizable = 1, scrollbars=1, left=200, top=50');
		else        
			//window.open('../../searchResults.aspx?searchstring=%' + '&usertype=' + usertype + '&searchType='+selValue , 'x', 'toolbar=no, statusbar = 1, menubar=no, width=450; height=650, top=150, left=325, resizable=1' );
			window.open('../../searchResults.aspx?searchstring=%' + '&usertype=' + usertype + '&searchType='+selValue , 'x', 'toolbar=no, status = 1, menubar=no, width=300, height=400, resizable=1, scrollbars=1, left=200, top=50' );
	}
//-->
</script>

<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table2">
	<tr>
		<td align="left" width="150px">
			<img border="0" src="../images/logo.jpg" width="150px" height="63">
		</td>
		<td>
			&nbsp;
		</td>
		<td class="globalLinks" align="right" width="360px">
			<p>
				<asp:TextBox ID="tbSearch" runat="server" Height="20px" Width="130px" />
				<asp:Button ID="btnSearch" runat="server" UseSubmitBehavior="false" Text="Search" />
				<asp:DropDownList ID="ddlSearchOpt" runat="server">
					<asp:ListItem Value="1">Bid Events</asp:ListItem>
					<asp:ListItem Value="2">Bid Reference No.</asp:ListItem>
					<asp:ListItem Value="3">Bid Event PR Number</asp:ListItem>
					<asp:ListItem Value="4">Auction Events</asp:ListItem>
					<asp:ListItem Value="5">Auction Reference No.</asp:ListItem>
					<asp:ListItem Value="6">Auction Event PR Number</asp:ListItem>
					<asp:ListItem Value="7">Product</asp:ListItem>
					<asp:ListItem Value="8">Supplier</asp:ListItem>
				</asp:DropDownList>			
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;				
				<asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="~/about.aspx">About Globe E-Sourcing System</asp:HyperLink>
				&nbsp;|&nbsp;				
				<asp:HyperLink ID="lnkHelp" runat="server" NavigateUrl="~/help.aspx">Help</asp:HyperLink>
				&nbsp;|&nbsp;				
				<asp:HyperLink ID="lnkFaqs" runat="server" NavigateUrl="~/faqs.aspx">FAQs</asp:HyperLink>
				&nbsp;|&nbsp;
				<asp:HyperLink ID="lnkLogout" runat="server" NavigateUrl="~/logout.aspx">Log Out</asp:HyperLink>				
			</p>
		</td>
	</tr>
</table>
