<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

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
        }
        .table>tbody>tr>td
        {
            padding: 8px 0px !important;
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
        var Head, AccNo, Profitcenter, Cost = '';
        var flagLevel3 = false;
        $(function () {


            $.ajax({
                type: 'GET',
                url: 'http://localhost:51340/Default.aspx/GetDetails',

                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var table = $("#tblannualbudget tbody");
                    var html = '';
                    $.each(data.d, function (i) {
                        var input = data.d[i].Head;
                        var trid = 'id_' + i
                        if (data.d[i].Group == 'NEWF2') {
                            html += "<tr id='" + trid + "' style='color: blue;font-weight: bold;' class='section'><td>" + data.d[i].Head + "<span onclick='update(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><td>" + data.d[i].Total + "</td></tr>";
                        }
                        else if (data.d[i].Group == 'NEWF3') {
                            html += "<tr id='" + trid + "' style='color: red;font-weight: bold;'><td>" + data.d[i].Head + "<span onclick='update(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><td>" + data.d[i].Total + "</td></tr>";
                        }
                        else {
                            html += "<tr  id='" + trid + "' style='font-weight: bold;'><td>" + data.d[i].Head + "<span onclick='update(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><td>" + data.d[i].Total + "</td></tr>";
                        }

                    });
                    console.log(data.d);
                    table.append(html);
                },
                error: function (data) {

                }
            });
        });

        function update(id, item) {
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
                    var accobj = getfirstleveldetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table>"

                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td style='width:5%!important;'>" + data.AccountNumber + "<span onclick='update1(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#id_' + id).find('td:first').after('<td>' + html + '</td>');
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#id_' + id).find('td:last').removeClass('show').addClass('hide');

                    $('#thheadtotal').html("");
                    $('#thheadtotal').html("Acc/No" + "<span style='margin-left: 410px;'>Total</span>");
                }
                else {
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table>";
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td>" + data.AccountNumber + "<span onclick='update1(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#id_' + id).find('td:first').after('<td>' + html + '</td>');
                    $('#id_' + id).find('td:last').removeClass('show').addClass('hide');

                }
            }
            else {
                $('#id_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

                $('#id_' + id).find('td:first').next().addClass('hide');
                $('#id_' + id).find('td:last').removeClass('hide').addClass('show');
                $('#thheadtotal').html("<span>Total</span>");

                flag = false;
            }
        }

        function getfirstleveldetails(id, item) {
            Head = item;
            var accobjlist = null;
            $.ajax({
                type: "POST",
                url: '/Default.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account: '',Profit: '',Cost: '',level: '" + 1 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }

        function update1(id, item) {
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
                    var accobj = getsecondleveldetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table id='profit_" + id + "'>"
                        totalhtml = "<table id='profittoal_" + id + "'>";

                        //Creating Table With Dynamic Value For Total And Profit Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='secondlevel_" + dynID + "'><td>" + data.AccountNumber + "<span onclick='update2(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Total + "</td></tr>";


                        });
                        html += '</table>';
                    }

                    //$('#firstLevel_' + id).find('td:last').html('<td>' + html + '</td>')
                    $('#firstLevel_' + id).find('td:last').html(html);

                    //$.each($("[id^=firstLevel_]"), function (i, data) {
                    //    debugger;
                    //    if (data.id != "firstLevel_" + id)
                    //    {
                    //        $(data).find("td:last").html("<table><tr><td>&nbsp</td></tr></table>")
                    //    }
                    //});

                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //$('#firstLevel_' + id).find('td:last').removeClass('show').addClass('hide');
                    $('#thheadtotal').html("");
                    $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 410px;'>Profit Center</span>" + "<span style='margin-left: 146px;'>Total</span>");
                }

                else {

                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondleveldetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table id='profit_" + id + "'>"
                        totalhtml = "<table id='profittoal_" + id + "'>";

                        //Creating Table With Dynamic Value For Total And Profit Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='secondlevel_" + dynID + "'><td>" + data.AccountNumber + "<span onclick='update2(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }

                    //Taking Parent Id For Appending Dynamically Generated Table For ProfitCenters
                    $('#firstLevel_' + id).find('td:last').html(html);

                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //$('#firstLevel_' + id).find('td:last').removeClass('show').addClass('hide');
                }
            }
            else {
                $('#firstLevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                var total = 0;
                var objrow = $("#firstLevel_" + id).find('tr');
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    total = total + parseInt($(obj).find('td:last').html());
                }
                $('#firstLevel_' + id).find('table').html("")
                $('#firstLevel_' + id).find('td:last').html(total);
               // $('#thheadtotal').html("<span>Acc/No</span>" + "<span>Total</span>");
                $('#thheadtotal').html("Acc/No" + "<span style='margin-left: 410px;'>Total</span>");
                flagLevel1 = false;

            }
        }

        function getsecondleveldetails(id, item) {
            var accobjlist = null;
            AccNo = item;
            $.ajax({
                type: "POST",
                url: '/Default.aspx/SubgridData',
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

        function update2(id, item) {
            debugger;
            if ($('#secondlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel2 == false) {
                    flagLevel2 = true;

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getthirdleveldetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table id='cost_" + id + "'>"

                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td>" + data.AccountNumber + "<span onclick='update3(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Total + "</td></tr>";


                        });
                        html += '</table>';
                    }



                    //$('#secondlevel_' + id).find('td:last').html('<td>' + html + '</td>');
                    $('#secondlevel_' + id).find('td:last').html(html);

                    $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 410px;'>Profit Center</span>" + "<span style='margin-left: 146px;'>Cost Center</span>" + "<span style='margin-left: 35px;'>Total</span>");

                }
                else {

                    var accobj = getthirdleveldetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table id='cost_" + id + "'>"


                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td>" + data.AccountNumber + "<span onclick='update3(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Total + "</td></tr>";


                        });
                        html += '</table>';
                        //$('#secondlevel_' + id).find('td:last').html('<td>' + html + '</td>');
                        $('#secondlevel_' + id).find('td:last').html(html);

                        $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }



                }
            }
            else {
                $('#secondlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

                var total = 0;
                var objrow = $("#secondlevel_" + id).find('tr');
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    total = total + parseInt($(obj).find('td:last').html());
                }
                $('#secondlevel_' + id).find('table').html("")
                $('#secondlevel_' + id).find('td:last').html(total);
               // $('#thheadtotal').html("<span>Acc/No</span>" + "<span>Profit Center</span>" + "<span>Total</span>");
                $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 410px;'>Profit Center</span>" + "<span style='margin-left: 146px;'>Total</span>");
                flagLevel2 = false;

            }
        }





        function update3(id, item) {
            debugger;
            if ($('#thirdlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel3 == false) {
                    flagLevel3 = true;

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfourthleveldetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table id='order_" + id + "'>"

                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='fourthlevel_" + dynID + "'><td>" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";


                        });
                        html += '</table>';
                    }

                    else {
                        html = "<table id='order_nan'>"

                        html += "<tr id='fourthlevel_nan' ><td>0</td><td>0</td></tr>";


                        html += '</table>';
                    }



                    $('#thirdlevel_' + id).find('td:last').html( html );

                    $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 410px;'>Profit Center</span>" + "<span style='margin-left: 127px;'>Cost Center</span>" + "<span style='margin-left: 18px;'>Order Number</span>" + "<span style='margin-left: 5px;'>Total</span>");

                }
                else {

                    var accobj = getfourthleveldetails(id, item);
                    if (accobj.length > 0) {

                        html = "<table id='order_" + id + "'>"

                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='fourthlevel_" + dynID + "'><td>" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";


                        });
                        html += '</table>';
                        $('#thirdlevel_' + id).find('td:last').html(html);

                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                    else {
                        html = "<table id='order_nan'>"

                        html += "<tr id='fourthlevel_nan' ><td>0</td><td>0</td></tr>";


                        html += '</table>';
                        $('#thirdlevel_' + id).find('td:last').html(html);

                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }



                }
            }
            else {
                $('#thirdlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

                var total = 0;
                var objrow = $("#thirdlevel_" + id).find('tr');
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    total = total + parseInt($(obj).find('td:last').html());
                }
                $('#thirdlevel_' + id).find('table').html("")
                $('#thirdlevel_' + id).find('td:last').html(total);
                // $('#thheadtotal').html("<span>Acc/No</span>" + "<span>Profit Center</span>" + "<span>Cost Center</span>" + "<span>Total</span>");
                $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 410px;'>Profit Center</span>" + "<span style='margin-left: 146px;'>Cost Center</span>" + "<span style='margin-left: 35px;'>Total</span>");
                flagLevel3 = false;

            }
        }

        function getthirdleveldetails(id, item) {
            var accobjlist = null;
            Profitcenter = item;
            $.ajax({
                type: "POST",
                url: '/Default.aspx/SubgridData',
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

        function getfourthleveldetails(id, item) {
            var accobjlist = null;
            costcenter = item;
            $.ajax({
                type: "POST",
                url: '/Default.aspx/SubgridData',
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
             <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover no-margin tab-blk tab_cls"  id="tblannualbudget" >
                        <thead>
                            <tr>
                                 <th id="thheading" style="width:30%">Head</th>
                         <%--       <th>
                                    <table>
                                        <thead>
                                    <th id="thheading">Head</th>
                                    <th id="thaccountno">AccNo</th>
                                    <th id="profitcenter">ProfitCenter</th>
                                   
                                            </thead>
                                    </table>
                                </th> --%>                             
                                <th id="thheadtotal" style="width:70%">Total</th>
                            </tr>                        

                        </thead>
                        <tbody>

                        </tbody>
                    </table>


                </div>

          </form>
</body>
</html>
