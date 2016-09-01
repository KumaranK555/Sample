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
            background-color: #A1DCF2;
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
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("[src*=minus]").each(function () {
                $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>");
                $(this).next().remove()
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="Grid"
        DataKeyNames="CustomerID">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="imgShow" runat="server" OnClick="Show_Hide_ChildGrid" ImageUrl="~/images/plus.png"
                        CommandArgument="Show" />
                    <asp:Panel ID="pnlOrders" runat="server" Visible="false" Style="position: relative">
                        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" PageSize="5"
                            AllowPaging="true" OnPageIndexChanging="OnChildGrid_PageIndexChanging" CssClass="ChildGrid">
                            <Columns>
                                <asp:BoundField ItemStyle-Width="150px" DataField="OrderId" HeaderText="Order Id" />
                                <asp:BoundField ItemStyle-Width="150px" DataField="OrderDate" HeaderText="Date" />
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField ItemStyle-Width="150px" DataField="ContactName" HeaderText="Contact Name" />
            <asp:BoundField ItemStyle-Width="150px" DataField="City" HeaderText="City" />
        </Columns>
    </asp:GridView>
    </form>
</body>
</html>
