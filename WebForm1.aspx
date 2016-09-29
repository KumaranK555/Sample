<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="WebForm1.aspx.cs" Inherits="DBCLWebReports1.WebForm1" %>


<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
   <style type="text/css">
       .heightdiv
       {
           height:260px;
       }
       table
       {
           border-collapse:collapse; 
       }
       table, th, td
       {
            border: 1px solid black;   
       }
   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <%--<asp:ScriptManager ID="scriptmanager1" AsyncPostBackTimeout = "360000" runat="server"></asp:ScriptManager>--%>
    <form id="Form1" runat="server">
    <div class="app-content-body ">
        <div class="bg-light lter b-b wrapper-md">
            <h1 class="m-n font-thin h3">
                Production Planning Report</h1>
        </div>
        <div class="wrapper-md">
            <div class="panel panel-default">
               
                <div class="panel-heading" style="color: #09F" runat="server" id="divTitle">
                </div>
                <telerik:RadScriptManager AsyncPostBackTimeout="360000" runat="server" ID="RadScriptManager1" />
             

                <div class="slimscroll1" style="width: 100%; overflow: auto;">
                   <table class="table table-striped table-bordered table-hover no-margin" id="tblannualbudget">
                   <thead>
                   <th>Head</th>
                   <th>Months</th>
                   <th>Budget</th>
                   </thead>
                   <tbody>
                   </tbody>
                   </table>
                </div>
                <asp:Panel ID="ContentPanel" runat="server">
                </asp:Panel>
               
            </div>
        </div>
    </div>
   
    </form>
 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript">
        $(function () {
            $(".slimscroll1").slimScroll({
                height: '410px'
            });
          
        });
    </script>
    <script type="text/javascript">
    var QueryId = "201";
    var QueryCondition = "OPEX";
    var Report = "Actuals";
    var flag = false;
    var flagLevel1 = false;
    var flagLevel2 = false;
    var openflag = false;
    //var accobjlist = '';
    var AccNo, Head, Profit = ''; 
    $(document).ready(function () {
        debugger;
        if (Report == "adhoc") {
        }
        else if (Report == "Pages") {

        }
        else if (Report == "Wastage") {

        }
        else if (Report == "OPEX" || Report == "MIS" || Report == "Actuals" || Report == "Trend") {
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/RequestData',
                data: "{id: '" + QueryId + "',condition: '" + QueryCondition + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    var table = $("#tblannualbudget tbody");
                    var html = "";
                    $.each(response.d, function (i,data) {
                        var input = response.d[i].Head;
                        var trid = 'id_' + i;
                        if (response.d[i].Group == 'NEWF2') {
                            html += "<tr id='" + trid + "' style='font-weight:bold'><td>" + data.Head + "<span onclick='update(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Months + "</td><td>" + data.Total + "</td></tr>";
                        }
                        else if (response.d[i].Group == 'NEWF3' && response.d[i].flag == 'false') {
                            html += "<tr id='" + trid + "' style='font-weight:bold'><td>" + data.Head + "<span onclick='update(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Months + "</td><td>" + data.Total + "</td></tr>";
                        }
                        else {
                            html += "<tr id='" + trid + "' style='font-weight:bold'><td>" + data.Head + "<span onclick='update(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td><td>" + data.Months + "</td><td>" + data.Total + "</td></tr>";
                        }
                    });
                    table.append(html);
                },
                error: function (response) {

                }
            });
        }
        else {

        }
    });

        function GetParameterValues(param) {
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (urlparam[0] == param) {
                    return urlparam[1];
                }
            }
        }


        function update(id, item) {
            debugger;
            if ($('#id_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
            //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flag == false) {
                    flag = true;
                    $('#tblannualbudget tr').children(":eq(0)").after($("<th>"));
                    $('#tblannualbudget tr').children(":eq(0)").next().html('Acc No');
                    $('#tblannualbudget tbody tr').each(function () {
                        //$('#tblfeeds tr').children(":eq(0)").append($("<td>"));
                        $(this).children(":eq(0)").after($("<td>"));
                    });
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfirstleveldetails(id, item);
                    //$('#id_' + id).attr('rowspan', accobj.length);
                    if (accobj.length > 0) {
                        html = "<table>"
                        totalhtml = "<table>";
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            html += "<tr id='firstLevel" + i + "'><td>" + data.AccountNumber + "<span onclick='update1(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td></tr>";
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            totalhtml += "<tr id='firstLevelTotal" + i + "'><td>" + data.Total + "</td></tr>";
                        });
                    }
                    $('#id_' + id).addClass('heightdiv');
                    $('#firstLevelTotal' + id).addClass('heightdiv');
                    // var html = "<table><tr><td>1233<span onclick='update1(0,3434)'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>1234<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><tr></tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr></table>";
                    $('#id_' + id).children(":eq(1)").append(html)
                    //$('#id_' + id).find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#id_' + id).find('td:first').children().children().removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    var html1 = $('#id_' + id).children(":eq(3)").html();
                    $('#id_' + id).children(":eq(3)").html("");
                    // var totalhtml = "<table><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr></table>";
                    var total = '';
                    if (accobj.length == 1) {
                        total = totalhtml + "</table><div style=display:none;>" + html1 + "</div>";
                    }
                    else {
                        total = totalhtml + "</table><div>" + html1 + "</div>";
                    }
                    $('#id_' + id).children(":eq(3)").html(total);
                }
                else {
                    //var htl = "<table><tr><td>1233<span onclick='update1(0,3434)'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>1234<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td><tr></tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr><tr><td>6789<span><i class='fa fa-plus-circle' aria-hidden='true' ></i></span></td></tr></table>";
                    var accobj = getfirstleveldetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table>"
                        totalhtml = "<table>";
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            html += "<tr id='firstLevel" + i + "'><td>" + data.AccountNumber + "<span onclick='update1(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td></tr>";
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            totalhtml += "<tr id='firstLevelTotal" + i + "'><td>" + data.Total + "</td></tr>";
                        });
                    }
                    $('#id_' + id).children(":eq(1)").append(html)
                    $('#id_' + id).addClass('heightdiv');
                    $('#firstLevelTotal' + id).addClass('heightdiv');
                   // $('#id_' + id).find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#id_' + id).find('td:first').children().children().removeClass('fa-plus-circle').addClass('fa-minus-circle');

                    var html1 = $('#id_' + id).children(":eq(3)").html();
                    $('#id_' + id).children(":eq(3)").html("");
                    // var totalhtml = "<table><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr><tr><td>0</td></tr></table>";
                    var total = '';
                    if (accobj.length == 1) {
                        total = totalhtml + "</table><div style=display:none;>" + html1 + "</div>";
                    }
                    else {
                         total = totalhtml + "</table><div>" + html1 + "</div>";
                    }
                    $('#id_' + id).children(":eq(3)").html(total);
                }
            }
            else {
                $('#id_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                $('#id_' + id).removeClass('heightdiv');
                $('#id_' + id).find('table').html("");
                $('#id_' + id).find('div').css('display', 'block');
                // $('#tblfeeds tr').children(":eq(1)").remove();

                //$('#tblfeeds tbody tr').each(function () {

                //    $(this).children(":eq(1)").remove();

                //});
                if ($('#tblannualbudget tr').find('i').hasClass("fa-minus-circle") == false) {
                    $('#tblannualbudget tr').children(":eq(1)").remove();
                    $('#tblannualbudget tbody tr').each(function () {

                        //$('#tblfeeds tr').children(":eq(0)").append($("<td>"));
                        $(this).children(":eq(1)").remove();
                    });
                    flag = false;
                }
            }
        }

        function getfirstleveldetails(id, item) {
            Head = item;
            var accobjlist = null;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account: '',Profit: '',Cost: '',level: '" + 1 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    debugger;
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }

        function update1(id, item) {
            debugger;
            if ($('#firstLevel' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel1 == false) {
                    flagLevel1 = true;
                    $('#tblannualbudget tr').children(":eq(1)").after($("<td>"));
                    $('#tblannualbudget tr').children(":eq(1)").next().html('Profit Center');
                    $('#tblannualbudget tbody tr').each(function () {
                        //$('#tblfeeds tr').children(":eq(0)").append($("<td>"));
                        $(this).children(":eq(1)").after($("<td>"));
                    });

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getsecondleveldetails(id, item);
                    if (accobj.length > 0) {
                        //.addClass('heightdiv')
                        html = "<table>"
                        totalhtml = "<table>";

                        if (id > 0) {
                            for (var i = 0; i < id; i++) {
                                html += "<tr><td>-</td></tr>";
                            }
                        }

                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            html += "<tr id='secondlevel_"+ i +"'><td>" + data.AccountNumber + "<span onclick='update2(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td></tr>";
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            totalhtml += "<tr id='secondLevelTotal" + i + "'><td>" + data.Total + "</td></tr>";
                        });
                    }
                    var Parentid = $('#firstLevel' + id).parent().parent().parent().parent().attr('id');

                    //$('#firstLevel' + id).addClass('heightdiv');
                    //$('#firstLevelTotal' + id).addClass('heightdiv');
                    $('#' + Parentid).children(":eq(2)").append(html);

                    var dynHeight = $('#' + Parentid).children(":eq(2)").height();
                    $('#firstLevel' + id).css('height',dynHeight);
                    $('#firstLevelTotal' + id).css('height',dynHeight);

                    $('#firstLevel' + id).find('td:first').children().children().removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    var html1 = $('#id_' + id).children(":eq(3)").html();
                    $('#firstLevel' + id).children(":eq(3)").html("");
                    var total = '';
                    if (accobj.length == 1) {
                        total = totalhtml + "</table><div style=display:none;>" + html1 + "</div>";
                    }
                    else {
                        //total = totalhtml + "</table><div>" + html1 + "</div>";
                        total = totalhtml + "</table>";
                    }
                    //$('#firstLevel' + id).children(":eq(2)").html(total);
                    $('#firstLevelTotal' + id).empty().append(total);

                }
                else {
                    var Parentid = $('#firstLevel' + id).parent().parent().parent().parent().attr('id');
                    var dynHeight = $('#' + Parentid).children(":eq(2)").height();
                    $('#firstLevel' + id).css('height', dynHeight);
                    $('#firstLevelTotal' + id).css('height', dynHeight);
                    var marginTop = dynHeight / 2;
                    var accobj = getsecondleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table style='margin-top:" + marginTop + "px;'>"
                        totalhtml = "<table style='margin-top:" + marginTop + "px;'>";

//                        if (id > 0) {
//                            for (var i = 0; i < id; i++) {
//                                html += "<tr><td>-</td></tr>";
//                            }
//                        }

                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            html += "<tr  id='secondlevel_" + i + "'><td>" + data.AccountNumber + "<span onclick='update2(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td></tr>";
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            totalhtml += "<tr id='secondLevelTotal" + i + "'><td>" + data.Total + "</td></tr>";
                        });
                    }
                    
                    $('#' + Parentid).children(":eq(2)").append(html);
                    

                    $('#firstLevel' + id).find('td:first').children().children().removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    var html1 = $('#id_' + id).children(":eq(3)").html();
                    $('#firstLevel' + id).children(":eq(3)").html("");
                    var total = '';
                    if (accobj.length == 1) {
                        total = totalhtml + "</table><div style=display:none;>" + html1 + "</div>";
                    }
                    else {
                        //total = totalhtml + "</table><div>" + html1 + "</div>";
                        total = totalhtml + "</table>";
                    }
                    //$('#firstLevel' + id).children(":eq(2)").html(total);
                    $('#firstLevelTotal' + id).empty().append(total);
                }
            }
            else {
                $('#firstLevel' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                $('#firstLevel' + id).removeClass('heightdiv');
                $('#firstLevel' + id).find('table').html("");
                $('#firstLevel' + id).find('div').css('display', 'block');

                if ($('#tblannualbudget tr').find('i').hasClass("fa-minus-circle") == false) {
                    $('#tblannualbudget tr').children(":eq(2)").remove();
                    $('#tblannualbudget tbody tr').each(function () {
                        $(this).children(":eq(2)").remove();
                    });
                    flagLevel1 = false;
                }
            }
        }


        function update2(id, item) {
            debugger;
            if ($('#secondlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel2 == false) {
                    flagLevel2 = true;
                    $('#tblannualbudget tr').children(":eq(2)").after($("<td>"));
                    $('#tblannualbudget tr').children(":eq(2)").next().html('Cost Center');
                    $('#tblannualbudget tbody tr').each(function () {
                        //$('#tblfeeds tr').children(":eq(0)").append($("<td>"));
                        $(this).children(":eq(2)").after($("<td>"));
                    });

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getsecondleveldetails(id, item);
                    if (accobj.length > 0) {
                        //.addClass('heightdiv')
                        html = "<table>"
                        totalhtml = "<table>";

                        if (id > 0) {
                            for (var i = 0; i < id; i++) {
                                html += "<tr><td>-</td></tr>";
                            }
                        }

                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            html += "<tr id='thirdlevel_"+ i +"'><td>" + data.AccountNumber + "<span onclick='update3(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td></tr>";
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            totalhtml += "<tr><td>" + data.Total + "</td></tr>";
                        });
                    }
                    var Parentid = $('#secondlevel_' + id).parent().parent().parent().parent().attr('id');

                    //$('#firstLevel' + id).addClass('heightdiv');
                    //$('#firstLevelTotal' + id).addClass('heightdiv');
                    $('#' + Parentid).children(":eq(2)").append(html);

                    var dynHeight = $('#' + Parentid).children(":eq(2)").height();
                    $('#secondlevel_' + id).css('height', dynHeight);
                    $('#secondLevelTotal' + id).css('height', dynHeight);

                    $('#secondlevel_' + id).find('td:first').children().children().removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    var html1 = $('#id_' + id).children(":eq(3)").html();
                    $('#secondlevel_' + id).children(":eq(3)").html("");
                    var total = '';
                    if (accobj.length == 1) {
                        total = totalhtml + "</table><div style=display:none;>" + html1 + "</div>";
                    }
                    else {
                        //total = totalhtml + "</table><div>" + html1 + "</div>";
                        total = totalhtml + "</table>";
                    }
                    //$('#firstLevel' + id).children(":eq(2)").html(total);
                    $('#secondLevelTotal' + id).empty().append(total);

                }
                else {
                    var Parentid = $('#secondlevel_' + id).parent().parent().parent().parent().attr('id');
                    var dynHeight = $('#' + Parentid).children(":eq(2)").height();
                    $('#secondlevel_' + id).css('height', dynHeight);
                    $('#secondLevelTotal' + id).css('height', dynHeight);
                    var marginTop = dynHeight / 2;
                    var accobj = getsecondleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table style='margin-top:" + marginTop + "px;'>"
                        totalhtml = "<table style='margin-top:" + marginTop + "px;'>";

                        //                        if (id > 0) {
                        //                            for (var i = 0; i < id; i++) {
                        //                                html += "<tr><td>-</td></tr>";
                        //                            }
                        //                        }

                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            html += "<tr id='thirdlevel_" + i + "'><td>" + data.AccountNumber + "<span onclick='update2(" + i + ",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span></td></tr>";
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            totalhtml += "<tr><td>" + data.Total + "</td></tr>";
                        });
                    }

                    $('#' + Parentid).children(":eq(2)").append(html);


                    $('#secondlevel_' + id).find('td:first').children().children().removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    var html1 = $('#id_' + id).children(":eq(3)").html();
                    $('#secondlevel_' + id).children(":eq(3)").html("");
                    var total = '';
                    if (accobj.length == 1) {
                        total = totalhtml + "</table><div style=display:none;>" + html1 + "</div>";
                    }
                    else {
                        //total = totalhtml + "</table><div>" + html1 + "</div>";
                        total = totalhtml + "</table>";
                    }
                    //$('#firstLevel' + id).children(":eq(2)").html(total);
                    $('#secondLevelTotal' + id).empty().append(total);
                }
            }
            else {
                $('#secondlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                $('#secondlevel_' + id).removeClass('heightdiv');
                $('#secondlevel_' + id).find('table').html("");
                $('#secondlevel_' + id).find('div').css('display', 'block');

                if ($('#tblannualbudget tr').find('i').hasClass("fa-minus-circle") == false) {
                    $('#tblannualbudget tr').children(":eq(2)").remove();
                    $('#tblannualbudget tbody tr').each(function () {
                        $(this).children(":eq(2)").remove();
                    });
                    flagLevel2 = false;
                }
            }
        }

        function getsecondleveldetails(id, item) {
            var accobjlist = null;
            AccNo = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridData',
                //data: "{id: '" + id + "',condition: '" + item + "',level: '" + 2 + "'}",
                data: "{Head: '" + Head + "',Account: '" + AccNo + "',Profit: '',Cost: '',level: '" + 2 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    debugger;
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }


        function getthirdleveldetails(id, item) {
            var accobjlist = null;
            Profitcenter = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridData',               
                data: "{Head: '" + Head + "',Account: '',Profit: '"+ Profitcenter +"',Cost: '',level: '" + 3 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    debugger;
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }
        
    </script>
</asp:Content>
