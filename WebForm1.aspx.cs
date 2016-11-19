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
using Newtonsoft.Json;

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
        public class BureauClass
        {
            public string Head { get; set; }
            public string Months { get; set; }
            public string Total { get; set; }


        }
        public class AnnualbudgetClass
        {
            public string Head { get; set; }
            public string Apr { get; set; }
            public string May { get; set; }
            public string June { get; set; }
            public string July { get; set; }
            public string Aug { get; set; }
            public string Sep { get; set; }
            public string Oct { get; set; }
            public string Nov { get; set; }
            public string Dec { get; set; }
            public string Jan { get; set; }
            public string Feb { get; set; }
            public string Mar { get; set; }
            public string Months { get; set; }
            public string Total { get; set; }
            public string Group { get; set; }
            public string flag { get; set; }
            public string Status { get; set; }
        }
        public class OpexbudgetClass
        {
            public string Head { get; set; }
            public string BudgetFTM { get; set; }
            public string ActualFTM { get; set; }
            public string CarryForward1 { get; set; }
            public string JobWorkFTM { get; set; }
            public string AdjActualFTM { get; set; }
            public string VarianceFTM { get; set; }
            public string Comments { get; set; }
            public string Variance { get; set; }
            public string BudgetYTD { get; set; }
            public string ActualYTD { get; set; }
            public string CarryForward2 { get; set; }
            public string JobWorkYTD { get; set; }
            public string AdjActualYtd { get; set; }
            public string VaianceYtd { get; set; }
            public string VarPercent { get; set; }
            public string Months { get; set; }
            public string Group { get; set; }
            public string flag { get; set; }
        }
        public class Trent3OpexClass
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
        public class Subgrid1Class
        {
            public string AccountNumber { get; set; }
            public string Total { get; set; }
        }
        public class SubgridbureauClass
        {
            public string name { get; set; }
        public string Budget { get; set; }
        public string Actual { get; set; }
        public string Variance { get; set; }
        }
        public class Subgrid2Class
        {
            public string Head { get; set; }
            public string Budget { get; set; }
            public string Actual { get; set; }
            public string JobWork { get; set; }
            public string AdjustedActual { get; set; }
            public string Variance { get; set; }
        }
        public class SubgridbureauopexClass
        {
            public string Bureau { get; set; }
            public string Budget { get; set; }
            public string Actual { get; set; }
            public string Variance { get; set; }
            public string Months { get; set; }

        }

        [WebMethod]
        public static List<BureauClass> RequestDataBureau(int id, string condition, bool InitialLoad)
        {
            List<BureauClass> obj = new List<BureauClass>();
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

                obj = (from DataRow row in dt.Rows
                       select new BureauClass()
                       {
                           Head = row["NEWF4"].ToString(),
                           Months = row["MONTHS"].ToString(),
                           Total = row["BUDGET"].ToString(),

                       }).ToList();

            }
            catch (Exception Ex)
            {
                obj = null;
            }
            return obj;
        }

        [WebMethod]
        public static List<SubgridbureauopexClass> RequestDataBureauOpextotalbysingeitem(int id, string item)
        {
            List<SubgridbureauopexClass> obj = new List<SubgridbureauopexClass>();
            DataTable dt = new DataTable();
            string result = string.Empty;
            try
            {
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand("FetchReportData", _dconn);
                    cmd.Parameters.Add("P_Id", OracleType.Int32).Value = id;
                    cmd.Parameters.Add("P_Condition", OracleType.VarChar).Value = "OPEX";
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

                obj = (from DataRow row in dt.Rows
                       where row.Field<string>("NEWF4") == item.ToString()
                       select new SubgridbureauopexClass()
                       {
                           Bureau = row["NEWF4"].ToString(),
                           Budget = row["Budget"].ToString(),
                           Actual = row["Actual"].ToString(),
                           Variance = row["VarianceVal"].ToString(),
                           Months = row["Months"].ToString()

                       }).ToList();

            }
            catch (Exception Ex)
            {
                obj = null;
            }
            return obj;
        }

        [WebMethod]
        public static List<SubgridbureauopexClass> RequestDataBureauOpex(int id, string condition, bool InitialLoad)
        {
            List<SubgridbureauopexClass> obj = new List<SubgridbureauopexClass>();
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

                obj = (from DataRow row in dt.Rows
                       select new SubgridbureauopexClass()
                       {
                           Bureau = row["NEWF4"].ToString(),
                           Budget = row["Budget"].ToString(),
                           Actual = row["Actual"].ToString(),
                           Variance = row["VarianceVal"].ToString(),
                           Months = row["Months"].ToString()

                       }).ToList();

            }
            catch (Exception Ex)
            {
                obj = null;
            }
            return obj;
        }

        [WebMethod]
        public static List<OpexbudgetClass> RequestDataOpex(int id, string condition, bool InitialLoad)
        {
            List<OpexbudgetClass> obj = new List<OpexbudgetClass>();
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
                DataTable dtmain = GroupingOPEXBudget(dt);               


                obj = (from DataRow row in dtmain.Rows
                       select new OpexbudgetClass()
                       {
                           Head = row["Head"].ToString(),
                           BudgetFTM = row["BudgetFTM"].ToString(),
                           ActualFTM = row["ActualFTM"].ToString(),
                           CarryForward1 = row["CarryForward1"].ToString(),
                           JobWorkFTM = row["JobWorkFTM"].ToString(),
                           AdjActualFTM = row["AdjActualFTM"].ToString(),
                           VarianceFTM = row["VarianceFTM"].ToString(),
                           Comments = row["Comments"].ToString(),
                           Variance = row["Variance"].ToString(),

                           BudgetYTD = row["BudgetYTD"].ToString(),
                           ActualYTD = row["ActualYTD"].ToString(),
                           CarryForward2 = row["CarryForward2"].ToString(),
                           JobWorkYTD = row["JobWorkYTD"].ToString(),
                           AdjActualYtd = row["AdjActualYtd"].ToString(),

                           VaianceYtd = row["VaianceYtd"].ToString(),
                           VarPercent = row["VarPercent"].ToString(),

                           Months = row["Months"].ToString(),
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
        public static List<AnnualbudgetClass> RequestData(int id, string condition, bool InitialLoad)
        {
            List<AnnualbudgetClass> obj=new List<AnnualbudgetClass>();
            DataTable dt = new DataTable();
            DataTable dtmain = new DataTable();
            string result = string.Empty;
            try
            {
                if (InitialLoad && condition == "ANNUAL BUDGET")
                {
                    string updateQuery = "UPDATE FILTERTABLE SET DEFAULTFILTERVALUE = 'All' WHERE QUERYID = 201";
                    using (_dconn = new OracleConnection(connStr))
                    {
                        _dconn.Open();
                        OracleCommand cmd = new OracleCommand(updateQuery, _dconn);
                        cmd.ExecuteNonQuery();
                    }

                    string query = "SELECT * FROM ANNUALBUDGETLOAD ORDER BY SORTID ASC";
                    using (_dconn = new OracleConnection(connStr))
                    {
                        _dconn.Open();
                        OracleCommand cmd = new OracleCommand(query, _dconn);
                        using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }

                    dtmain = dt;
                    obj = (from DataRow row in dtmain.Rows
                           select new AnnualbudgetClass()
                           {
                               Head = row["Head"].ToString(),
                               Apr = row["Apr"].ToString(),
                               May = row["May"].ToString(),
                               June = row["June"].ToString(),
                               July = row["July"].ToString(),
                               Aug = row["Aug"].ToString(),
                               Sep = row["Sep"].ToString(),
                               Oct = row["Oct"].ToString(),
                               Nov = row["Nov"].ToString(),
                               Dec = row["Dec"].ToString(),
                               Jan = row["Jan"].ToString(),
                               Feb = row["Feb"].ToString(),
                               Mar = row["Mar"].ToString(),
                               Months = row["Months"].ToString(),
                               Total = row["Total"].ToString(),
                               Group = row["Group"].ToString(),
                               flag = row["flag"].ToString(),
                               Status = "New"
                           }).ToList();
                }
                else
                {
                    using (_dconn = new OracleConnection(connStr))
                    {
                        _dconn.Open();
                        OracleCommand cmd = new OracleCommand("FetchAnnualBudgetData", _dconn);
                        cmd.Parameters.Add("P_Id", OracleType.Int32).Value = id;
                        //cmd.Parameters.Add("P_Condition", OracleType.VarChar).Value = condition;
                        cmd.Parameters.Add("P_UserId", OracleType.Int32).Value = Convert.ToInt32("15");
                        cmd.Parameters.Add(new OracleParameter("ReportDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                        //cmd.Parameters.Add(new OracleParameter("TableConfig", OracleType.Cursor)).Direction = ParameterDirection.Output;
                        //cmd.Parameters.Add(new OracleParameter("Title", OracleType.Cursor)).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(new OracleParameter("P_Status", OracleType.VarChar, 100)).Direction = ParameterDirection.Output;
                        cmd.CommandType = CommandType.StoredProcedure;
                        OracleDataAdapter adp = new OracleDataAdapter(cmd);
                        using (DataSet ds = new DataSet())
                        {
                            adp.Fill(dt);
                        }

                        if (cmd.Parameters["P_Status"].Value.ToString() == "N")
                        {
                            dtmain = dt;
                            obj = (from DataRow row in dtmain.Rows
                                   select new AnnualbudgetClass()
                                   {
                                       Head = row["Head"].ToString(),
                                       //Apr = row["Apr"] == null ? "" : row["Apr"].ToString(),
                                       Apr = row.Table.Columns["Apr"] == null ? "NoColumn" : row["Apr"].ToString(),
                                       May = row.Table.Columns["May"] == null ? "NoColumn" : row["May"].ToString(),
                                       June = row.Table.Columns["June"] == null ? "NoColumn" : row["June"].ToString(),
                                       July = row.Table.Columns["July"] == null ? "NoColumn" : row["July"].ToString(),
                                       Aug = row.Table.Columns["Aug"] == null ? "NoColumn" : row["Aug"].ToString(),
                                       Sep = row.Table.Columns["Sep"] == null ? "NoColumn" : row["Sep"].ToString(),
                                       Oct = row.Table.Columns["Oct"] == null ? "NoColumn" : row["Oct"].ToString(),
                                       Nov = row.Table.Columns["Nov"] == null ? "NoColumn" : row["Nov"].ToString(),
                                       Dec = row.Table.Columns["Dec"] == null ? "NoColumn" : row["Dec"].ToString(),
                                       Jan = row.Table.Columns["Jan"] == null ? "NoColumn" : row["Jan"].ToString(),
                                       Feb = row.Table.Columns["Feb"] == null ? "NoColumn" : row["Feb"].ToString(),
                                       Mar = row.Table.Columns["Mar"] == null ? "NoColumn" : row["Mar"].ToString(),
                                       Months = row.Table.Columns["Months"] == null ? "" : row["Months"].ToString(),
                                       Total = row["Total"].ToString(),
                                       Group = row["Group"].ToString(),
                                       flag = row["flag"].ToString(),
                                       Status = "New"
                                   }).ToList();
                        }
                        else
                        {
                            dtmain = GroupingAnnualBudget(dt);
                            obj = (from DataRow row in dtmain.Rows
                                   select new AnnualbudgetClass()
                                   {
                                       Head = row["Head"].ToString(),
                                       Months = row["Months"].ToString(),
                                       Total = row["Total"].ToString(),
                                       Group = row["Group"].ToString(),
                                       flag = row["flag"].ToString(),
                                       Status = "Old"
                                   }).ToList();
                        }
                    }
                }
                
                //DataTable dtmain = GroupingAnnualBudget(dt);
            }
            catch (Exception Ex)
            {
                obj = null;
            }
            return obj;
        }

        [WebMethod]
        public static List<Trent3OpexClass> RequestDataTrendbysingleitem(int id, string item)
        {
            try
            {
                List<Trent3OpexClass> obj = new List<Trent3OpexClass>();
                DataTable dt = new DataTable();
                string result = string.Empty;

                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand("FetchReportData", _dconn);
                    cmd.Parameters.Add("P_Id", OracleType.Int32).Value = id;
                    cmd.Parameters.Add("P_Condition", OracleType.VarChar).Value = "OPEX";
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
                DataTable dtmain = GroupingTrendOpex(dt);
                obj = (from DataRow row in dtmain.Rows
                       where row.Field<string>("HEAD") == item.ToString()
                       select new Trent3OpexClass()
                       {

                           Head = row["HEAD"].ToString(),
                           Budget = row["BUDGET"].ToString(),
                           Actual = row["ACTUAL"].ToString(),
                           JobWork = row["JOBWORK"].ToString(),
                           AdjustedActual = row["ADJUSTEDACTUAL"].ToString(),
                           Variance = row["VARIANCE"].ToString(),
                           Months = row["MONTHS"].ToString(),
                           Group = row["GROUP"].ToString(),
                           flag = row["flag"].ToString()
                       }).ToList();
                return obj;
            }
            catch (Exception Ex)
            {
                return null;
            }
        }

        [WebMethod]
        public static List<Trent3OpexClass> RequestDataTrend(int id, string condition, bool InitialLoad)
        {
            try
            {
                List<Trent3OpexClass> obj=new List<Trent3OpexClass>();
                DataTable dt = new DataTable();
                string result = string.Empty;
            
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
                DataTable dtmain = GroupingTrendOpex(dt);
                obj = (from DataRow row in dtmain.Rows
                       select new Trent3OpexClass()
                       {
                            
                           Head = row["HEAD"].ToString(),
                           Budget = row["BUDGET"].ToString(),
                           Actual = row["ACTUAL"].ToString(),
                           JobWork = row["JOBWORK"].ToString(),
                           AdjustedActual = row["ADJUSTEDACTUAL"].ToString(),
                           Variance = row["VARIANCE"].ToString(),
                           Months = row["MONTHS"].ToString(),
                           Group = row["GROUP"].ToString(),
                           flag = row["flag"].ToString()
                       }).ToList();
                return obj;
            }
            catch (Exception Ex)
            {
                return null;
            }
        }

        [WebMethod]
        public static List<Subgrid2Class> SubgridDataTrend(string Head, string Account, string Profit, string Cost, int level)
        {
            List<Subgrid2Class> obj = new List<Subgrid2Class>();
            DataTable dt = new DataTable();
            string result = string.Empty;
            try
            {
                using (OracleConnection con = new OracleConnection(connStr))
                {
                    con.Open();
                    OracleCommand cmd = new OracleCommand("FETCHTRENDDATA", con);
                    cmd.Parameters.Add("P_Head", OracleType.NVarChar).Value = Head.Trim();
                    cmd.Parameters.Add("P_Account", OracleType.NVarChar).Value = Account.Trim();
                    cmd.Parameters.Add("P_Profit", OracleType.NVarChar).Value = Profit.Trim();
                    cmd.Parameters.Add("P_CostCenter", OracleType.NVarChar).Value = Cost.Trim();
                    cmd.Parameters.Add("P_Level", OracleType.Int32).Value = level;
                    cmd.Parameters.Add(new OracleParameter("ReportDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    adp.Fill(dt);
                }
                 obj = (from DataRow row in dt.Rows
                                           select new Subgrid2Class()
                                         {
                                             Head = row[0].ToString(),
                                             Budget = row[1].ToString(),
                                             Actual = row[2].ToString(),
                                             JobWork = row[3].ToString(),
                                             AdjustedActual = row[4].ToString(),
                                             Variance = row[5].ToString()
                                         }).ToList();
            }
            catch (Exception Ex)
            {
                obj = null;
            }
            return obj;
        }

        [WebMethod]
        public static List<Subgrid1Class> SubgridData(string Head, string Account, string Profit, string Cost, int level,string query)
        {
            List<Subgrid1Class> obj = new List<Subgrid1Class>();
            DataTable dt = new DataTable();
            string result = string.Empty;
            string queryname = string.Empty;
            if (query == "AnnualBudget")
            {
                queryname = "FETCHANNUALDATA";
            }
            else if (query == "Actuals (Incl.JW)")
            {
                queryname = "FETCHACTUALSJWDATA";
            }
            else if (query == "Actuals(JW)")
            {
                queryname = "FETCHACTUALDATA";
            }
            try
            {
                using (OracleConnection con = new OracleConnection(connStr))
                {
                    con.Open();
                    OracleCommand cmd = new OracleCommand(queryname, con);
                    cmd.Parameters.Add("P_Head", OracleType.NVarChar).Value = Head.Trim();
                    cmd.Parameters.Add("P_Account", OracleType.NVarChar).Value = Account.Trim();
                    cmd.Parameters.Add("P_Profit", OracleType.NVarChar).Value = Profit.Trim();
                    cmd.Parameters.Add("P_CostCenter", OracleType.NVarChar).Value = Cost.Trim();
                    cmd.Parameters.Add("P_Level", OracleType.Int32).Value = level;
                    cmd.Parameters.Add(new OracleParameter("ReportDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    adp.Fill(dt);
                }

                DataView distinctView = new DataView(dt);
                DataTable distinctTable = distinctView.ToTable(true, "MONTHS");

                //DataTable 

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
       
        [WebMethod]
        public static List<Subgrid1Class> SubgridDataBureau(string Head, string Glname, string Account, string Profit, string Cost, int level, string queryname)
        {
            List<Subgrid1Class> obj = new List<Subgrid1Class>();
            DataTable dt = new DataTable();
            string result = string.Empty;
            try
            {
                using (OracleConnection con = new OracleConnection(connStr))
                {
                    OracleCommand cmd = new OracleCommand();
                    con.Open();
                    if (queryname == "Bureau Trend-3B")
                    {
                        cmd = new OracleCommand("FETCHANNUALDATABUREAU3B", con);
                    }
                    else if (queryname == "Bureau Trend-3A")
                    {
                        cmd = new OracleCommand("FETCHANNUALDATABUREAU3A", con);
                    }
                    else if (queryname == "Bureau Opex")
                    {
                        cmd = new OracleCommand("FETCHBureauOpex", con);
                    }

                    cmd.Parameters.Add("P_Head", OracleType.NVarChar).Value = Head.Trim();
                    cmd.Parameters.Add("P_GLName", OracleType.NVarChar).Value = Glname.Trim();
                    cmd.Parameters.Add("P_Account", OracleType.NVarChar).Value = Account.Trim();
                    cmd.Parameters.Add("P_Profit", OracleType.NVarChar).Value = Profit.Trim();
                    cmd.Parameters.Add("P_CostCenter", OracleType.NVarChar).Value = Cost.Trim();
                    cmd.Parameters.Add("P_Level", OracleType.Int32).Value = level;
                    cmd.Parameters.Add(new OracleParameter("ReportDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    adp.Fill(dt);
                }
                if (queryname == "Bureau Trend-3B" || queryname == "Bureau Trend-3A")
                {
                    obj = (from DataRow row in dt.Rows
                           select new Subgrid1Class()
                           {
                               //AccountNumber = row["ACCOUNTNUMBER_RACCT"].ToString(),
                               //Total = row["Total"].ToString()
                               AccountNumber = row[0].ToString(),
                               Total = row[1].ToString()
                           }).ToList();
                }
                
            }
            catch (Exception Ex)
            {
                obj = null;
            }
            return obj;
        }

        [WebMethod]
        public static List<SubgridbureauClass> SubgridDataBureauopex(string Head, string Glname, string Account, string Profit, string Cost, int level)
        {
            List<SubgridbureauClass> obj = new List<SubgridbureauClass>();
            DataTable dt = new DataTable();
            string result = string.Empty;
            try
            {
                using (OracleConnection con = new OracleConnection(connStr))
                {
                    OracleCommand cmd = new OracleCommand();
                    con.Open();

                    cmd = new OracleCommand("FETCHBureauOpex", con);

                    cmd.Parameters.Add("P_Head", OracleType.NVarChar).Value = Head.Trim();
                    cmd.Parameters.Add("P_GLName", OracleType.NVarChar).Value = Glname.Trim();
                    cmd.Parameters.Add("P_Account", OracleType.NVarChar).Value = Account.Trim();
                    cmd.Parameters.Add("P_Profit", OracleType.NVarChar).Value = Profit.Trim();
                    cmd.Parameters.Add("P_CostCenter", OracleType.NVarChar).Value = Cost.Trim();
                    cmd.Parameters.Add("P_Level", OracleType.Int32).Value = level;
                    cmd.Parameters.Add(new OracleParameter("ReportDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    adp.Fill(dt);
                }
                obj = (from DataRow row in dt.Rows
                       select new SubgridbureauClass()
                       {

                           name = row[0].ToString(),
                           Budget = row[1].ToString(),
                           Actual = row[2].ToString(),
                           Variance = row[3].ToString()

                       }).ToList();

            }
            catch (Exception Ex)
            {
                obj = null;
            }
            return obj;
        }

        public static DataTable GroupingOPEXBudget(DataTable dtmain)
        {
            
            DataTable tablenewf4 = new DataTable();
            tablenewf4.Columns.Add("Head", typeof(string));

            tablenewf4.Columns.Add("BudgetFTM", typeof(string));
            tablenewf4.Columns.Add("ActualFTM", typeof(string));
            tablenewf4.Columns.Add("CarryForward1", typeof(string));
            tablenewf4.Columns.Add("JobWorkFTM", typeof(string));
            tablenewf4.Columns.Add("AdjActualFTM", typeof(string));
            tablenewf4.Columns.Add("VarianceFTM", typeof(string));
            tablenewf4.Columns.Add("Comments", typeof(string));
            tablenewf4.Columns.Add("Variance", typeof(string));
            tablenewf4.Columns.Add("BudgetYTD", typeof(string));
            tablenewf4.Columns.Add("ActualYTD", typeof(string));
            tablenewf4.Columns.Add("CarryForward2", typeof(string));
            tablenewf4.Columns.Add("JobWorkYTD", typeof(string));
            tablenewf4.Columns.Add("AdjActualYtd", typeof(string));
            tablenewf4.Columns.Add("VaianceYtd", typeof(string));
            tablenewf4.Columns.Add("VarPercent", typeof(string));
            tablenewf4.Columns.Add("Months", typeof(string));
            tablenewf4.Columns.Add("Group", typeof(string));
            tablenewf4.Columns.Add("flag", typeof(string));

            //string[] selectedColumns = new[] { "NEWF2" };
            //DataTable dt = new DataView(dtmain).ToTable(false, selectedColumns);
            try
            {
                int finaltotalbudget = 0;
                int finaltotalactual = 0;
                int finaltotaljobwork = 0;
                int finaltotaladjuatedactual = 0;
                int finaltotalvariance = 0;
                int finaltotalbudgetytd = 0;
                int finaltotalactualytd = 0;
                int finaltotaljobworkytd = 0;
                int finaltotaladjuatedactualytd = 0;
                int finaltotalvarianceytd = 0;
                for (int i = 0; i < dtmain.Rows.Count; i++)
                {

                    string title = dtmain.Rows[i]["NEWF2"].ToString();
                    bool exists = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title)).Count() > 0;
                    if (exists == false)
                    {

                        increment = 0;
                        int totalbudget = 0;
                        int totalactual = 0;
                        int totaljobwork = 0;
                        int totaladjuatedactual = 0;
                        int totalvariance = 0;
                        int totalbudgetytd = 0;
                        int totalactualytd = 0;
                        int totaljobworkytd = 0;
                        int totaladjuatedactualytd = 0;
                        int totalvarianceytd = 0;
                        tablenewf4.Rows.Add(dtmain.Rows[i]["NEWF2"].ToString(), dtmain.Rows[i]["BudgetFTM"].ToString(), dtmain.Rows[i]["ActualFTM"].ToString(), "", dtmain.Rows[i]["JobWorkFTM"].ToString(), dtmain.Rows[i]["AdjActualFTM"].ToString(), dtmain.Rows[i]["VarianceFTM"].ToString(), "", dtmain.Rows[i]["Variance"].ToString(), dtmain.Rows[i]["BudgetYTD"].ToString(), dtmain.Rows[i]["ActualYTD"].ToString(), "", dtmain.Rows[i]["JobWorkYTD"].ToString(), dtmain.Rows[i]["AdjActualYtd"].ToString(), dtmain.Rows[i]["VaianceYtd"].ToString(), dtmain.Rows[i]["VarPercent"].ToString(), dtmain.Rows[i]["MONTHS"].ToString(), "NEWF2", "false");

                        var items = dtmain.Select("NEWF2 = '" + title + "'").Distinct().ToList();

                        for (int j = 0; j < items.Count(); j++)
                        {

                            string title1 = items[j]["NEWF3"].ToString();
                            bool exists1 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title1)).Count() > 0;
                            if (exists1 == false)
                            {
                                // tablenewf4.Rows.Add(items[j]["NEWF3"].ToString(), items[j]["MONTHS"].ToString(), items[j]["TOTAL"].ToString(), "NEWF3", "false");
                                tablenewf4.Rows.Add(items[j]["NEWF3"].ToString(), items[j]["BudgetFTM"].ToString(), items[j]["ActualFTM"].ToString(), "", items[j]["JobWorkFTM"].ToString(), items[j]["AdjActualFTM"].ToString(), items[j]["VarianceFTM"].ToString(), "", items[j]["Variance"].ToString(), items[j]["BudgetYTD"].ToString(), items[j]["ActualYTD"].ToString(), "", items[j]["JobWorkYTD"].ToString(), items[j]["AdjActualYtd"].ToString(), items[j]["VaianceYtd"].ToString(), items[j]["VarPercent"].ToString(), items[j]["MONTHS"].ToString(), "NEWF3", "false");
                                var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
                                for (int k = 0; k < items1.Count(); k++)
                                {
                                    string title2 = items1[k]["NEWF4"].ToString();
                                    bool exists3 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("HeaD").Equals(title2)).Count() > 0;
                                    if (exists3 == false)
                                    {
                                        //tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["TOTAL"].ToString(), "NEWF4", "false");
                                        tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["BudgetFTM"].ToString(), items1[k]["ActualFTM"].ToString(), "", items1[k]["JobWorkFTM"].ToString(), items1[k]["AdjActualFTM"].ToString(), items1[k]["VarianceFTM"].ToString(), "", items1[k]["Variance"].ToString(), items1[k]["BudgetYTD"].ToString(), items1[k]["ActualYTD"].ToString(), "", items1[k]["JobWorkYTD"].ToString(), items1[k]["AdjActualYtd"].ToString(), items1[k]["VaianceYtd"].ToString(), items1[k]["VarPercent"].ToString(), items1[k]["MONTHS"].ToString(), "NEWF4", "false");
                                        totalbudget = totalbudget + Convert.ToInt32(items1[k]["BudgetFTM"].ToString());
                                        totalactual = totalactual + Convert.ToInt32(items1[k]["ActualFTM"].ToString());
                                        totaljobwork = totaljobwork + Convert.ToInt32(items1[k]["JobWorkFTM"].ToString());
                                        totaladjuatedactual = totaladjuatedactual + Convert.ToInt32(items1[k]["AdjActualFTM"].ToString());
                                        totalvariance = totalvariance + Convert.ToInt32(items1[k]["VarianceFTM"].ToString());
                                        totalbudgetytd = totalbudgetytd + Convert.ToInt32(items1[k]["BudgetYTD"].ToString());
                                        totalactualytd = totalactualytd + Convert.ToInt32(items1[k]["ActualYTD"].ToString());
                                        totaljobworkytd = totaljobworkytd + Convert.ToInt32(items1[k]["JobWorkYTD"].ToString());
                                        totaladjuatedactualytd = totaladjuatedactualytd + Convert.ToInt32(items1[k]["AdjActualYtd"].ToString());
                                        totalvarianceytd = totalvarianceytd + Convert.ToInt32(items1[k]["VaianceYtd"].ToString());
                                    }
                                    else
                                    {
                                        if (title1 == title2)
                                        {
                                            DataRow dr2 = tablenewf4.Select("Head ='" + title1 + "'").FirstOrDefault();
                                            if (dr2 != null)
                                            {
                                                dr2["flag"] = "true"; //changes the Product_name   
                                                totalbudget = totalbudget + Convert.ToInt32(items1[k]["BudgetFTM"].ToString());
                                                totalactual = totalactual + Convert.ToInt32(items1[k]["ActualFTM"].ToString());
                                                totaljobwork = totaljobwork + Convert.ToInt32(items1[k]["JobWorkFTM"].ToString());
                                                totaladjuatedactual = totaladjuatedactual + Convert.ToInt32(items1[k]["AdjActualFTM"].ToString());
                                                totalvariance = totalvariance + Convert.ToInt32(items1[k]["VarianceFTM"].ToString());
                                                totalbudgetytd = totalbudgetytd + Convert.ToInt32(items1[k]["BudgetYTD"].ToString());
                                                totalactualytd = totalactualytd + Convert.ToInt32(items1[k]["ActualYTD"].ToString());
                                                totaljobworkytd = totaljobworkytd + Convert.ToInt32(items1[k]["JobWorkYTD"].ToString());
                                                totaladjuatedactualytd = totaladjuatedactualytd + Convert.ToInt32(items1[k]["AdjActualYtd"].ToString());
                                                totalvarianceytd = totalvarianceytd + Convert.ToInt32(items1[k]["VaianceYtd"].ToString());


                                            }
                                        }
                                    }

                                }

                                DataRow drdetail = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                                if (drdetail != null)
                                {
                                    drdetail["BudgetFTM"] = totalbudget; //changes the Product_name  
                                    drdetail["BudgetYTD"] = totalbudgetytd;
                                    finaltotalbudget = finaltotalbudget + totalbudget;
                                    finaltotalbudgetytd = finaltotalbudgetytd + totalbudgetytd;
                                    totalbudget = 0;
                                    totalbudgetytd = 0;

                                    drdetail["ActualFTM"] = totalactual; //changes the Product_name         
                                    drdetail["ActualYTD"] = totalactualytd;
                                    finaltotalactual = finaltotalactual + totalactual;
                                    finaltotalactualytd = finaltotalactualytd + totalactualytd;
                                    totalactual = 0;
                                    totalactualytd = 0;

                                    drdetail["JobWorkFTM"] = totaljobwork; //changes the Product_name    
                                    drdetail["JobWorkYTD"] = totaljobworkytd;
                                    finaltotaljobwork = finaltotaljobwork + totaljobwork;
                                    finaltotaljobworkytd = finaltotaljobworkytd + totaljobworkytd;
                                    totaljobwork = 0;
                                    totaljobworkytd = 0;

                                    drdetail["AdjActualFTM"] = totaladjuatedactual; //changes the Product_name   
                                    drdetail["AdjActualYtd"] = totaladjuatedactualytd;
                                    finaltotaladjuatedactual = finaltotaladjuatedactual + totaladjuatedactual;
                                    finaltotaladjuatedactualytd = finaltotaladjuatedactualytd + totaladjuatedactualytd;
                                    totaladjuatedactual = 0;
                                    totaladjuatedactualytd = 0;

                                    drdetail["VarianceFTM"] = totalvariance; //changes the Product_name       
                                    drdetail["VaianceYtd"] = totalvarianceytd; //changes the Product_name  
                                    finaltotalvariance = finaltotalvariance + totalvariance;
                                    finaltotalvarianceytd = finaltotalvarianceytd + totalvarianceytd;
                                    totalvariance = 0;
                                    totalvarianceytd = 0;


                                }

                            }
                            else
                            {

                                if (title == title1 && increment == 0)
                                {
                                    var items1 = dtmain.Select("NEWF2 = '" + title + "' and NEWF3 ='" + title1 + "'");
                                    for (int k = 0; k < items1.Count(); k++)
                                    {
                                        //tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["TOTAL"].ToString(), "NEWF4", "false");
                                        tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["BudgetFTM"].ToString(), items1[k]["ActualFTM"].ToString(), "", items1[k]["JobWorkFTM"].ToString(), items1[k]["AdjActualFTM"].ToString(), items1[k]["VarianceFTM"].ToString(), "", items1[k]["Variance"].ToString(), items1[k]["BudgetYTD"].ToString(), items1[k]["ActualYTD"].ToString(), "", items1[k]["JobWorkYTD"].ToString(), items1[k]["AdjActualYtd"].ToString(), items1[k]["VaianceYtd"].ToString(), items1[k]["VarPercent"].ToString(), items1[k]["MONTHS"].ToString(), "NEWF4", "false");
                                        totalbudget = totalbudget + Convert.ToInt32(items1[k]["BudgetFTM"].ToString());
                                        totalactual = totalactual + Convert.ToInt32(items1[k]["ActualFTM"].ToString());
                                        totaljobwork = totaljobwork + Convert.ToInt32(items1[k]["JobWorkFTM"].ToString());
                                        totaladjuatedactual = totaladjuatedactual + Convert.ToInt32(items1[k]["AdjActualFTM"].ToString());
                                        totalvariance = totalvariance + Convert.ToInt32(items1[k]["VarianceFTM"].ToString());
                                        totalbudgetytd = totalbudgetytd + Convert.ToInt32(items1[k]["BudgetYTD"].ToString());
                                        totalactualytd = totalactualytd + Convert.ToInt32(items1[k]["ActualYTD"].ToString());
                                        totaljobworkytd = totaljobworkytd + Convert.ToInt32(items1[k]["JobWorkYTD"].ToString());
                                        totaladjuatedactualytd = totaladjuatedactualytd + Convert.ToInt32(items1[k]["AdjActualYtd"].ToString());
                                        totalvarianceytd = totalvarianceytd + Convert.ToInt32(items1[k]["VaianceYtd"].ToString());
                                    }
                                    DataRow dr1 = tablenewf4.Select("Head = '" + title1 + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                                    if (dr1 != null)
                                    {
                                        dr1["BudgetFTM"] = totalbudget; //changes the Product_name  
                                        dr1["BudgetYTD"] = totalbudgetytd;
                                        finaltotalbudget = finaltotalbudget + totalbudget;
                                        finaltotalbudgetytd = finaltotalbudgetytd + totalbudgetytd;
                                        totalbudget = 0;
                                        totalbudgetytd = 0;

                                        dr1["ActualFTM"] = totalactual; //changes the Product_name         
                                        dr1["ActualYTD"] = totalactualytd;
                                        finaltotalactual = finaltotalactual + totalactual;
                                        finaltotalactualytd = finaltotalactualytd + totalactualytd;
                                        totalactual = 0;
                                        totalactualytd = 0;

                                        dr1["JobWorkFTM"] = totaljobwork; //changes the Product_name    
                                        dr1["JobWorkYTD"] = totaljobworkytd;
                                        finaltotaljobwork = finaltotaljobwork + totaljobwork;
                                        finaltotaljobworkytd = finaltotaljobworkytd + totaljobworkytd;
                                        totaljobwork = 0;
                                        totaljobworkytd = 0;

                                        dr1["AdjActualFTM"] = totaladjuatedactual; //changes the Product_name   
                                        dr1["AdjActualYtd"] = totaladjuatedactualytd;
                                        finaltotaladjuatedactual = finaltotaladjuatedactual + totaladjuatedactual;
                                        finaltotaladjuatedactualytd = finaltotaladjuatedactualytd + totaladjuatedactualytd;
                                        totaladjuatedactual = 0;
                                        totaladjuatedactualytd = 0;

                                        dr1["VarianceFTM"] = totalvariance; //changes the Product_name       
                                        dr1["VaianceYtd"] = totalvarianceytd; //changes the Product_name  
                                        finaltotalvariance = finaltotalvariance + totalvariance;
                                        finaltotalvarianceytd = finaltotalvarianceytd + totalvarianceytd;
                                        totalvariance = 0;
                                        totalvarianceytd = 0;


                                    }
                                    increment++;


                                }
                            }
                        }

                        DataRow dr = tablenewf4.Select("Head = '" + title + "'").FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
                        if (dr != null)
                        {
                            dr["BudgetFTM"] = finaltotalbudget; //changes the Product_name  
                            dr["BudgetYTD"] = finaltotalbudgetytd;                          
                            finaltotalbudget = 0;
                            finaltotalbudgetytd = 0;

                            dr["ActualFTM"] = finaltotalactual; //changes the Product_name         
                            dr["ActualYTD"] = finaltotalactualytd;                            
                            finaltotalactual = 0;
                            finaltotalactualytd = 0;

                            dr["JobWorkFTM"] = finaltotaljobwork; //changes the Product_name    
                            dr["JobWorkYTD"] = finaltotaljobworkytd;                          
                            finaltotaljobwork = 0;
                            finaltotaljobworkytd = 0;

                            dr["AdjActualFTM"] = finaltotaladjuatedactual; //changes the Product_name   
                            dr["AdjActualYtd"] = finaltotaladjuatedactualytd;
                            finaltotaladjuatedactual = 0;
                            finaltotaladjuatedactualytd = 0;

                            dr["VarianceFTM"] = finaltotalvariance; //changes the Product_name       
                            dr["VaianceYtd"] = finaltotalvarianceytd; //changes the Product_name  

                            finaltotalvariance = 0;
                            finaltotalvarianceytd = 0;

                        }
                    }
                }

                DataTable dtNew = new DataTable();
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    string query = "select * from OPEXMISTESTING";
                    OracleCommand cmd = new OracleCommand(query, _dconn);
                    using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        try
                        {
                            da.Fill(dtNew);
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                }
                for (int i = 0; i < dtNew.Rows.Count; i++)
                {
                    for (int cnt = 0; cnt < tablenewf4.Rows.Count; cnt++)
                    {
                        if (dtNew.Rows[i][0].ToString() == tablenewf4.Rows[cnt][0].ToString().Replace("'", ""))
                        {
                            DataTable dt = new DataTable();
                            using (_dconn = new OracleConnection(connStr))
                            {
                                _dconn.Open();
                                string query = "select * from OPEXMISTESTING where Category = '" + tablenewf4.Rows[cnt][0].ToString().Replace("'", "") + "' ";
                                OracleCommand cmd = new OracleCommand(query, _dconn);
                                using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                                {
                                    try
                                    {
                                        da.Fill(dt);
                                    }
                                    catch (Exception ex)
                                    {

                                    }
                                }

                            }
                            if (dt.Rows.Count > 0)
                            {
                                tablenewf4.Rows[cnt]["CarryForward1"] = dt.Rows[0][1].ToString();
                                tablenewf4.Rows[cnt]["CarryForward2"] = dt.Rows[0][2].ToString();
                                tablenewf4.Rows[cnt]["Comments"] = dt.Rows[0][3].ToString();
                            }
                        }
                    }
                }

                return tablenewf4;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static DataTable GroupingAnnualBudget(DataTable dtmain)
        {
            DataTable tablenewf4 = new DataTable();
            tablenewf4.Columns.Add("Head", typeof(string));
            //tablenewf4.Columns.Add("Apr", typeof(string));
            //tablenewf4.Columns.Add("May", typeof(string));
            //tablenewf4.Columns.Add("June", typeof(string));
            //tablenewf4.Columns.Add("July", typeof(string));
            //tablenewf4.Columns.Add("Aug", typeof(string));
            //tablenewf4.Columns.Add("Sep", typeof(string));
            //tablenewf4.Columns.Add("Oct", typeof(string));
            //tablenewf4.Columns.Add("Nov", typeof(string));
            //tablenewf4.Columns.Add("Dec", typeof(string));
            //tablenewf4.Columns.Add("Jan", typeof(string));
            //tablenewf4.Columns.Add("Feb", typeof(string));
            //tablenewf4.Columns.Add("Mar", typeof(string));
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

        public static DataTable GroupingTrendOpex(DataTable dtmain)
        {
            try
            {
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

                tablenewf4.Columns.Add("BUDGET1", typeof(string));
                tablenewf4.Columns.Add("ACTUAL1", typeof(string));
                tablenewf4.Columns.Add("JOBWORK1", typeof(string));
                tablenewf4.Columns.Add("ADJUSTEDACTUAL1", typeof(string));
                tablenewf4.Columns.Add("VARIANCE1", typeof(string));
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
                        tablenewf4.Rows.Add(dtmain.Rows[i]["NEWF2"].ToString(), dtmain.Rows[i]["MONTHS"].ToString(), dtmain.Rows[i]["BUDGET"].ToString(), dtmain.Rows[i]["ACTUAL"].ToString(), dtmain.Rows[i]["JOBWORK"].ToString(), dtmain.Rows[i]["ADJUSTEDACTUAL"].ToString(), dtmain.Rows[i]["VARIANCE"].ToString(), "NEWF2", "false", dtmain.Rows[i]["BUDGET"].ToString(), dtmain.Rows[i]["ACTUAL"].ToString(), dtmain.Rows[i]["JOBWORK"].ToString(), dtmain.Rows[i]["ADJUSTEDACTUAL"].ToString(), dtmain.Rows[i]["VARIANCE"].ToString());
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
                                tablenewf4.Rows.Add(items[j]["NEWF3"].ToString(), items[j]["MONTHS"].ToString(), items[j]["BUDGET"].ToString(), items[j]["ACTUAL"].ToString(), items[j]["JOBWORK"].ToString(), items[j]["ADJUSTEDACTUAL"].ToString(), items[j]["VARIANCE"].ToString(), "NEWF3", "false", items[j]["BUDGET"].ToString(), items[j]["ACTUAL"].ToString(), items[j]["JOBWORK"].ToString(), items[j]["ADJUSTEDACTUAL"].ToString(), items[j]["VARIANCE"].ToString());

                                var items1 = dtmain.Select("Newf2 = '" + title + "' and Newf3 ='" + title1 + "'");
                                for (int k = 0; k < items1.Count(); k++)
                                {
                                    string title2 = items1[k]["NEWF4"].ToString();
                                    bool exists3 = tablenewf4.AsEnumerable().Where(c => c.Field<string>("Head").Equals(title2)).Count() > 0;
                                    if (exists3 == false)
                                    {
                                        tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString(), "NEWF4", "false", items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString());
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
                                    dr2["BUDGET1"] = totalbudget;
                                    finaltotalbudget = finaltotalbudget + totalbudget;
                                    totalbudget = 0;


                                    dr2["ACTUAL"] = totalactual; //changes the Product_name         
                                    dr2["ACTUAL1"] = totalactual;
                                    finaltotalactual = finaltotalactual + totalactual;
                                    totalactual = 0;


                                    dr2["JOBWORK"] = totaljobwork; //changes the Product_name    
                                    dr2["JOBWORK1"] = totaljobwork;
                                    finaltotaljobwork = finaltotaljobwork + totaljobwork;
                                    totaljobwork = 0;


                                    dr2["ADJUSTEDACTUAL"] = totaladjuatedactual; //changes the Product_name   
                                    dr2["ADJUSTEDACTUAL1"] = totaladjuatedactual;
                                    finaltotaladjuatedactual = finaltotaladjuatedactual + totaladjuatedactual;
                                    totaladjuatedactual = 0;

                                    dr2["VARIANCE"] = totalvariance; //changes the Product_name       
                                    dr2["VARIANCE1"] = totalvariance; //changes the Product_name  
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

                                        tablenewf4.Rows.Add(items1[k]["NEWF4"].ToString(), items1[k]["MONTHS"].ToString(), items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString(), "NEWF4", "false", items1[k]["BUDGET"].ToString(), items1[k]["ACTUAL"].ToString(), items1[k]["JOBWORK"].ToString(), items1[k]["ADJUSTEDACTUAL"].ToString(), items1[k]["VARIANCE"].ToString());
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
                                        dr1["BUDGET1"] = totalbudget;
                                        finaltotalbudget = finaltotalbudget + totalbudget;
                                        totalbudget = 0;


                                        dr1["ACTUAL"] = totalactual; //changes the Product_name 
                                        dr1["ACTUAL1"] = totalactual;
                                        finaltotalactual = finaltotalactual + totalactual;
                                        totalactual = 0;


                                        dr1["JOBWORK"] = totaljobwork; //changes the Product_name   
                                        dr1["JOBWORK1"] = totaljobwork;
                                        finaltotaljobwork = finaltotaljobwork + totaljobwork;
                                        totaljobwork = 0;


                                        dr1["ADJUSTEDACTUAL"] = totaladjuatedactual; //changes the Product_name   
                                        dr1["ADJUSTEDACTUAL1"] = totaladjuatedactual;
                                        finaltotaladjuatedactual = finaltotaladjuatedactual + totaladjuatedactual;
                                        totaladjuatedactual = 0;

                                        dr1["VARIANCE"] = totalvariance; //changes the Product_name
                                        dr1["VARIANCE1"] = totalvariance;
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
                            dr["BUDGET1"] = finaltotalbudget;
                            finaltotalbudget = 0;

                            dr["ACTUAL"] = finaltotalbudget; //changes the Product_name
                            dr["ACTUAL1"] = finaltotalbudget;
                            finaltotalactual = 0;


                            dr["JOBWORK"] = finaltotaljobwork; //changes the Product_name
                            dr["JOBWORK1"] = finaltotaljobwork;
                            finaltotaljobwork = 0;


                            dr["ADJUSTEDACTUAL"] = finaltotaladjuatedactual; //changes the Product_name
                            dr["ADJUSTEDACTUAL1"] = finaltotaladjuatedactual;
                            finaltotaladjuatedactual = 0;


                            dr["VARIANCE"] = finaltotalvariance; //changes the Product_name
                            dr["VARIANCE1"] = finaltotalvariance;
                            finaltotalvariance = 0;
                        }
                    }
                }
                return tablenewf4;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        [WebMethod]
        public static string FetchDate(int Id, string condition)
        {
            string result = string.Empty;
            try
            {
                DataTable dt = new DataTable();
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand("GetDefaultDate", _dconn);
                    cmd.Parameters.Add("P_Id", OracleType.Int32).Value = Id;
                    cmd.Parameters.Add("P_Condition", OracleType.VarChar).Value = condition;
                    cmd.Parameters.Add("P_StartDate", OracleType.VarChar).Value = "GetDate";
                    cmd.Parameters.Add("P_EndDate", OracleType.VarChar).Value = "GetDate";
                    cmd.Parameters.Add(new OracleParameter("DefaultDates", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("P_Message", OracleType.Int32).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    adp.Fill(dt);
                }
                if (dt.Rows.Count > 0)
                {
                    if (condition == "OPEX" || condition == "adhoc")
                    {
                        DataTable newTable = new DataTable();
                        newTable.Columns.Add("COLUMNNAME");
                        newTable.Columns.Add("FILTERVALUE");

                        foreach (DataRow dr in dt.Rows)
                        {
                            newTable.Rows.Add(dr["COLUMNNAME"].ToString(), dr["DefaultFilterValue"].ToString());
                        }
                        result = JsonConvert.SerializeObject(newTable);
                    }
                }
                return result;
            }
            catch (Exception Ex)
            {
                return Ex.Message;
            }
        }

        //Get The List Of Reports In OPEX
        [WebMethod]
        public static string GetMasterData(string category)
        {
            string result = string.Empty;
            DataTable dt = new DataTable();
            string query = "select Id,Title from queryTable where Title not like '%Collapse' and reportcategory = '" + category + "' order by Id asc";
            string strli = string.Empty;
            try
            {
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand(query, _dconn);
                    using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        strli += "<li><a href='#' id='" + dr[1] + "' class='auto' onclick='FetchReportRecords(" + dr[0] + ",this,\"" + dr[1] + "\",\"" + category + "\")'>" + "<span class='font-bold'>" + dr[1] + "</span></li>";
                    }
                    result = strli;
                }
                return result;
            }
            catch (Exception Ex)
            {
                return Ex.Message;
            }
        }

        //To Update The Filter Value According To The User Selection
        [WebMethod]
        public static string UpdateFilter(int Id, string condition, string fromDate, string toDate)
        {
            string result = string.Empty;
            int QueryResult;
            if (condition != "OPEX" && condition != "adhoc")
            {
                DateTime dtFrom = Convert.ToDateTime(fromDate).AddDays(-1);
                fromDate = dtFrom.ToString("dd-MM-yyyy");

                //DateTime dtTo = Convert.ToDateTime(toDate).AddDays(1);
                DateTime dtTo = Convert.ToDateTime(toDate);
                toDate = dtTo.ToString("dd-MM-yyyy");
            }
            try
            {
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand("GetDefaultDate", _dconn);
                    cmd.Parameters.Add("P_Id", OracleType.Int32).Value = Id;
                    cmd.Parameters.Add("P_Condition", OracleType.VarChar).Value = condition;
                    cmd.Parameters.Add("P_StartDate", OracleType.VarChar).Value = fromDate;
                    cmd.Parameters.Add("P_EndDate", OracleType.VarChar).Value = toDate;
                    cmd.Parameters.Add(new OracleParameter("DefaultDates", OracleType.Cursor)).Direction = ParameterDirection.Output;

                    cmd.Parameters.Add("P_Message", OracleType.Int32).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    QueryResult = Convert.ToInt32(cmd.Parameters["P_Message"].Value.ToString());
                    if (QueryResult > 0)
                    {
                        result = "Success";
                    }
                    else
                    {
                        result = "Failure";
                    }
                }
                return result;
            }
            catch (Exception Ex)
            {
                return Ex.Message;
            }
        }

        [WebMethod]
        public static string UpdateFilterValues(int Id, string condition, string value)
        {
            int QueryResult;
            string result = string.Empty;
            try
            {
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand("UPDATEFILTER", _dconn);
                    cmd.Parameters.Add("P_Id", OracleType.Int32).Value = Id;
                    cmd.Parameters.Add("P_Condition", OracleType.VarChar).Value = condition;
                    cmd.Parameters.Add("P_Value", OracleType.VarChar).Value = value;
                    cmd.Parameters.Add("P_Message", OracleType.Int32).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    QueryResult = Convert.ToInt32(cmd.Parameters["P_Message"].Value.ToString());
                    if (QueryResult > 0)
                    {
                        result = "Success";
                    }
                    else
                    {
                        result = "Failure";
                    }
                }
                return result;
            }
            catch (Exception Ex)
            {
                return Ex.Message;
            }
        }

        public class commonclass
        {
            public List<StateClass> objstate { get; set; }
            public List<Newf2Class> objnewf2 { get; set; }
            public List<Newf3Class> objnewf3 { get; set; }
            public List<Newf4Class> objnewf4 { get; set; }
            public List<GLCodeClass> objglcode { get; set; }
            public List<ProductClass> objproduct { get; set; }
            public List<BusinessClass> objbusiness { get; set; }

        }

        public class StateClass
        {
            public string Name { get; set; }
        }
        
        public class Newf2Class
        {
            public string Name { get; set; }
        }
        
        public class Newf3Class
        {
            public string Name { get; set; }

        }
        
        public class Newf4Class
        {
            public string Name { get; set; }
        }
        
        public class GLCodeClass
        {
            public string Name { get; set; }
        }
        
        public class ProductClass
        {
            public string Name { get; set; }

        }
        
        public class BusinessClass
        {
            public string Name { get; set; }

        }
        
        [WebMethod]
        public static commonclass FetchfilterValues()
        {
            string result = string.Empty;
            DataTable dtmainrecord = GetDropdownvalues("State");
            DataTable dt = dtmainrecord;

         

            commonclass objmain = new commonclass();

            if (dt.Rows.Count > 0)
            {

                List<StateClass> objstate = (from DataRow row in dt.Rows
                                             where row.Field<string>("CATEGORY") == "STATE"                                           select new StateClass()
                                             {
                                                 Name = row["DDLVALUES"].ToString()
                                             }).ToList();
                
                objmain.objstate = objstate;
            }
            else
            {
                objmain.objstate = null;
            }

            DataTable dtnewf2 = dtmainrecord;

            // DataTable dtnewf2=GetDropdownvalues("Newf2");
            if (dtnewf2.Rows.Count > 0)
            {

                List<Newf2Class> objnewf2 = (from DataRow row in dtnewf2.Rows
                                             where row.Field<string>("CATEGORY") == "NEWF2" 
                                             select new Newf2Class()
                                             {
                                                 Name = row["DDLVALUES"].ToString()
                                             }).ToList();
                objmain.objnewf2 = objnewf2;
            }
            else
            {
                objmain.objnewf2 = null;
            }




            DataTable dtnewf3 = dtmainrecord;
            // DataTable dtnewf3 = GetDropdownvalues("Newf3");
            if (dtnewf3.Rows.Count > 0)
            {

                List<Newf3Class> objnewf3 = (from DataRow row in dtnewf3.Rows
                                             where row.Field<string>("CATEGORY") == "NEWF3" 
                                             select new Newf3Class()
                                             {
                                                 Name = row["DDLVALUES"].ToString()
                                             }).ToList();
                objmain.objnewf3 = objnewf3;
            }
            else
            {
                objmain.objnewf3 = null;
            }


            DataTable dtnewf4 = dtmainrecord;
            // DataTable dtnewf4 = GetDropdownvalues("Newf4");
            if (dtnewf4.Rows.Count > 0)
            {

                List<Newf4Class> objnewf4 = (from DataRow row in dtnewf4.Rows
                                             where row.Field<string>("CATEGORY") == "NEWF4"
                                             select new Newf4Class()
                                             {
                                                 Name = row["DDLVALUES"].ToString()
                                             }).ToList();
                objmain.objnewf4 = objnewf4;
            }
            else
            {
                objmain.objnewf4 = null;
            }




            DataTable dtglcode = dtmainrecord;

            // DataTable dtglcode = GetDropdownvalues("Glcode");
            if (dtglcode.Rows.Count > 0)
            {

                List<GLCodeClass> objglcode = (from DataRow row in dtglcode.Rows
                                               where row.Field<string>("CATEGORY") == "ACCOUNTNUMBER"
                                               select new GLCodeClass()
                                               {
                                                   Name = row["DDLVALUES"].ToString()
                                               }).ToList();
                objmain.objglcode = objglcode;
            }
            else
            {
                objmain.objglcode = null;
            }

            DataTable dtproduct = dtmainrecord;
            //DataTable dtproduct = GetDropdownvalues("Product");
            if (dtproduct.Rows.Count > 0)
            {

                List<ProductClass> objproduct = (from DataRow row in dtproduct.Rows
                                                 where row.Field<string>("CATEGORY") == "PRODUCT"
                                                 select new ProductClass()
                                                 {
                                                     Name = row["DDLVALUES"].ToString()
                                                 }).ToList();
                objmain.objproduct = objproduct;
            }
            else
            {
                objmain.objproduct = null;
            }




            DataTable dtbusinessarea = dtmainrecord;
            // DataTable dtbusinessarea = GetDropdownvalues("BusinessArea");
            if (dtbusinessarea.Rows.Count > 0)
            {

                List<BusinessClass> objbusiness = (from DataRow row in dtbusinessarea.Rows
                                                   where row.Field<string>("CATEGORY") == "BUSINESSAREA"
                                                   select new BusinessClass()
                                                   {
                                                       Name = row["DDLVALUES"].ToString()
                                                   }).ToList();
                objmain.objbusiness = objbusiness;
            }
            else
            {
                objmain.objbusiness = null;
            }

            return objmain;
        }

        public static DataTable GetDropdownvalues(string condition)
        {
            //DataTable dt = new DataTable();
            // string query="";
            // if (condition == "State")
            // {
            //     query = "select distinct state from glpcp where STATE is not null order by state ASC";
            // }
            // else if (condition == "Newf2")
            // {
            //     query = "select distinct Newf2 from glpcp where Newf2 is not null order by Newf2 ASC";
            // }
            // else if (condition == "Newf3")
            // {
            //     query = "select distinct Newf3 from glpcp where Newf3 is not null order by Newf3 ASC";
            // }
            // else if (condition == "Newf4")
            // {
            //     query = "select distinct Newf4 from glpcp where Newf4 is not null order by Newf4 ASC";
            // }
            // else if (condition == "Glcode")
            // {
            //     query = "select distinct ACCOUNTNUMBER_RACCT from glpcp where ACCOUNTNUMBER_RACCT is not null order by ACCOUNTNUMBER_RACCT ASC";
            // }
            // else if (condition == "Product")
            // {
            //     query = "select distinct product from glpcp where product is not null order by product ASC";
            // }

            // else if (condition == "BusinessArea")
            // {
            //     query = "select distinct BUSINESSAREA_GSBER from glpcp where BUSINESSAREA_GSBER is not null order by BUSINESSAREA_GSBER ASC";
            // }            

            //string strli = string.Empty;
            //try
            //{


            //    using (_dconn = new OracleConnection(connStr))
            //    {
            //        _dconn.Open();
            //        OracleCommand cmd = new OracleCommand(query, _dconn);
            //        using (OracleDataAdapter da = new OracleDataAdapter(cmd))
            //        {
            //            da.Fill(dt);
            //        }
            //    }
            //}
            //catch(Exception ex)
            //{
            //   dt=null;
            //}


            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            try
            {
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();
                    OracleCommand cmd = new OracleCommand("FetchDropdownData", _dconn);
                    cmd.Parameters.Add(new OracleParameter("StateDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    //cmd.Parameters.Add(new OracleParameter("Newf2Details", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    //cmd.Parameters.Add(new OracleParameter("Newf3Details", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    //cmd.Parameters.Add(new OracleParameter("Newf4Details", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    //cmd.Parameters.Add(new OracleParameter("AccountnumberDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    //cmd.Parameters.Add(new OracleParameter("ProductDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    //cmd.Parameters.Add(new OracleParameter("BusinessAreaDetails", OracleType.Cursor)).Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    OracleDataAdapter adp = new OracleDataAdapter(cmd);
                    adp.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                dt = null;
            }
            return dt;
        }

        [WebMethod]
        public static string GetMasterData11(string category, string InputVal)
        {
            try
            {
                string result = string.Empty;
                string strli = string.Empty;
                DataTable dt = new DataTable();
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();

                    string query = "select * from OPEXMISTESTING where Category = '" + category.Replace("'", "") + "' ";
                    OracleCommand cmd = new OracleCommand(query, _dconn);
                    using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    if (dt.Rows.Count > 0)
                    {
                        string Insertquery = "update OPEXMISTESTING set CarryForward1='" + InputVal + "' where Category='" + category.Replace("'", "") + "' ";
                        cmd = new OracleCommand(Insertquery, _dconn);
                        cmd.ExecuteNonQuery();
                        result = "Update";

                    }
                    else
                    {
                        string Insertquery = "insert into OPEXMISTESTING (Category,CarryForward1) values ('" + category.Replace("'", "") + "','" + InputVal + "') ";
                        cmd = new OracleCommand(Insertquery, _dconn);
                        cmd.ExecuteNonQuery();
                        result = "Insert";
                    }
                }
                return result;
            }
            catch (Exception Ex)
            {
                return Ex.Message;
            }
        }

        [WebMethod]
        public static string GetMasterData12(string category, string InputVal)
        {
            try
            {
                string result = string.Empty;
                string strli = string.Empty;
                DataTable dt = new DataTable();
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();

                    string query = "select * from OPEXMISTESTING where Category = '" + category.Replace("'", "") + "' ";
                    OracleCommand cmd = new OracleCommand(query, _dconn);
                    using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    if (dt.Rows.Count > 0)
                    {
                        string Insertquery = "update OPEXMISTESTING set CarryForward2='" + InputVal + "' where Category='" + category.Replace("'", "") + "' ";
                        cmd = new OracleCommand(Insertquery, _dconn);
                        cmd.ExecuteNonQuery();
                        result = "Update";

                    }
                    else
                    {
                        string Insertquery = "insert into OPEXMISTESTING (Category,CarryForward2) values ('" + category.Replace("'", "") + "','" + InputVal + "') ";
                        cmd = new OracleCommand(Insertquery, _dconn);
                        cmd.ExecuteNonQuery();
                        result = "Insert";
                    }
                }
                return result;
            }
            catch (Exception Ex)
            {
                return Ex.Message;
            }
        }


        [WebMethod]
        public static string GetMasterData13(string category, string InputVal)
        {
            try
            {
                string result = string.Empty;
                string strli = string.Empty;
                DataTable dt = new DataTable();
                using (_dconn = new OracleConnection(connStr))
                {
                    _dconn.Open();

                    string query = "select * from OPEXMISTESTING where Category = '" + category.Replace("'", "") + "' ";
                    OracleCommand cmd = new OracleCommand(query, _dconn);
                    using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                    if (dt.Rows.Count > 0)
                    {
                        string Insertquery = "update OPEXMISTESTING set Comments='" + InputVal + "' where Category='" + category.Replace("'", "") + "' ";
                        cmd = new OracleCommand(Insertquery, _dconn);
                        cmd.ExecuteNonQuery();
                        result = "Update";

                    }
                    else
                    {
                        string Insertquery = "insert into OPEXMISTESTING (Category,Comments) values ('" + category.Replace("'", "") + "','" + InputVal + "') ";
                        cmd = new OracleCommand(Insertquery, _dconn);
                        cmd.ExecuteNonQuery();
                        result = "Insert";
                    }
                }
                return result;
            }
            catch (Exception Ex)
            {
                return Ex.Message;
            }
        }
    }
}