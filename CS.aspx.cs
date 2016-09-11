using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

public partial class CS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int increment = 0;
        if (!IsPostBack)
        {
           
           
            DataTable dtmain = GetData("select * from  sheet2$");
            //DataTable tablenewf4 = new DataTable();
            //tablenewf4.Columns.Add("Head", typeof(string));
            //tablenewf4.Columns.Add("Months", typeof(string));
            //tablenewf4.Columns.Add("Total", typeof(string));
            //tablenewf4.Columns.Add("Group", typeof(string));
            

            // //string[] selectedColumns = new[] { "NEWF2" };
            // //DataTable dt = new DataView(dtmain).ToTable(false, selectedColumns);

            //decimal finaltotal = 0;
            // for (int i = 0; i < dtmain.Rows.Count; i++)
            // {
                 
            //       string title = dtmain.Rows[i]["Newf2"].ToString();                
            //         bool exists = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title)).Count() > 0;
            //         if (exists == false)
            //         {

            //             increment = 0;
            //             tablenewf4.Rows.Add(dtmain.Rows[i]["Newf2"].ToString(), dtmain.Rows[i]["Months"].ToString(), 0, "NEWF2");
            //             decimal total = 0;
            //             // finaltotal = finaltotal + Convert.ToDecimal(dtmain.Rows[i]["Budget"].ToString());
            //             var items = dtmain.Select("Newf2 = '" + title + "'").Distinct().ToList();

            //             for (int j = 0; j < items.Count(); j++)
            //             {
                            
            //                 string title1 = items[j]["Newf3"].ToString();
            //                 bool exists1 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title1)).Count() > 0;
            //                 if (exists1 == false)
            //                 {
            //                     tablenewf4.Rows.Add(items[j]["Newf3"].ToString(), items[j]["Months"].ToString(), items[j]["Budget"].ToString(), "NEWF3");
            //                     //total = total + Convert.ToDecimal(items[j]["Budget"].ToString());
            //                     // finaltotal = finaltotal + Convert.ToDecimal(items[j]["Budget"].ToString());
            //                     var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
            //                     for (int k = 0; k < items1.Count(); k++)
            //                     {
            //                         tablenewf4.Rows.Add(items1[k]["Newf4"].ToString(), items1[k]["Months"].ToString(), items1[k]["Budget"].ToString(), "NEWF4");
            //                         total = total + Convert.ToDecimal(items1[k]["Budget"].ToString());
            //                         // finaltotal = finaltotal + total;
            //                     }

            //                     DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            //                     if (dr1 != null)
            //                     {
            //                         dr1["Total"] = total; //changes the Product_name                                 
            //                         finaltotal = finaltotal + total;
            //                         total = 0;

            //                     }
            //                 }
            //                 else
            //                 {
                                
            //                     if(title == title1 && increment == 0)
            //                     {
            //                         var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
            //                         for (int k = 0; k < items1.Count(); k++)
            //                         {
            //                             tablenewf4.Rows.Add(items1[k]["Newf4"].ToString(), items1[k]["Months"].ToString(), items1[k]["Budget"].ToString(), "NEWF4");
            //                             total = total + Convert.ToDecimal(items1[k]["Budget"].ToString());
            //                             // finaltotal = finaltotal + total;
            //                         }

            //                         DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            //                         if (dr1 != null)
            //                         {
            //                             dr1["Total"] = total; //changes the Product_name                                        
            //                             finaltotal = finaltotal + total;
            //                             total = 0;

            //                         }
            //                         increment++;
            //                     }
            //                 }
            //             }

            //             DataRow dr = tablenewf4.Select("Head = '" + title + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            //             if (dr != null)
            //             {
            //                 dr["Total"] = finaltotal; //changes the Product_name
            //                 finaltotal = 0;
            //             }
            //         }

                 
                
            // }
            
            DataTable tablenewf4 = new DataTable();
            tablenewf4.Columns.Add("HEAD", typeof(string));
            tablenewf4.Columns.Add("MONTHS", typeof(string));
            tablenewf4.Columns.Add("BUDGET", typeof(string));
            tablenewf4.Columns.Add("ACTUAL", typeof(string));
            tablenewf4.Columns.Add("JOBWORK", typeof(string));
            tablenewf4.Columns.Add("ADJUSTEDACTUAL", typeof(string));
            tablenewf4.Columns.Add("VARIANCE", typeof(string));
            tablenewf4.Columns.Add("GROUP", typeof(string));
            tablenewf4.Columns.Add("flag", typeof(string));
            //string[] selectedColumns = new[] { "NEWF2" };
            //DataTable dt = new DataView(dtmain).ToTable(false, selectedColumns);

            int finaltotalbudget = 0;
            int finaltotalactual = 0;
            int finaltotaljobwork = 0;
            int finaltotaladjuatedactual = 0;
            int finaltotalvariance = 0;
            for (int i = 0; i < dtmain.Rows.Count; i++)
            {

                string title = dtmain.Rows[i]["NEWF2"].ToString();
                bool exists = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title)).Count() > 0;
                if (exists == false)
                {

                    increment = 0;
                    tablenewf4.Rows.Add(dtmain.Rows[i]["NEWF2"].ToString(), dtmain.Rows[i]["MONTHS"].ToString(), dtmain.Rows[i]["BUDGET"].ToString(), dtmain.Rows[i]["ACTUAL"].ToString(), dtmain.Rows[i]["JOBWORK"].ToString(), dtmain.Rows[i]["ADJUSTEDACTUAL"].ToString(), dtmain.Rows[i]["VARIANCE"].ToString(), "NEWF2","false");
                    int totalbudget = 0;
                    int totalactual = 0;
                    int totaljobwork = 0;
                    int totaladjuatedactual = 0;
                    int totalvariance = 0;
                    // finaltotal = finaltotal + Convert.ToDecimal(dtmain.Rows[i]["Budget"].ToString());
                    var items = dtmain.Select("NEWF2 = '" + title + "'").Distinct().ToList();

                    for (int j = 0; j < items.Count(); j++)
                    {

                        string title1 = items[j]["NEWF3"].ToString();
                        bool exists1 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title1)).Count() > 0;
                        if (exists1 == false)
                        {
                            tablenewf4.Rows.Add(items[j]["NEWF3"].ToString(), items[j]["MONTHS"].ToString(), items[j]["BUDGET"].ToString(), items[j]["ACTUAL"].ToString(), items[j]["JOBWORK"].ToString(), items[j]["ADJUSTEDACTUAL"].ToString(), items[j]["VARIANCE"].ToString(), "NEWF3","false");

                            var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
                            for (int k = 0; k < items1.Count(); k++)
                            {
                                string title2 = items1[k]["NEWF4"].ToString();
                                bool exists3 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title2)).Count() > 0;
                                if (exists3 == false)
                                {
                                    tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString(), "NEWF4","false");
                                    totalbudget = totalbudget + Convert.ToInt32(items1[k]["BUDGET"].ToString());
                                    totalactual = totalactual + Convert.ToInt32(items1[k]["ACTUAL"].ToString());
                                    totaljobwork = totaljobwork + Convert.ToInt32(items1[k]["JOBWORK"].ToString());
                                    totaladjuatedactual = totaladjuatedactual + Convert.ToInt32(items1[k]["ADJUSTEDACTUAL"].ToString());
                                    totalvariance = totalvariance + Convert.ToInt32(items1[k]["VARIANCE"].ToString());
                                }
                                else
                                {
                                    if (title1 == title2)
                                    {
                                        DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                                        if (dr1 != null)
                                        {
                                            dr1["flag"] = "true"; //changes the Product_name   

                                            totalbudget = Convert.ToInt32(items1[k]["BUDGET"].ToString());
                                            totalactual = Convert.ToInt32(items1[k]["ACTUAL"].ToString());
                                            totaljobwork =  Convert.ToInt32(items1[k]["JOBWORK"].ToString());
                                            totaladjuatedactual = Convert.ToInt32(items1[k]["ADJUSTEDACTUAL"].ToString());
                                            totalvariance =  Convert.ToInt32(items1[k]["VARIANCE"].ToString());

                                        }
                                    }



                                }

                            }

                            DataRow dr2 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                            if (dr2 != null)
                            {
                                dr2["BUDGET"] = totalbudget; //changes the Product_name                                 
                                finaltotalbudget = finaltotalbudget + totalbudget;
                                totalbudget = 0;


                                dr2["ACTUAL"] = totalactual; //changes the Product_name                                 
                                finaltotalactual = finaltotalactual + totalactual;
                                totalactual = 0;


                                dr2["JOBWORK"] = totaljobwork; //changes the Product_name                                 
                                finaltotaljobwork = finaltotaljobwork + totaljobwork;
                                totaljobwork = 0;


                                dr2["ADJUSTEDACTUAL"] = totaladjuatedactual; //changes the Product_name                                 
                                finaltotaladjuatedactual = finaltotaladjuatedactual + totaladjuatedactual;
                                totaladjuatedactual = 0;

                                dr2["VARIANCE"] = totalvariance; //changes the Product_name                                 
                                finaltotalvariance = finaltotalvariance + totalvariance;
                                totalvariance = 0;



                            }
                        }
                        else
                        {

                            if (title == title1 && increment == 0)
                            {
                                var items1 = dtmain.Select("NEWF2 = '" + title + "' and NEWF3 ='" + title1 + "'");
                                for (int k = 0; k < items1.Count(); k++)
                                {

                                    tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString(), "NEWF4","false");
                                    // total = total + Convert.ToInt32(items1[k]["TOTAL"].ToString());
                                    totalbudget = totalbudget + Convert.ToInt32(items1[k]["BUDGET"].ToString());
                                    totalactual = totalactual + Convert.ToInt32(items1[k]["ACTUAL"].ToString());
                                    totaljobwork = totaljobwork + Convert.ToInt32(items1[k]["JOBWORK"].ToString());
                                    totaladjuatedactual = totaladjuatedactual + Convert.ToInt32(items1[k]["ADJUSTEDACTUAL"].ToString());
                                    totalvariance = totalvariance + Convert.ToInt32(items1[k]["VARIANCE"].ToString());

                                }

                                DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                                if (dr1 != null)
                                {
                                    dr1["BUDGET"] = totalbudget; //changes the Product_name                                 
                                    finaltotalbudget = finaltotalbudget + totalbudget;
                                    totalbudget = 0;


                                    dr1["ACTUAL"] = totalactual; //changes the Product_name                                 
                                    finaltotalactual = finaltotalactual + totalactual;
                                    totalactual = 0;


                                    dr1["JOBWORK"] = totaljobwork; //changes the Product_name                                 
                                    finaltotaljobwork = finaltotaljobwork + totaljobwork;
                                    totaljobwork = 0;


                                    dr1["ADJUSTEDACTUAL"] = totaladjuatedactual; //changes the Product_name                                 
                                    finaltotaladjuatedactual = finaltotaladjuatedactual + totaladjuatedactual;
                                    totaladjuatedactual = 0;

                                    dr1["VARIANCE"] = totalvariance; //changes the Product_name                                 
                                    finaltotalvariance = finaltotalvariance + totalvariance;
                                    totalvariance = 0;

                                }
                                increment++;
                            }
                        }
                    }

                    DataRow dr = tablenewf4.Select("Head = '" + title + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                    if (dr != null)
                    {
                        dr["BUDGET"] = finaltotalbudget; //changes the Product_name
                        finaltotalbudget = 0;

                        dr["ACTUAL"] = finaltotalbudget; //changes the Product_name
                        finaltotalactual = 0;


                        dr["JOBWORK"] = finaltotaljobwork; //changes the Product_name
                        finaltotaljobwork = 0;


                        dr["ADJUSTEDACTUAL"] = finaltotaladjuatedactual; //changes the Product_name
                        finaltotaladjuatedactual = 0;


                        dr["VARIANCE"] = finaltotalvariance; //changes the Product_name
                        finaltotalvariance = 0;

                    }
                }
            }
            gvParentTrend.DataSource = tablenewf4;
            gvParentTrend.DataBind();
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

    //protected void Show_Hide_OrdersGrid(object sender, EventArgs e)
    //{
    //    ImageButton imgShowHide = (sender as ImageButton);
    //    GridViewRow row = (imgShowHide.NamingContainer as GridViewRow);
    //    if (imgShowHide.CommandArgument == "Show")
    //    {
    //        row.FindControl("pnlOrders").Visible = true;
    //        imgShowHide.CommandArgument = "Hide";
    //        imgShowHide.ImageUrl = "~/images/minus.png";
    //        string customerId = gvCustomers.DataKeys[row.RowIndex].Value.ToString();
    //        GridView gvOrders = row.FindControl("gvOrders") as GridView;
    //        BindOrders(customerId, gvOrders);
    //    }
    //    else
    //    {
    //        row.FindControl("pnlOrders").Visible = false;
    //        imgShowHide.CommandArgument = "Show";
    //        imgShowHide.ImageUrl = "~/images/plus.png";
    //    }
    //}

    //private void BindOrders(string customerId, GridView gvOrders)
    //{
    //    gvOrders.ToolTip = customerId;
    //    gvOrders.DataSource = GetData(string.Format("select * from sheet1$ where NEWF2='{0}'", customerId));
    //    gvOrders.DataBind();
    //}

    //protected void OnOrdersGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView gvOrders = (sender as GridView);
    //    gvOrders.PageIndex = e.NewPageIndex;
    //    BindOrders(gvOrders.ToolTip, gvOrders);
    //}

    //protected void Show_Hide_ProductsGrid(object sender, EventArgs e)
    //{
    //    ImageButton imgShowHide = (sender as ImageButton);
    //    GridViewRow row = (imgShowHide.NamingContainer as GridViewRow);
    //    if (imgShowHide.CommandArgument == "Show")
    //    {
    //        row.FindControl("pnlProducts").Visible = true;
    //        imgShowHide.CommandArgument = "Hide";
    //        imgShowHide.ImageUrl = "~/images/minus.png";
    //        string orderId = Convert.ToString((row.NamingContainer as GridView).DataKeys[row.RowIndex].Value);
    //        GridView gvProducts = row.FindControl("gvProducts") as GridView;
    //        BindProducts(orderId, gvProducts);
    //    }
    //    else
    //    {
    //        row.FindControl("pnlProducts").Visible = false;
    //        imgShowHide.CommandArgument = "Show";
    //        imgShowHide.ImageUrl = "~/images/plus.png";
    //    }
    //}

    //private void BindProducts(string orderId, GridView gvProducts)
    //{
    //    gvProducts.ToolTip = orderId.ToString();
    //    gvProducts.DataSource = GetData(string.Format("SELECT * from sheet1$ WHERE NEWF3 = '{0}'", orderId));
    //    gvProducts.DataBind();
    //}

    //protected void OnProductsGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView gvProducts = (sender as GridView);
    //    gvProducts.PageIndex = e.NewPageIndex;
      
    //}
    //protected void gvCustomers_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        //If Salary is less than 10000 than set the row Background Color to Cyan  
    //        if (e.Row.Cells[3].Text == "NEWF2")
    //        {
    //            e.Row.ForeColor = Color.Blue;
    //            e.Row.Font.Bold = true;
                
    //        }
    //        else if (e.Row.Cells[3].Text == "NEWF3")
    //        {
    //             e.Row.ForeColor = Color.Red;
    //             e.Row.Font.Bold = true;
    //        }
    //        else if(e.Row.Cells[3].Text == "NEWF4")
    //        {
                 
    //        }
    //    }  
    //}
    protected void gvParentTrend_RowDataBound(object sender, GridViewRowEventArgs e)
    {

       
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //If Salary is less than 10000 than set the row Background Color to Cyan  
            if (e.Row.Cells[6].Text == "NEWF2")
            {
                e.Row.ForeColor = Color.Blue;
                e.Row.Font.Bold = true;
                
            }
            else if (e.Row.Cells[6].Text == "NEWF3" && e.Row.Cells[7].Text == "false")
            {
                 e.Row.ForeColor = Color.Red;
                 e.Row.Font.Bold = true;
            }
            
        }  
    }

    protected void gvParentTrend_DataBound(object sender, EventArgs e)
    {
        GridViewRow row = new GridViewRow(0,0, DataControlRowType.Header, DataControlRowState.Normal);
        TableHeaderCell cell = new TableHeaderCell();
        cell.Text = "Months";
        cell.ColumnSpan = 1;
        row.Controls.Add(cell);

        TableHeaderCell cell1 = new TableHeaderCell();
        cell1.Text = "Apr";
        cell1.ColumnSpan = 7;
        row.Controls.Add(cell1);

        //cell = new TableHeaderCell();
        //cell.ColumnSpan = 2;
        //cell.Text = "Employees";
        //row.Controls.Add(cell);

        row.BackColor = ColorTranslator.FromHtml("#3AC0F2");
        gvParentTrend.HeaderRow.Parent.Controls.AddAt(0, row);
    }
}