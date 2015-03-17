<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bidawardingchecklist.aspx.cs" Inherits="web_buyerscreens_bidawardingchecklist" EnableViewState="true"  %>
<%@ Register TagPrefix="EBid" TagName="LeftNav" Src="~/WEB/usercontrol/Buyer/LeftNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNavBids" Src="~/WEB/usercontrol/Buyer/TopNavBids.ascx" %>
<%@ Register TagPrefix="EBid" TagName="TopNav3" Src="~/WEB/usercontrol/Buyer/TopNav3.ascx" %>
<%@ Register TagPrefix="EBid" TagName="GlobalLinksNav" Src="~/web/usercontrol/GlobalLinksNav.ascx" %>
<%@ Register TagPrefix="EBid" TagName="Footer" Src="~/web/usercontrol/Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title id="PageTitle" runat="server"></title>
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <script type="text/javascript" src="../../jquery/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.core.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.widget.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.mouse.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.tabs.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.button.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.draggable.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.position.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.dialog.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.ui.datepicker.js"></script>
    <script type="text/javascript" src="../../jquery/ui/jquery.effects.slide.js"></script>
    <link rel="stylesheet" href="../../jquery/themes/redmond/jquery.ui.all.css" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../css/style_buyer.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("button, input:submit, input:button").button();

            var iSelected = $("#BuyerBidForBac").val();
            if (iSelected <= 0) {

                var pickerOpts = {
                    showOtherMonths: true,
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-MM-dd"
                };
                $("#<%=PRDate.ClientID%>").datepicker(pickerOpts);
                $("#<%=DateApprovedLbl.ClientID%>").datepicker(pickerOpts);
            }
        });

        function ShowDialog(dialogText, ctrl2Focus) {
            $("#dialog:ui-dialog").dialog("destroy");

            if ($("#dialog-message").length != 0) $('div').remove("#dialog-message");

            if ($("#dialog-message").length == 0) {
                sDiv = "<div id='dialog-message' title='Bid Awarding Checklist' style='display:none;'>";
                sDiv = sDiv + "<p>" + dialogText + "</p>";
                sDiv = sDiv + "</div>";
                $(sDiv).appendTo('body');
            }

            $("#dialog-message").dialog({
                modal: true,
                buttons: {
                    OK: function () {
                        $(this).dialog("close");
                        $(ctrl2Focus).focus();
                    }
                }
            });
        }

        function ChangeToLink(oID, sTxt) {
            document.getElementById(oID).innerHTML = sTxt;
        }

        function DeleteAttach(sDoc, oID, iID) {
            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
            $("#dialog:ui-dialog").dialog("destroy");

            if ($("#dialog-message").length != 0) $('div').remove("#dialog-message");

            if ($("#dialog-message").length == 0) {
                sDiv = "<div id='dialog-message' title='Bid Awarding Checklist' style='display:none;'>";
                sDiv = sDiv + "<p>Delete this attachment?</p>";
                sDiv = sDiv + "</div>";
                $(sDiv).appendTo('body');
            }

            $("#dialog-message").dialog({
                modal: true,
                buttons: {
                    OK: function () {
                        $(this).dialog("close");
                        __doPostBack('DeleteAttach_' + sDoc, iID);
                    },
                    Cancel: function () {
                        $(this).dialog("close");
                        document.getElementById(oID).checked = true;
                    }
                }
            });
        }

        function btnAddCol_onclick() {
            var i;
            i = $("#BuyerBidForBac").val();
            if (i != -1) {
                i = $("#txtNewVendor").val();
                i++;
                $("#txtNewVendor").val(i);

                i = $("#txtCDVendor").val();
                i++;
                $("#txtCDVendor").val(i);

                __doPostBack("NewVendor", "");
            }
        }

        function btnDelCol_onclick() {
            var i;
            i = $("#BuyerBidForBac").val();
            if (i != -1) {
                i = $("#txtNewVendor").val();
                if (i > 0) {
                    i--;
                    $("#txtNewVendor").val(i);
                    __doPostBack("NewVendor", "");
                }
            }
        }

        function HideCriteria() {
            var i;
            for (i = 0; i < 10; i++) {
                $("#tr" + i).hide();
            }
        }

        function btnAddRow_onclick() {
            var i;
            i = $("#txtNewRow").val();
            if (i < 9) i++;
            $("#txtNewRow").val(i);
            $("#tr" + i).show('slide');
        }

        function btnDelRow_onclick() {
            var i;
            i = $("#txtNewRow").val();
            var sCtrl;
            $("#tr" + i).hide('slide');
            $("#txtR" + i).val('');
            for (var j = 0; j < 100; j++) {
                if (j < 10) {
                    sCtrl = "#RepeaterC" + i + "_ctl0" + j + "_txtC" + i;
                }
                else {
                    sCtrl = "#RepeaterC" + i + "_ctl" + j + "_txtC" + i;
                }
                if ($(sCtrl).length == 0) {
                    break;
                }
                else {
                    $(sCtrl).val('');
                }
            }
            if (i > 0) i--;
            $("#txtNewRow").val(i);
        }

        function ShowNewRowsOnLoad() {
            var i = $("#txtNewRow").val();
            var j = 0;
            while (j <= i) {
                $("#tr" + j).show();
                j++;
            }
        }

        function ComputeAccCost() {
            var sCtrl;
            var sCtrl_1;
            var iTotal = 0;
            for (var j = 0; j < 100; j++) {
                if (j < 10) {
                    sCtrl = "#Repeater13_ctl0" + j + "_chkAwarded";
                    sCtrl_1 = "#Repeater10_ctl0" + j + "_txtBidTotal";
                }
                else {
                    sCtrl = "#Repeater13_ctl" + j + "_chkAwarded";
                    sCtrl_1 = "#Repeater10_ctl" + j + "_txtBidTotal";
                }
                if ($(sCtrl).length == 0) {
                    break;
                }
                else {
                    var chkd = $(sCtrl).is(':checked') ? 1 : 0;
                    if (chkd == 1) {
                        iTotal = iTotal + parseFloat($(sCtrl_1).val());
                    }
                }
            }
            document.getElementById('lblAccCost').innerHTML = add_commas(iTotal.toFixed(2));
            var iTotalAll = parseFloat(document.getElementById('lblTotalAll').value);
            var iNegDisc = iTotalAll - iTotal;
            document.getElementById('lblNegDisc').innerHTML = add_commas(iNegDisc.toFixed(2));
            var iPercent = (iTotal / iTotalAll) * 100;
            document.getElementById('lblPercentSpend').innerHTML = add_commas(iPercent.toFixed(2)) + "%";
        }

        function add_commas(nStr) {
            nStr += '';
            x = nStr.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }

        function createCookie(name, value, days) {
            var expires;
            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toGMTString();
            }
            else expires = "";
            document.cookie = name + "=" + value + expires + "; path=/";
        }

        function readCookie(name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }

        function eraseCookie(name) {
            createCookie(name, "", -1);
        }

        function AddTRCheckBox(sTable, sId, sTxt, bCheckCookie) {
            var sNewRow;
            sTxt = escape(sTxt);
            sDispTxt = sTxt;
            sTxt = sTxt.replace(new RegExp("/", "g"), "_slash_");
            sTxt = sTxt.replace(new RegExp("%", "g"), "_percent_");
            sId = sId + "_";
            var sCookieId = "my" + sId;
            if (bCheckCookie == true) {
                if (readCookie(sCookieId + sTxt.toLowerCase()) == null) {
                    sNewRow = "<input type='checkbox' name='" + sId + sTxt + "' id='" + sId + sTxt + "' onclick='RemoveRowOnCheck(\"" + sCookieId + sTxt + "\", \"" + sCookieId + sTxt.toLowerCase() + "\");' checked />";
                    sNewRow = sNewRow + "<label for='" + sId + sTxt + "' >" + unescape(sDispTxt) + "</label>";
                    $(sTable).last().append("<tr id='" + sCookieId + sTxt + "'><td>" + sNewRow + "</td></tr>");
                    createCookie(sCookieId + sTxt.toLowerCase(), unescape(sDispTxt), 1);
                }
                else {
                    ShowDialog("Item already exists.", "#form1");
                }
            }
            else {
                sNewRow = "<input type='checkbox' name='" + sId + sTxt + "' id='" + sId + sTxt + "' onclick='RemoveRowOnCheck(\"" + sCookieId + sTxt + "\", \"" + sCookieId + sTxt.toLowerCase() + "\");' checked />";
                sNewRow = sNewRow + "<label for='" + sId + sTxt + "' >" + unescape(sDispTxt) + "</label>";
                $(sTable).last().append("<tr id='" + sCookieId + sTxt + "'><td>" + sNewRow + "</td></tr>");
            }
        }

        function cbPaymentTerms_SelectedIndexChanged() {
            var oPT = document.getElementById("cbPaymentTerms");
            if (oPT.value != -1) {
                var sTxt = oPT.options[oPT.selectedIndex].text;
                AddTRCheckBox("#myPaymentTerms", "pt", sTxt, true);
            }
        }

        function AddOtherPaymentTerm() {
            if ($("#txtNewPaymentTerm").val() == "") {
                ShowDialog("Please type new payment term.", "#txtNewPaymentTerm");
            }
            else {
                var sTxt = $("#txtNewPaymentTerm").val();
                AddTRCheckBox("#myPaymentTerms", "pt", sTxt, true);
            }
        }

        function cbSourcingStrategy_SelectedIndexChanged() {
            var oPT = document.getElementById("cbSourcingStrategy");
            if (oPT.value != -1) {
                var sTxt = oPT.options[oPT.selectedIndex].text;
                AddTRCheckBox("#mySourcingStrategy", "ss", sTxt, true);
            }
        }

        function AddOtherSourcingStrategy() {
            if (jQuery.trim($("#txtNewSourcingStrategy").val()) == "") {
                ShowDialog("Please type new sourcing strategy.", "#txtNewSourcingStrategy");
            }
            else {
                var sTxt = $("#txtNewSourcingStrategy").val();
                AddTRCheckBox("#mySourcingStrategy", "ss", sTxt, true);
            }
        }

        function AddOtherNatureOfSaving() {
            if ($("#txtNewNatureOfSavings").val() == "") {
                ShowDialog("Please type new nature of service.", "#txtNewNatureOfSavings");
            }
            else {
                var sTxt = $("#txtNewNatureOfSavings").val();
                AddTRCheckBox("#myNatureOfSavings", "nos", sTxt, true);
            }
        }

        function cbNatureOfSavings_SelectedIndexChanged() {
            var oPT = document.getElementById("cbNatureOfSavings");
            if (oPT.value != -1) {
                var sTxt = oPT.options[oPT.selectedIndex].text;
                AddTRCheckBox("#myNatureOfSavings", "nos", sTxt, true);
            }
        }

        function cbTypeOfPurchase_SelectedIndexChanged() {
            var oPT = document.getElementById("cbTypeOfPurchase");
            if (oPT.value != -1) {
                var sTxt = oPT.options[oPT.selectedIndex].text;
                AddTRCheckBox("#myTypeOfPurchase", "top", sTxt, true);
            }
        }

        function AddOtherTypeOfPurchase() {
            if ($("#txtNewTypeOfPurchase").val() == "") {
                ShowDialog("Please type new type of purchase.", "#txtNewTypeOfPurchase");
            }
            else {
                var sTxt = $("#txtNewTypeOfPurchase").val();
                AddTRCheckBox("#myTypeOfPurchase", "top", sTxt, true);
            }
        }

        function cbSupplyPosition_SelectedIndexChanged() {
            var oPT = document.getElementById("cbSupplyPosition");
            if (oPT.value != -1) {
                var sTxt = oPT.options[oPT.selectedIndex].text;
                AddTRCheckBox("#mySupplyPosition", "sp", sTxt, true);
            }
        }

        function AddOtherSupplyPosition() {
            if ($("#txtNewSupplyPosition").val() == "") {
                ShowDialog("Please type new supply position.", "#txtNewSupplyPosition");
            }
            else {
                var sTxt = $("#txtNewSupplyPosition").val();
                AddTRCheckBox("#mySupplyPosition", "sp", sTxt, true);
            }
        }

        function cbBasisForAwarding_SelectedIndexChanged() {
            var oPT = document.getElementById("cbBasisForAwarding");
            if (oPT.value != -1) {
                var sTxt = oPT.options[oPT.selectedIndex].text;
                AddTRCheckBox("#myBasisForAwarding", "bfa", sTxt, true);
            }
        }

        function AddOtherBasisForAwarding() {
            if (jQuery.trim($("#txtNewBasisForAwarding").val()) == "") {
                ShowDialog("Please type new basis for awarding.", "#txtNewBasisForAwarding");
            }
            else {
                var sTxt = $("#txtNewBasisForAwarding").val();
                AddTRCheckBox("#myBasisForAwarding", "bfa", sTxt, true);
            }
        }

        function AddCRC() {
            if (jQuery.trim($("#txtNewCRC").val()) == "") {
                ShowDialog("Please type new CRC No.", "#txtNewCRC");
            }
            else {
                var sTxt = $("#txtNewCRC").val();
                AddTRCheckBox("#myCRC", "crc", sTxt, true);
            }
        }

        function AddPO() {
            if (jQuery.trim($("#txtNewPO").val()) == "") {
                ShowDialog("Please type new PO No.", "#txtNewPO");
            }
            else {
                var sTxt = $("#txtNewPO").val();
                AddTRCheckBox("#myPO1", "po1", sTxt, true);
            }
        }

        function RemoveRowOnCheck(sRow, sCookie) {
            $("#" + sRow).remove();
            eraseCookie(sCookie);
        }

        function ShowSavedCookies() {
            var i, nameEQ, ca, c;
            var iVal, iVal1, sTxt, sNewRow;

            // payment terms
            nameEQ = "mypt_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#myPaymentTerms", "pt", iVal1[1], false);
                }
            }
            // sourcing strategy
            nameEQ = "myss_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#mySourcingStrategy", "ss", iVal1[1], false);
                }
            }
            // type of purchase
            nameEQ = "mytop_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#myTypeOfPurchase", "top", iVal1[1], false);
                }
            }
            // supply position
            nameEQ = "mysp_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#mySupplyPosition", "sp", iVal1[1], false);
                }
            }
            // basis for awarding
            nameEQ = "mybfa_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#myBasisForAwarding", "bfa", iVal1[1], false);
                }
            }
            // nature of savings
            nameEQ = "mynos_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#myNatureOfSavings", "nos", iVal1[1], false);
                }
            }
            // CRC
            nameEQ = "mycrc_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#myCRC", "crc", iVal1[1], false);
                }
            }
            // PO
            nameEQ = "mypo1_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c.substring(nameEQ.length, c.length);
                    iVal1 = iVal.split("=");
                    AddTRCheckBox("#myPO1", "po1", iVal1[1], false);
                }
            }
        }

        function ClearSavedCookies() {
            var i, nameEQ, ca, c;
            var iVal, iVal1, sTxt, sNewRow;

            // payment terms
            nameEQ = "mypt_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
            // sourcing strategy
            nameEQ = "myss_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
            // type of purchase
            nameEQ = "mytop_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
            // supply position
            nameEQ = "mysp_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
            // basis for awarding
            nameEQ = "mybfa_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
            // nature of savings
            nameEQ = "mynos_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
            // CRC
            nameEQ = "mycrc_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
            // PO
            nameEQ = "mypo1_";
            ca = document.cookie.split(';');
            for (i = 0; i < ca.length; i++) {
                c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) {
                    iVal = c;
                    iVal1 = iVal.split("=");
                    eraseCookie(iVal1[0]);
                }
            }
        }

        function ChangeItemIndex(dropdownitem) {
            var oPT;
            var oPT1;
            if (dropdownitem == "details") {
                oPT = document.getElementById("cbItemNo");
                oPT1 = document.getElementById("cbItemD");
            }
            else {
                oPT = document.getElementById("cbItemD");
                oPT1 = document.getElementById("cbItemNo");
            }
            var iIndex = oPT.selectedIndex;
            oPT1.selectedIndex = iIndex;
        }
    </script>

    <style type="text/css">
        .ui-widget { font-family: Arial; font-size: 11; }
        .style1
        {
            width: 81px;
        }
        .style2
        {
            width: 210px;
        }
        .style4
        {
            height: 32px;
        }
        .style5
        {
            height: 33px;
        }
        </style>
