<%@ page language="C#" autoeventwireup="true" inherits="web_onlineAuction_participateauctionevent, App_Web_sessionexpired.aspx.162804a0" theme="default" %>

<%@ Register Src="../usercontrol/auctionvendor/sessionexpired.ascx" TagName="sessionexpired" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_oa.css" />    
</head>
<body>
    <div>
        <form runat="server">
            <uc1:sessionexpired ID="Sessionexpired1" runat="server" />            
        </form>
    </div>
</body>
</html>
