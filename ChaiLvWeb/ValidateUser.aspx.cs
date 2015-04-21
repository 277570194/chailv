using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ChaiLvService;
using ChaiLvService.Security;
using ChaiLvService.SessionKey;
using System.Web.Services;

public partial class ValidateUser : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String strUnit = "";
        String strDepart = "";
        String strUserName = "";
        String strPwd = "";
        String strErrorType = "";
        if (Request["txtUnit"] != null)
            strUnit = Request["txtUnit"].ToString();
        if (Request["txtDepartment"] != null)
            strDepart = Request["txtDepartment"].ToString();
        if (Request["username"] != null)
            strUserName = Request["username"].ToString();
        if (Request["password"] != null)
            strPwd = Request["password"].ToString();
        List<userinfo> objUserList = UserInfoService.GetUserInfo(strUnit, strDepart, strUserName, strPwd, ref strErrorType);
        switch (strErrorType)
        {
            case "1":
            case "2":
            case "3":
            case "4":
            case "5":
            case "6":
            case "7":
            case "8":
                Response.Write(strErrorType);
                Response.End();
                break;
            case "9":
                this.Session[SessionKeys.UserInfo] = objUserList[0];
                Response.Write("location.href='HomePage.aspx'");
                Response.End();
                break;
            default:
                Response.Write("");
                Response.End();
                break;
        }
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
}