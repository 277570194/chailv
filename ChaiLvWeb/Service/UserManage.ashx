<%@ WebHandler Language="C#" Class="UserManage" %>

using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ChaiLvService;

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
                //case "Logout":
                //    Logout(context);
                //    break; ;
            }

        }
    }

    //private void Logout(HttpContext context)
    //{
    //    string str = "";// context.Session.Keys.Count.ToString();
    //    DataContractJsonSerializer json = new DataContractJsonSerializer(str.GetType());
    //    json.WriteObject(context.Response.OutputStream, str);
    //}

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

        List<userinfo> li = UserInfoService.GetUserInfoListPage(rows, page);

        ReturnDate rd = new ReturnDate();
        rd.total = UserInfoService.GetUserInfoList().Count.ToString();
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

        userinfo u = new userinfo()
        {
            UserName = username,
            UserUint = userunit,
            UserDepartment = userdepartment,
            UserPwd = "123456",
            UserRole = "",
            UserStatus = "正常"
        };
        if (userid.Length > 0)
            u.UserID = Convert.ToInt32(userid);
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