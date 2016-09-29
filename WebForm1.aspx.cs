using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.OracleClient;
using System.Data;
using System.Configuration;
using System.Web.Script.Services;

namespace DBCLWebReports1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private static string connStr = ConfigurationManager.ConnectionStrings["OracleConnectionString"].ConnectionString.ToString();
        private static OracleConnection _dconn = null;
        public static int increment = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class AnnualbudgetClass
        {
            public string Head { get; set; }
            public string Months { get; set; }
            public string Total { get; set; }
            public string Group { get; set; }
            public string flag { get; set; }
        }

        public class Subgrid1Class
        {
            public string AccountNumber { get; set; }
            public string Total { get; set; }
        }
        [WebMethod]
        
        public static  List<AnnualbudgetClass> RequestData(int id, string condition)
        {
           List<AnnualbudgetClass> obj=new List<AnnualbudgetClass>();
            DataTable dt = new DataTable();
            string result = string.Empty;
            try
            {
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand("FetchReportData", _dconn);
                    cmd.Parameters.Add("P_Id", OracleType.Int32).Value = id;
                    cmd.Parameters.Add("P_Condition", OracleType.VarChar).Value = condition;
                    cmd.Parameters.Add("P_UserId", OracleType.Int32).Value = Convert.ToInt32("15");
                    cmd.Parameters.Add(new OracleParameter("ReportDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(new OracleParameter("TableConfig", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(new OracleParameter("Title", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    using (DataSet ds = new DataSet())
                    {
                        adp.Fill(dt);
                    }
                    
                }
                DataTable dtmain = GroupingAnnualBudget(dt);
                obj = (from DataRow row in dtmain.Rows
                       select new AnnualbudgetClass()
                       {
                           Head=row["Head"].ToString(),
                           Months = row["Months"].ToString(),
                           Total = row["Total"].ToString(),
                           Group = row["Group"].ToString(),
                           flag = row["flag"].ToString()
                       }).ToList();
                
            }
            catch (Exception Ex)
            {
                obj = null;
            }
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
                using (OracleConnection con = new OracleConnection(connStr))
                {
                    con.Open();
                    OracleCommand cmd = new OracleCommand("FETCHANNUALDATA", con);
                    cmd.Parameters.Add("P_Head", OracleType.NVarChar).Value = Head;
                    cmd.Parameters.Add("P_Account", OracleType.NVarChar).Value = Account;
                    cmd.Parameters.Add("P_Profit", OracleType.NVarChar).Value = Profit;
                    cmd.Parameters.Add("P_CostCenter", OracleType.NVarChar).Value = Cost;
                    cmd.Parameters.Add("P_Level", OracleType.Int32).Value = level;
                    cmd.Parameters.Add(new OracleParameter("ReportDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    adp.Fill(dt);
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

        public static DataTable GroupingAnnualBudget(DataTable dtmain)
        {

            DataTable tablenewf4 = new DataTable();
            tablenewf4.Columns.Add("Head", typeof(string));
            tablenewf4.Columns.Add("Months", typeof(string));
            tablenewf4.Columns.Add("Total", typeof(string));
            tablenewf4.Columns.Add("Group", typeof(string));
            tablenewf4.Columns.Add("flag", typeof(string));

            //string[] selectedColumns = new[] { "NEWF2" };
            //DataTable dt = new DataView(dtmain).ToTable(false, selectedColumns);

            int finaltotal = 0;
            for (int i = 0; i < dtmain.Rows.Count; i++)
            {

                string title = dtmain.Rows[i]["NEWF2"].ToString();
                bool exists = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title)).Count() > 0;
                if (exists == false)
                {

                    increment = 0;
                    tablenewf4.Rows.Add(dtmain.Rows[i]["NEWF2"].ToString(), dtmain.Rows[i]["MONTHS"].ToString(), 0, "NEWF2", "false");
                    int total = 0;
                    // finaltotal = finaltotal + Convert.ToDecimal(dtmain.Rows[i]["Budget"].ToString());
                    var items = dtmain.Select("NEWF2 = '" + title + "'").Distinct().ToList();

                    for (int j = 0; j < items.Count(); j++)
                    {

                        string title1 = items[j]["NEWF3"].ToString();
                        bool exists1 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title1)).Count() > 0;
                        if (exists1 == false)
                        {
                            tablenewf4.Rows.Add(items[j]["NEWF3"].ToString(), items[j]["MONTHS"].ToString(), items[j]["TOTAL"].ToString(), "NEWF3", "false");
                            //total = total + Convert.ToDecimal(items[j]["Budget"].ToString());
                            // finaltotal = finaltotal + Convert.ToDecimal(items[j]["Budget"].ToString());
                            var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
                            for (int k = 0; k < items1.Count(); k++)
                            {
                                string title2 = items1[k]["NEWF4"].ToString();
                                bool exists3 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("HeaD").Equals(title2)).Count() > 0;
                                if (exists3 == false)
                                {
                                    tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["TOTAL"].ToString(), "NEWF4", "false");
                                    total = total + Convert.ToInt32(items1[k]["TOTAL"].ToString());
                                }
                                else
                                {
                                    if (title1 == title2)
                                    {
                                        DataRow dr2 = tablenewf4.Select("Head ='" + title1 + "'").FirstOrDefault();
                                        if (dr2 != null)
                                        {
                                            dr2["flag"] = "true";
                                            total = total + Convert.ToInt32(items1[k]["TOTAL"].ToString());

                                        }
                                    }
                                }
                                // finaltotal = finaltotal + total;
                            }

                            DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                            if (dr1 != null)
                            {

                                dr1["TOTAL"] = total; //changes the Product_name                                 
                                finaltotal = finaltotal + total;
                                total = 0;

                            }
                        }
                        else
                        {

                            if (title == title1 && increment == 0)
                            {
                                var items1 = dtmain.Select("NEWF2 = '" + title + "' and NEWF3 ='" + title1 + "'");
                                for (int k = 0; k < items1.Count(); k++)
                                {
                                    tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["TOTAL"].ToString(), "NEWF4", "false");
                                    total = total + Convert.ToInt32(items1[k]["TOTAL"].ToString());
                                    // finaltotal = finaltotal + total;
                                }

                                DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                                if (dr1 != null)
                                {
                                    dr1["TOTAL"] = total; //changes the Product_name                                        
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
                        dr["TOTAL"] = finaltotal; //changes the Product_name
                        finaltotal = 0;
                    }
                }
            }
            return tablenewf4;
        }
    }
}