using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ChaiLvService;

public partial class UserManage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string GetUserListPage(int rows, int page)
    {
        //int page = Convert.ToInt32(context.Request["page"]);
        //int rows = Convert.ToInt32(context.Request["rows"]);

        List<userinfo> li = UserInfoService.GetUserInfoListPage(rows, page);

        //ReturnDate rd = new ReturnDate();
        //rd.total = UserInfoService.GetUserInfoList().Count.ToString();
        //rd.rows = li;
        //DataContractJsonSerializer json = new DataContractJsonSerializer(rd.GetType());
        //json.WriteObject(context.Response.OutputStream, rd); 
        string str = Newtonsoft.Json.JsonConvert.SerializeObject(li);
        return "{\"rows\":" + str + ",\"total\":\"" + UserInfoService.GetUserInfoList().Count + "\"}";
    }
    
}