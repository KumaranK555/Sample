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

public partial class bureau : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public class Subgrid1Class
    {
        public string name { get; set; }
        public string Budget { get; set; }
        public string Actual { get; set; }
        public string Variance { get; set; }
    }
    public class commonclass
    {
        public string Bureau { get; set; }
        public string Budget { get; set; }
        public string Actual { get; set; }
        public string Variance { get; set; }
        public string Months { get; set; }
       
    }
    [System.Web.Services.WebMethod]
    [ScriptMethod(UseHttpGet = true)]
    public static List<commonclass> GetDetails()
    {
       
        DataTable dtmain;

        string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select * from  bureau";
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
                                     Bureau = row["Bureau"].ToString(),
                                     Budget = row["Budget"].ToString(),
                                     Actual = row["Actual"].ToString(),
                                     Variance = row["Variance"].ToString(),
                                     Months = row["Months"].ToString()
                                 }).ToList();


        return obj;
    }



    [WebMethod]
    public static List<Subgrid1Class> SubgridDataBureau(string Head, string Glname, string Account, string Profit, string Cost, int level)
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
                        cmd.CommandText = "Qry_actuals";
                    }
                    else if (level == 2)
                    {
                        cmd.CommandText = "Qry_actuals1";
                    }
                    else if (level == 3)
                    {
                        cmd.CommandText = "Qry_actuals3";
                    }
                    else if (level == 4)
                    {
                        cmd.CommandText = "Qry_actuals4";

                    }
                    else if (level == 5)
                    {
                        cmd.CommandText = "Qry_actuals5";
                        
                    }
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Head", Head);
                        cmd.Parameters.AddWithValue("@Glname", Glname);
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


}