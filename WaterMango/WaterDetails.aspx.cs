using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WaterMango.BAL;

namespace WaterMango
{
    public partial class WaterDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                CheckForWater();
            }
        }
        public void CheckForWater()
        {
            string[] plantToBeWatered = new string[5];
            List<WaterDetailsBAL> lst = (List<WaterDetailsBAL>)Session["lst"];
            int i, j = 0;
            for (i = 0; i < 5; i++)
            {
                if ((DateTime.Now - lst[i].waterEndTime).Hours >= 6)
                {
                    plantToBeWatered[j++] = (i + 1).ToString();
                }
            }
            string output = string.Empty;
            foreach (var item in plantToBeWatered)
            {
                if (item != null)
                    output += "Plant" + item + " , ";
            }

            if (output != string.Empty)
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + output + " need to be watered')", true);

        }
        public void BindGrid()
        {
            WaterDetailsBAL obj = new WaterDetailsBAL();
            List<WaterDetailsBAL> lst = new List<WaterDetailsBAL>();
            lst = obj.getWaterDetails(0);
            Session["lst"] = lst;

            grdPlants.DataSource = lst;
            grdPlants.DataBind();

        }

        protected void grdPlants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "STRT")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                WaterDetailsBAL obj = new WaterDetailsBAL();

                obj.plantID = rowIndex + 1;
                obj.waterStartTime = DateTime.Now;
                obj.waterEndTime = obj.waterStartTime.AddSeconds(10);
                obj.IsWateredFlag = true;

                List<WaterDetailsBAL> lst = (List<WaterDetailsBAL>)Session["lst"];
                //var old = DateTime.ParseExact(grdPlants.Rows[rowIndex].Cells[2].Text, "T", null);

                //if (DateTime.Now > old.AddSeconds(30))
                if (DateTime.Now > lst[rowIndex].waterEndTime.AddSeconds(30))
                {
                    //System.Threading.Thread.Sleep(10000);


                    int i = obj.updateWaterDetails(obj);
                    if (i > 0)
                    {
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "AfterStart()", true);
                        BindGrid();
                        var moveIndex = rowIndex + 1;

                        Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "move(" + moveIndex + ")", true);

                        //CheckForWater();
                    }
                }
                else
                {
                    //List<WaterDetailsBAL> lst = (List<WaterDetailsBAL>)Session["lst"];
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Wait For 30 Seconds')", true);
                    int remainingTime = 30 - Convert.ToInt32((DateTime.Now - lst[rowIndex].waterEndTime).TotalSeconds);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "WaitFor30(" + remainingTime + ")", true);
                }

            }
            else if (e.CommandName == "STOP")
            {
                //System.Threading.Thread.
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                WaterDetailsBAL obj = new WaterDetailsBAL();
                List<WaterDetailsBAL> lst = (List<WaterDetailsBAL>)Session["lst"];
                obj.plantID = rowIndex + 1;
                obj.waterStartTime = lst[rowIndex].waterStartTime;
                obj.waterEndTime = DateTime.Now;
                if (lst[rowIndex].waterEndTime < DateTime.Now)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "NoProcess()", true);
                }
                else
                {
                    int i = obj.updateWaterDetails(obj);
                    if (i > 0)
                    {
                        BindGrid();
                        //CheckForWater();
                    }
                }
            }
        }
    }
}