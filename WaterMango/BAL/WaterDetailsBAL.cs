using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WaterMango.DAL;

namespace WaterMango.BAL
{
    public class WaterDetailsBAL
    {
        public Int32 plantID { get; set;}

        public DateTime waterStartTime { get; set; }
        public DateTime waterEndTime { get; set; }
        public Boolean IsWateredFlag { get; set; }

        WaterDetailsDAL objDAL = new WaterDetailsDAL();
        
        public List<WaterDetailsBAL> getWaterDetails(Int32 plantID)
        {
            return objDAL.getWaterDetails(plantID);
        }


        public int updateWaterDetails(WaterDetailsBAL obj)
        {
            return objDAL.updateWaterDetails(obj);
        }

    }
}