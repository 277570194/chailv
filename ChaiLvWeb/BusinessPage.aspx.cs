using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization.Json;
using ChaiLvService;

public partial class BusinessPage : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["method"] != null)
        {
            string method = Request["method"];
            switch (method)
            {
                case "GetNodes"://获取导航树节点
                    GetNodes();
                    break;
            }
        }
    }
    #region 获取导航树节点
    public void GetNodes()
    {
        String nodeID = String.IsNullOrEmpty(this.Request["id"]) ? "0" : this.Request["id"];
        List<navigationtree> nodeList = ChaiLvService.NavTree.GetNavTree(this.User.UserRoleID, Convert.ToInt32(nodeID));
        DataContractJsonSerializer json = new DataContractJsonSerializer(nodeList.GetType());
        json.WriteObject(Response.OutputStream, nodeList);
        Response.End();
    }
    #endregion

}