using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ChaiLvService;
using ChaiLvService.Service;

public partial class BaseDataManage : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string GetDataDicAllType()
    {
        string strReturnValue = "[";
        strReturnValue += "{id:'　',value:'　'},";

        List<string> list = DataDictionaryService.GetDataDicAllType();
        for (int i = 0; list != null && i < list.Count; i++)
        {
            strReturnValue = strReturnValue + "{id:'" + list[i] + "'"
                            + ",value:'" + list[i] + "'},";
        }
        strReturnValue = strReturnValue.TrimEnd(',') + "]";
        return strReturnValue;
    }
}