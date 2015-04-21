using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace ChaiLvService
{
    public static class NavTree
    {
        /// <summary>
        /// 获取导航菜单项
        /// </summary>
        /// <returns></returns>
        public static List<navigationtree> GetNavTree(Int32 strRoleID, Int32 nodeID)
        {
            using (CLEntities dbContext = new CLEntities())
            {
                return dbContext.navigationtree.Where(u => strRoleID == u.RoleID && u.nid == nodeID).ToList();
            }
        }
    }
}
