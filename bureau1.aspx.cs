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

public partial class bureau1 : System.Web.UI.Page
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
                cmd.CommandText = "select * from  bureau1";
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



        List<commonclass> obj = (from DataRow row in dtmain.Rows
                                 select new commonclass()
                                 {
                                     Head = row["Bureau"].ToString(),

                                     Total = row["Budget"].ToString(),
                                     Months = row["Months"].ToString()
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
    public static List<Subgrid1Class> SubgridData(string Head, string Glname, string Account, string Profit, string Cost, int level)
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
                    if(level == 1)
                    {
                        cmd.CommandText = "SELECT glname,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Budget'AND Newf2='CITY & BUREAU EXP' AND MONTHS = 'Apr' AND FISCALYEAR_RYEAR=(SELECT Max(FISCALYEAR_RYEAR) FROM GLPCP) AND  NEWF4 = '" + Head + "'  GROUP BY glname ORDER BY glname ASC";
                    }
                    else if (level == 2)
                    {
                        cmd.CommandText = "SELECT ACCOUNTNUMBER_RACCT,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG='Budget'AND Newf2='CITY & BUREAU EXP' AND MONTHS = 'Apr' AND FISCALYEAR_RYEAR=(SELECT Max(FISCALYEAR_RYEAR) FROM GLPCP) AND   NEWF4 = '" + Head + "'  and GLname='"+Glname +"' GROUP BY ACCOUNTNUMBER_RACCT ORDER BY ACCOUNTNUMBER_RACCT ASC";
                    }
                    else if (level == 3)
                    {
                        cmd.CommandText = "SELECT PROFITCENTER_RPRCTR,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget' AND Newf2='CITY & BUREAU EXP' AND MONTHS = 'Apr' AND FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND   NEWF4 = '" + Head + "'  and GLname='" + Glname + "' AND ACCOUNTNUMBER_RACCT = '" + Account + "'  GROUP BY PROFITCENTER_RPRCTR ORDER BY PROFITCENTER_RPRCTR ASC";
                    }
                    else if (level == 4)
                    {
                        cmd.CommandText = "SELECT COSTCENTER_KOSTL,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget'  AND Newf2='CITY & BUREAU EXP' AND MONTHS = 'Apr' AND  FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND  NEWF4 = '" + Head + "'  and GLname='" + Glname + "'  AND ACCOUNTNUMBER_RACCT = '" + Account + "'  AND PROFITCENTER_RPRCTR =  '" + Profit + "' GROUP BY COSTCENTER_KOSTL ORDER BY COSTCENTER_KOSTL ASC";
                    }
                    else if (level == 5)
                    {
                        cmd.CommandText = "SELECT ORDERNUMBER,SUM(CompanyCurrency_HSL) AS Total FROM GLPCP WHERE TABFLAG = 'Budget'AND Newf2='CITY & BUREAU EXP' AND MONTHS = 'Apr' AND  FISCALYEAR_RYEAR=(SELECT MAX(FISCALYEAR_RYEAR) FROM GLPCP) AND  NEWF4 = '" + Head + "' and GLname='" + Glname + "' AND ACCOUNTNUMBER_RACCT =  '" + Account + "' AND PROFITCENTER_RPRCTR = '" + Profit + "' AND COSTCENTER_KOSTL = '" + Cost + "' GROUP BY ORDERNUMBER ORDER BY ORDERNUMBER ASC";

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