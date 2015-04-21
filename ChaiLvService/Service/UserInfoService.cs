﻿using ChaiLvService.Security;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ChaiLvService
{
    public class UserInfoService
    {
        /// <summary>
        /// 用户新增或者修改
        /// </summary>
        /// <param name="u"></param>
        public static void UserInfoSave(userinfo u)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                dbContext.userinfo.AddOrUpdate(u);
                dbContext.SaveChanges();
            }
        }

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="intUserID"></param>
        /// <returns></returns>
        public static bool UserInfoDelete(int intUserID)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                userinfo u = dbContext.userinfo.FirstOrDefault(u1 => u1.UserID == intUserID);
                if (u != null)
                {
                    u.UserStatus = "已删除";
                    dbContext.userinfo.AddOrUpdate(u);
                    dbContext.SaveChanges();
                    return true; ;
                }
                return false;
            }
        }

        /// <summary>
        /// 获取用户列表
        /// </summary>
        /// <returns></returns>
        public static List<userinfo> GetUserInfoList()
        {
            using (CLEntities dbContext = new CLEntities())
            {
                return dbContext.userinfo.Where(u => u.UserStatus != "已删除").ToList();
            }
        }
        public static List<userinfo> GetUserInfoListPage(int pageSize, int pageNum)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                List<userinfo> list = dbContext.userinfo.Where(u => u.UserStatus != "已删除").OrderBy(u => u.UserID).Take(pageSize * pageNum).Skip(pageSize * (pageNum - 1)).ToList();
                return list;
            }
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <returns></returns>
        public static List<userinfo> GetUserInfo(String strUserUint)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                return dbContext.userinfo.Where(u => u.UserStatus != "已删除"
                    && u.UserUint == strUserUint).ToList();
            }
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <returns></returns>
        public static List<userinfo> GetUserInfo(String strUserUint, string strDepartment,
        string strUserName, string strPwd, ref string strErrorType)
        {
            List<userinfo> objUserInfoList = new List<userinfo>();
            if (String.IsNullOrEmpty(strUserUint))
            {
                strErrorType = "1";//必须选择机关
                goto ErrorShow;
            }
            if (String.IsNullOrEmpty(strDepartment))
            {
                strErrorType = "2";//必须选择职别
                goto ErrorShow;
            }
            if (String.IsNullOrEmpty(strUserName))
            {
                strErrorType = "3";//必须输入姓名
                goto ErrorShow;
            }
            if (String.IsNullOrEmpty(strPwd))
            {
                strErrorType = "4";//密码不能为空
                goto ErrorShow;
            }
            using (CLEntities dbContext = new CLEntities())
            {
                objUserInfoList = dbContext.userinfo.Where(u => u.UserStatus != "已删除"
                     && u.UserUint == strUserUint).ToList();
                if (objUserInfoList != null && objUserInfoList.Count > 0)
                {
                    objUserInfoList = objUserInfoList.Where(u => u.UserDepartment == strDepartment).ToList();
                    if (objUserInfoList != null && objUserInfoList.Count > 0)
                    {
                        objUserInfoList = objUserInfoList.Where(u => u.UserName == strUserName).ToList();
                        if (objUserInfoList != null && objUserInfoList.Count > 0)
                        {
                            objUserInfoList = objUserInfoList.Where(u => u.UserPwd == CommonCryptoProvider.Encrypt(strPwd)).ToList();
                            if (objUserInfoList != null && objUserInfoList.Count > 0)
                            {
                                strErrorType = "9";
                                goto ErrorShow;
                            }
                            else
                            {
                                strErrorType = "8"; //密码输入有误
                                objUserInfoList = null;
                                goto ErrorShow;
                            }
                        }
                        else
                        {
                            strErrorType = "7"; //用户不存在
                            objUserInfoList = null;
                            goto ErrorShow;
                        }
                    }
                    else
                    {
                        strErrorType = "6"; //职别不存在
                        objUserInfoList = null;
                        goto ErrorShow;
                    }
                }
                else
                {
                    strErrorType = "5"; //机关不存在
                    objUserInfoList = null;
                    goto ErrorShow;
                }
            }
        ErrorShow:

            return objUserInfoList;
        }

        /// <summary>
        ///  获取所有单位
        /// </summary>
        /// <param name="strExclude">排除那个单位(如：管理员)</param>
        /// <returns></returns>
        public static string GetUnit(string strExclude)
        {
            string strReturnValue = String.Empty;
            List<userinfo> UserInfoList = UserInfoService.GetUserInfoList();
            if (UserInfoList != null && UserInfoList.Count > 0)
            {
                var userinfoList = (from user in UserInfoList orderby user.UserUint where user.UserUint != "" && (strExclude == "" || user.UserUint != strExclude) select user.UserUint).Distinct();
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

        /// <summary>
        ///  获取对于单位的部门
        /// </summary>
        /// <param name="strUnit">单位名称</param>
        /// <returns></returns>
        public static string GetDepartment(string strUnit)
        {
            string strReturnValue = String.Empty;
            List<userinfo> UserInfoList = UserInfoService.GetUserInfoList();
            if (UserInfoList != null && UserInfoList.Count > 0)
            {
                var userinfoList = (from user in UserInfoList orderby user.UserUint where user.UserUint == strUnit && user.UserDepartment != "" select user.UserDepartment).Distinct();
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
}
