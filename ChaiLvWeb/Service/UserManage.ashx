<%@ WebHandler Language="C#" Class="UserManage" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ChaiLvService;
using ChaiLvService.Security;

public class UserManage : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request["mode"] != null)
        {
            string mode = context.Request["mode"];
            switch (mode)
            {
                case "Qry":
                    GetUserList(context);
                    break;
                case "Edit":
                    EditUser(context);
                    break;
                case "Get":
                    GetUser(context);
                    break;
                case "Del":
                    DelUser(context);
                    break;
                case "ResetPwd":
                    ResetPwd(context);
                    break;

                //case "Logout":
                //    Logout(context);
                //    break; ;
            }

        }
    }

    private void ResetPwd(HttpContext context)
    {
        string userid = context.Request["userid"];

        userinfo u = new userinfo();
        if (userid.Length > 0)
            u = UserInfoService.GetUserInfo(Convert.ToInt32(userid));
        if (u != null)
        {
            u.UserPwd = CommonCryptoProvider.Encrypt("123456");
            UserInfoService.UserInfoSave(u);
            DataContractJsonSerializer json = new DataContractJsonSerializer(u.GetType());
            json.WriteObject(context.Response.OutputStream, u);
        }
    }

    public bool IsReusable { get { return false; } }

    public void DelUser(HttpContext context)
    {
        string[] userids = context.Request["userids"].Split(',');
        if (userids.Length > 1)
            foreach (string t in userids) UserInfoService.UserInfoDelete(Convert.ToInt32(t));
        else
            UserInfoService.UserInfoDelete(Convert.ToInt32(userids[0]));

        DataContractJsonSerializer json = new DataContractJsonSerializer(userids.Length.GetType());
        json.WriteObject(context.Response.OutputStream, userids.Length);
    }

    public void GetUser(HttpContext context)
    {
        int userid = Convert.ToInt32(context.Request["userid"]);

        userinfo obju = UserInfoService.GetUserInfoList().First(u => u.UserID == userid);

        DataContractJsonSerializer json = new DataContractJsonSerializer(obju.GetType());
        json.WriteObject(context.Response.OutputStream, obju);
    }

    public void GetUserList(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request["page"]);
        int rows = Convert.ToInt32(context.Request["rows"]);

        string username = context.Request["username"] ?? "";
        string userunit = context.Request["userunit"] ?? "　";
        string userdpm = context.Request["userdpm"] ?? "　";
        string usergrade = context.Request["usergrade"] ?? "　";
        username = username.Trim();
        userunit = userunit.Trim();
        userdpm = userdpm.Trim();
        usergrade = usergrade.Trim();

        List<userinfo> li = UserInfoService.GetUserInfoListPage(rows, page, username, userunit, userdpm, usergrade);

        ReturnDate rd = new ReturnDate();
        rd.total = UserInfoService.GetUserInfoListPage(100000, 1, username, userunit, userdpm, usergrade).Count.ToString();
        rd.rows = li;
        DataContractJsonSerializer json = new DataContractJsonSerializer(rd.GetType());
        json.WriteObject(context.Response.OutputStream, rd);
    }

    public void EditUser(HttpContext context)
    {
        string userid = context.Request["userid"];
        string username = context.Request["username"];
        string userunit = context.Request["userunit"];
        string userdepartment = context.Request["userdepartment"];
        string usergrade = context.Request["usergrade"];

        userinfo u = null;
        if (userid.Length > 0)
            u = UserInfoService.GetUserInfo(Convert.ToInt32(userid));
        if (u != null)
        {
            u.UserName = username;
            u.UserUint = userunit;
            u.UserDepartment = userdepartment;
            u.UserRole = usergrade;
        }
        else
        {
            u = new userinfo
            {
                UserName = username,
                UserUint = userunit,
                UserDepartment = userdepartment,
                UserRole = usergrade,
                UserStatus = "正常",
                UserPwd = CommonCryptoProvider.Encrypt("123456")
            };
        }
        string strSystemManager = ConfigurationManager.AppSettings["SystemManager"];//管理员权限
        string strOnlyAskFor = ConfigurationManager.AppSettings["OnlyAskFor"];//只有申请权限
        if (strSystemManager.Split(',').Contains(u.UserRole))
            u.UserRoleID = 0;
        else if (strOnlyAskFor.Split(',').Contains(u.UserRole))
            u.UserRoleID = 2;
        else
            u.UserRoleID = 1;

        UserInfoService.UserInfoSave(u);

        DataContractJsonSerializer json = new DataContractJsonSerializer(u.GetType());
        json.WriteObject(context.Response.OutputStream, u);
    }


    public class ReturnDate
    {
        public string total { get; set; }
        public List<userinfo> rows { get; set; }
    }


}