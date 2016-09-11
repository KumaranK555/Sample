<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CS.aspx.cs" Inherits="CS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
            color: black;
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
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("[id*=imgOrdersShow]").each(function () {
                debugger;
                if ($(this)[0].src.indexOf("minus") != -1) {
                    $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>");
                    $(this).next().remove();
                }
            });
            $("[id*=imgProductsShow]").each(function () {
                debugger;
                if ($(this)[0].src.indexOf("minus") != -1) {
                    $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>");
                    $(this).next().remove();
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <%--<asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="Grid"
        DataKeyNames="Head">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="imgOrdersShow" runat="server" OnClick="Show_Hide_OrdersGrid"
                        ImageUrl="~/images/plus.png" CommandArgument="Show" />
                    <asp:Panel ID="pnlOrders" runat="server" Visible="false" Style="position: relative">
                        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" PageSize="5"
                            AllowPaging="true" OnPageIndexChanging="OnOrdersGrid_PageIndexChanging" CssClass="ChildGrid"
                            DataKeyNames="Newf3">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgProductsShow" runat="server" OnClick="Show_Hide_ProductsGrid"
                                            ImageUrl="~/images/plus.png" CommandArgument="Show" />
                                        <asp:Panel ID="pnlProducts" runat="server" Visible="false" Style="position: relative">
                                            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="false" PageSize="2"
                                                AllowPaging="true" OnPageIndexChanging="OnProductsGrid_PageIndexChanging" CssClass="Nested_ChildGrid">
                                                <Columns>
                                                    <asp:BoundField ItemStyle-Width="150px" DataField="Months" HeaderText="Product Id" />
                                                    <asp:BoundField ItemStyle-Width="150px" DataField="Budget" HeaderText="Product Name" />
                                                </Columns>
                                            </asp:GridView>
                                        </asp:Panel>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField ItemStyle-Width="150px" DataField="Months" HeaderText="Months" />
                                <asp:BoundField ItemStyle-Width="150px" DataField="Budget" HeaderText="Budget" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField ItemStyle-Width="150px" DataField="Head" HeaderText="Head" />
            <asp:BoundField ItemStyle-Width="150px" DataField="Months" HeaderText="Months" />
            <asp:BoundField ItemStyle-Width="150px" DataField="Total" HeaderText="Total" />
             <asp:BoundField ItemStyle-Width="150px" DataField="Group" HeaderText="Group" />
        </Columns>
    </asp:GridView>--%>
           <asp:GridView ID="gvParentTrend" runat="server" AutoGenerateColumns="false" CssClass="Grid"
                            OnRowDataBound="gvParentTrend_RowDataBound" DataKeyNames="Head" OnDataBound="gvParentTrend_DataBound">
                            <Columns>
                               <asp:BoundField ItemStyle-Width="450px" DataField="HEAD" HeaderText="HEAD" />
                              <asp:BoundField ItemStyle-Width="450px" DataField="BUDGET" HeaderText="BUDGET" />
                                <asp:BoundField ItemStyle-Width="100px" DataField="ACTUAL" HeaderText="ACTUAL" />
                                <asp:BoundField ItemStyle-Width="100px" DataField="JOBWORK" HeaderText="JOBWORK" />
                                <asp:BoundField ItemStyle-Width="100px" DataField="ADJUSTEDACTUAL" HeaderText="ADJUSTEDACTUAL"  />
                                 <asp:BoundField ItemStyle-Width="100px" DataField="VARIANCE" HeaderText="VARIANCE"  />
                                  <asp:BoundField ItemStyle-Width="100px" DataField="Group" HeaderText="Group" HeaderStyle-CssClass="hidecol"
                                    ItemStyle-CssClass="hidecol" />
                                  <asp:BoundField ItemStyle-Width="100px" DataField="flag" HeaderText="flag" HeaderStyle-CssClass="hidecol"
                                    ItemStyle-CssClass="hidecol" />
                            </Columns>
                            </asp:GridView>
    </form>
</body>
</html>
