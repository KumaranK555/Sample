<%@ Page Language="C#" AutoEventWireup="true" CodeFile="trendopex.aspx.cs" Inherits="trendopex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .Grid td
        {
            /*background-color: #A1DCF2;*/
            /*color: black;*/
            font-size: 10pt;
            line-height: 200%;
        }
        .Grid th
        {
            background-color: #3AC0F2;
            color: White;
            font-size: 10pt;
            line-height: 200%;
        }
        .ChildGrid td
        {
            background-color: #eee !important;
            color: black;
            font-size: 10pt;
            line-height: 200%;
        }
        .ChildGrid th
        {
            background-color: #6C6C6C !important;
            color: White;
            font-size: 10pt;
            line-height: 200%;
        }
        .Nested_ChildGrid td
        {
            background-color: #fff !important;
            color: black;
            font-size: 10pt;
            line-height: 200%;
        }
        .Nested_ChildGrid th
        {
            background-color: #2B579A !important;
            color: White;
            font-size: 10pt;
            line-height: 200%;
        }
        .heightdiv
        {
            height: 260px !important;
        }
        .hide
        {
            display:none;
        }
        .show
        {
            display:block;
        }

        .tdclass
        {

        }
        tr td table,tr td table tr, tr td table tr td table, tr td table tr, tr td table tr td table tr td table
        {
            width: 100% !important;
             
        }
        tr td table tr td
        {
            width: 25% !important;      
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;     
            vertical-align: top;
            padding: 0px 3px;
        }
        .table>tbody>tr>td
        {
            padding: 0px 0px !important;
        }
        table.update2>tbody>tr>td, table.update3>tbody>tr>td
        {
            border-bottom: 1px solid transparent;
        }
        table.update2>tbody>tr>td:last-child,table.update3>tbody>tr>td:last-child
        {
            border-right: 1px solid transparent;
        }
        table.update>tbody>tr>td:first-child
        {
            width: 2% !important;
        }
        table.update1>tbody>tr>td:first-child
        {
            width: 5% !important;
        }
        table.update2>tbody>tr>td:first-child
        {
            width: 7% !important;            
        }
        table.update3>tbody>tr>td:first-child
        {
            width: 12% !important;            
        }
        .table-bordered>tbody>tr>td
        {
            border: 1px solid transparent;
        }
    </style>
    <link href="bootstrap.min.css" rel="stylesheet" />
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" />
  
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        var flag = false;
        var openflag = false;

        var flagLevel1 = false; // To Check Whether Need To Add Dynami Column Or Not.
        var flagLevel2 = false;
        var Head, AccNo, Profitcenter, Glname, Cost = '';
        var flagLevel3 = false;
        var month = '';
        $(function () {


            $.ajax({
                type: 'GET',
                url: 'http://localhost:52658/trendopex.aspx/GetDetails',
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    debugger;
                    var table = $("#tblTrent3OPEX tbody");
                    var html = '';
                    $.each(response.d, function (i) {

                        var input = response.d[i].Head;
                        var trid = 'id_' + i
                        var data = response.d[i];

                        if (response.d[i].Group == 'NEWF2') {
                            html += "<tr id=" + trid + " style='color: blue;font-weight:bold' class='section'><td>" + data.Head + "<span onclick='updatetrendaccno(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td><tr>";
                        }
                        else if (response.d[i].Group == 'NEWF3' && response.d[i].flag == 'false') {
                            html += "<tr id=" + trid + " style='color: red;font-weight:bold' class='section'><td>" + data.Head + "<span onclick='updatetrendaccno(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td><tr>";
                        }
                        else {
                            html += "<tr id=" + trid + "  style='font-weight:bold' class='section'><td>" + data.Head + "<span onclick='updatetrendaccno(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td><tr>";
                        }

                    });

                    $("#thheadingtrendopex").html("<td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");

                  
                    table.append(html);

                },
                error: function (data) {
                    debugger;
                }
            });
        });


        function updatetrendaccno(id, item) {
            debugger;
            //To Determine Whether Expand/Collapse Function By Checking The Status Of Button As Plus/Minus
            if ($('#id_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {

                //Checking With Flag As To Add Column And Append value Or Just To Append Value
                if (flag == false) {
                    flag = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';

                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstleveltrenddetails(id, item);

                    if (accobj.length > 0) {
                        debugger;
                        html = "<table class='update'>"

                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            debugger;
                            var input = data.Head;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            //html += "<tr id='firstLevel_" + dynID + "'><td>" + data.Head + "<span onclick='updatetrendprofitcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                            html += "<tr id='firstLevel_" + dynID + "'><td>" + data.Head + "<span onclick='updatetrendprofitcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                   
                    $('#id_' + id).find('td:first').next().html(html);

                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                  

                    $('#thheadingtrendopex').html("");
                    $("#thheadingtrendopex").html("<td>AccNo</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                }
                else {
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update'>";
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.Head;
                            var dynID = id.toString() + i.toString();
                          
                            html += "<tr id='firstLevel_" + dynID + "'><td>" + data.Head + "<span onclick='updatetrendprofitcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                   
                    $('#id_' + id).find('td:first').next().html(html);
                 

                }
            }
            else {
                $('#id_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                var budget = 0;
                var actual = 0;
                var jobwork = 0;
                var adjustedactual = 0;
                var variance = 0;
                var html = '';
                var objrow = $('#id_' + id).find('td:first').next().find('.update').find('table').find('tr');
                html = '<table>';
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());
                   
                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + jobwork + "</td><td>" + adjustedactual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";
                $('#id_' + id).find('td:first').next().html( html );
                $("#thheadingtrendopex").html("<td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");

                flag = false;
            }
        }

        function updatetrendprofitcenter(id, item) {
            debugger;
            //To Determine Whether Expand/Collapse Function By Checking The Status Of Button As Plus/Minus
            if ($('#firstLevel_' + id).find('td:first').find('i').hasClass('fa-minus-circle') == false) {

                //Setting Head Value For Fetching Data
                Head = $('#firstLevel_' + id).parent().parent().parent().parent().children(":eq(0)").text();

                //Checking With Flag As To Add Column And Append value Or Just To Append Value
                if (flagLevel1 == false) {

                    flagLevel1 = true;

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';

                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondleveltrenddetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table class='update1' id='profit_" + id + "'>"
                        totalhtml = "<table id='profittoal_" + id + "'>";

                        //Creating Table With Dynamic Value For Total And Profit Column 
                        $.each(accobj, function (i, data) {
                            var input = data.Head;
                            var dynID = id.toString() + i.toString();
                            if (data.Head == "") {
                                data.Head = 0;
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }

                            if (data.Actual == "") {
                                data.Actual = 0;
                            }

                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.JobWork == "") {
                                data.JobWork = 0;
                            }

                            if (data.AdjustedActual == "") {
                                data.AdjustedActual = 0;
                            }


                            if (data.Variance == "") {
                                data.Variance = 0;
                            }

                            html += "<tr id='secondlevel_" + dynID + "'><td>" + data.Head + "<span onclick='updatecostcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";


                        });
                        html += '</table>';
                    }

                    $('#firstLevel_' + id).find('table').remove();
                    $('#firstLevel_' + id).find('td:last').html(html);

                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //$('#firstLevel_' + id).find('td:last').removeClass('show').addClass('hide');
                    $('#thheadingtrendopex').html("");
                    $("#thheadingtrendopex").html("<td>AccNo</td><td>Profit Center</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                }

                else {

                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondleveltrenddetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table class='update1' id='profit_" + id + "'>"
                        

                        //Creating Table With Dynamic Value For Total And Profit Column 
                        $.each(accobj, function (i, data) {
                            var input = data.Head;
                            var dynID = id.toString() + i.toString();
                            if (data.Head == "") {
                                data.Head = 0;
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }

                            if (data.Actual == "") {
                                data.Actual = 0;
                            }

                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.JobWork == "") {
                                data.JobWork = 0;
                            }

                            if (data.AdjustedActual == "") {
                                data.AdjustedActual = 0;
                            }
                            html += "<tr id='secondlevel_" + dynID + "'><td>" + data.Head + "<span onclick='updatecostcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";


                        });
                        html += '</table>';
                    }

                    //Taking Parent Id For Appending Dynamically Generated Table For ProfitCenters
                    $('#firstLevel_' + id).find('table').remove();
                    $('#firstLevel_' + id).find('td:last').html(html);

                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //$('#firstLevel_' + id).find('td:last').removeClass('show').addClass('hide');
                }
            }
            else {
                $('#firstLevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

                var budget = 0;
                var actual = 0;
                var jobwork = 0;
                var adjustedactual = 0;
                var variance = 0;
                var html = '';
             
                var objrow = $("#firstLevel_" + id).find('.update1').find('table').find('tr');
                html = '<table>';
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());

                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + jobwork + "</td><td>" + adjustedactual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";

                $('#firstLevel_' + id).find('table').remove();
                $('#firstLevel_' + id).find('td:last').html(html);
               
                $("#thheadingtrendopex").html("<td>AccNo</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                flagLevel1 = false;

            }
        }

        function updatecostcenter(id, item) {
            debugger;
            if ($('#secondlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel2 == false) {
                    flagLevel2 = true;

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getthirdleveltrenddetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table class='update2' id='cost_" + id + "'>"

                        $.each(accobj, function (i, data) {
                            var input = data.Head;
                            var dynID = id.toString() + i.toString();
                            if (data.Head == "") {
                                data.Head = 0;
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }

                            if (data.Actual == "") {
                                data.Actual = 0;
                            }

                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.JobWork == "") {
                                data.JobWork = 0;
                            }

                            if (data.AdjustedActual == "") {
                                data.AdjustedActual = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td>" + data.Head + "<span onclick='updateordernumber(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";


                        });
                        html += '</table>';
                    }



                    $('#secondlevel_' + id).find('table').remove();
                    $('#secondlevel_' + id).find('td:last').html(html);
                   

                    $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $("#thheadingtrendopex").html("<td>AccNo</td><td>Profit Center</td><td>Cost Center</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");

                }
                else {

                    var accobj = getthirdleveltrenddetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table class='update2' id='cost_" + id + "'>"

                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.Head == "") {
                                data.Head = 0;
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }

                            if (data.Actual == "") {
                                data.Actual = 0;
                            }

                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.JobWork == "") {
                                data.JobWork = 0;
                            }

                            if (data.AdjustedActual == "") {
                                data.AdjustedActual = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td>" + data.Head + "<span onclick='updateordernumber(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                       
                        $('#secondlevel_' + id).find('table').remove();
                        $('#secondlevel_' + id).find('td:last').html(html);

                        $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                }
            }
            else {
                $('#secondlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

                var budget = 0;
                var actual = 0;
                var jobwork = 0;
                var adjustedactual = 0;
                var variance = 0;
                var html = '';

                var objrow = $("#secondlevel_" + id).find('.update2').find('table').find('tr');
                html = '<table>';
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());

                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + jobwork + "</td><td>" + adjustedactual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";
             
                $('#secondlevel_' + id).find('table').remove()
                $('#secondlevel_' + id).find('td:last').html(html);
               
                $("#thheadingtrendopex").html("<td>AccNo</td><td>Profit Center</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                flagLevel2 = false;

            }
        }


        function updateordernumber(id, item) {
            debugger;
            if ($('#thirdlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel3 == false) {
                    flagLevel3 = true;

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfourthleveltrenddetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table class='update3' id='order_" + id + "'>"

                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.Head;
                            if (data.Head == "") {
                                data.Head = 0;
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }

                            if (data.Actual == "") {
                                data.Actual = 0;
                            }

                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.JobWork == "") {
                                data.JobWork = 0;
                            }

                            if (data.AdjustedActual == "") {
                                data.AdjustedActual = 0;
                            }
                            //html += "<tr id='fourthlevel_" + dynID + "'><td>" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                            html += "<tr id='fourthlevel_" + dynID + "'><td>" + data.Head + "</td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }

                    else {
                        html = "<table class='update3' id='order_nan'>"

                        html += "<tr id='fourthlevel_nan' ><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>";


                        html += '</table>';
                    }

                   
                    $('#thirdlevel_' + id).find('table').remove();
                    $('#thirdlevel_' + id).find('td:last').html(html);

                    $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $("#thheadingtrendopex").html("<td>AccNo</td><td>Profit Center</td><td>Cost Center</td><td>Order Number</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");

                }
                else {

                    var accobj = getfourthleveltrenddetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table class='update3' id='order_" + id + "'>"

                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            if (data.Head == "") {
                                data.Head = 0;
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }

                            if (data.Actual == "") {
                                data.Actual = 0;
                            }

                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.JobWork == "") {
                                data.JobWork = 0;
                            }

                            if (data.AdjustedActual == "") {
                                data.AdjustedActual = 0;
                            }
                            html += "<tr id='fourthlevel_" + dynID + "'><td>" + data.Head + "</td><td><table><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";


                        });
                        html += '</table>';
                        $('#thirdlevel_' + id).find('table').remove();
                        $('#thirdlevel_' + id).find('td:last').html(html);

                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                    else {
                        html = "<table class='update3' id='order_nan'>"

                        html += "<tr id='fourthlevel_nan' ><td>0</td><td>0</td></tr>";


                        html += '</table>';
                        $('#thirdlevel_' + id).find('td:last').html(html);

                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }



                }
            }
            else {
                $('#thirdlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

            

                var budget = 0;
                var actual = 0;
                var jobwork = 0;
                var adjustedactual = 0;
                var variance = 0;
                var html = '';

                var objrow = $("#thirdlevel_" + id).find('.update3').find('table').find('tr');
                html = '<table>';
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());

                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + jobwork + "</td><td>" + adjustedactual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";

                $('#thirdlevel_' + id).find('table').remove()
                $('#thirdlevel_' + id).find('td:last').html(html);
                $("#thheadingtrendopex").html("<td>AccNo</td><td>Profit Center</td><td>Cost Center</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                flagLevel3 = false;

            }
        }

        function getfirstleveltrenddetails(id, item) {
            Head = item;
            var accobjlist = null;
            $.ajax({
                type: "POST",
                url: '/trendopex.aspx/SubgridData',
                data: "{Head: '" + Head + "',Glname:'',Account: '',Profit: '',Cost: '',level: '" + 1 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }


        function getsecondleveltrenddetails(id, item) {
            var accobjlist = null;
            AccNo = item;
            $.ajax({
                type: "POST",
                url: '/trendopex.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account: '" + AccNo + "',Profit: '',Cost: '',level: '" + 2 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }


        function getthirdleveltrenddetails(id, item) {
            var accobjlist = null;
            Profitcenter = item;
            $.ajax({
                type: "POST",
                url: '/trendopex.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '',level: '" + 3 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }


        function getfourthleveltrenddetails(id, item) {
            var accobjlist = null;
            costcenter = item;
            $.ajax({
                type: "POST",
                url: '/trendopex.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '" + costcenter + "',level: '" + 4 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }

        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table class="table table-striped table-bordered table-hover no-margin tab-blk tab_cls"  id="tblTrent3OPEX" >
                        <thead>
                            <tr>
                                <th>Head</th>
                                <th id="thheadingtrendopex"></th>
                              
                                
                            </tr>                        

                        </thead>
                        <tbody>

                        </tbody>
                    </table>
    </div>
    </form>
</body>
</html>
