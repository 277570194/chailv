﻿$(
    function () {
        $('#nav').tree({
            lines: true,
            url: 'BusinessPage.aspx?method=GetNodes',
            onClick: function (node) {
                //console.log(node);
                if (node.url) {
                    if ($('#tabs').tabs('exists', node.text)) {
                        $('#tabs').tabs('select', node.text);
                    } else {
                        $('#tabs').tabs('add', {
                            title: node.text,
                            //iconCls: node.iconCls,
                            closable: true,
                            href: node.url + '.aspx',
                        });
                    }
                }
            },
            onLoadSuccess: function (node, data) {
                if (data) {
                    $(data).each(function (index, value) {
                        if (this.state == 'closed') {
                            $('#nav').tree('expandAll');
                        }
                    });
                }
            }
        });

        $('#tabs').tabs({
            fit: true,
            border: false,
        });
    },

     Logout = function () {
         $.messager.confirm('确定操作', '确定要退出登录吗？', function (flag) {
             if (flag) {
                 window.location.href = "login.aspx";
                 //$.ajax({
                 //    type: 'POST',
                 //    url: 'Service/UserManage.ashx',
                 //    data: {
                 //        mode: 'Logout'
                 //    },
                 //    success: function (data) {
                 //        if (data) {

                 //        }
                 //    },
                 //});
             }
         });
     }
);