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


public partial class trendopex : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    public class Subgrid1Class
    {
        public string Head { get; set; }
        public string Budget { get; set; }
        public string Actual { get; set; }
        public string JobWork { get; set; }
        public string AdjustedActual { get; set; }
        public string Variance { get; set; }
    }
    public class commonclass
    {
        public string Head { get; set; }
        public string Months { get; set; }
        public string Budget { get; set; }
        public string Actual { get; set; }
        public string JobWork { get; set; }
        public string AdjustedActual { get; set; }
        public string Variance { get; set; }
        public string Group { get; set; }
        public string flag { get; set; }
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
                cmd.CommandText = "select * from  sheet2$";
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
                tablenewf4.Rows.Add(dtmain.Rows[i]["NEWF2"].ToString(), dtmain.Rows[i]["MONTHS"].ToString(), dtmain.Rows[i]["BUDGET"].ToString(), dtmain.Rows[i]["ACTUAL"].ToString(), dtmain.Rows[i]["JOBWORK"].ToString(), dtmain.Rows[i]["ADJUSTEDACTUAL"].ToString(), dtmain.Rows[i]["VARIANCE"].ToString(), "NEWF2", "false");
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
                        tablenewf4.Rows.Add(items[j]["NEWF3"].ToString(), items[j]["MONTHS"].ToString(), items[j]["BUDGET"].ToString(), items[j]["ACTUAL"].ToString(), items[j]["JOBWORK"].ToString(), items[j]["ADJUSTEDACTUAL"].ToString(), items[j]["VARIANCE"].ToString(), "NEWF3", "false");

                        var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
                        for (int k = 0; k < items1.Count(); k++)
                        {
                            string title2 = items1[k]["NEWF4"].ToString();
                            bool exists3 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title2)).Count() > 0;
                            if (exists3 == false)
                            {
                                tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString(), "NEWF4", "false");
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
                                        totaljobwork = Convert.ToInt32(items1[k]["JOBWORK"].ToString());
                                        totaladjuatedactual = Convert.ToInt32(items1[k]["ADJUSTEDACTUAL"].ToString());
                                        totalvariance = Convert.ToInt32(items1[k]["VARIANCE"].ToString());

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

                                tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString(), "NEWF4", "false");
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

        List<commonclass> obj = (from DataRow row in tablenewf4.Rows
                                 select new commonclass()
                                 {
                                     
                                     Head = row["Head"].ToString(),
                                     Months = row["Months"].ToString(),
                                     Budget = row["BUDGET"].ToString(),
                                     Actual = row["ACTUAL"].ToString(),
                                     JobWork = row["JOBWORK"].ToString(),
                                     AdjustedActual = row["ADJUSTEDACTUAL"].ToString(),
                                     Variance = row["VARIANCE"].ToString(),
                                     Group = row["GROUP"].ToString(),
                                     flag = row["flag"].ToString()
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
                        cmd.CommandText = "Qry_trend";
                    }
                    else if (level == 2)
                    {
                        cmd.CommandText = "Qry_trend1";
                    }
                    else if (level == 3)
                    {
                        cmd.CommandText = "Qry_trend2";
                    }
                    else if (level == 4)
                    {
                        cmd.CommandText = "Qry_trend3";

                    }
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Head", Head);                   
                        cmd.Parameters.AddWithValue("@Account", Account);
                        cmd.Parameters.AddWithValue("@Profit", Profit);
                        cmd.Parameters.AddWithValue("@Cost", Cost);
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
                       
                       Head= row[0].ToString(),
                       Budget=row[1].ToString(),
                       Actual = row[2].ToString(),
                       JobWork = row[3].ToString(),
                       AdjustedActual=row[4].ToString(),
                       Variance = row[5].ToString()
                   }).ToList();
        }
        catch (Exception Ex)
        {
            obj = null;
        }
        return obj;
    }

}