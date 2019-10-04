using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WaterMango.BAL;

namespace WaterMango.DAL
{
    public class WaterDetailsDAL
    {
        SqlConnection con;
        SqlCommand cmd;

        public WaterDetailsDAL()
        {
            con = new SqlConnection();
            cmd = new SqlCommand();
            string cnstr = ConfigurationManager.ConnectionStrings["cnstr"].ConnectionString;
            con.ConnectionString = cnstr;
            cmd.Connection = con;
        }

        public List<WaterDetailsBAL> getWaterDetails(Int32 plantID)
        {

            List<WaterDetailsBAL> lst = new List<WaterDetailsBAL>();
            SqlDataReader dr;
            try
            {
                cmd.CommandText = "getWaterDetails";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@plantID", plantID);
                con.Open();

                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        WaterDetailsBAL obj = new WaterDetailsBAL();
                        obj.plantID = dr.GetInt32(dr.GetOrdinal("plantID"));
                        obj.waterStartTime = dr.GetDateTime(dr.GetOrdinal("waterStartTime"));
                        obj.waterEndTime = dr.GetDateTime(dr.GetOrdinal("waterEndTime"));
                        obj.IsWateredFlag = dr.GetBoolean(dr.GetOrdinal("IsWateredFlag"));

                        lst.Add(obj);
                    }
                    //dr.NextResult();
                }
                dr.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cmd.Parameters.Clear();
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
            return lst;
        }

        public int updateWaterDetails(WaterDetailsBAL obj)
        {
            int i = 0;
           
            try
            {
                cmd.CommandText = "updateWaterDetails";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@plantID", obj.plantID);
                cmd.Parameters.AddWithValue("@waterStartTime", obj.waterStartTime);
                cmd.Parameters.AddWithValue("@waterEndTime", obj.waterEndTime);
                cmd.Parameters.AddWithValue("@IsWateredFlag", obj.IsWateredFlag);
               

                con.Open();
                i = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cmd.Parameters.Clear();
                con.Close();
                con.Dispose();
                cmd.Dispose();
            }
            return i;
        }


    }
}