</head>
<body id="Body1" runat="server">
    <div>
        <form enctype="multipart/form-data" id="form1" title="form1" runat="server">&nbsp;
			<table border="0" cellpadding="0" cellspacing="0" width="100%" id="page">
                <tr>
                    <td valign="top" height="137px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <div align="left" id="masthead">
                                        <EBid:GlobalLinksNav runat="server" ID="GlobalLinksNav" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNavBids ID="TopNavBids1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <EBid:TopNav3 ID="TopNav3" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                            <tr>
                                <td id="relatedInfo">
                                    <h2>Bid Events</h2>
                                    <div align="left">
                                        <EBid:LeftNav ID="LeftNav" runat="server" />
                                    </div>
                                    <p>&nbsp;</p>
                                </td>
                                <td id="content">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td valign="top">
												<h1><br />Bid Awarding Checklist</h1>
												<p><asp:Label ID="lblMessage" runat="server" Font-Size="11px" ForeColor="red"></asp:Label></p>
                                                <table cellspacing="5" style="width:100%;">
                                                    <tr>
                                                        <td colspan="2" valign="top">
															<table width="50%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td colspan="4" class="ui-widget-header" style="height:26px; vertical-align:middle;">BID DETAILS</td>
																	</tr>
																	<tr valign="middle" >
																		<td colspan="2" align="center" valign="middle" style="padding:5px; font-size:12px; width:50%">Bid Reference No. </td>
																		<td colspan="2" align="center" valign="middle" style="padding:5px; font-size:12px; width:50%">Bid Events Description: </td>
																	</tr>
																	<tr valign="middle" >
																		<td colspan="2" align="center" valign="middle" bgcolor="#FFFFFF" style="padding:15px 5px; font-size:12px; width:50%">
																			<div id="fromDS">
																				<asp:dropdownlist ID="BuyerBidForBac" runat="server"
																					DataSourceID="dsBuyerBidForBac"
																					DataTextField="BidRefNoItemDesc"
																					DataValueField="BidRefNo" AutoPostBack="True"
																					OnDataBound="BuyerBidForBac_DataBound" onload="Page_LoadComplete" >
																				</asp:dropdownlist>

																				<asp:SqlDataSource ID="dsBuyerBidForBac" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																					SelectCommand="SELECT t1.BidRefNo,t1.ItemDesc, Convert(varchar, t1.BidRefNo) + ': ' + SUBSTRING(t1.ItemDesc,1,25)+'...' AS BidRefNoItemDesc,
																						t1.BidRefNo AS BidDetailNo FROM tblBidItems t1 WHERE t1.Status = @Status AND t1.ForAuction = 0 AND t1.BuyerId = @BuyerId
																						and not exists (select 1 from  tblBacBidItems t2 where t1.BidRefNo = t2.BidRefNo) ORDER BY t1.DateCreated DESC" >
																					<SelectParameters>
																						<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																						<asp:Parameter Name="Status" DefaultValue="4" Type="Int32" />
																					</SelectParameters>
																				</asp:SqlDataSource>
																			</div>
																			<div id="fromNew">
																				<asp:Label ID="lblNew" runat="server" Text="New Bid Reference No.:"></asp:Label><asp:TextBox ID="txtNew" runat="server"></asp:TextBox>
																			</div>

																			<input type="hidden" id="lblTotalAll" name="lblTotalAll" runat="server" />
                                                                            <input type="hidden" id="lblLoad" name="lblLoad" runat="server" />
																		</td>
																		<td colspan="2" align="center" valign="middle" bgcolor="#FFFFFF" style="padding:15px 5px; font-size:12px; width:50%">
																			<asp:TextBox ID="ItemDescLbl" runat="server" Width="350"></asp:TextBox>
																		</td>
																	</tr>
																	<tr valign="middle">
																		<td align="center" valign="middle" style="width:25%;">SAP PR No.:</td>
																		<td align="center" valign="middle" style="width:25%;">Amount:</td>
																		<td align="center" valign="middle" style="width:25%;">SAP PR Date:</td>
																		<td align="center" valign="middle" style="width:25%;">Date Received</td>
																	</tr>
																	<tr valign="middle">
																		<td align="center" valign="middle" style="background-color:#FFFFFF; width:25%;">
																			<asp:TextBox ID="PRRefNoLbl" runat="server" Width="75"></asp:TextBox>
																		</td>
																		<td align="center" valign="middle" bgcolor="#FFFFFF" style="width:25%;">
																			<asp:TextBox ID="EstItemValueLbl" runat="server" Text="0" Width="75"></asp:TextBox>
																		</td>
																		<td align="center" valign="middle" bgcolor="#FFFFFF" style="width:25%;">
																			<asp:TextBox ID="PRDate" runat="server" Width="75"></asp:TextBox>
																		</td>
																		<td align="center" valign="middle" bgcolor="#FFFFFF" style="width:25%;">
																			<asp:TextBox ID="DateApprovedLbl" runat="server" Width="75"></asp:TextBox>
																		</td>
																	</tr>
																	<tr valign="middle">
																		<td colspan="2" align="center" valign="middle" style="width:25%;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td><input type="radio" runat="server" id="Budgeted" name="Budgeted" value="1" />
																						<label for="Budgeted">Budgeted</label>
																					</td>
																					<td>
																						<input type="radio" runat="server" id="UnBudgeted" name="Budgeted" value="0" checked="true" />
																						<label for="UnBudgeted">UnBudgeted</label>
																					</td>
																				</tr>
																			</table>
																		</td>
																		<td colspan="2" align="center" valign="middle" style="width:25%;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td class="style1"><input name="CompanyId" runat="server" value="0" id="CompanyIdGT" type="radio" checked="true" />
																						<label for="CompanyIdGT">GT</label>
																					</td>
																					<td>
																						<input name="CompanyId"  id="CompanyIdIC" runat="server" value="1" type="radio" />
																						<label for="CompanyIdIC">IC</label>
																					</td>
																					<td>
																						<input name="CompanyId"  id="CompanyIdGXI" runat="server" value="2" type="radio" />
																						<label for="CompanyIdGXI">GXI</label>
																					</td>
																					<td>
																						<input name="CompanyId"  id="CompanyIdEGG" runat="server" value="4" type="radio" />
																						<label for="CompanyIdEGG">EGG</label>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>
															<asp:SqlDataSource ID="dsBuyerBidDetailsForBac" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																	SelectCommand="SELECT t1.*, t3.Company FROM tblBidItems t1 INNER JOIN rfcCompany t3 ON t3.CompanyId = t1.CompanyId WHERE t1.Status = @Status
																	AND t1.ForAuction = 0 AND t1.BuyerId = @BuyerId AND t1.BidRefNo = @BidRefNo AND t3.CompanyId = t1.CompanyId ORDER BY t1.DateCreated DESC" >
																<SelectParameters>
																	<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																	<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																	<asp:Parameter Name="Status" DefaultValue="4" Type="Int32" />
																</SelectParameters>
															</asp:SqlDataSource>
														</td>
													</tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <table width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails9" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">EXECUTIVE SUMMARY</td>
																	</tr>
																	<tr valign="middle" >
																		<td align="center" valign="middle" style="padding:5px; font-size:12px; width:100%"><label for="textarea"></label>
																			<textarea name="executive_summary" id="executive_summary" cols="45" rows="10" runat="server" style="width:100%"></textarea>
																		</td>
																	</tr>
																</tbody>
															</table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <table width="50%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails8" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td colspan="2" class="ui-widget-header" style="height:26px; vertical-align:middle;">REMARKS / COMMENTS</td>
																	</tr>
																	<tr valign="middle" >
																		<td align="center" valign="middle" style="padding:5px; font-size:12px; width:50%">
																			<label for="textarea"></label>
																			<textarea name="remarks_comments" id="remarks_comments" cols="45" rows="10" style="width:100%" runat="server" ></textarea>
																		</td>
																	</tr>
																</tbody>
															</table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
															
                                                            <table width="50%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Table3" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245);">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">SUPPLY POSITION</td>
																	</tr>
																	<tr valign="middle">
																		<td align="center" valign="middle" style="width:25%;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="60%">
																						<table>
																							<tr><td class="style2">
																								<asp:DropDownList ID="cbSupplyPosition" runat="server"
																									DataSourceID="dsSupplyPosition" DataTextField="SupplyPosition"
																									DataValueField="ID" ondatabound="cbSupplyPosition_DataBound">
																								</asp:DropDownList>
																								<asp:SqlDataSource ID="dsSupplyPosition" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																									SelectCommand="SELECT * FROM rfcSupplyPosition ORDER BY ID" >
																								</asp:SqlDataSource>
																							</td></tr>
																							<tr><td class="style2">
																								<asp:TextBox ID="txtNewSupplyPosition" runat="server" Width="150"></asp:TextBox>
																								<input id="Button1" type="button" value="Others" onclick="AddOtherSupplyPosition();" />
																							</td></tr>
																						</table>
																					</td>
																					<td>
																						<table id="mySupplyPosition"></table>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>
                                                        </td>
                                                        <td valign="top">
															<table width="50%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails5" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245);">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">SOURCING STRATEGY</td>
																	</tr>
																	<tr valign="middle">
																		<td align="center" valign="middle" style="width:25%;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="60%" style="border:none">
																						<table>
																							<tr><td>
																								<asp:DropDownList ID="cbSourcingStrategy" runat="server"
																									DataSourceID="dsSourcingStrategy" DataTextField="SourcingStrategy"
																									DataValueField="ID" ondatabound="cbSourcingStrategy_DataBound">
																								</asp:DropDownList>
																								<asp:SqlDataSource ID="dsSourcingStrategy" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																									SelectCommand="SELECT * FROM rfcSourcingStrategy ORDER BY ID" >
																								</asp:SqlDataSource>
																							</td></tr>
																							<tr><td>
																								<asp:TextBox ID="txtNewSourcingStrategy" runat="server" Width="150"></asp:TextBox>
																								<input id="btnNewSS" type="button" value="Others" onclick="AddOtherSourcingStrategy();" />
																							</td></tr>
																						</table>
																					</td>
																					<td style="border:none">
																						<table>
																							<tr><td>
																								<label for="ss_nobidders">No. of Invited Bidders: </label>
																								<input name="ss_nobidders" type="text" id="ss_nobidders" size="3" value="0" runat="server"  />
																							</td></tr>
																							<tr><td>
																								<label for="ss_nobidsrcvd">No. of Bids Received: </label>
																								<input name="ss_nobidsrcvd" type="text" id="ss_nobidsrcvd" size="3" value="0" runat="server"  />
																							</td></tr>
																							<tr><td class="style5">
																								<label for="ss_techcompliance">Tech. Compliance: </label>
																								<input name="ss_techcompliance" type="text" id="ss_techcompliance" size="3" value="0" runat="server"  />
																							</td></tr>
																						</table>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																	<tr><td>
																		<table id="mySourcingStrategy" runat="server"></table>
																	</td></tr>
																</tbody>
															</table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td valign="top">
															<table width="60%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails6" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); width:99%; ">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">TYPE OF PURCHASE</td>
																	</tr>
																	<tr valign="middle">
																		<td align="center" valign="middle" style="width:25%;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="60%">
																						<table>
																							<tr><td>
																								<asp:DropDownList ID="cbTypeOfPurchase" runat="server"
																									DataSourceID="dsTypeOfPurchase" DataTextField="TypeOfPurchase"
																									DataValueField="ID" ondatabound="cbTypeOfPurchase_DataBound" >
																								</asp:DropDownList>
																								<asp:SqlDataSource ID="dsTypeOfPurchase" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																									SelectCommand="SELECT * FROM rfcTypeOfPurchase ORDER BY ID" >
																								</asp:SqlDataSource>
																							</td></tr>
																							<tr><td>
																								<asp:TextBox ID="txtNewTypeOfPurchase" runat="server" Width="150"></asp:TextBox>
																								<input id="btnTOP" type="button" value="Others" onclick="AddOtherTypeOfPurchase();" />
																							</td></tr>
																						</table>
																					</td>
																					<td>
																						<table id="myTypeOfPurchase"></table>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
                                                        <td valign="top">
															<table width="50%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails4" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); width:99%;">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">PAYMENT TERMS</td>
																	</tr>
																	<tr valign="middle">
																		<td align="center" valign="middle" style="width:25%;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="60%">
																						<table>
																							<tr><td style="border:none">
																								<asp:DropDownList ID="cbPaymentTerms" runat="server"
																									DataSourceID="dsPaymentTerms" DataTextField="PaymentTerm" DataValueField="ID"
																									ondatabound="cbPaymentTerms_DataBound">
																								</asp:DropDownList>
																								<asp:SqlDataSource ID="dsPaymentTerms" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																									SelectCommand="SELECT * FROM rfcPaymentTerms ORDER BY ID" >
																								</asp:SqlDataSource>
																							</td></tr>
																						</table>
																					</td>
																					<td>
																						<table id="myPaymentTerms"></table>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>
                                                        </td>
                                                    </tr>
                                                    <tr>
														<td valign="top">
															<table border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails2" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245);">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">SUPPORTING DOCUMENTS ATTACHED</td>
																	</tr>
																	<tr valign="middle" >
																		<td align="center" valign="middle" style="padding:5px; font-size:12px; width:50%">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="50%">
																						<strong><label id="doc_ApprovedPR" runat="server">Approved PR</label></strong><br />
																						<asp:Repeater ID="Repeater_SDA_APR" runat="server" DataSourceID="dsSDA_APR" onitemdatabound="Repeater_SDA_APR_ItemDataBound" >
																							<ItemTemplate>
																								<input id="chkSDA_APR" name="chkSDA_APR" type="checkbox" runat="server" checked="true" />
																								<a id="lnkSDA_APR" href="bidawardingchecklist.aspx?ShowAttachment=<%# Eval("FileUploadID") %>" target="_blank"><%# Eval("OriginalFileName") %></a><br />
																							</ItemTemplate>
																						</asp:Repeater>
																						<asp:SqlDataSource ID="dsSDA_APR" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																							SelectCommand="SELECT * FROM tblBACSupportingDocuments WHERE BuyerID=@BuyerID AND BidRefNo=@BidRefNo AND DocuName='Approved_PR' ORDER BY FileUploadID"
																							onload="dsSDA_APR_Load" >
																							<SelectParameters>
																								<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																								<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																							</SelectParameters>
																						</asp:SqlDataSource>
																					</td>
																					<td width="50%">
																						<strong><label id="doc_Commercial" runat="server">Commercial Evaluation</label></strong><br />
																						<asp:Repeater ID="Repeater_SDA_CE" runat="server" DataSourceID="dsSDA_CE"
																							onitemdatabound="Repeater_SDA_CE_ItemDataBound">
																							<ItemTemplate>
																								<input id="chkSDA_CE" name="chkSDA_CE" type="checkbox" runat="server" checked="true" />
																								<a href="../fileattachments/<% =Session["UserId"] %>/BAC/<%# Eval("ActualFileName") %>" target="_blank"><%# Eval("OriginalFileName") %></a><br />
																							</ItemTemplate>
																						</asp:Repeater>
																						<asp:SqlDataSource ID="dsSDA_CE" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																							SelectCommand="SELECT * FROM tblBACSupportingDocuments WHERE BuyerID=@BuyerID AND BidRefNo=@BidRefNo AND DocuName='Commercial_Evaluation' ORDER BY FileUploadID"
																							onload="dsSDA_CE_Load" >
																							<SelectParameters>
																								<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																								<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																							</SelectParameters>
																						</asp:SqlDataSource>
																					</td>
																				</tr>
																				<tr>
																					<td>
																						<strong><label id="doc_ApprovedBC" runat="server">Approved Business Case</label></strong><br />
																						<asp:Repeater ID="Repeater_SDA_ABC" runat="server" DataSourceID="dsSDA_ABC"
																							onitemdatabound="Repeater_SDA_ABC_ItemDataBound">
																							<ItemTemplate>
																								<input id="chkSDA_ABC" name="chkSDA_ABC" type="checkbox" runat="server" checked="true" />
																								<a href="../fileattachments/<% =Session["UserId"] %>/BAC/<%# Eval("ActualFileName") %>" target="_blank"><%# Eval("OriginalFileName") %></a><br />
																							</ItemTemplate>
																						</asp:Repeater>
																						<asp:SqlDataSource ID="dsSDA_ABC" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																							SelectCommand="SELECT * FROM tblBACSupportingDocuments WHERE BuyerID=@BuyerID AND BidRefNo=@BidRefNo AND DocuName='Approved_Business_Case' ORDER BY FileUploadID"
																							onload="dsSDA_ABC_Load" >
																							<SelectParameters>
																								<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																								<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																							</SelectParameters>
																						</asp:SqlDataSource>
																					</td>
																					<td>
																						<strong><label id="doc_Negotiation" runat="server">Negotiation Results</label></strong><br />
																						<asp:Repeater ID="Repeater_SDA_NR" runat="server" DataSourceID="dsSDA_NR"
																							onitemdatabound="Repeater_SDA_NR_ItemDataBound">
																							<ItemTemplate>
																								<input id="chkSDA_NR" name="chkSDA_NR" type="checkbox" runat="server" checked="true" />
																								<a href="../fileattachments/<% =Session["UserId"] %>/BAC/<%# Eval("ActualFileName") %>" target="_blank"><%# Eval("OriginalFileName") %></a><br />
																							</ItemTemplate>
																						</asp:Repeater>
																						<asp:SqlDataSource ID="dsSDA_NR" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																							SelectCommand="SELECT * FROM tblBACSupportingDocuments WHERE BuyerID=@BuyerID AND BidRefNo=@BidRefNo AND DocuName='Negotiation_Results' ORDER BY FileUploadID"
																							onload="dsSDA_NR_Load" >
																							<SelectParameters>
																								<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																								<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																							</SelectParameters>
																						</asp:SqlDataSource>
																					</td>
																				</tr>
																				<tr>
																					<td>
																						<strong><label id="doc_Board" runat="server">Board Resolution</label></strong><br />
																						<asp:Repeater ID="Repeater_SDA_BR" runat="server" DataSourceID="dsSDA_BR"
																							onitemdatabound="Repeater_SDA_BR_ItemDataBound">
																							<ItemTemplate>
																								<input id="chkSDA_BR" name="chkSDA_BR" type="checkbox" runat="server" checked="true" />
																								<a href="../fileattachments/<% =Session["UserId"] %>/BAC/<%# Eval("ActualFileName") %>" target="_blank"><%# Eval("OriginalFileName") %></a><br />
																							</ItemTemplate>
																						</asp:Repeater>
																						<asp:SqlDataSource ID="dsSDA_BR" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																							SelectCommand="SELECT * FROM tblBACSupportingDocuments WHERE BuyerID=@BuyerID AND BidRefNo=@BidRefNo AND DocuName='Board_Resolution' ORDER BY FileUploadID"
																							onload="dsSDA_BR_Load" >
																							<SelectParameters>
																								<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																								<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																							</SelectParameters>
																						</asp:SqlDataSource>
																					</td>
																					<td>
																						<strong><label id="doc_Others" runat="server">Others</label></strong><br />
																						<asp:Repeater ID="Repeater_SDA_Oth" runat="server" DataSourceID="dsSDA_Oth"
																							onitemdatabound="Repeater_SDA_Oth_ItemDataBound">
																							<ItemTemplate>
																								<input id="chkSDA_Oth" name="chkSDA_Oth" type="checkbox" runat="server" checked="true" />
																								<a href="../fileattachments/<% =Session["UserId"] %>/BAC/<%# Eval("ActualFileName") %>" target="_blank"><%# Eval("OriginalFileName") %></a><br />
																							</ItemTemplate>
																						</asp:Repeater>
																						<asp:SqlDataSource ID="dsSDA_Oth" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																							SelectCommand="SELECT * FROM tblBACSupportingDocuments WHERE BuyerID=@BuyerID AND BidRefNo=@BidRefNo AND DocuName='Others' ORDER BY FileUploadID"
																							onload="dsSDA_Oth_Load" >
																							<SelectParameters>
																								<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																								<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																							</SelectParameters>
																						</asp:SqlDataSource>
																					</td>
																				</tr>
																				<tr>
																					<td>
																						<strong><label id="doc_Technical" runat="server">Technical Evaluation</label></strong><br />
																						<asp:Repeater ID="Repeater_SDA_TE" runat="server" DataSourceID="dsSDA_TE"
																							onitemdatabound="Repeater_SDA_TE_ItemDataBound">
																							<ItemTemplate>
																								<input id="chkSDA_TE" name="chkSDA_TE" type="checkbox" runat="server" checked="true" />
																								<a href="../fileattachments/<% =Session["UserId"] %>/BAC/<%# Eval("ActualFileName") %>" target="_blank"><%# Eval("OriginalFileName") %></a><br />
																							</ItemTemplate>
																						</asp:Repeater>
																						<asp:SqlDataSource ID="dsSDA_TE" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																							SelectCommand="SELECT * FROM tblBACSupportingDocuments WHERE BuyerID=@BuyerID AND BidRefNo=@BidRefNo AND DocuName='Technical_Evaluation' ORDER BY FileUploadID"
																							onload="dsSDA_TE_Load" >
																							<SelectParameters>
																								<asp:SessionParameter Name="BuyerId" SessionField="UserId" Type="Int32" />
																								<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																							</SelectParameters>
																						</asp:SqlDataSource>
																					</td>
																					<td>&nbsp;</td>
																				</tr>
																				<tr>
																					<td style="border-bottom:none">
																						&nbsp;
																					</td>
																					<td style="border-bottom:none">
																						&nbsp;
																					</td>
																				</tr>
																				<tr>
																					<td style="border-bottom:none" colspan="2">
																						<asp:DropDownList ID="SupportDocuAttached" runat="server">
																							<asp:ListItem Value="Approved_PR">Approved PR</asp:ListItem>
																							<asp:ListItem Value="Approved_Business_Case">Approved Business Case</asp:ListItem>
																							<asp:ListItem Value="Board_Resolution">Board Resolution</asp:ListItem>
																							<asp:ListItem Value="Technical_Evaluation">Technical Evaluation</asp:ListItem>
																							<asp:ListItem Value="Commercial_Evaluation">Commercial Evaluation</asp:ListItem>
																							<asp:ListItem Value="Negotiation_Results">Negotiation Results</asp:ListItem>
																							<asp:ListItem Value="Others">Others</asp:ListItem>
																						</asp:DropDownList>
																					</td>
																				</tr>
																				<tr>
																					<td style="border-bottom:none" colspan="2">
																						<asp:FileUpload ID="fileUpload" runat="server" Width="350px" /><br />
																						<asp:LinkButton ID="lnkAttach" runat="server" CausesValidation="false">Add To Attachments List</asp:LinkButton><br />
																						<asp:Literal ID="addAttachmentMsg" runat="server"></asp:Literal>
																					</td>
																				</tr>
																				<tr>
																					<td style="border-bottom:none" colspan="2">
																						&nbsp;
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																	<tr valign="middle">
																		<td valign="middle"></td>
																	</tr>
																</tbody>
															</table>
														</td>
														<td valign="top">
															<table width="60%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails3" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245);">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">BASIS FOR AWARDING</td>
																	</tr>
																	<tr valign="middle">
																		<td align="center" valign="middle" style="width:25%;">
																			<table width="100%" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td width="100%">
																						<table width="100%">
																							<tr><td>
																								<asp:DropDownList ID="cbBasisForAwarding" runat="server"
																									DataSourceID="dsBasisForAwarding" DataTextField="BasisForAwarding"
																									DataValueField="ID" ondatabound="cbBasisForAwarding_DataBound" >
																								</asp:DropDownList>
																								<asp:SqlDataSource ID="dsBasisForAwarding" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																									SelectCommand="SELECT * FROM rfcBasisForAwarding ORDER BY ID" >
																								</asp:SqlDataSource>
																							</td></tr>
																							<tr><td class="style4" style="border:none">
																								<asp:TextBox ID="txtNewBasisForAwarding" runat="server" Width="150"></asp:TextBox>
																								<input id="btnBFA" type="button" value="Others" onclick="AddOtherBasisForAwarding();" />
																							</td></tr>
																						</table>
																					</td>
																				</tr>
																				<tr>
                                                                                <td>
																					<table id="myBasisForAwarding"></table></td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
                                                    <tr>
														<td colspan="2" valign="top">
															<div style="width:970px;overflow-x:auto; overflow-y:hidden">
															<table width="60%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails10" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">
																			BID EVALUATION SUMMARY
																			<input id="txtNewVendor" type="hidden" name="txtNewVendor" runat="server" />
																			<input id="txtCDVendor" type="hidden" name="txtCDVendor" runat="server" />
																			<input id="txtNewRow" type="hidden" name="txtNewRow" runat="server" />
																		</td>
																	</tr>
																	<tr>
																		<td style="padding:5px; font-size:12px; width:90%;">
																			<div style="width:100%; overflow:hidden;">
																				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblCriteria">
                                                                                <tbody >
																					<tr bgcolor="#E4EFF8">
																						<td>
																							<strong>VENDOR / CRITERIA</strong>
																						</td>
																						<asp:Repeater id="Repeater4" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="Repeater4_ItemDataBound" >
																							<ItemTemplate>
																								<td><div style="max-width:150px;">
																									<asp:TextBox ID="txtVendorName" runat="server" Width="150" Text='<%# Eval("VendorName") %>'></asp:TextBox>
																									<input type="hidden" name="fromDB" id="fromDB" value='<%# Eval("fromDB") %>' runat="server" />
																								</div></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr>
																						<td>
																							<strong>Accreditation Status</strong>
																						</td>
																						<asp:Repeater id="Repeater100" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="Repeater100_ItemDataBound" >
																							<ItemTemplate>
																								<td>
																									<asp:DropDownList ID="cbAccreditation" runat="server" DataSourceID="dsAccreditation" DataTextField="SupplierTypeDesc" DataValueField="SupplierTypeId" ></asp:DropDownList>
																									<input type="hidden" id="txtAccreditation" name="txtAccreditation" runat="server" value='<%# Eval("Accredited") %>' />
																								</td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr bgcolor="#E4EFF8">
																						<td>
																							<b>Performance Rating</b>
																						</td>
																						<asp:Repeater id="RepeaterPRating" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterPRating_ItemDataBound" >
																							<ItemTemplate>
																								<td>
																									<asp:TextBox ID="txtPRating" runat="server" Width="40"></asp:TextBox>
																								</td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr>
																						<td>Technical Compliance</td>
																						<asp:Repeater id="Repeater5" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="Repeater5_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtTechnical" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr bgcolor="#E4EFF8">
																						<td>Commercial Compliance</td>
																						<asp:Repeater id="Repeater6" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="Repeater6_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtCommercial" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr>
																						<td>Contract Compliance</td>
																						<asp:Repeater id="Repeater7" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="Repeater7_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtContract" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>

																					<tr bgcolor="#E4EFF8" id="tr0">
																						<td><asp:TextBox ID="txtR0" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC0" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC0_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC0" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr id="tr1">
																						<td><asp:TextBox ID="txtR1" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC1" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC1_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC1" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr bgcolor="#E4EFF8" id="tr2">
																						<td><asp:TextBox ID="txtR2" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC2" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC2_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC2" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr id="tr3">
																						<td><asp:TextBox ID="txtR3" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC3" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC3_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC3" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr bgcolor="#E4EFF8" id="tr4">
																						<td><asp:TextBox ID="txtR4" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC4" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC4_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC4" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr id="tr5">
																						<td><asp:TextBox ID="txtR5" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC5" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC5_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC5" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr bgcolor="#E4EFF8" id="tr6">
																						<td><asp:TextBox ID="txtR6" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC6" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC6_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC6" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr id="tr7">
																						<td><asp:TextBox ID="txtR7" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC7" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC7_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC7" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr bgcolor="#E4EFF8" id="tr8">
																						<td><asp:TextBox ID="txtR8" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC8" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC8_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC8" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr id="tr9">
																						<td><asp:TextBox ID="txtR9" runat="server" Width="75"></asp:TextBox></td>
																						<asp:Repeater id="RepeaterC9" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="RepeaterC9_ItemDataBound" >
																							<ItemTemplate>
																								<td><asp:TextBox ID="txtC9" runat="server" Width="75"></asp:TextBox></td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr>
																					<tr style="display:none;">
																						<td><h3 style="border:none; color:#000"></h3></td>
																						<asp:Repeater id="Repeater13" runat="server" DataSourceID="dsBidItemTendersSummary" onitemdatabound="Repeater13_ItemDataBound" >
																							<ItemTemplate>
																								<td bgcolor="#CCCCCC">
																									<asp:CheckBox ID="chkAwarded" runat="server" />
																								</td>
																							</ItemTemplate>
																						</asp:Repeater>
																					</tr></tbody>
																				</table>
																				<table border="0" cellpadding="0" cellspacing="0"><tr>
																					<td align="center">
																						<input type="button" name="btnAddRow" id="btnAddRow" value="Add New Criteria (Row)" onclick="return btnAddRow_onclick();" />
																						<input type="button" name="btnDelRow" id="btnDelRow" value="Remove Last Criteria (Row)" onclick="return btnDelRow_onclick();" />
																						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																						<input type="button" name="btnAddCol" id="btnAddCol" value="Add New Vendor (Column)" onclick="return btnAddCol_onclick();" />
																						<input type="button" name="btnDelCol" id="btnDelCol" value="Remove Last Vendor (Column)" onclick="return btnDelCol_onclick();" />
																					</td>
																				</tr></table>
																			</div>
																			
																		</td>
																	</tr>
																</tbody>
															</table>
															</div>
                                                            <asp:SqlDataSource ID="dsBidItemTendersSummary" runat="server"
																				ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																				SelectCommand="SELECT DISTINCT 1 fromDB, t3.Accredited, t3.VendorName, t3.VendorId, t1.Status
																				FROM tblBidTenders t1 INNER JOIN tblBidItemDetails t2 ON t2.BidDetailNo = t1.BidDetailNo
																				INNER JOIN tblVendors t3 ON t3.VendorId = t1.VendorId INNER JOIN tblBidItems t4 ON t4.BidRefNo = t2.BidRefNo
																				WHERE t2.BidRefNo = @BidRefNo AND t1.Status > 0" onload="dsBidItemTendersSummary_Load" >
																				<SelectParameters>
																					<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																				</SelectParameters>
																			</asp:SqlDataSource>
																			
																			<asp:SqlDataSource ID="dsAccreditation" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																				SelectCommand="SELECT * FROM rfcSupplierType ORDER BY SupplierTypeId" >
																			</asp:SqlDataSource>




															<table width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Table2" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">
																			ITEMS
																		</td>
																	</tr>
																	<tr><td>
																		<asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="False"
																			DataSourceID="dsItems" Width="100%" onrowcommand="gvItems_RowCommand" >
																			<Columns>
																				<asp:TemplateField HeaderText="Item #" HeaderStyle-CssClass="ui-widget-header" >
																					<ItemTemplate>
																						&nbsp;<asp:LinkButton ID="lblItemNo" runat="server" Text='<%# Bind("SKU") %>' CommandArgument='<%# Bind("BidDetailNo") %>' CommandName="AddItemRow"></asp:LinkButton>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Item Details" HeaderStyle-CssClass="ui-widget-header" >
																					<ItemTemplate>
																						&nbsp;<asp:LinkButton ID="lblItemD" runat="server" Text='<%# Bind("ItemName") %>' CommandArgument='<%# Bind("BidDetailNo") %>' CommandName="AddItemRow"></asp:LinkButton>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Remove Item" HeaderStyle-CssClass="ui-widget-header" >
																					<ItemTemplate>
																						&nbsp;<asp:LinkButton ID="lblRemoveItem" runat="server" Text='Remove Item' CommandArgument='<%# Bind("BidDetailNo") %>' CommandName="DelItemRow"></asp:LinkButton>
																					</ItemTemplate>
																				</asp:TemplateField>
																			</Columns>
																		</asp:GridView>
																	</td></tr>
																</tbody>
															</table>
                                                            <asp:SqlDataSource ID="dsItems" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																	SelectCommand="SELECT DISTINCT t2.BidDetailNo, t2.Item SKU, t2.DetailDesc ItemName
																	FROM tblBidTenders t1
																	INNER JOIN tblBidItemDetails t2 ON t2.BidDetailNo = t1.BidDetailNo
																	INNER JOIN tblBidItems t4 ON t4.BidRefNo = t2.BidRefNo
																	WHERE t2.BidRefNo = @BidRefNo AND t1.Status > 0 ORDER BY t2.DetailDesc" >
																	<SelectParameters>
																		<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																	</SelectParameters>
																</asp:SqlDataSource>

															<table width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Table1" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">
																			COMMERCIAL DETAILS
																		</td>
																	</tr>
																	<tr><td>
																		<asp:GridView ID="gvCommDetails" SkinID="BidEvents" runat="server" AllowPaging="False" 
                                                                            AllowSorting="False" AutoGenerateColumns="False"
																			DataKeyNames="BidDetailNo" onrowdatabound="gvCommDetails_RowDataBound" >
																			<Columns>
																				<asp:TemplateField HeaderText="Award" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemStyle HorizontalAlign="Center" Width="35px" />
																					<ItemTemplate>
																						<asp:CheckBox ID="chkAward" runat="server" />
                                                                                        <input id="Chkd" type="hidden" runat="server" value='<%# Bind("Chkd") %>' />
																						<input id="fromDB1" type="hidden" runat="server" value='<%# Bind("fromDB") %>' />
																						<input id="lblBidDetailNo" type="hidden" runat="server" value='<%# Bind("BidDetailNo") %>' />
                                                                                        <input id="lblBidTenderNo" type="hidden" runat="server" value='<%# Bind("BidTenderNo") %>' />
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Vendor Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						<asp:TextBox ID="lblVendorName" runat="server" Width="170" Text='<%# Bind("VendorName") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Item #" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						&nbsp;<asp:TextBox ID="lblItemNo" runat="server" Width="60" Text='<%# Bind("SKU") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Item Details" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						<asp:TextBox ID="lblItemD" runat="server" Width="150" Text='<%# Bind("ItemName") %>' TextMode="MultiLine" Height="55" Font-Names="arial"></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Qty" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						<asp:TextBox ID="lblQty" runat="server" Width="45" Text='<%# Bind("Qty") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Unit" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						&nbsp;<asp:TextBox ID="lblUnit" runat="server" Width="50" Text='<%# Bind("UnitMeasure") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Unit Cost" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						&nbsp;<asp:TextBox ID="lblUnitCost" runat="server" Width="75" Text='<%# Bind("UnitCost") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Total" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						&nbsp;<asp:TextBox ID="lblBidPrice" runat="server" Width="75" Text='<%# Bind("TotalCost") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Currency" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						&nbsp;<asp:TextBox ID="lblCurrenzy" runat="server" Width="35" Text='<%# Bind("Currenzy") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																				<asp:TemplateField HeaderText="Ranking" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
																					<HeaderStyle HorizontalAlign="Center" CssClass="ui-widget-header" />
																					<ItemTemplate>
																						&nbsp;<asp:TextBox ID="txtRanking" runat="server" Width="25" Text='<%# Bind("Ranking") %>'></asp:TextBox>
																					</ItemTemplate>
																				</asp:TemplateField>
																			</Columns>
																		</asp:GridView>
																	</td></tr>
																</tbody>
															</table>
                                                            <asp:SqlDataSource ID="dsBidItemTendersDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																	SelectCommand="SELECT * FROM tblBACEvaluationDetails_tmp WHERE BidRefNo=@BidRefNo" >
																	<SelectParameters>
																		<asp:ControlParameter Name="BidRefNo" ControlID="BuyerBidForBac" PropertyName="SelectedValue" Type="Int32" />
																	</SelectParameters>
																</asp:SqlDataSource>


															<table width="100%" border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails11" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td colspan="4" class="ui-widget-header" style="height:26px; vertical-align:middle;">PURCHASING</td>
																	</tr>
																	<tr valign="middle" >
																		<td width="25%" align="center" valign="middle" style="padding:5px; font-size:12px;">
																			<table width="150" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td>Prepared by / date: <br /><asp:Literal ID="lblPreparedDate" runat="server"></asp:Literal></td>
																				</tr>
																				<tr>
																					<td>&nbsp;</td>
																				</tr>
																				<tr>
																					<td><strong><asp:Literal ID="lblBuyer" runat="server" Text="BUYER"></asp:Literal></strong></td>
																				</tr>
																				<tr>
																					<td style="border-top:2px #000 solid;">Buyer</td>
																				</tr>
																			</table>
																		</td>
																		<td width="25%" align="center" valign="middle" style="padding:5px; font-size:12px;">
																			<table width="150" border="0" cellspacing="0" cellpadding="0">
																				<tr>
																					<td colspan="2">Reviewed by / date: <br />&nbsp;</td>
																				</tr>
																				<tr>
																					<td>
																						<label for="clarify4">Clarify</label>
																						<input name="clarify4" type="checkbox" id="clarify4" disabled="disabled" />
																					</td>
																					<td>
																						<label for="approved4">Approved</label>
																						<input type="checkbox" name="approved4" id="approved4" disabled="disabled" />
																					</td>
																				</tr>
																				<tr>
																					<td colspan="2"><strong><asp:Literal ID="lblApprover4" runat="server" Text="PURCHASING_APPROVER"></asp:Literal></strong></td>
																				</tr>
																				<tr>
																					<td colspan="2" style="border-top:2px #000 solid;">Purchasing Approver</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>

															<table width="100%" border="1" cellpadding="0" cellspacing="0" rules="all"
																class="itemDetails" id="BidTendersAccumulatedCost"
																style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">NATURE OF SAVINGS</td>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">SAVINGS GENERATED</td>
																	</tr>
																	<tr valign="middle" >
																		<td width="50%" align="center">
																			<table width="50%">
																				<tr valign="middle"><td class="style2">
																					<asp:DropDownList ID="cbNatureOfSavings" runat="server"
																						DataSourceID="dsNatureOfSavings" DataTextField="NatureOfSavings"
																						DataValueField="ID" ondatabound="cbNatureOfSavings_DataBound">
																					</asp:DropDownList>
																					<asp:SqlDataSource ID="dsNatureOfSavings" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																						SelectCommand="SELECT * FROM rfcNatureOfSavings ORDER BY ID" >
																					</asp:SqlDataSource>
																				</td></tr>
																				<tr><td class="style2">
																					<asp:TextBox ID="txtNewNatureOfSavings" runat="server" Width="150px"></asp:TextBox>
																					<input id="btnNewNOS" type="button" value="Others" onclick="AddOtherNatureOfSaving();" />
																				</td></tr>
																				<tr><td>
																					<table id="myNatureOfSavings" runat="server"></table>
																				</td></tr>
																			</table>
																		</td>
																		<td align="center" valign="middle" style="padding:5px; font-size:12px;" class="style4">
																			<table style="width: 80%;">
																				<tr>
																					<td class="style5">Accumulated Cost:</td>
																					<td>
                                                                                    <%--<label id="lblAccCost" runat="server">1,524,573.25</label>--%>
                                                                                    <input name="lblAccCost" type="text" id="lblAccCost" size="4" value="0" runat="server"  />
                                                                                    </td>
																				</tr>
																				<tr>
																					<td class="style5">Amount:</td>
																					<td><%--<label id="lblNegDisc" runat="server">2,104,999.35</label>--%>
                                                                                    <input name="lblNegDisc" type="text" id="lblNegDisc" size="4" value="0" runat="server"  /></td>
																				</tr>
																				<tr>
																					<td class="style5">% from Spend:</td>
																					<td><%--<label id="lblPercentSpend" runat="server">11%</label>--%>
                                                                                    <input name="lblPercentSpend" type="text" id="lblPercentSpend" size="4" value="0" runat="server"  /></td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>

															<!--<table width="100%" border="1" cellpadding="0" cellspacing="0" rules="all"
																class="itemDetails" id="Table3"
																style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td colspan="2" class="ui-widget-header" style="height:26px; vertical-align:middle;">CRC No. and PO No.</td>
																	</tr>
																	<tr valign="middle" >
																		<td width="50%" align="center">
																		    <table width="100%">
                                                                                <tr>
                                                                                    <td style="width:45%;">
                                                                                        <table><tr><td><strong>CRC No.</strong></td></tr></table>
                                                                                        <table id="myCRC"></table>
                                                                                    </td>
                                                                                    <td style="width:10%;">&nbsp;</td>
                                                                                    <td style="width:45%;">
                                                                                        <table><tr><td><strong>PO No.</strong></td></tr></table>
                                                                                        <table id="myPO1"></table>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
																		</td>
																		<td align="center" valign="middle" style="padding:5px; font-size:12px;" class="style4">
																			<table border="0" cellpadding="0" cellspacing="1">
                                                                                <tr>
                                                                                    <td>
                                                                                        CRC No.<br />
                                                                                        <asp:TextBox ID="txtNewCRC" runat="server" Width="150px"></asp:TextBox>
																					    <input id="btnewCRC" type="button" value="Add" onclick="AddCRC();" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        PO No.<br />
                                                                                        <asp:TextBox ID="txtNewPO" runat="server" Width="150px"></asp:TextBox>
																					    <input id="btnNewPO" type="button" value="Add" onclick="AddPO();" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
																		</td>
																	</tr>
																</tbody>
															</table>-->

															<table border="1" cellpadding="0" cellspacing="0" rules="all" class="itemDetails" id="Biddetails_details1_dvEventDetails12" style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%; width:100%;">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">BID APPROVING AUTHORITY</td>
																	</tr>
																	<tr valign="middle" >
																		<td width="100" align="center" valign="middle" style="padding:5px; font-size:12px;">
																			<asp:Repeater ID="RepeaterApprover" runat="server" DataSourceID="dsApprover" onitemdatabound="RepeaterApprover_ItemDataBound">
																				<ItemTemplate>
																					<div style="float:left; margin-right:15px; width:150px; padding:10px 20px;">
																						<table width="150px" border="0" cellspacing="0" cellpadding="0">
																							<tr>
																								<td colspan="2">Approved by / date: <br />&nbsp;</td>
																							</tr>
																							<tr>
																								<td><label for="clarify1">Clarify</label>
																									<asp:CheckBox ID="clarify1" runat="server" Enabled="false" />
																								</td>
																								<td><label for="approved1">Approved</label>
																									<asp:CheckBox ID="approved1" runat="server" Enabled="false" />
																								</td>
																							</tr>
																							<tr>
																								<td colspan="2"><strong><%# Eval("Name1") %></strong></td>
																							</tr>
																							<tr>
																								<td colspan="2"><%# String.Format("{0:0,0.00}", Eval("ApprovingMaxLimit")) %></td>
																							</tr>
																							<tr>
																								<td colspan="2" style="border-top:2px #000 solid;"><asp:Literal ID="lblApprover" runat="server" Text="APPROVER"></asp:Literal></td>
																							</tr>
																						</table>
																					</div>
																				</ItemTemplate>
																			</asp:Repeater>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
                                                    </tr>
                                                    <tr>
														<td>
															<asp:SqlDataSource ID="dsApprover" runat="server"
																ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
																SelectCommand="SELECT t1.BACId, t1.LastName + ', ' + t1.FirstName + ' ' + t1.MiddleName AS Name1, t1.ApprovingMaxLimit
                                                                FROM tblBidAwardingCommittee t1
                                                                JOIN tblUsers t2 ON (t1.BACId=t2.UserId AND t2.IsAuthenticated=1)
                                                                ORDER BY t1.ApprovingMaxLimit ASC" >
															</asp:SqlDataSource>
														</td>
													</tr>
                                                    <tr>
														<td colspan="2" valign="top" align="right">
														</td>
                                                    </tr>
                                                </table>
												<br />
												
                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" id="actions">
                                                    <tr>
                                                        <td align="right">
                                                            <input id="btnDraft" type="button" value="Draft" onclick="document.getElementById('status').value=0; document.getElementById('form1').submit();" />
                                                            <input id="btnEndorse" type="button" value="Endorse"onclick="document.getElementById('status').value=1; document.getElementById('form1').submit();" />
                                                            <input id="btnCancel" type="button" value="Cancel" onclick="history.back();" />
                                                        </td>
                                                    </tr>
												</table>
                                                <br />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
							
						</table>
                    </td>
                </tr>
                <tr>
					<td id="footer" height="50px">
						<EBid:Footer runat="server" ID="Footer1" />
					</td>
				</tr>
            </table>
            <input type="hidden" name="status" id="status" runat="server" />
        </form>
    </div>
</body>
</html>
<script type="text/javascript">
    HideCriteria();
    if ($("#lblLoad").val() == "true") {
        ClearSavedCookies();
    }
    ShowSavedCookies();
    ShowNewRowsOnLoad();
    ComputeAccCost();
</script>