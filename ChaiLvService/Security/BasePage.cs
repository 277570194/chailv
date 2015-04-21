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
        private userinfo user = null;
        protected override void OnPreInit(EventArgs e)
        {
            if (this.Session[SessionKeys.UserInfo] != null)
            {

            }
            else
                this.Response.Redirect(this.Request.ApplicationPath.TrimEnd('/') + "/Login.aspx", true);

            base.OnPreInit(e);
        }
        //保存登陆用户信息
        public userinfo User
        {
            get
            {
                if (this.user == null)
                    this.user = (userinfo)this.Session[SessionKeys.UserInfo];

                return this.user;
            }
            private set
            {
                this.user = value;
                this.Session[SessionKeys.UserInfo] = this.user;
            }
        }

    }
}
