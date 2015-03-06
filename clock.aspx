<%@ Page Language="C#" AutoEventWireup="true" CodeFile="clock.aspx.cs" Inherits="clock" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%;">
<head runat="server">
    <title></title>
    <script type= "text/javascript" src="jquery/jquery-1.5.1.js"> </script>
    <script type= "text/javascript">
        $(document).ready(function () {

            function update() {
                $.ajax({
                    type: 'POST',
                    url: 'timer.aspx',
                    timeout: 1000,
                    success: function (data) {
                        $("#timer").html(data);
                        window.setTimeout(update, 1000);
                    },
                    async: false,
                });
            }
            update();
        });
    </script>
    <style type="text/css">
        body {
        margin:0px;
        font-family:Arial;
        font-size: 12px;
        color:#fff;
        background-color:#4d5b65;
        }
    </style>
    
</head>
<body style="height: 100%;">
<div id="timer"> </div>
</body>
</html>
