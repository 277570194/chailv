using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ChaiLvService.Service
{
    public class DataDictionaryService
    {
        /// <summary> 获取数据字典集合 </summary>
        /// <param name="pageSize">每页行数(如果=0表示查询所有)</param>
        /// <param name="pageNum">当前页码</param>
        /// <param name="strGroupName">配置项类型（不输入表示查询所有类型）</param>
        /// <param name="strValue">配置项值（不输入表示查询所有类型）</param>
        /// <returns>返回DataDictionary集合</returns>
        public static List<DataDictionary> GetDataDicListPagedByGroup(int pageSize, int pageNum, string strGroupName, string strValue)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                if (pageSize > 0)
                    return dbContext.datadictionary.Where(dd =>
                        (string.IsNullOrEmpty(strGroupName) || (!string.IsNullOrEmpty(strGroupName) && dd.DataDictionaryType == strGroupName))
                        && (string.IsNullOrEmpty(strValue) || (!string.IsNullOrEmpty(strValue) && dd.DataDictionaryValue.IndexOf(strValue) > -1))
                        ).OrderBy(dd => dd.DataDictionaryType).ThenBy(dd => dd.DataDictionaryValue).Skip(pageSize * (pageNum - 1)).Take(pageSize * pageNum).ToList();
                else
                    return dbContext.datadictionary.Where(dd =>
                        (string.IsNullOrEmpty(strGroupName) || (!string.IsNullOrEmpty(strGroupName) && dd.DataDictionaryType == strGroupName))
                        && (string.IsNullOrEmpty(strValue) || (!string.IsNullOrEmpty(strValue) && dd.DataDictionaryValue.IndexOf(strValue) > -1))
                        ).OrderBy(dd => dd.DataDictionaryType).ThenBy(dd => dd.DataDictionaryValue).ToList();
            }
        }

        /// <summary> 根据ID查询单个数据字典实体 </summary>
        /// <param name="intDataDicID">实体ID</param>
        /// <returns>返回单个DataDictionary实体</returns>
        public static DataDictionary GetDateDictionaryByID(int intDataDicID)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                DataDictionary dd = dbContext.datadictionary.FirstOrDefault(d => d.DataDictionaryID == intDataDicID);
                return dd;
            }
        }

        ///<summary> 保存单个实体（没有就新增，有就修改）</summary>
        ///<param name="objDataDictionary">要保存的对象</param> 
        /// <returns></returns>
        public static bool DataDictionarySave(DataDictionary objDataDictionary)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                try
                {
                    dbContext.datadictionary.AddOrUpdate(objDataDictionary);
                    dbContext.SaveChanges();
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }
            }
        }

        /// <summary> 根据ID删除相应实体 </summary>
        /// <param name="intDataDicID"></param>
        /// <returns></returns>
        public static bool DataDictionaryDelete(int intDataDicID)
        {
            using (CLEntities dbContext = new CLEntities())
            { 
                try
                {
                    DataDictionary d = dbContext.datadictionary.FirstOrDefault(d1 => d1.DataDictionaryID == intDataDicID);
                    dbContext.datadictionary.Remove(d);
                    dbContext.SaveChanges();
                    return true;
                }
                catch (Exception)
                {
                    return false;
                }

            }
        }

        /// <summary> 获取所有DataDictionary类型 </summary>
        /// <returns>返回DataDictionary类型结合</returns>
        public static List<string> GetDataDicAllType()
        {
            using (CLEntities dbContext = new CLEntities())
            {
                List<string> list = dbContext.datadictionary.Select(d => d.DataDictionaryType).Distinct().ToList();
                return list;
            }
        }
    }
}
