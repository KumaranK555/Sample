using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
   
    public class commonclass1
    {
        public string NewF2 { get; set; }
        public string NewF3 { get; set; }
        public string NewF4 { get; set; }

        public string Months { get; set; }

        public string Budget { get; set; }


    }
    public class Subgrid1Class
    {
        public string AccountNumber { get; set; }
        public string Total { get; set; }
    }
    public class commonclass
    {
        public string Head { get; set; }
        public string Months { get; set; }
        public string Total { get; set; }

        public string Group { get; set; }
    }
    [System.Web.Services.WebMethod]
    [ScriptMethod(UseHttpGet = true)]
    public static List<commonclass> GetDetails()
    {
        int increment = 0;
        DataTable dtmain;
    
        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select * from  sheet1$";
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        dtmain = new DataTable();
                        sda.Fill(dtmain);
                       
                    }
                }
            }
        }

        DataTable tablenewf4 = new DataTable();
        tablenewf4.Columns.Add("Head", typeof(string));
        //tablenewf4.Columns.Add("Months", typeof(string));
        tablenewf4.Columns.Add("Total", typeof(string));
        tablenewf4.Columns.Add("Group", typeof(string));


        //string[] selectedColumns = new[] { "NEWF2" };
        //DataTable dt = new DataView(dtmain).ToTable(false, selectedColumns);

        decimal finaltotal = 0;
        for (int i = 0; i < dtmain.Rows.Count; i++)
        {

            string title = dtmain.Rows[i]["Newf2"].ToString();
            bool exists = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title)).Count() > 0;
            if (exists == false)
            {

                increment = 0;
                tablenewf4.Rows.Add(dtmain.Rows[i]["Newf2"].ToString(), 0, "NEWF2");
                decimal total = 0;
                // finaltotal = finaltotal + Convert.ToDecimal(dtmain.Rows[i]["Budget"].ToString());
                var items = dtmain.Select("Newf2 = '" + title + "'").Distinct().ToList();

                for (int j = 0; j < items.Count(); j++)
                {

                    string title1 = items[j]["Newf3"].ToString();
                    bool exists1 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title1)).Count() > 0;
                    if (exists1 == false)
                    {
                        tablenewf4.Rows.Add(items[j]["Newf3"].ToString(), items[j]["Budget"].ToString(), "NEWF3");
                        //total = total + Convert.ToDecimal(items[j]["Budget"].ToString());
                        // finaltotal = finaltotal + Convert.ToDecimal(items[j]["Budget"].ToString());
                        var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
                        for (int k = 0; k < items1.Count(); k++)
                        {
                            tablenewf4.Rows.Add(items1[k]["Newf4"].ToString(),  items1[k]["Budget"].ToString(), "NEWF4");
                            total = total + Convert.ToDecimal(items1[k]["Budget"].ToString());
                            // finaltotal = finaltotal + total;
                        }

                        DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                        if (dr1 != null)
                        {
                            dr1["Total"] = total; //changes the Product_name                                 
                            finaltotal = finaltotal + total;
                            total = 0;

                        }
                    }
                    else
                    {

                        if (title == title1 && increment == 0)
                        {
                            var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
                            for (int k = 0; k < items1.Count(); k++)
                            {
                                tablenewf4.Rows.Add(items1[k]["Newf4"].ToString(),  items1[k]["Budget"].ToString(), "NEWF4");
                                total = total + Convert.ToDecimal(items1[k]["Budget"].ToString());
                                // finaltotal = finaltotal + total;
                            }

                            DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                            if (dr1 != null)
                            {
                                dr1["Total"] = total; //changes the Product_name                                        
                                finaltotal = finaltotal + total;
                                total = 0;

                            }
                            increment++;
                        }
                    }
                }

                DataRow dr = tablenewf4.Select("Head = '" + title + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                if (dr != null)
                {
                    dr["Total"] = finaltotal; //changes the Product_name
                    finaltotal = 0;
                }
            }



        }



        List<commonclass> obj = (from DataRow row in tablenewf4.Rows
                                 select new commonclass()
                                 {
                                     Head = row["Head"].ToString(),
                                    
                                     Total = row["Total"].ToString(),
                                     Group = row["Group"].ToString()
                                 }).ToList();


        return obj;
    }





    [System.Web.Services.WebMethod]
    [ScriptMethod(UseHttpGet = true)]
    public static List<commonclass1> GetDetails1()
    {
        int increment = 0;
        DataTable dtmain;

        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select * from  sheet1$";
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        dtmain = new DataTable();
                        sda.Fill(dtmain);

                    }
                }
            }
        }


        List<commonclass1> obj = (from DataRow row in dtmain.Rows
                                 select new commonclass1()
                                 {
                                     NewF2 = row["NewF2"].ToString(),
                                     NewF3 = row["NewF3"].ToString(),
                                     NewF4 = row["NewF4"].ToString(),
                                     Months = row["Months"].ToString(),
                                     Budget = row["Budget"].ToString()
                                 }).ToList();


        return obj;
    }







    [WebMethod]
    public static List<Subgrid1Class> SubgridData(string Head, string Account, string Profit, string Cost, int level)
    {
        List<Subgrid1Class> obj = new List<Subgrid1Class>();
        DataTable dt = new DataTable();
        string result = string.Empty;
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {

                using (SqlCommand cmd = new SqlCommand())
                {
                    if (level == 1)
                    {
                        cmd.CommandText = "SELECT ACCOUNTNUMBER_RACCT,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Budget'AND PRODUCT !='JJ' AND MONTHS = 'Apr' AND FISCALYEAR_RYEAR=(SELECT Max(FISCALYEAR_RYEAR) FROM GLPCP) AND  (NEWF2 = '" + Head + "' or NEWF3 = '" + Head + "' or NEWF4 = '" + Head + "')  GROUP BY ACCOUNTNUMBER_RACCT ORDER BY ACCOUNTNUMBER_RACCT ASC";
                    }
                    else if (level==2)
                    {
                        cmd.CommandText = "SELECT PROFITCENTER_RPRCTR,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget' AND PRODUCT != 'JJ' AND MONTHS = 'Apr' AND FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND  (NEWF2 = '" + Head + "' or NEWF3 = '" + Head + "' or NEWF4 = '" + Head + "') AND ACCOUNTNUMBER_RACCT = '" + Account + "'  GROUP BY PROFITCENTER_RPRCTR ORDER BY PROFITCENTER_RPRCTR ASC";
                    }
                    else if(level == 3)
                    {
                        cmd.CommandText = "SELECT COSTCENTER_KOSTL,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget'  AND PRODUCT != 'JJ' AND MONTHS = 'Apr' AND  FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND (NEWF2 = '" + Head + "' or NEWF3 = '" + Head + "' or NEWF4 = '" + Head + "')  AND ACCOUNTNUMBER_RACCT = '" + Account + "'  AND PROFITCENTER_RPRCTR =  '" + Profit + "' GROUP BY COSTCENTER_KOSTL ORDER BY COSTCENTER_KOSTL ASC";
                    }
                    else if(level == 4)
                    {
                        cmd.CommandText = "SELECT ORDERNUMBER,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget'AND PRODUCT != 'JJ' AND MONTHS = 'Apr' AND  FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND  (NEWF2 = '" + Head + "' or NEWF3 = '" + Head + "' or NEWF4 = '" + Head + "') AND ACCOUNTNUMBER_RACCT =  '" + Account + "' AND PROFITCENTER_RPRCTR = '" + Profit + "' AND COSTCENTER_KOSTL = '" + Cost + "' GROUP BY ORDERNUMBER ORDER BY ORDERNUMBER ASC";

                    }
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataSet ds = new DataSet())
                        {
                            dt = new DataTable();
                            sda.Fill(dt);

                        }
                    }
                }

               
            }

            obj = (from DataRow row in dt.Rows
                   select new Subgrid1Class()
                   {
                       //AccountNumber = row["ACCOUNTNUMBER_RACCT"].ToString(),
                       //Total = row["Total"].ToString()
                       AccountNumber = row[0].ToString(),
                       Total = row[1].ToString()
                   }).ToList();
        }
        catch (Exception Ex)
        {
            obj = null;
        }
        return obj;
    }


}