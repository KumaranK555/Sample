<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="WebForm1.aspx.cs"
    Inherits="DBCLWebReports1.WebForm1" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .color
        {
            /*background: #00ff00;
            color: #fff;*/
            background:powderblue;
            color: Blue;
        }
        .hidecol
        {
            display: none;
        }
        label
        {
            display: block;
            padding-left: 15px;
            text-indent: -15px;
        }
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        .Grid td
        {
            /*background-color: #A1DCF2;*/ /*color: black;*/
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
            display: none;
        }
        .show
        {
            display: block;
        }
        /* .tab_cls  tbody tr td
        {
            border:1px solid #ddd !important;
        }*/
        
        .tdclass
        {
        }
        .scrollbar
        {
            /*margin-left: 30px;
	float: left;
    margin-bottom: 25px;
    width: 65px;
    background: #F5F5F5;*/
            height: 410px;
            overflow-y: scroll;
            margin-right: 15px;
        }
        /*
 *  STYLE 3
 */
        
        #style-3::-webkit-scrollbar-track
        {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            background-color: #F5F5F5;
        }
        
        #style-3::-webkit-scrollbar
        {
            width: 6px;
            background-color: #F5F5F5;
        }
        
        #style-3::-webkit-scrollbar-thumb
        {
            background-color: #000000;
        }
        
        
        
        
        table
        {
            font-family: "Helvetica Neue" ,Helvetica, Arial, Sans-Serif !important;
            font-size: 12px;
        }
        
        tr td table, tr td table tr, tr td table tr td table, tr td table tr, tr td table tr td table tr td table
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
        .table > tbody > tr > td, .table > tbody > tr > td table tr td:last-child
        {
            padding: 0px 0px !important;
        }
        .table.tblopexmis > tbody > tr > td
        {
            padding: 0px 8px !important;
        }
        .table.tblannualbudget, .table.tblbureaureport1
        {
            width: 150%;
            max-width: 200%;
        }
        .table.tblTrent3OPEX
        {
            width: 125%;
            max-width: 150%;
        }
        table.update2 > tbody > tr > td, table.update3 > tbody > tr > td, table.update4 > tbody > tr > td, table.update5 > tbody > tr > td
        {
            border-bottom: 1px solid transparent;
        }
        table.update2 > tbody > tr > td:last-child, table.update3 > tbody > tr > td:last-child, table.update4 > tbody > tr > td:last-child, table.update5 > tbody > tr > td:last-child
        {
            border-right: 1px solid transparent;
        }
        table.update > tbody > tr > td:first-child
        {
            width: 2% !important;
        }
        table.update1 > tbody > tr > td:first-child
        {
            width: 5% !important;
        }
        table.update2 > tbody > tr > td:first-child
        {
            width: 7% !important;
        }
        table.update3 > tbody > tr > td:first-child
        {
            width: 12% !important;
        }
        table.update4 > tbody > tr > td:first-child
        {
            width: 12% !important;
        }
        table.update5 > tbody > tr > td:first-child
        {
            width: 12% !important;
        }
        
        table.updateone > tbody > tr > td:first-child
        {
            width: 12% !important;
        }
        .table-bordered > tbody > tr > td
        {
            border: 1px solid #ddd;
        }
        table.cols_width tr td
        {
            width: 112px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <%--<asp:ScriptManager ID="scriptmanager1" AsyncPostBackTimeout = "360000" runat="server"></asp:ScriptManager>--%>
    <form id="Form1" runat="server">
    <div class="app-content-body ">
        <%--<div class="bg-light lter b-b wrapper-md">
            <h1 class="m-n font-thin h3">
                Production Planning Report</h1>
        </div>--%>
        <%--<div class="wrapper-md">--%>
            <div class="panel panel-default">
                <div class="panel-heading" style="color: #09F;height:40px;display:none;" id="divTitleHead" >
                <div id="divTitle" ></div>
                  <div class="topdropdown" style="float:right;    margin-top: -20px;">
                            <div class="form-group">
                                <span id="btnExport" style="cursor: pointer"><i class="fa fa-file-excel-o" aria-hidden="true">
                                </i>Export to Excel</span>
                            </div>
                        </div>
                </div>
                <telerik:RadScriptManager AsyncPostBackTimeout="360000" runat="server" ID="RadScriptManager1" />
                <div class="row">
                    <div class="col-md-12 clm_pn" style="margin-top: 5px;">
                        <div  class="topdropdown">    <%--class="col-md-2"--%>
                            <div class="form-group">
                                <select id="selState" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="topdropdown" > <%--col-md-2--%>
                            <div class="form-group">
                                <select id="selBusinessarea" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="topdropdown" > <%--col-md-2--%>
                            <div class="form-group">
                                <select id="selNewf2" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="topdropdown" > <%--col-md-2--%>
                            <div class="form-group">
                                <select id="selNewf3" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="topdropdown" > <%--col-md-2--%>
                            <div class="form-group">
                                <select id="selNewf4" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="topdropdown" > <%--col-md-2--%>
                            <div class="form-group">
                                <select id="selGlcode" class="form-control">
                                </select>
                            </div>
                        </div>
                         <div class="topdropdown" > <%--col-md-2--%>
                            <div class="form-group">
                                <select id="selProduct" class="form-control">
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="row">
                    <div class="col-md-12 clm_pn" style="margin-top: 5px;">
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <select id="selState" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <select id="selBusinessarea" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <select id="selNewf2" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <select id="selNewf3" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <select id="selNewf4" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <select id="selGlcode" class="form-control">
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <select id="selProduct" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2" style="padding: 0px 10px 0px 10px;">
                            <div class="form-group">
                                <span id="btnExport" style="cursor: pointer"><i class="fa fa-file-excel-o" aria-hidden="true">
                                </i>Export to Excel</span>
                            </div>
                        </div>
                    </div>
                </div>--%>
                <div class="row" id="divopexreport">
                    <div class="col-md-2" style="padding-right: 0px !important;">
                        <div class="form-group">
                            <div id="div_All" style="height: 45px; border: 1px solid Blue; margin: auto;">
                                <div style="height: 20px; background-color: Blue; line-height: 20px; text-align: center;
                                    color: #fff; font-weight: bold;">
                                    Financial Year
                                </div>
                                <div style="height: 20px; line-height: 20px; text-align: right;
                                    color: #000; margin-right: 5px; font-weight: bold;">
                                    <label id="lblYear" style="cursor: pointer;" onclick="UpdateDateNew('All')">2016</label>
                                 </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-10">
                        <div class="form-group">
                            <div style="height: 42px; border: 1px solid Blue; margin: auto;">
                                <div style="height: 20px; background-color: Blue; line-height: 20px; text-align: left;
                                    color: #fff; font-weight: bold;">
                                    Month
                                </div>
                                <div style="height: 20px; background-color: #ebebe0; line-height: 20px; text-align: left;
                                    color: #000; font-weight: bold;">
                                    <div class="col-md-1" id="div_Apr">
                                        <label id="lblApr" style="cursor: pointer;" onclick="UpdateDateNew('April 2016')">
                                            Apr</label>
                                    </div>
                                    <div class="col-md-1" id="div_May">
                                        <label id="Label1" style="cursor: pointer;" onclick="UpdateDateNew('May 2016')">
                                            May</label></div>
                                    <div class="col-md-1" id="div_June">
                                        <label id="Label2" style="cursor: pointer;" onclick="UpdateDateNew('June 2016')">
                                            June</label></div>
                                    <div class="col-md-1" id="div_July">
                                        <label id="Label3" style="cursor: pointer;" onclick="UpdateDateNew('July 2016')">
                                            July</label></div>
                                    <div class="col-md-1" id="div_Aug">
                                        <label id="Label4" style="cursor: pointer;" onclick="UpdateDateNew('August 2016')">
                                            Aug</label></div>
                                    <div class="col-md-1" id="div_Sep">
                                        <label id="Label5" style="cursor: pointer;" onclick="UpdateDateNew('September 2016')">
                                            Sep</label></div>
                                    <div class="col-md-1" id="div_Oct">
                                        <label id="Label6" style="cursor: pointer;" onclick="UpdateDateNew('October 2016')">
                                            Oct</label></div>
                                    <div class="col-md-1" id="div_Nov">
                                        <label id="Label7" style="cursor: pointer;" onclick="UpdateDateNew('November 2016')">
                                            Nov</label></div>
                                    <div class="col-md-1" id="div_Dec">
                                        <label id="Label8" style="cursor: pointer;" onclick="UpdateDateNew('December 2016')">
                                            Dec</label></div>
                                    <div class="col-md-1" id="div_Jan">
                                        <label id="Label9" style="cursor: pointer;" onclick="UpdateDateNew('January 2016')">
                                            Jan</label></div>
                                    <div class="col-md-1" id="div_Feb">
                                        <label id="Label10" style="cursor: pointer;" onclick="UpdateDateNew('February 2016')">
                                            Feb</label></div>
                                    <div class="col-md-1" id="div_Mar">
                                        <label id="Label11" style="cursor: pointer;" onclick="UpdateDateNew('March 2016')">
                                            Mar</label></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="DisableDiv">
                </div>
                <div class="scrollbar" id="style-3">
                    <%--<img src="img/loadingimg.gif" id="loaderimage" style="margin-top:-105px; margin-left: 400px; position:absolute; z-index:999; display: none;" />--%>
                    <div class="table-responsive" style="width: 100%;overflow-x: visible;">
                        <div id="divAnnualBudget" style="display: none; padding: 0px 15px;" runat="server">
                            <table class="table table-striped table-bordered table-hover no-margin tab-blk tab_cls tblannualbudget tablefont"
                                id="tblannualbudget" >
                                <thead>
                                    <tr class="OpexMISFont"></tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                        <div id="divTrent3OPEX" style="display: none; padding: 0px 15px;" runat="server">
                            <table class="table table-striped table-bordered table-hover no-margin tab-blk tab_cls tblTrent3OPEX tablefont"
                                id="tblTrent3OPEX">
                                <thead>
                                    <tr class="OpexMISFont">
                                        <th id="th2" style="width: 20%">
                                            Head
                                        </th>
                                        <th id="thheadingtrendopex" style="width: 80%">
                                        </th>
                                        <%-- <th>Budget</th>
                               <th>Actual</th>
                               <th>Job Work</th>
                               <th>Adjusted Actual</th>
                               <th>Variance</th>--%>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div id="divOpexMIS" class="" style="width: 96%; display: none; padding: 0px 15px;"
                            runat="server">
                            <table class="table table-striped table-bordered table-hover no-margin tab-blk tab_cls tblopexmis tablefont"
                                id="tblopexmis" >
                                <thead>
                                    <tr class="OpexMISFont">
                                        <th>
                                        </th>
                                        <th colspan="7" class="textalign">
                                            FTM
                                        </th>
                                        <th>
                                        </th>
                                        
                                        <th colspan="7" class="textalign">
                                            YTD
                                        </th>
                                        
                                    </tr>
                                    <tr class="OpexMISFont">
                                        <td id="th1" style="width: 60%" class="textalign">
                                            Heads
                                        </td>
                                        <td class="textalign">
                                            Budget
                                        </td>
                                        <td class="textalign">
                                            Actual
                                        </td>
                                        <td class="textalign">
                                          Carry Forward
                                        </td>
                                        <td class="textalign">
                                          Job Work
                                        </td>
                                        <td class="textalign">
                                           Adj Actual
                                        </td>
                                        <td class="textalign">
                                          Variance
                                        </td>
                                        <td class="textalign">
                                            Var(%)
                                        </td>
                                        <td class="textalign">
                                           Remarks
                                        </td>
                                        
                                        <td class="textalign">
                                           Budget
                                        </td>
                                        <td class="textalign">
                                            Actual
                                        </td>
                                        <td class="textalign">
                                            Carry Forward
                                        </td>
                                        <td class="textalign">
                                            Job Work
                                        </td>
                                        <td class="textalign">
                                            Adj Actual
                                        </td>
                                        <td class="textalign">
                                            Variance
                                        </td>
                                        <td class="textalign">
                                            Var(%)
                                        </td>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div id="divBureau" style="display: none; padding: 0px 15px;" runat="server">
                            <table class="table table-striped table-bordered table-hover no-margin tab-blk tab_cls tblbureaureport1 tablefont"
                                id="tblbureaureport1">
                                <thead>
                                    <tr class="OpexMISFont">
                                        <th id="th3" style="width: 20%">
                                            Head
                                        </th>
                                        <th id="thheadtotalbureau" style="width: 80%">
                                            Total
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div id="divOpexBureau" style="display: none; padding: 0px 15px;" runat="server">
                            <table class="table table-striped table-bordered table-hover no-margin tab-blk tab_cls tblbureaureport1 tablefont"
                                id="tblannualbureau">
                                <thead>
                                    <tr class="OpexMISFont">
                                        <th style="width: 20%">
                                            Bureau
                                        </th>
                                        <th id="thheadingbureauopex" style="width: 80%">
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <asp:Panel ID="ContentPanel" runat="server">
                </asp:Panel>
            </div>
        <%--</div>--%>
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

        var QueryId, Report = '';
        var QueryCondition = "OPEX";
        var queryname = '';
        var flag = false;
        var flagLevel1 = false;
        var flagLevel2 = false;
        var flagLevel3 = false;
        var flagLevel4 = false;
        var openflag = false;
        var AnnualBudgetHeader = true;
        var AnnualBudgetDate = false;
        //var accobjlist = '';
        var Head, AccNo, Profitcenter, Glname, Cost = '';

        $(document).ready(function () {
            //$("#loaderimage").show();
            $('#DisableDiv').fadeTo('slow', .6);
            $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
            setTimeout(function () {
                fetchfiltervalues();
                FetchMasterData("OPEX");
            }, 1000);

            $("#btnExport").click(function () {
                var fileName, Id = '';
                if (queryname == "OPEX MIS" || queryname == "29 Chart" || queryname == "29 Heads") {
                    Id = "tblopexmis";
                    if (queryname == "OPEX MIS") {
                        fileName = "OPEXMIS";
                    }
                    else if (queryname == "29 Chart") {
                        fileName = "29Chart";
                    }
                    else if (queryname == "29 Heads") {
                        fileName = "29Heads";
                    }
                }
                else if (queryname == "AnnualBudget" || queryname == "Actuals (Incl.JW)" || queryname == "Actuals(JW)") {
                    Id = "tblannualbudget";
                    if (queryname == "AnnualBudget") {
                        fileName = "AnnualBudget";
                    }
                    else if (queryname == "Actuals (Incl.JW)") {
                        fileName = "ActualsIncludeJW";
                    }
                    else if (queryname == "Actuals(JW)") {
                        fileName = "Actuals(JW)";
                    }
                }
                else if (queryname == "Bureau Trend-3B" || queryname == "Bureau Trend-3A") {
                    Id = "tblbureaureport1";
                    if (queryname == "Bureau Trend-3B") {
                        fileName = "BureauTrend-3B";
                    }
                    else if (queryname == "Bureau Trend-3A") {
                        fileName = "BureauTrend-3A";
                    }
                }
                else if (queryname == "Bureau Opex") {
                    Id = "tblannualbureau";
                    fileName = "BureauOpex";
                }
                else if (queryname == "Trend-3 Tot OPEX") {
                    Id = "tblTrent3OPEX";
                    fileName = "Trend-3TotOPEX";
                }

                $("#" + Id).table2excel({
                    exclude: ".noExl",
                    name: queryname,
                    filename: fileName,
                    fileext: ".xls",
                    exclude_img: true,
                    exclude_links: true,
                    exclude_inputs: true
                });
            });

            $("#selState").on('change', function () {
                //$("#loaderimage").show();
                var condition = 'STATE';
                var value = '';
                if ($("#selState").val() == "0") {
                    value = 'All';
                }
                else {
                    value = $("#selState").val();
                }
                $('#DisableDiv').fadeTo('slow', .6);
                $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
                setTimeout(function () {
                    UpdateFilterValues(condition, value);
                }, 1000);

            });

            $("#selNewf2").on('change', function () {
                //$("#loaderimage").show();
                var condition = 'NEWF2';
                var value = '';
                if ($("#selNewf2").val() == "0") {
                    value = 'All';
                }
                else {
                    value = $("#selNewf2").val();
                }
                $('#DisableDiv').fadeTo('slow', .6);
                $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
                setTimeout(function () {
                    UpdateFilterValues(condition, value);
                }, 1000);
            });

            $("#selNewf3").on('change', function () {
                //$("#loaderimage").show();
                var condition = 'NEWF3';
                var value = '';
                if ($("#selNewf3").val() == "0") {
                    value = 'All';
                }
                else {
                    value = $("#selNewf3").val();
                }
                $('#DisableDiv').fadeTo('slow', .6);
                $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
                setTimeout(function () {
                    UpdateFilterValues(condition, value);
                }, 1000);
            });


            $("#selNewf4").on('change', function () {
                //$("#loaderimage").show();
                var condition = 'NEWF4';
                var value = '';
                if ($("#selNewf4").val() == "0") {
                    value = 'All';
                }
                else {
                    value = $("#selNewf4").val();
                }
                $('#DisableDiv').fadeTo('slow', .6);
                $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
                setTimeout(function () {
                    UpdateFilterValues(condition, value);
                }, 1000);
            });

            $("#selGlcode").on('change', function () {
                //$("#loaderimage").show();
                var condition = 'ACCOUNTNUMBER_RACCT';
                var value = '';
                if ($("#selGlcode").val() == "0") {
                    value = 'All';
                }
                else {
                    value = $("#selGlcode").val();
                }
                $('#DisableDiv').fadeTo('slow', .6);
                $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
                setTimeout(function () {
                    UpdateFilterValues(condition, value);
                }, 1000);
            });

            $("#selProduct").on('change', function () {
                //$("#loaderimage").show();
                var condition = 'PRODUCT';
                var value = '';
                if ($("#selProduct").val() == "0") {
                    value = 'All';
                }
                else {
                    value = $("#selProduct").val();
                }
                $('#DisableDiv').fadeTo('slow', .6);
                $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
                setTimeout(function () {
                    UpdateFilterValues(condition, value);
                }, 1000);
            });

            $("#selBusinessarea").on('change', function () {
                //$("#loaderimage").show();
                var condition = 'BUSINESSAREA_GSBER';
                var value = '';
                if ($("#selBusinessarea").val() == "0") {
                    value = 'All';
                }
                else {
                    value = $("#selBusinessarea").val();
                }
                $('#DisableDiv').fadeTo('slow', .6);
                $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
                setTimeout(function () {
                    UpdateFilterValues(condition, value);
                }, 1000);
            });
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

        function FetchReportRecords(id, e, Condition, category) {
            //$("#loaderimage").show();
            if (Condition == "AnnualBudget") {
                category = "ANNUAL BUDGET";
                Report = "ANNUALBUDGET";

                if (AnnualBudgetDate)
                    AnnualBudgetHeader = false;
                else
                    AnnualBudgetHeader = true;
            }
            $('#DisableDiv').fadeTo('slow', .6);
            $('#DisableDiv').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width: 100%;height:300%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="img/loadingimg.gif" style="background-color:Aqua;position:fixed; top:40%; left:46%;"/></div>');
            setTimeout(function () { FetchReportsDB(id, e, Condition, category) }, 1000);
        }

        function FetchReportsDB(id, e, Condition, category) {
            QueryId = id;
            queryname = Condition;
            $("#divTitleHead").css("display", "block");
            $("#divTitle").html(queryname);
            var url = "";
            if (Condition == "OPEX MIS" || Condition == "29 Chart" || Condition == "29 Heads") {
                url = '/WebForm1.aspx/RequestDataOpex';
            }
            else if (Condition == "AnnualBudget" || Condition == "Actuals (Incl.JW)" || Condition == "Actuals(JW)") {
                url = '/WebForm1.aspx/RequestData';
            }
            else if (Condition == "Bureau Trend-3B" || Condition == "Bureau Trend-3A") {
                url = '/WebForm1.aspx/RequestDataBureau';
            }
            else if (Condition == "Bureau Opex") {
                url = '/WebForm1.aspx/RequestDataBureauOpex';
            }
            else {
                url = '/WebForm1.aspx/RequestDataTrend';
            }
            $.ajax({
                type: "POST",
                url: url,
                data: "{id: '" + id + "',condition: '" + category + "',InitialLoad: '" + AnnualBudgetHeader + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    if (Condition == "OPEX MIS" || Condition == "29 Chart" || Condition == "29 Heads") {
                        $("[id*=divAnnualBudget]").css("display", "none");
                        $("[id*=divTrent3OPEX]").css("display", "none");
                        $("[id*=divOpexMIS]").css("display", "block");
                        $("[id*=divBureau]").css("display", "none");
                        $("[id*=divOpexBureau]").css("display", "none");
                        $("#tblopexmis tbody").html("");
                        var table = $("#tblopexmis tbody");
                        var html = "";

                        $.each(response.d, function (i, data) {
                            var input = response.d[i].Head;

                            if (response.d[i].Group == 'NEWF2') {
                                html += "<tr style='background-color:powderblue;color: blue;font-weight:bold;font-size:11px;' class='section'><td style='padding:0 !important;'>" + data.Head + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.BudgetFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.ActualFTM) + "</td><td> </td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWorkFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjActualFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VarianceFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Variance) + "</td><td></td><td style='text-align:right;'>" + commaSeparateNumber(data.BudgetYTD) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.ActualYTD) + "</td><td style='text-align:right;'> </td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWorkYTD) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjActualYtd) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VaianceYtd) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VarPercent) + "</td><tr>";
                            }
                            else if (response.d[i].Group == 'NEWF3' && response.d[i].flag == 'false') {
                                html += "<tr style='color: blue;font-weight:bold;font-size:11px;' class='section'><td>" + data.Head + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.BudgetFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.ActualFTM) + "</td><td><input type='text' value='" + data.CarryForward1 + "' onkeydown='keydown(&#39;" + data.Head + "&#39;,this.value)'  style='width:60px;background-color: #f9f9f9;border: none;text-align:right;'/> </td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWorkFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjActualFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VarianceFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Variance) + "</td><td><input type='text' value='" + data.Comments + "'  onkeydown='keydown3(&#39;" + data.Head + "&#39;,this.value)' style='width:60px;background-color: #f9f9f9;border: none;text-align:right;' /> </td><td style='text-align:right;'>" + commaSeparateNumber(data.BudgetYTD) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.ActualYTD) + "</td><td><input type='text' value='" + data.CarryForward2 + "' onkeydown='keydown2(&#39;" + data.Head + "&#39;,this.value)' style='width:60px;background-color: #f9f9f9;border: none;text-align:right;'/> </td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWorkYTD) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjActualYtd) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VaianceYtd) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VarPercent) + "</td><tr>";
                            }
                            else {
                                html += "<tr style='font-weight:bold' class='section'><td>" + data.Head + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.BudgetFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.ActualFTM) + "</td><td><input type='text' value='" + data.CarryForward1 + "' onkeydown='keydown(&#39;" + data.Head + "&#39;,this.value)'  style='width:60px;background-color: #f9f9f9;border: none;text-align:right;'/> </td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWorkFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjActualFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VarianceFTM) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Variance) + "</td><td><input type='text' value='" + data.Comments + "' onkeydown='keydown3(&#39;" + data.Head + "&#39;,this.value)' style='width:60px;background-color: #f9f9f9;border: none;text-align:right;'/> </td><td style='text-align:right;'>" + commaSeparateNumber(data.BudgetYTD) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.ActualYTD) + "</td><td><input type='text' value='" + data.CarryForward2 + "' onkeydown='keydown2(&#39;" + data.Head + "&#39;,this.value)' style='width:60px;background-color: #f9f9f9;border: none;text-align:right;'/> </td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWorkYTD) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjActualYtd) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VaianceYtd) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.VarPercent) + "</td><tr>";
                            }
                        });
                        table.append(html);
                    }
                    else if (Condition == "Actuals (Incl.JW)" || Condition == "Actuals(JW)") {
                        $("[id*=divOpexMIS]").css("display", "none");
                        $("[id*=divTrent3OPEX]").css("display", "none");
                        $("[id*=divAnnualBudget]").css("display", "block");
                        $("[id*=divBureau]").css("display", "none");
                        $("[id*=divOpexBureau]").css("display", "none");
                        $("#tblannualbudget tbody").html("");
                        var table = $("#tblannualbudget tbody");

                        $(".OpexMISFont").empty().append("<th id='thheading' style='width: 30%'>Head</th><th id='thheadtotal'>Total</th>");

                        var html = "";
                        $.each(response.d, function (i, data) {
                            var input = response.d[i].Head;
                            var trid = 'id_' + i;
                            if (response.d[i].Group == 'NEWF2') {
                                html += "<tr id='" + trid + "' style='background-color:powderblue;color: blue;font-weight:bold;font-size:11px;cursor:pointer;' class='section'><td><span onclick='update(" + i + ",\"" + input + "\",&#39;NEWF2&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                            }
                            else if (response.d[i].Group == 'NEWF3' && response.d[i].flag == 'false') {
                                html += "<tr id='" + trid + "' style='color: blue;font-weight:bold;cursor:pointer;font-size:11px;'><td><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                            }
                            else {
                                html += "<tr id='" + trid + "' style='font-weight:bold;cursor:pointer;'><td><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                            }
                        });

                        table.append(html);
                    }
                    else if (Condition == "AnnualBudget") {
                        debugger;
                        $("[id*=divOpexMIS]").css("display", "none");
                        $("[id*=divTrent3OPEX]").css("display", "none");
                        $("[id*=divAnnualBudget]").css("display", "block");
                        $("[id*=divBureau]").css("display", "none");
                        $("[id*=divOpexBureau]").css("display", "none");
                        $("#tblannualbudget tbody").html("");
                        var table = $("#tblannualbudget tbody");

                        var html = "";

                        if (response.d[0].Status == "New") {
                            if (AnnualBudgetHeader) {
                                $(".OpexMISFont").empty().append("<th id='thheading' style='width: 30%'>Head</th><th>Apr</th><th>May</th><th>June</th><th>July</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th><th>Jan</th><th>Feb</th><th>Mar</th><th id='thheadtotal'>Total</th>");
                                AnnualBudgetHeader = false;
                                $.each(response.d, function (i, data) {
                                    var input = response.d[i].Head;
                                    var trid = 'id_' + i;
                                    if (response.d[i].Group == 'NEWF2') {
                                        html += "<tr id='" + trid + "' style='background-color:powderblue;color: blue;font-weight:bold;font-size:11px;cursor:pointer;text-align:right;' class='section'><td style='text-align:left;'><span onclick='update(" + i + ",\"" + input + "\",&#39;NEWF2&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Apr) + "</td><td>" + commaSeparateNumber(data.May) + "</td><td>" + commaSeparateNumber(data.June) + "</td><td>" + commaSeparateNumber(data.July) + "</td><td>" + commaSeparateNumber(data.Aug) + "</td><td>" + commaSeparateNumber(data.Sep) + "</td><td>" + commaSeparateNumber(data.Oct) + "</td><td>" + commaSeparateNumber(data.Nov) + "</td><td>" + commaSeparateNumber(data.Dec) + "</td><td>" + commaSeparateNumber(data.Jan) + "</td><td>" + commaSeparateNumber(data.Feb) + "</td><td>" + commaSeparateNumber(data.Mar) + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                                    }
                                    else if (response.d[i].Group == 'NEWF3' && response.d[i].flag == 'false') {
                                        html += "<tr id='" + trid + "' style='color: blue;font-weight:bold;cursor:pointer;font-size:11px;text-align:right;'><td style='text-align:left;'><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Apr) + "</td><td>" + commaSeparateNumber(data.May) + "</td><td>" + commaSeparateNumber(data.June) + "</td><td>" + commaSeparateNumber(data.July) + "</td><td>" + commaSeparateNumber(data.Aug) + "</td><td>" + commaSeparateNumber(data.Sep) + "</td><td>" + commaSeparateNumber(data.Oct) + "</td><td>" + commaSeparateNumber(data.Nov) + "</td><td>" + commaSeparateNumber(data.Dec) + "</td><td>" + commaSeparateNumber(data.Jan) + "</td><td>" + commaSeparateNumber(data.Feb) + "</td><td>" + commaSeparateNumber(data.Mar) + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                                    }
                                    else {
                                        html += "<tr id='" + trid + "' style='font-weight:bold;cursor:pointer;text-align:right;'><td style='text-align:left;'><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Apr) + "</td><td>" + commaSeparateNumber(data.May) + "</td><td>" + commaSeparateNumber(data.June) + "</td><td>" + commaSeparateNumber(data.July) + "</td><td>" + commaSeparateNumber(data.Aug) + "</td><td>" + commaSeparateNumber(data.Sep) + "</td><td>" + commaSeparateNumber(data.Oct) + "</td><td>" + commaSeparateNumber(data.Nov) + "</td><td>" + commaSeparateNumber(data.Dec) + "</td><td>" + commaSeparateNumber(data.Jan) + "</td><td>" + commaSeparateNumber(data.Feb) + "</td><td>" + commaSeparateNumber(data.Mar) + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                                    }
                                });
                            }
                            else {
                                debugger;
                                var setHeader = "<th id='thheading' style='width: 30%'>Head</th>";
                                var setData = '';
                                var dataArray = response.d;
                                if (dataArray[0].Apr != "NoColumn") {
                                    setHeader += "<th>Apr</th>";
                                }
                                if (dataArray[0].May != "NoColumn") {
                                    setHeader += "<th>May</th>";
                                }
                                if (dataArray[0].June != "NoColumn") {
                                    setHeader += "<th>June</th>";
                                }
                                if (dataArray[0].July != "NoColumn") {
                                    setHeader += "<th>July</th>";
                                }
                                if (dataArray[0].Aug != "NoColumn") {
                                    setHeader += "<th>Aug</th>";
                                }
                                if (dataArray[0].Sep != "NoColumn") {
                                    setHeader += "<th>Sep</th>";
                                }
                                if (dataArray[0].Oct != "NoColumn") {
                                    setHeader += "<th>Oct</th>";
                                }
                                if (dataArray[0].Nov != "NoColumn") {
                                    setHeader += "<th>Nov</th>";
                                }
                                if (dataArray[0].Dec != "NoColumn") {
                                    setHeader += "<th>Dec</th>";
                                }
                                if (dataArray[0].Jan != "NoColumn") {
                                    setHeader += "<th>Jan</th>";
                                }
                                if (dataArray[0].Feb != "NoColumn") {
                                    setHeader += "<th>Feb</th>";
                                }
                                if (dataArray[0].Mar != "NoColumn") {
                                    setHeader += "<th>Mar</th>";
                                }

                                setHeader += "<th id='thheadtotal'>Total</th>";
                                $(".OpexMISFont").empty().append(setHeader);
                                $.each(response.d, function (i, data) {
                                    var stApr = commaSeparateNumber(data.Apr) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Apr) + "</td>";
                                    var stMay = commaSeparateNumber(data.May) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.May) + "</td>";
                                    var stJune = commaSeparateNumber(data.June) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.June) + "</td>";
                                    var stJuly = commaSeparateNumber(data.July) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.July) + "</td>";
                                    var stAug = commaSeparateNumber(data.Aug) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Aug) + "</td>";
                                    var stSep = commaSeparateNumber(data.Sep) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Sep) + "</td>";
                                    var stOct = commaSeparateNumber(data.Oct) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Oct) + "</td>";
                                    var stNov = commaSeparateNumber(data.Nov) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Nov) + "</td>";
                                    var stDec = commaSeparateNumber(data.Dec) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Dec) + "</td>";
                                    var stJan = commaSeparateNumber(data.Jan) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Jan) + "</td>";
                                    var stFeb = commaSeparateNumber(data.Feb) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Feb) + "</td>";
                                    var stMar = commaSeparateNumber(data.Mar) == "NoColumn" ? "" : "<td>" + commaSeparateNumber(data.Mar) + "</td>";
                                    var input = dataArray[i].Head;
                                    var trid = 'id_' + i;
                                    var strConcat = stApr + stMay + stJune + stJuly + stAug + stSep + stOct + stNov + stDec + stJan + stFeb + stMar + "<td>" + commaSeparateNumber(data.Total) + "</td>";
                                    if (dataArray[i].Group == 'NEWF2') {
                                        html += "<tr id='" + trid + "' style='background-color:powderblue;color: blue;font-weight:bold;font-size:11px;cursor:pointer;text-align:right;' class='section'><td style='text-align:left;'><span onclick='update(" + i + ",\"" + input + "\",&#39;NEWF2&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td>" + strConcat + "</tr>";
                                    }
                                    else if (dataArray[i].Group == 'NEWF3' && dataArray[i].flag == 'false') {
                                        html += "<tr id='" + trid + "' style='color: blue;font-weight:bold;cursor:pointer;font-size:11px;text-align:right;'><td style='text-align:left;'><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td>" + strConcat + "</tr>";
                                    }
                                    else {
                                        html += "<tr id='" + trid + "' style='font-weight:bold;cursor:pointer;text-align:right;'><td style='text-align:left;'><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td>" + strConcat + "</tr>";
                                    }
                                });
                            }
                        }
                        else {
                            debugger;
                            $.each(response.d, function (i, data) {
                                $(".OpexMISFont").empty().append("<th id='thheading' style='width: 30%'>Head</th><th id='thheadtotal'>Total</th>");
                                AnnualBudgetHeader = false;
                                var input = response.d[i].Head;
                                var trid = 'id_' + i;
                                if (response.d[i].Group == 'NEWF2') {
                                    html += "<tr id='" + trid + "' style='background-color:powderblue;color: blue;font-weight:bold;font-size:11px;cursor:pointer;' class='section'><td><span onclick='update(" + i + ",\"" + input + "\",&#39;NEWF2&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                                }
                                else if (response.d[i].Group == 'NEWF3' && response.d[i].flag == 'false') {
                                    html += "<tr id='" + trid + "' style='color: blue;font-weight:bold;cursor:pointer;font-size:11px;'><td><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                                }
                                else {
                                    html += "<tr id='" + trid + "' style='font-weight:bold;cursor:pointer;'><td><span onclick='update(" + i + ",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                                }
                            });
                        }
                        table.append(html);
                    }
                    else if (Condition == "Trend-3 Tot OPEX") {
                        $("[id*=divOpexMIS]").css("display", "none");
                        $("[id*=divAnnualBudget]").css("display", "none");
                        $("[id*=divTrent3OPEX]").css("display", "block");
                        $("[id*=divBureau]").css("display", "none");
                        $("[id*=divOpexBureau]").css("display", "none");
                        $("#tblTrent3OPEX tbody").html("");
                        var table = $("#tblTrent3OPEX tbody");
                        var html = "";
                        $.each(response.d, function (i, data) {
                            var input = response.d[i].Head;
                            var trid = 'id_' + i

                            if (response.d[i].Group == 'NEWF2') {
                                html += "<tr id=" + trid + " style='background-color:powderblue;color: blue;font-weight:bold;font-size:11px;' class='section'><td><span onclick='updatetrendaccno(\"" + i + "\",\"" + input + "\",&#39;NEWF2&#39;)'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='cols_width tablefont'><tr><td style='text-align:right;'>" + commaSeparateNumber(data.Budget) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Actual) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWork) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjustedActual) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td><tr>";
                            }
                            else if (response.d[i].Group == 'NEWF3' && response.d[i].flag == 'false') {
                                html += "<tr id=" + trid + " style='color: blue;font-weight:bold;font-size:11px;cursor:pointer;' class='section'><td><span onclick='updatetrendaccno(\"" + i + "\",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='cols_width tablefont'><tr><td style='text-align:right;'>" + commaSeparateNumber(data.Budget) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Actual) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWork) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjustedActual) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td><tr>";
                            }
                            else {
                                html += "<tr id=" + trid + "  style='font-weight:bold;cursor:pointer;' class='section'><td><span onclick='updatetrendaccno(\"" + i + "\",\"" + input + "\",&#39;&#39;)'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='cols_width tablefont'><tr><td style='text-align:right;'>" + commaSeparateNumber(data.Budget) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Actual) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.JobWork) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.AdjustedActual) + "</td><td style='text-align:right;'>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td><tr>";
                            }
                        });
                        $("#thheadingtrendopex").html("<span >Budget</span><span style='margin-left:92px;'>Actual</span><span style='margin-left:110px;'>Jobwork</span><span style='margin-left:88px;'>AdjustedActual</span><span style='margin-left:60px;'>Variance</span>");
                        table.append(html);
                    }
                    else if (Condition == "Bureau Trend-3B" || Condition == "Bureau Trend-3A") {
                        $("[id*=divOpexMIS]").css("display", "none");
                        $("[id*=divAnnualBudget]").css("display", "none");
                        $("[id*=divTrent3OPEX]").css("display", "none");
                        $("[id*=divOpexBureau]").css("display", "none");

                        $("[id*=divBureau]").css("display", "block");
                        $("#tblbureaureport1 tbody").html("");
                        var table = $("#tblbureaureport1 tbody");
                        var html = "";
                        $.each(response.d, function (i, data) {
                            var input = response.d[i].Head;
                            var trid = 'id_' + i;
                            html += "<tr  id='" + trid + "' style='font-weight: bold;cursor:pointer;'><td><span onclick='updatebureautrend(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span>&nbsp;&nbsp;" + data.Head + "</td><td>" + commaSeparateNumber(data.Total) + "</td></tr>";
                        });
                        table.append(html);
                    }
                    else if (Condition == "Bureau Opex") {
                        $("[id*=divOpexMIS]").css("display", "none");
                        $("[id*=divAnnualBudget]").css("display", "none");
                        $("[id*=divTrent3OPEX]").css("display", "none");
                        $("[id*=divBureau]").css("display", "none");
                        $("[id*=divOpexBureau]").css("display", "block");
                        $("#tblannualbureau tbody").html("");
                        var table = $("#tblannualbureau tbody");
                        var html = "";
                        $.each(response.d, function (i, data) {
                            var input = response.d[i].Bureau;
                            var trid = 'id_' + i;
                            html += "<tr id='" + trid + "' style='font-weight: bold;;cursor:pointer;' class='section'><td><span onclick='updatebureauglname(\"" + i + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true' ></i></span>&nbsp;&nbsp;" + commaSeparateNumber(data.Bureau) + "</td><td ><table class='maintable tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
                        });
                        table.append(html);
                        $("#thheadingbureauopex").html('<span style="margin-left: 4px;">Budget</span><span style="margin-left: 235px;">Actual</span><span style="margin-left: 248px;">Variance</span>');
                    }
                    fetchDate(Condition);
                },
                error: function (response) { }
            });
        }

        function FetchMasterData(category) {
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/GetMasterData',
                data: "{category: '" + category + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    var data = response.d;
                    $("#ulTitle").html(data);
                    $('#DisableDiv').html("");
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        /* New Update Function*/
        function UpdateDateNew(Date) {
            var fromDate = '';
            var toDate = '';
            var QueryCondition = "OPEX";
            var selMonthAnnualBudget = '';
            if (QueryCondition == "OPEX" || QueryCondition == "adhoc") {

                var actualDate = Date;

                if (actualDate == "All") {
                    fromDate = "All";
                    toDate = "All";
                }

                else {
                    fromDate = actualDate.split(" ")[0];

                    if (fromDate == "January") {
                        toDate = '1';
                        fromDate = "Jan";
                    }
                    else if (fromDate == "February") {
                        toDate = '2';
                        fromDate = "Feb";
                    }
                    else if (fromDate == "March") {
                        toDate = '3';
                        fromDate = "Mar";
                    }
                    else if (fromDate == "April") {
                        toDate = '4';
                        fromDate = "Apr";
                    }
                    else if (fromDate == "May") {
                        toDate = '5';
                        fromDate = "May";
                    }
                    else if (fromDate == "June") {
                        toDate = '6';
                        fromDate = "June";
                    }
                    else if (fromDate == "July") {
                        toDate = '7';
                        fromDate = "July";
                    }
                    else if (fromDate == "August") {
                        toDate = '8';
                        fromDate = "Aug";
                    }
                    else if (fromDate == "September") {
                        toDate = '9';
                        fromDate = "Sep";
                    }
                    else if (fromDate = "October") {
                        toDate = '10';
                        fromDate = "Oct";
                    }
                    else if (fromDate == "November") {
                        toDate = '11';
                        fromDate = "Nov";
                    }
                    else if (fromDate == "December") {
                        toDate = '12';
                        fromDate = "Dec";
                    }
                    if (QueryCondition == "adhoc") {
                        fromDate = fromDate + " " + actualDate.split(" ")[1];
                    }

                    if (Report == "ANNUALBUDGET") {
                        AnnualBudgetDate = true;
                        var unique = false;
                        $(".color").each(function (index, value) {
                            value = value.textContent.trim()
                            if (value != fromDate) {
                                selMonthAnnualBudget += value + ",";
                            }
                            else {
                                unique = true;
                            }
                        });
                        if (unique) {
                            fromDate = selMonthAnnualBudget.slice(0, -1);
                        }
                        else {
                            if (selMonthAnnualBudget != "")
                                fromDate = fromDate + "," + selMonthAnnualBudget.slice(0, -1);
                        }
                    }
                    else {
                        AnnualBudgetDate = false;
                    }
                }
            }
            else {
                fromDate = $("#fromDate").datepicker('getFormattedDate');
                toDate = $("#toDate").datepicker('getFormattedDate');
                AnnualBudgetDate = false;
            }

            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/UpdateFilter',
                data: "{Id: '" + QueryId + "',condition: '" + QueryCondition + "',fromDate: '" + fromDate + "',toDate: '" + toDate + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    if (response.d == "Success") {
                        //window.location.reload();
                        $("a[id='" + queryname + "']").click();
                    }
                    //setTimeout(function () { $("#loaderimage").hide(); }, 3000);
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function UpdateFilterValues(condition, value) {
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/UpdateFilterValues',
                data: "{Id: '" + QueryId + "',condition: '" + condition + "',value :'" + value + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    if (response.d == "Success") {
                        $("a[id='" + queryname + "']").click();
                    }
                    //setTimeout(function () { $("#loaderimage").hide(); }, 3000);
                    $('#DisableDiv').html("");
                },
                error: function (response)
                { }
            });
        }

        function fetchDate(Condition) {
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/FetchDate',
                data: "{Id: '" + QueryId + "',condition: '" + QueryCondition + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    debugger;
                    var result = JSON.parse(response.d);
                    if (result.length > 0) {
                        for (var i = 0; i < result.length; i++) {
                            var obj = result[i];
                            if (obj.COLUMNNAME == "Months") {
                                $("[id*='div_']").removeClass('color');
                                if (Condition == "AnnualBudget") {
                                    var splitValues = obj.FILTERVALUE.split(",");
                                    for (var j = 0; j < splitValues.length; j++) {
                                        $("#div_" + splitValues[j]).addClass('color');
                                        $("#div_" + splitValues[j]).find('label').css('margin-bottom', 0);
                                    }
                                }
                                else {
                                    $("#div_" + obj.FILTERVALUE).addClass('color');
                                    $("#div_" + obj.FILTERVALUE).find('label').css('margin-bottom', 0);
                                }

                                if (Condition == "OPEX MIS" || Condition == "29 Chart" || Condition == "29 Heads") {
                                    $.each($("#tblopexmis thead tr th"), function (i, data) {
                                        if (i > 0 && data.textContent.indexOf(obj.FILTERVALUE) < 0) {
                                            $(data).text(data.textContent + " " + obj.FILTERVALUE + "-" + new Date().getFullYear().toString().substr(2, 2));
                                        }
                                    });
                                }
                            }
                            else if (obj.COLUMNNAME == "State") {
                                if (obj.FILTERVALUE != "All") {
                                    $("#selState").val(obj.FILTERVALUE);
                                }
                            }
                            else if (obj.COLUMNNAME == "NEWF2") {
                                if (obj.FILTERVALUE != "All") {
                                    $("#selNewf2").val(obj.FILTERVALUE);
                                }
                                if (Condition == "Bureau Trend-3B" || Condition == "Bureau Trend-3A" || Condition == "Bureau Opex") {
                                    $("#selNewf2").val('CITY & BUREAU EXP');
                                    $("#selNewf2").attr('disabled', 'disabled');
                                }
                            }
                            else if (obj.COLUMNNAME == "NEWF3") {
                                if (obj.FILTERVALUE != "All") {
                                    $("#selNewf3").val(obj.FILTERVALUE);
                                }
                                if (Condition == "Bureau Trend-3B" || Condition == "Bureau Trend-3A" || Condition == "Bureau Opex") {
                                    $("#selNewf3").val('CITY & BUREAU EXP');
                                    $("#selNewf3").attr('disabled', 'disabled');
                                }
                            }
                            else if (obj.COLUMNNAME == "NEWF4") {
                                if (obj.FILTERVALUE != "All") {
                                    $("#selNewf4").val(obj.FILTERVALUE);
                                }
                            }

                            else if (obj.COLUMNNAME == "ACCOUNTNUMBER_RACCT") {
                                if (obj.FILTERVALUE != "All") {
                                    $("#selGlcode").val(obj.FILTERVALUE);
                                }
                            }

                            else if (obj.COLUMNNAME == "PRODUCT") {
                                if (obj.FILTERVALUE != "All") {
                                    $("#selProduct").val(obj.FILTERVALUE);
                                }
                            }
                            else if (obj.COLUMNNAME == "BUSINESSAREA_GSBER") {
                                if (obj.FILTERVALUE != "All") {
                                    $("#selBusinessarea").val(obj.FILTERVALUE);
                                }
                            }
                        }
                        //setTimeout(function () { $("#loaderimage").hide(); }, 3000);
                        $('#DisableDiv').html("");
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function fetchfiltervalues() {
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/FetchfilterValues',
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    var result = response.d;
                    if (result.objstate != null) {
                        var html = "<option value=0>State</option>";
                        $.each(result.objstate, function (i) {
                            html += '<option value="' + result.objstate[i].Name + '">' + result.objstate[i].Name + '</option>';
                        });
                        $("#selState").html(html);
                    }

                    if (result.objnewf2 != null) {
                        var html = "<option value=0>Group</option>";
                        $.each(result.objnewf2, function (i) {
                            html += '<option value="' + result.objnewf2[i].Name + '">' + result.objnewf2[i].Name + '</option>';
                        });

                        $("#selNewf2").html(html);
                    }

                    if (result.objnewf3 != null) {
                        var html = "<option value=0>SubGroupA</option>";
                        $.each(result.objnewf3, function (i) {
                            html += '<option value="' + result.objnewf3[i].Name + '">' + result.objnewf3[i].Name + '</option>';
                        });

                        $("#selNewf3").html(html);
                    }

                    if (result.objnewf4 != null) {
                        var html = "<option value=0>SubGroupB</option>";
                        $.each(result.objnewf4, function (i) {
                            html += '<option value="' + result.objnewf4[i].Name + '">' + result.objnewf4[i].Name + '</option>';
                        });

                        $("#selNewf4").html(html);
                    }

                    if (result.objglcode != null) {
                        var html = "<option value=0>GLCode</option>";
                        $.each(result.objglcode, function (i) {
                            html += '<option value="' + result.objglcode[i].Name + '">' + result.objglcode[i].Name + '</option>';
                        });

                        $("#selGlcode").html(html);
                    }

                    if (result.objproduct != null) {
                        var html = "<option value=0>Product</option>";
                        $.each(result.objproduct, function (i) {
                            html += '<option value="' + result.objproduct[i].Name + '">' + result.objproduct[i].Name + '</option>';
                        });

                        $("#selProduct").html(html);
                    }

                    if (result.objbusiness != null) {
                        var html = "<option value=0>BusinessArea</option>";
                        $.each(result.objbusiness, function (i) {
                            html += '<option value="' + result.objbusiness[i].Name + '">' + result.objbusiness[i].Name + '</option>';
                        });
                        $("#selBusinessarea").html(html);
                    }
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        //start annualbudget
        function update(id, item,grp) {
            //To Determine Whether Expand/Collapse Function By Checking The Status Of Button As Plus/Minus
            if ($('#id_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                if (grp == "NEWF2") {
                    var x = $('#id_' + id);
                    x[0].style.backgroundColor = "white";
                }
                //Checking With Flag As To Add Column And Append value Or Just To Append Value
                if (flag == false) {
                    flag = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';

                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstleveldetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table class='update tablefont'>";

                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='update1(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#id_' + id).find('td:first').after('<td>' + html + '</td>');
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#id_' + id).find('td:last').removeClass('show').addClass('hide');
                    $('#thheadtotal').html("");
                    $('#thheadtotal').html("Acc/No" + "<span style='margin-left: 60px;'>Total</span>");
                }
                else {
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update tablefont' >";
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='update1(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#id_' + id).find('td:first').after('<td>' + html + '</td>');
                    $('#id_' + id).find('td:last').removeClass('show').addClass('hide');
                }
            }
            else {
                if (grp == "NEWF2") {
                    var x = $('#id_' + id);
                    x[0].style.backgroundColor = "powderblue";
                }

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
                url: '/WebForm1.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account: '',Profit: '',Cost: '',level: '" + 1 + "',query:'" + queryname + "'}",
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
                        html = "<table class='update1 tablefont' id='profit_" + id + "' >";
                        totalhtml = "<table id='profittoal_" + id + "' class='tablefont'>";

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
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='update2(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }

                    //$('#firstLevel_' + id).find('td:last').html('<td>' + html + '</td>')
                    $('#firstLevel_' + id).find('td:last').html(html);

                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //$('#firstLevel_' + id).find('td:last').removeClass('show').addClass('hide');
                    $('#thheadtotal').html("");
                    $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 60px;'>Profit Center</span>" + "<span style='margin-left: 50px;'>Total</span>");
                }
                else {
                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update1 tablefont' id='profit_" + id + "' >";
                        totalhtml = "<table id='profittoal_" + id + "' class='tablefont'>";

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
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='update2(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
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
                $('#firstLevel_' + id).find('table').html("");
                $('#firstLevel_' + id).find('td:last').html(total);
                // $('#thheadtotal').html("<span>Acc/No</span>" + "<span>Total</span>");
                $('#thheadtotal').html("Acc/No" + "<span style='margin-left: 60px;'>Total</span>");
                flagLevel1 = false;
            }
        }

        function getsecondleveldetails(id, item) {
            var accobjlist = null;
            AccNo = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account: '" + AccNo + "',Profit: '',Cost: '',level: '" + 2 + "',query:'" + queryname + "'}",
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
            if ($('#secondlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel2 == false) {
                    flagLevel2 = true;

                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getthirdleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "' >";
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='update3(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }

                    //$('#secondlevel_' + id).find('td:last').html('<td>' + html + '</td>');
                    $('#secondlevel_' + id).find('td:last').html(html);
                    $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 60px;'>Profit Center</span>" + "<span style='margin-left: 65px;'>Cost Center</span>" + "<span style='margin-left: 70px;'>Total</span>");
                }
                else {
                    var accobj = getthirdleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='update3(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
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
                $('#secondlevel_' + id).find('table').html("");
                $('#secondlevel_' + id).find('td:last').html(total);
                // $('#thheadtotal').html("<span>Acc/No</span>" + "<span>Profit Center</span>" + "<span>Total</span>");
                $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 60px;'>Profit Center</span>" + "<span style='margin-left: 65px;'>Total</span>");
                flagLevel2 = false;
            }
        }

        function getthirdleveldetails(id, item) {
            var accobjlist = null;
            Profitcenter = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '',level: '" + 3 + "',query:'" + queryname + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }

        function update3(id, item) {
            if ($('#thirdlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                if (flagLevel3 == false) {
                    flagLevel3 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfourthleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
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
                        html = "<table class='update3 tablefont' id='order_nan'>";
                        html += "<tr id='fourthlevel_nan' ><td>0</td><td>0</td></tr>";
                        html += '</table>';
                    }

                    $('#thirdlevel_' + id).find('td:last').html(html);
                    $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 60px;'>Profit Center</span>" + "<span style='margin-left: 50px;'>Cost Center</span>" + "<span style='margin-left: 70px;'>Order Number</span>" + "<span style='margin-left: 65px;'>Total</span>");
                }
                else {
                    var accobj = getfourthleveldetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
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
                        html = "<table class='update3 tablefont' id='order_nan'>";
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
                $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 60px;'>Profit Center</span>" + "<span style='margin-left: 50px;'>Cost Center</span>" + "<span style='margin-left: 70px;'>Total</span>");
                flagLevel3 = false;
            }
        }

        function getfourthleveldetails(id, item) {
            var accobjlist = null;
            costcenter = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridData',
                data: "{Head: '" + Head + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '" + costcenter + "',level: '" + 4 + "',query:'" + queryname + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }
        //end

        //start bureau
        function updatebureautrend(id, item) {
            //To Determine Whether Expand/Collapse Function By Checking The Status Of Button As Plus/Minus
            if ($('#id_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
               
                //Checking With Flag As To Add Column And Append value Or Just To Append Value
                if (flag == false) {
                    flag = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';

                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstlevelbureaudetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table class='updateone tablefont'>";

                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend1(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#id_' + id).find('td:first').after('<td>' + html + '</td>');
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#id_' + id).find('td:last').removeClass('show').addClass('hide');

                    $('#thheadtotalbureau').html("");
                    $('#thheadtotalbureau').html("GLName" + "<span style='margin-left: 225px;'>Total</span>");
                }
                else {
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstlevelbureaudetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update tablefont' >";
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend1(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span> &nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
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
                $('#thheadtotalbureau').html("<span>Total</span>");

                flag = false;
            }
        }

        function getfirstlevelbureaudetails(id, item) {
            Head = item;
            var accobjlist = null;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridDataBureau',
                data: "{Head: '" + Head + "',Glname:'',Account: '',Profit: '',Cost: '',level: '" + 1 + "',queryname:'" + queryname + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }

        function updatebureautrend1(id, item) {
            //To Determine Whether Expand/Collapse Function By Checking The Status Of Button As Plus/Minus
            if ($('#firstLevel_' + id).find('td:first').find('i').hasClass('fa-minus-circle') == false) {
                var x = $('#id_' + id);
                x[0].style.backgroundColor = "white";
                //Setting Head Value For Fetching Data
                Head = $('#firstLevel_' + id).parent().parent().parent().parent().children(":eq(0)").text();

                //Checking With Flag As To Add Column And Append value Or Just To Append Value
                if (flagLevel1 == false) {
                    flagLevel1 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';

                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondlevelbureaudetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table class='update1 tablefont' id='profit_" + id + "'>";
                        totalhtml = "<table id='profittoal_" + id + "' class='tablefont'>";

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
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend2(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }

                    //$('#firstLevel_' + id).find('td:last').html('<td>' + html + '</td>')
                    $('#firstLevel_' + id).find('td:last').html(html);

                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //$('#firstLevel_' + id).find('td:last').removeClass('show').addClass('hide');
                    $('#thheadtotalbureau').html("");
                    $('#thheadtotalbureau').html("<span>GLName</span>" + "<span style='margin-left: 225px;'>AccNo</span>" + "<span style='margin-left: 90px;'>Total</span>");
                }

                else {

                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondlevelbureaudetails(id, item);

                    if (accobj.length > 0) {
                        html = "<table class='update1 tablefont' id='profit_" + id + "'>";
                        totalhtml = "<table id='profittoal_" + id + "' class='tablefont'>";

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
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend2(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
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
                var x = $('#id_' + id);
                x[0].style.backgroundColor = "yello";
                $('#firstLevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                var total = 0;
                var objrow = $("#firstLevel_" + id).find('tr');
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    total = total + parseInt($(obj).find('td:last').html());
                }
                $('#firstLevel_' + id).find('table').html("");
                $('#firstLevel_' + id).find('td:last').html(total);
                // $('#thheadtotal').html("<span>Acc/No</span>" + "<span>Total</span>");
                $('#thheadtotalbureau').html("GLName" + "<span style='margin-left: 225px;'>Total</span>");
                flagLevel1 = false;
            }
        }

        function getsecondlevelbureaudetails(id, item) {
            var accobjlist = null;
            Glname = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridDataBureau',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account: '',Profit: '',Cost: '',level: '" + 2 + "',queryname:'" + queryname + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }

        function updatebureautrend2(id, item) {
            if ($('#secondlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel2 == false) {
                    flagLevel2 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getthirdlevelbureaudetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var input = data.AccountNumber;
                            var dynID = id.toString() + i.toString();
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend3(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }

                    //$('#secondlevel_' + id).find('td:last').html('<td>' + html + '</td>');
                    $('#secondlevel_' + id).find('td:last').html(html);
                    $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $("#thheadtotalbureau").html("");
                    $('#thheadtotalbureau').html("<span>GLName</span>" + "<span style='margin-left: 225px;'>AccNo</span>" + "<span style='margin-left: 90px;'>Profit Center</span>" + "<span style='margin-left: 50px;'>Total</span>");
                }
                else {
                    var accobj = getthirdlevelbureaudetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend3(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
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
                $('#thheadtotalbureau').html("<span>GLName</span>" + "<span style='margin-left: 225px;'>Acc No</span>" + "<span style='margin-left: 90px;'>Total</span>");
                flagLevel2 = false;
            }
        }

        function updatebureautrend3(id, item) {
            if ($('#thirdlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel3 == false) {
                    flagLevel3 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfourthlevelbureaudetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='fourthlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend4(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }

                    else {
                        html = "<table class='update3 tablefont' id='order_nan'>";
                        html += "<tr id='fourthlevel_nan' ><td><span onclick='updatebureautrend4(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;0</td><td>0</td></tr>";
                        html += '</table>';
                    }
                    $('#thirdlevel_' + id).find('td:last').html(html);
                    $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $("#thheadtotalbureau").html("");
                    $('#thheadtotalbureau').html("<span>GL Name</span>" + "<span style='margin-left: 220px;'>Acc/No</span>" + "<span style='margin-left: 82px;'>Profit Center</span>" + "<span style='margin-left: 50px;'>Cost Center</span>" + "<span style='margin-left: 75px;'>Total</span>");
                }
                else {
                    var accobj = getfourthlevelbureaudetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";

                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='fourthlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureautrend4(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                        $('#thirdlevel_' + id).find('td:last').html(html);

                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                    else {
                        html = "<table class='update3 tablefont' id='order_nan'>";
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
                $('#thheadtotalbureau').html("<span>GLName</span>" + "<span style='margin-left: 200px;'>Acc No</span>" + "<span style='margin-left: 70px;'>Profit Center</span>" + "<span style='margin-left: 50px;'>Total</span>");
                flagLevel3 = false;
            }
        }

        function updatebureautrend4(id, item) {
            if ($('#fourthlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel4 == false) {
                    flagLevel4 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfifthlevelbureaudetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update4 tablefont' id='order_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='fifthlevel_" + dynID + "'><td>" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                    }

                    else {
                        html = "<table class='update4 tablefont' id='order_nan'>";
                        html += "<tr id='fifthlevel_nan' ><td>0</td><td>0</td></tr>";
                        html += '</table>';
                    }
                    $('#fourthlevel_' + id).find('td:last').html(html);
                    $('#fourthlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $("#thheadtotalbureau").html("");
                    $('#thheadtotalbureau').html("<span>GL Name</span>" + "<span style='margin-left: 200px;'>Acc/No</span>" + "<span style='margin-left: 70px;'>Profit Center</span>" + "<span style='margin-left: 50px;'>Cost Center</span>" + "<span style='margin-left: 75px;'>Order Number</span>" + "<span style='margin-left: 50px;'>Total</span>");
                }
                else {
                    var accobj = getfifthlevelbureaudetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.AccountNumber;
                            if (data.AccountNumber == "") {
                                data.AccountNumber = 0;
                            }
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='fourthlevel_" + dynID + "'><td><span onclick='update4(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.AccountNumber + "</td><td>" + data.Total + "</td></tr>";
                        });
                        html += '</table>';
                        $('#fourthlevel_' + id).find('td:last').html(html);

                        $('#fourthlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                    else {
                        html = "<table class='update3 tablefont' id='order_nan'>";
                        html += "<tr id='fourthlevel_nan' ><td>0</td><td>0</td></tr>";
                        html += '</table>';
                        $('#fourthlevel_' + id).find('td:last').html(html);

                        $('#fourthlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                }
            }
            else {
                $('#fourthlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

                var total = 0;
                var objrow = $("#fourthlevel_" + id).find('tr');
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    total = total + parseInt($(obj).find('td:last').html());
                }
                $('#fourthlevel_' + id).find('table').html("")
                $('#fourthlevel_' + id).find('td:last').html(total);
                // $('#thheadtotal').html("<span>Acc/No</span>" + "<span>Profit Center</span>" + "<span>Cost Center</span>" + "<span>Total</span>");
                $('#thheadtotalbureau').html("<span>Acc/No</span>" + "<span style='margin-left: 72px;'>GL Name</span>" + "<span style='margin-left: 72px;'>Profit Center</span>" + "<span style='margin-left: 80px;'>Cost Center</span>" + "<span style='margin-left: 65px;'>Total</span>");
                flagLevel4 = false;

            }
        }

        function getthirdlevelbureaudetails(id, item) {
            var accobjlist = null;
            AccNo = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridDataBureau',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account:  '" + AccNo + "',Profit: '',Cost: '',level: '" + 3 + "',queryname:'" + queryname + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }

        function getfourthlevelbureaudetails(id, item) {
            var accobjlist = null;
            Profitcenter = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridDataBureau',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '',level: '" + 4 + "',queryname:'" + queryname + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }


        function getfifthlevelbureaudetails(id, item) {
            var accobjlist = null;
            Cost = item;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridDataBureau',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '" + Cost + "',level: '" + 5 + "',queryname:'" + queryname + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }
        //end

        //start trend 3 dot opex
        function updatetrendaccno(id, item,grp) {
            //To Determine Whether Expand/Collapse Function By Checking The Status Of Button As Plus/Minus
            if ($('#id_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                if (grp == "NEWF2") {
                    var x = $('#id_' + id);
                    x[0].style.backgroundColor = "white";
                }
                //Checking With Flag As To Add Column And Append value Or Just To Append Value
                if (flag == false) {
                    flag = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update tablefont' >";
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.Head;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatetrendprofitcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }

                    $('#id_' + id).find('td:first').next().html(html);
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');

                    $('#thheadingtrendopex').html("");
                    $("#thheadingtrendopex").html("<span>AccNo</span><span style='margin-left: 90px'>Budget</span><span style='margin-left: 70px'>Actual</span><span style='margin-left: 80px'>Jobwork</span><span style='margin-left: 60px'>AdjustedActual</span><span style='margin-left: 60px'>Variance</span>");
                }
                else {
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update tablefont'>";
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.Head;
                            var dynID = id.toString() + i.toString();

                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatetrendprofitcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#id_' + id).find('td:first').next().html(html);
                }
            }
            else {
                if (grp == "NEWF2") {
                    var x = $('#id_' + id);
                    x[0].style.backgroundColor = "powderblue";
                }
                $('#id_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                var budget = 0;
                var actual = 0;
                var jobwork = 0;
                var adjustedactual = 0;
                var variance = 0;
                var html = '';
                var objrow = $('#id_' + id).find('td:first').next().find('.update').find('table').find('tr');
                html = '<table class="cols_width tablefont">';
                //                for (var i = 0; i < objrow.length; i++) {
                //                    var obj = objrow[i];
                //                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                //                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                //                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                //                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                //                    variance = variance + parseInt($($(obj).find('td')[4]).html());

                //                }
                //                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + jobwork + "</td><td>" + adjustedactual + "</td><td>" + variance + "</td></tr>";
                var totalobj = totaltrenddotopexlist(item);
                if (totalobj.length > 0) {
                    $.each(totalobj, function (i, data) {
                        html += "<tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr>";
                    });
                }
                html += "</table>";
                $('#id_' + id).find('td:first').next().html(html);
                // $("#thheadingtrendopex").html("<td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                $("#thheadingtrendopex").html("<span>Budget</span><span>Actual</span><span>Jobwork</span><span>AdjustedActual</span><span>Variance</span>");
                flag = false;
            }
        }


        function totaltrenddotopexlist(item) {
            var objtotal = null;

            var url = '/WebForm1.aspx/RequestDataTrendbysingleitem';
            $.ajax({
                type: "POST",
                url: url,
                data: "{id: '" + QueryId + "',item: '" + item + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    objtotal = response.d;
                },
                error: function (err) {
                }
            });
            return objtotal;
        }

        function updatetrendprofitcenter(id, item) {
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
                        html = "<table class='update1 tablefont' id='profit_" + id + "'>";
                        totalhtml = "<table id='profittoal_" + id + "' class='tablefont'>";
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
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatecostcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#firstLevel_' + id).find('table').remove();
                    $('#firstLevel_' + id).find('td:last').html(html);
                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //$('#firstLevel_' + id).find('td:last').removeClass('show').addClass('hide');
                    $('#thheadingtrendopex').html("");
                    //$("#thheadingtrendopex").html("<td>AccNo</td><td>Profit Center</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                    $("#thheadingtrendopex").html("<span>AccNo</span><span style='margin-left: 90px'>Profit Center</span><span style='margin-left: 90px'>Budget</span><span style='margin-left: 60px'>Actual</span><span style='margin-left: 60px'>Jobwork</span><span style='margin-left: 60px'>AdjustedActual</span><span style='margin-left: 60px'>Variance</span>");
                }
                else {
                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update1 tablefont' id='profit_" + id + "'>";

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
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatecostcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.JobWork + "</td><td>" + data.AdjustedActual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
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
                html = "<table class='tablefont'>";
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());
                }
                html += "<tr><td>" + commaSeparateNumber(budget) + "</td><td>" + commaSeparateNumber(actual) + "</td><td>" + commaSeparateNumber(jobwork) + "</td><td>" + commaSeparateNumber(adjustedactual) + "</td><td>" + commaSeparateNumber(variance) + "</td></tr>";
                html += "</table>";
                $('#firstLevel_' + id).find('table').remove();
                $('#firstLevel_' + id).find('td:last').html(html);
                $("#thheadingtrendopex").html("<span>AccNo</span><span>Budget</span><span>Actual</span><span>Jobwork</span><span>AdjustedActual</span><span>Variance</span>");
                //$("#thheadingtrendopex").html("<td>AccNo</td><td>Budget</td><td>Actual</td><td>Jobwork</td><td>AdjustedActual</td><td>Variance</td>");
                flagLevel1 = false;
            }
        }
        function updatecostcenter(id, item) {
            if ($('#secondlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel2 == false) {
                    flagLevel2 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getthirdleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "'>";
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
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updateordernumber(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#secondlevel_' + id).find('table').remove();
                    $('#secondlevel_' + id).find('td:last').html(html);

                    $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');

                    $("#thheadingtrendopex").html("<span>AccNo</span><span style='margin-left: 90px'>Profit Center</span><span style='margin-left: 70px'>Cost Center</span><span style='margin-left: 60px'>Budget</span><span style='margin-left: 70px'>Actual</span><span style='margin-left: 60px'>Jobwork</span><span style='margin-left: 60px'>AdjustedActual</span><span style='margin-left: 60px'>Variance</span>");
                }
                else {
                    var accobj = getthirdleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "'>"
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
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updateordernumber(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.Head + "</td><td><table class='tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
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
                html = "<table class='tablefont'>";
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());
                }
                html += "<tr><td>" + commaSeparateNumber(budget) + "</td><td>" + commaSeparateNumber(actual) + "</td><td>" + commaSeparateNumber(jobwork) + "</td><td>" + commaSeparateNumber(adjustedactual) + "</td><td>" + commaSeparateNumber(variance) + "</td></tr>";
                html += "</table>";

                $('#secondlevel_' + id).find('table').remove();
                $('#secondlevel_' + id).find('td:last').html(html);

                $("#thheadingtrendopex").html("<span>AccNo</span><span>Profit Center</span><span>Budget</span><span>Actual</span><span>Jobwork</span><span>AdjustedActual</span><span>Variance</span>");
                flagLevel2 = false;
            }
        }
        function updateordernumber(id, item) {
            if ($('#thirdlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel3 == false) {
                    flagLevel3 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfourthleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
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
                            html += "<tr id='fourthlevel_" + dynID + "'><td>" + data.Head + "</td><td><table class='tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    else {
                        html = "<table class='update3 tablefont' id='order_nan'>";
                        html += "<tr id='fourthlevel_nan' ><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>";
                        html += '</table>';
                    }

                    $('#thirdlevel_' + id).find('table').remove();
                    $('#thirdlevel_' + id).find('td:last').html(html);
                    $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $("#thheadingtrendopex").html("<span>AccNo</span><span style='margin-left: 90px'>Profit Center</span><span style='margin-left: 80px'>Cost Center</span><span style='margin-left: 60px'>Order Number</span><span style='margin-left: 60px'>Budget</span><span style='margin-left: 70px'>Actual</span><span style='margin-left: 90px'>Jobwork</span><span style='margin-left: 90px'>AdjustedActual</span><span style='margin-left: 90px'>Variance</span>");
                }
                else {
                    var accobj = getfourthleveltrenddetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
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
                            html += "<tr id='fourthlevel_" + dynID + "'><td>" + data.Head + "</td><td><table class='tablefont'><tr><td>" + commaSeparateNumber(data.Budget) + "</td><td>" + commaSeparateNumber(data.Actual) + "</td><td>" + commaSeparateNumber(data.JobWork) + "</td><td>" + commaSeparateNumber(data.AdjustedActual) + "</td><td>" + commaSeparateNumber(data.Variance) + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                        $('#thirdlevel_' + id).find('table').remove();
                        $('#thirdlevel_' + id).find('td:last').html(html);
                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                    else {
                        html = "<table class='update3 tablefont' id='order_nan'>"
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
                html = "<table class='tablefont'>";
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    jobwork = jobwork + parseInt($($(obj).find('td')[2]).html());
                    adjustedactual = adjustedactual + parseInt($($(obj).find('td')[3]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());
                }
                html += "<tr><td>" + commaSeparateNumber(budget) + "</td><td>" + commaSeparateNumber(actual) + "</td><td>" + commaSeparateNumber(jobwork) + "</td><td>" + commaSeparateNumber(adjustedactual) + "</td><td>" + commaSeparateNumber(variance) + "</td></tr>";
                html += "</table>";
                $('#thirdlevel_' + id).find('table').remove();
                $('#thirdlevel_' + id).find('td:last').html(html);
                $("#thheadingtrendopex").html("<span>AccNo</span>Profit Center</span><span>Cost Center</span><span>Budget</span><span>Actual</span><span>Jobwork</span><span>AdjustedActual</span><span>Variance</span>");
                flagLevel3 = false;
            }
        }
        function getfirstleveltrenddetails(id, item) {
            Head = item;
            var accobjlist = null;
            $.ajax({
                type: "POST",
                url: '/WebForm1.aspx/SubgridDataTrend',
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
                url: '/WebForm1.aspx/SubgridDataTrend',
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
                url: '/WebForm1.aspx/SubgridDataTrend',
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
                url: '/WebForm1.aspx/SubgridDataTrend',
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
        //end

        //start bureau opex
        function getfirstlevelglnamedetails(id, item) {
            Head = item;
            var accobjlist = null;
            $.ajax({
                type: "POST",
                url: 'SubgridDataBureauopex',
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
        function updatebureauglname(id, item) {
            //To Determine Whether Expand/Collapse Function By Checking The Status Of Button As Plus/Minus
            if ($('#id_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
               
                //Checking With Flag As To Add Column And Append value Or Just To Append Value
                if (flag == false) {
                    flag = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstlevelglnamedetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update tablefont'>"
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.name;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureauaccno(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.name + "</td><td><table class='maintable tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }

                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#id_' + id).find('td:first').next().html(html);
                    $('#thheadingbureauopex').html("");
                    $('#thheadingbureauopex').html('<span>GlName</span><span style="margin-left: 75px;">Budget</span><span style="margin-left: 204px;">Actual</span><span style="margin-left: 243px;">Variance</span>');
                }
                else {
                    $('#id_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    //Get Data For Selected Value From DataBase
                    var accobj = getfirstlevelglnamedetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update tablefont'>";
                        //Creating Table With Dynamic Value For Total And AccNumber Column 
                        $.each(accobj, function (i, data) {
                            var input = data.name;
                            var dynID = id.toString() + i.toString();
                            if (data.Total == "") {
                                data.Total = 0;
                            }
                            html += "<tr id='firstLevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureauaccno(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span> &nbsp;&nbsp;" + data.name + "</td><td><table class='maintable tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#id_' + id).find('td:first').next().html(html);
                    $('#id_' + id).find('td:last').removeClass('show').addClass('hide');
                }
            }
            else {
                $('#id_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                var budget = 0;
                var actual = 0;

                var variance = 0;
                var html = '';
                var objrow = $('#id_' + id).find('td:first').next().find('.update').find('table').find('tr');
                html = "<table class='tablefont'>";
                //                for (var i = 0; i < objrow.length; i++) {
                //                    var obj = objrow[i];
                //                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                //                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                //                   
                //                    variance = variance + parseInt($($(obj).find('td')[2]).html());
                //                }
                //                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + variance + "</td></tr>";
                var totalobj = totalburealist(item);
                if (totalobj.length > 0) {
                    $.each(totalobj, function (i, data) {
                        html += "<tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr>";
                    });
                }
                html += "</table>";
                $('#id_' + id).find('td:first').next().html(html);
                flag = false;
                $("#thheadingbureauopex").html('<span style="margin-left: 4px;">Budget</span><span style="margin-left: 278px;">Actual</span><span style="margin-left: 293px;">Variance</span>');
            }
        }

        function totalburealist(item) {
            var objtotal = null;

            var url = 'RequestDataBureauOpextotalbysingeitem';
            $.ajax({
                type: "POST",
                url: url,
                data: "{id: '" + QueryId + "',item: '" + item + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    objtotal = response.d;
                },
                error: function (err) {
                }
            });
            return objtotal;
        }

        function updatebureauaccno(id, item) {
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
                    var accobj = getsecondlevelaccnodetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update1 tablefont' id='profit_" + id + "'>";
                        //Creating Table With Dynamic Value For Total And Profit Column 
                        $.each(accobj, function (i, data) {
                            var input = data.name;
                            var dynID = id.toString() + i.toString();
                            if (data.name == "") {
                                data.name = "";
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureprofitcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.name + "</td><td><table class='maintable tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#firstLevel_' + id).find('table').remove();
                    $('#firstLevel_' + id).find('td:last').html(html);
                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#thheadingbureauopex').html("");
                    $('#thheadingbureauopex').html('<span>GlName</span><span style="margin-left: 97px;">AccNo</span><span style="margin-left: 93px;">Budget</span><span style="margin-left: 240px;">Actual</span><span style="margin-left: 243px;">Variance</span>');
                }
                else {
                    //Get Data For Selected Value From DataBase
                    var accobj = getsecondlevelaccnodetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update1 tablefont' id='profit_" + id + "'>";
                        //Creating Table With Dynamic Value For Total And Profit Column 
                        $.each(accobj, function (i, data) {
                            var input = data.name;
                            var dynID = id.toString() + i.toString();
                            if (data.name == "") {
                                data.name = "";
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }
                            html += "<tr id='secondlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureprofitcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.name + "</td><td><table class='maintable tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#firstLevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#firstLevel_' + id).find('table').remove();
                    $('#firstLevel_' + id).find('td:last').html(html);

                }
            }
            else {
                $('#firstLevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                var budget = 0;
                var actual = 0;
                var variance = 0;
                var html = '';
                var objrow = $("#firstLevel_" + id).find('.update1').find('table').find('tr');
                html = "<table class='tablefont'>";
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    variance = variance + parseInt($($(obj).find('td')[2]).html());
                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";
                $('#firstLevel_' + id).find('table').remove();
                $('#firstLevel_' + id).find('td:last').html(html);

                $('#thheadingbureauopex').html('<span>GlName</span><span style="margin-left: 93px;">Budget</span><span style="margin-left: 240px;">Actual</span><span style="margin-left: 243px;">Variance</span>');
                flagLevel1 = false;
            }
        }
        function getsecondlevelaccnodetails(id, item) {
            var accobjlist = null;
            Glname = item;
            $.ajax({
                type: "POST",
                url: 'SubgridDataBureauopex',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account: '',Profit: '',Cost: '',level: '" + 2 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }
        function updatebureprofitcenter(id, item) {
            if ($('#secondlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel2 == false) {
                    flagLevel2 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getthirdlevelprofitcenterdetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var input = data.name;
                            var dynID = id.toString() + i.toString();
                            if (data.name == "") {
                                data.name = "";
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureaucostcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.name + "</td><td><table class='tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    $('#secondlevel_' + id).find('table').remove();
                    $('#secondlevel_' + id).find('td:last').html(html);
                    $('#secondlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#thheadingbureauopex').html('<span>GlName</span><span style="margin-left: 87px;">AccNo</span><span style="margin-left: 140px;">Profit Center</span><span style="margin-left: 83px;">Budget</span><span style="margin-left: 120px;">Actual</span><span style="margin-left: 120px;">Variance</span>');
                }
                else {
                    var accobj = getthirdlevelprofitcenterdetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update2 tablefont' id='cost_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var input = data.name;
                            var dynID = id.toString() + i.toString();
                            if (data.name == "") {
                                data.name = "";
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }
                            html += "<tr id='thirdlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureaucostcenter(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.name + "</td><td><table class='tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
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
                var variance = 0;
                var html = '';
                var objrow = $("#secondlevel_" + id).find('.update2').find('table').find('tr');
                html = "<table class='tablefont'>";
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    variance = variance + parseInt($($(obj).find('td')[4]).html());
                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";
                $('#secondlevel_' + id).find('table').remove()
                $('#secondlevel_' + id).find('td:last').html(html);
                $('#thheadingbureauopex').html('<span>GlName</span><span style="margin-left: 97px;">AccNo</span><span style="margin-left: 93px;">Budget</span><span style="margin-left: 240px;">Actual</span><span style="margin-left: 243px;">Variance</span>');
                flagLevel2 = false;
            }
        }
        function updatebureaucostcenter(id, item) {
            if ($('#thirdlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel3 == false) {
                    flagLevel3 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfourthlevelcostcenterdetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.name;
                            if (data.name == "") {
                                data.name = "";
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }

                            html += "<tr id='fourthlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureauordernumber(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.name + "</td><td><table class='tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    else {
                        html = "<table class='update3 tablefont' id='order_nan'>";
                        html += "<tr id='fourthlevel_nan' ><td><span onclick='updatebureauordernumber(0,0)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;0</td><td>0</td><td>0</td><td>0</td></tr>";
                        html += '</table>';
                    }
                    $('#thirdlevel_' + id).find('table').remove();
                    $('#thirdlevel_' + id).find('td:last').html(html);
                    $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    $('#thheadingbureauopex').html('<span>GlName</span><span style="margin-left: 88px;">AccNo</span><span style="margin-left: 96px;">Profit Center</span><span style="margin-left: 76px;">Cost Center</span><span style="margin-left: 16px;">Budget</span><span style="margin-left: 87px;">Actual</span><span style="margin-left: 62px;">Variance</span>');
                }
                else {
                    var accobj = getfourthlevelcostcenterdetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update3 tablefont' id='order_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.name;
                            if (data.name == "") {
                                data.name = "";
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }
                            html += "<tr id='fourthlevel_" + dynID + "'><td><span style='cursor:pointer;' onclick='updatebureauordernumber(\"" + dynID + "\",\"" + input + "\")'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;" + data.name + "</td><td><table class='tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                        $('#thirdlevel_' + id).find('table').remove();
                        $('#thirdlevel_' + id).find('td:last').html(html);
                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                    else {
                        html = "<table class='update3 tablefont' id='order_nan'>"
                        html += "<tr id='fourthlevel_nan' ><td><span onclick='updatebureauordernumber(0,0)'><i class='fa fa-plus-circle' aria-hidden='true'></i></span>&nbsp;&nbsp;0</td><td>0</td><td>0</td><td>0</td></tr>";
                        html += '</table>';
                        $('#thirdlevel_' + id).find('table').remove();
                        $('#thirdlevel_' + id).find('td:last').html(html);
                        $('#thirdlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                }
            }
            else {
                $('#thirdlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                var budget = 0;
                var actual = 0;
                var variance = 0;
                var html = '';
                var objrow = $("#thirdlevel_" + id).find('.update3').find('table').find('tr');
                html = "<table class='tablefont'>";
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());

                    variance = variance + parseInt($($(obj).find('td')[2]).html());
                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";
                $('#thirdlevel_' + id).find('table').remove()
                $('#thirdlevel_' + id).find('td:last').html(html);
                $('#thheadingbureauopex').html('<span>GlName</span><span style="margin-left: 87px;">AccNo</span><span style="margin-left: 140px;">Profit Center</span><span style="margin-left: 83px;">Budget</span><span style="margin-left: 120px;">Actual</span><span style="margin-left: 120px;">Variance</span>');
                flagLevel3 = false;
            }
        }

        function updatebureauordernumber(id, item) {
            if ($('#fourthlevel_' + id).find('td:first').children().children().hasClass("fa-minus-circle") == false) {
                //if ($('#id_' + id).find('i').hasClass("fa-minus-circle") == false) {
                if (flagLevel4 == false) {
                    flagLevel4 = true;
                    var html = '';
                    var totalhtml = '';
                    var html1 = '';
                    var accobj = getfifthlevelordernumberdetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update4 tablefont' id='order_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();

                            if (data.name == "") {
                                data.name = 0;
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }
                            html += "<tr id='fifthlevel_" + dynID + "'><td>" + data.name + "</td><td><table class='update5 tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                    }
                    else {
                        html = "<table class='update4 tablefont' id='order_nan'>";
                        html += "<tr id='fifthlevel_nan' ><td>0</td><td><table class='update5 tablefont'><tr><td>0</td><td>0</td><td>0</td></tr></table></td></tr>";
                        html += '</table>';
                    }
                    $('#fourthlevel_' + id).find('table').remove();
                    $('#fourthlevel_' + id).find('td:last').html(html);
                    //  $('#fourthlevel_' + id).find('td:last').html(html);
                    $('#fourthlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');

                    $('#thheadtotal').html("<span>Acc/No</span>" + "<span>GL Name</span>" + "<span>Profit Center</span>" + "<span>Cost Center</span>" + "<span> Order Number</span>");
                }
                else {
                    var accobj = getfifthlevelordernumberdetails(id, item);
                    if (accobj.length > 0) {
                        html = "<table class='update4 tablefont' id='order_" + id + "'>";
                        $.each(accobj, function (i, data) {
                            var dynID = id.toString() + i.toString();
                            var input = data.name;
                            if (data.name == "") {
                                data.name = "";
                            }
                            if (data.Budget == "") {
                                data.Budget = 0;
                            }
                            if (data.Actual == "") {
                                data.Actual = 0;
                            }
                            if (data.Variance == "") {
                                data.Variance = 0;
                            }
                            html += "<tr id='fifthlevel_" + dynID + "'><td>" + data.name + "</td><td><table class='update5 tablefont'><tr><td>" + data.Budget + "</td><td>" + data.Actual + "</td><td>" + data.Variance + "</td></tr></table></td></tr>";
                        });
                        html += '</table>';
                        $('#fourthlevel_' + id).find('table').remove();
                        $('#fourthlevel_' + id).find('td:last').html(html);
                        $('#fourthlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');

                    }
                    else {
                        html = "<table class='update4 tablefont' id='order_nan'>";
                        html += "<tr id='fifthlevel_nan' ><td>0</td><td><table class='update5 tablefont'><tr><td>0</td><td>0</td><td>0</td></tr></table></td></tr>";
                        html += '</table>';
                        $('#fourthlevel_' + id).find('table').remove();
                        $('#fourthlevel_' + id).find('td:last').html(html);
                        $('#fourthlevel_' + id).find('td:first').find('i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                    }
                }
            }
            else {
                $('#fourthlevel_' + id).find('i').removeClass('fa-minus-circle').addClass('fa-plus-circle');

                var budget = 0;
                var actual = 0;
                var variance = 0;
                var html = '';
                var objrow = $("#fourthlevel_" + id).find('.update3').find('table').find('tr');
                html = "<table class='tablefont'>";
                for (var i = 0; i < objrow.length; i++) {
                    var obj = objrow[i];
                    budget = budget + parseInt($($(obj).find('td')[0]).html());
                    actual = actual + parseInt($($(obj).find('td')[1]).html());
                    variance = variance + parseInt($($(obj).find('td')[2]).html());
                }
                html += "<tr><td>" + budget + "</td><td>" + actual + "</td><td>" + variance + "</td></tr>";
                html += "</table>";
                $('#fourthlevel_' + id).find('table').remove();
                $('#fourthlevel_' + id).find('td:last').html(html);
                $('#thheadtotal').html("<span>Acc/No</span>" + "<span style='margin-left: 72px;'>GL Name</span>" + "<span style='margin-left: 72px;'>Profit Center</span>" + "<span style='margin-left: 80px;'>Cost Center</span>" + "<span style='margin-left: 65px;'>Total</span>");
                flagLevel4 = false;
            }
        }
        function getthirdlevelprofitcenterdetails(id, item) {
            var accobjlist = null;
            AccNo = item;
            $.ajax({
                type: "POST",
                url: 'SubgridDataBureauopex',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account:  '" + AccNo + "',Profit: '',Cost: '',level: '" + 3 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }
        function getfourthlevelcostcenterdetails(id, item) {
            var accobjlist = null;
            Profitcenter = item;
            $.ajax({
                type: "POST",
                url: 'SubgridDataBureauopex',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '',level: '" + 4 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }
        function getfifthlevelordernumberdetails(id, item) {
            var accobjlist = null;
            Cost = item;
            $.ajax({
                type: "POST",
                url: 'SubgridDataBureauopex',
                data: "{Head: '" + Head + "',Glname:'" + Glname + "',Account:  '" + AccNo + "',Profit: '" + Profitcenter + "',Cost: '" + Cost + "',level: '" + 5 + "'}",
                contentType: "application/json; charset=utf-8",
                async: false,
                success: function (response) {
                    accobjlist = response.d;
                },
                error: function (err) { console.log(err); }
            });
            return accobjlist;
        }
        //end

        function commaSeparateNumber(val) {
            while (/(\d+)(\d{3})/.test(val.toString())) {
                val = val.toString().replace(/(\d+)(\d{3})/, '$1' + ',' + '$2');
            }
            return val;
        }

    </script>
    <script type="text/javascript">
        function keydown(Cat, InputVal) {
            var e = event.keyCode || event.which;
            if (e == 13 | e == 38 || e == 40) {
                $.ajax({
                    type: "POST",
                    url: '/WebForm1.aspx/GetMasterData11',
                    data: "{category: '" + Cat + "',InputVal:'" + InputVal + "'}",
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (response) {
                        var data = response.d;
                        alert("saved successfully");
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });

            }
        }

        function keydown2(Cat, InputVal) {
            var e = event.keyCode || event.which;
            if (e == 13 | e == 38 || e == 40) {
                $.ajax({
                    type: "POST",
                    url: '/WebForm1.aspx/GetMasterData12',
                    data: "{category: '" + Cat + "',InputVal:'" + InputVal + "'}",
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (response) {
                        var data = response.d;
                        alert("saved successfully");
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });

            }
        }

        function keydown3(Cat, InputVal) {
            var e = event.keyCode || event.which;
            if (e == 13 | e == 38 || e == 40) {
                $.ajax({
                    type: "POST",
                    url: '/WebForm1.aspx/GetMasterData13',
                    data: "{category: '" + Cat + "',InputVal:'" + InputVal + "'}",
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    success: function (response) {
                        var data = response.d;
                        alert("saved successfully");
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });

            }
        }
        
    </script>
</asp:Content>
