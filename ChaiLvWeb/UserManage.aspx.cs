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
    public static string GetUnit()
    {
        return UserInfoService.GetUnit("");
    }
    [WebMethod]
    public static string GetDepartment(string strUnit)
    {
        return UserInfoService.GetDepartment(strUnit);
    }

    [WebMethod]
    public static string GetGrade(string strUnit)
    {
        return UserInfoService.GetGrade(strUnit);
    }
}