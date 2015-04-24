<%@ WebHandler Language="C#" Class="BaseDataManage" %>

using System;
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using System.Web;
using ChaiLvService;
using ChaiLvService.Service;

public class BaseDataManage : IHttpHandler
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
                    GetBaseDataList(context);
                    break;
                case "Edit":
                    EditBaseData(context);
                    break;
                case "Get":
                    GetBaseData(context);
                    break;
                case "Del":
                    DelBaseData(context);
                    break;
            }
        }
    }

    public void DelBaseData(HttpContext context)
    {
        string ddid = context.Request["ddid"];
        bool blnSuccess = DataDictionaryService.DataDictionaryDelete(Convert.ToInt32(ddid));
        DataContractJsonSerializer json = new DataContractJsonSerializer(blnSuccess.GetType());
        json.WriteObject(context.Response.OutputStream, blnSuccess);
    }

    public void GetBaseData(HttpContext context)
    {
        string ddid = context.Request["ddid"];
        DataDictionary d = null;
        if (ddid.Length > 0)
            d = DataDictionaryService.GetDateDictionaryByID(Convert.ToInt32(ddid));

        DataContractJsonSerializer json = new DataContractJsonSerializer(d.GetType());
        json.WriteObject(context.Response.OutputStream, d);
    }

    public void EditBaseData(HttpContext context)
    {
        string ddid = context.Request["ddid"];
        string ddtype = context.Request["ddtype"];
        string ddvalue = context.Request["ddvalue"];
        string dddesc = context.Request["dddesc"];

        DataDictionary d = null;
        if (ddid.Length > 0)
            d = DataDictionaryService.GetDateDictionaryByID(Convert.ToInt32(ddid));
        if (d != null)
        {
            d.DataDictionaryType = ddtype;
            d.DataDictionaryValue = ddvalue;
            d.DataDictionaryDesc = dddesc;
        }
        else
        {
            d = new DataDictionary
            {
                DataDictionaryType = ddtype,
                DataDictionaryValue = ddvalue,
                DataDictionaryDesc = dddesc
            };
        }

        DataDictionaryService.DataDictionarySave(d);

        DataContractJsonSerializer json = new DataContractJsonSerializer(d.GetType());
        json.WriteObject(context.Response.OutputStream, d);
    }

    public void GetBaseDataList(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request["page"]);
        int rows = Convert.ToInt32(context.Request["rows"]);

        string strType = context.Request["ddtype"] ?? "";
        string strValue = context.Request["ddvalue"] ?? "";
        strType = strType.Trim();
        strValue = strValue.Trim();

        List<DataDictionary> listdd = DataDictionaryService.GetDataDicListPagedByGroup(rows, page, strType, strValue);

        ReturnDate rd = new ReturnDate();
        rd.total = DataDictionaryService.GetDataDicListPagedByGroup(0, page, strType, strValue).Count.ToString();
        rd.rows = listdd;
        DataContractJsonSerializer json = new DataContractJsonSerializer(rd.GetType());
        json.WriteObject(context.Response.OutputStream, rd);
    }
    public class ReturnDate
    {
        public string total { get; set; }
        public List<DataDictionary> rows { get; set; }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}