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
        String strDepart = "";
        String strZhiBie = "";
        String strUserName = "";
        String strPwd = "";
        String strErrorType = "";
        if (Request["txtDepartment"] != null)
            strDepart = Request["txtDepartment"].ToString();
        if (Request["txtZhiBie"] != null)
            strZhiBie = Request["txtZhiBie"].ToString();
        if (Request["username"] != null)
            strUserName = Request["username"].ToString();
        if (Request["password"] != null)
            strPwd = Request["password"].ToString();
        List<userinfo> objUserList = UserInfoService.GetUserInfo(strDepart,
                         strZhiBie, strUserName, strPwd, ref strErrorType);
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
    public static String GetDepart()
    {
        String strReturnValue = String.Empty;
        List<userinfo> UserInfoList = UserInfoService.GetUserInfoList();
        if (UserInfoList != null && UserInfoList.Count > 0)
        {
            var userinfoList = (from user in UserInfoList orderby user.UserUint where user.UserUint != "" select user.UserUint).Distinct();
            if (userinfoList != null && userinfoList.Count() > 0)
            {
                strReturnValue = "[";
                for (int i = 0; i < userinfoList.Count(); i++)
                {
                    strReturnValue = strReturnValue + "{id:'" + userinfoList.ElementAt(i) + "'"
                        + ",name:'" + userinfoList.ElementAt(i) + "'},";
                }
                strReturnValue = strReturnValue.TrimEnd(',') + "]";
            }
        }
        return strReturnValue;
    }
    [WebMethod]
    public static String GetZhiBie(string strJiGou)
    {
        String strReturnValue = String.Empty;
        List<userinfo> UserInfoList = UserInfoService.GetUserInfoList();
        if (UserInfoList != null && UserInfoList.Count > 0)
        {
            var userinfoList = (from user in UserInfoList orderby user.UserUint where user.UserUint == strJiGou && user.UserDepartment != "" select user.UserDepartment).Distinct();
            if (userinfoList != null && userinfoList.Count() > 0)
            {
                strReturnValue = "[";
                for (int i = 0; i < userinfoList.Count(); i++)
                {
                    strReturnValue = strReturnValue + "{id:'" + userinfoList.ElementAt(i) + "'"
                        + ",name:'" + userinfoList.ElementAt(i) + "'},";
                }
                strReturnValue = strReturnValue.TrimEnd(',') + "]";
            }
        }
        return strReturnValue;
    }
}