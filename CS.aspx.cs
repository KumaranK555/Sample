using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class CS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            gvCustomers.DataSource = GetData("select top 10 * from Customers");
            gvCustomers.DataBind();
        }
    }

    private static DataTable GetData(string query)
    {
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = query;
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }

    protected void Show_Hide_ChildGrid(object sender, EventArgs e)
    {
        ImageButton imgShowHide = (sender as ImageButton);
        GridViewRow row = (imgShowHide.NamingContainer as GridViewRow);
        if (imgShowHide.CommandArgument == "Show")
        {
            row.FindControl("pnlOrders").Visible = true;
            imgShowHide.CommandArgument = "Hide";
            imgShowHide.ImageUrl = "~/images/minus.png";
            string customerId = gvCustomers.DataKeys[row.RowIndex].Value.ToString();
            GridView gvOrders = row.FindControl("gvOrders") as GridView; gvOrders.ToolTip = customerId;
            gvOrders.DataSource = GetData(string.Format("select * from Orders where CustomerId='{0}'", customerId));
            gvOrders.DataBind();
        }
        else
        {
            row.FindControl("pnlOrders").Visible = false;
            imgShowHide.CommandArgument = "Show";
            imgShowHide.ImageUrl = "~/images/plus.png";
        }
    }

    private void BindOrders(string customerId, GridView gvOrders)
    {
        gvOrders.ToolTip = customerId;
        gvOrders.DataSource = GetData(string.Format("select * from Orders where CustomerId='{0}'", customerId));
        gvOrders.DataBind();
    }
    protected void OnChildGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView gvOrders = (sender as GridView);
        gvOrders.PageIndex = e.NewPageIndex;
        BindOrders(gvOrders.ToolTip, gvOrders);
    }
}