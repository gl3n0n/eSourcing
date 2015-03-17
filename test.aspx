<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%;">
<head runat="server">
    <title></title>
    <script type= "text/javascript" src="jquery/jquery-1.7.1.min.js"> </script>
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
                });
            }
            update();
        });
    </script>

</head>
<body style="height: 100%;">
<div id="timer"> </div>
</body>
</html>
