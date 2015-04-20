using ChaiLvService.SessionKey;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;

namespace ChaiLvService
{
    public class BasePage : Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            if (this.Session[SessionKeys.UserInfo] != null)
            {

            }
            else
                this.Response.Redirect(this.Request.ApplicationPath.TrimEnd('/') + "/Login.aspx", true);

            base.OnPreInit(e);
        }
    }
}
