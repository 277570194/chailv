$(
    function () {
        $('#gv_UserManage').datagrid({
            url: 'Service/UserManage.ashx',
            fit: true,
            fitColumns: true,
            rownumbers: true,
            border: false,
            pagination: true,
            pageSize: 5,
            pageList: [5, 10, 15, 20, 25],
            pageNumber: 1,
            idField: 'UserID',
            queryParams: { mode: 'Qry' },
            dataType: 'json',
            columns: [[
            {
                field: 'UserID',
                title: '编号',
                width: 10,
                //checkbox: true,
            }, {
                field: 'UserName',
                title: '用户名',
                width: 100,
            }, {
                field: 'UserUint',
                title: '单位',
                width: 100,
            }, {
                field: 'UserDepartment',
                title: '部门',
                width: 100,
            }
            ]],
            toolbar: "#manage_tool"
        });

        $('#manager_edit').dialog({
            width: 350,
            title: '编辑用户',
            modal: true,
            closed: true,
            iconCls: 'icon-user-add',
            buttons: [{
                text: '保存',
                iconCls: 'icon-add-new',
                handler: function () {
                    if ($('#manager_edit').form('validate')) {
                        $.ajax({
                            url: 'Service/UserManage.ashx',
                            type: 'post',
                            data: {
                                mode: 'Edit',
                                userid: $('input[name="userid"]').val(),
                                username: $('input[name="username"]').val(),
                                userunit: $('input[name="userunit"]').val(),
                                userdepartment: $('input[name="userdepartment"]').val(),
                            },
                            beforeSend: function () {
                                $.messager.progress({
                                    text: '正在保存中...',
                                });
                            },
                            success: function (data, response, status) {
                                data = $.parseJSON(data);
                                $.messager.progress('close');
                                console.log(data);
                                if (data) {
                                    $.messager.show({
                                        title: '提示',
                                        msg: '保存成功',
                                    });
                                    $('#manager_edit').dialog('close').form('reset');
                                    $('#gv_UserManage').datagrid('reload');
                                    $('#gv_UserManage').datagrid('unselectAll');
                                } else {
                                    $.messager.alert('保存失败！', '未知错误导致失败，请重试！', 'warning');
                                }
                            }
                        });
                    }
                },
            }, {
                text: '取消',
                iconCls: 'icon-redo',
                handler: function () {
                    $('#manager_edit').dialog('close').form('reset');
                },
            }],
        });


        manage_tool = {
            add: function () {
                $('#manager_edit').dialog('open');
                $('input[name="username"]').focus();
            },
            edit: function () {
                var rows = $('#gv_UserManage').datagrid('getSelections');
                if (rows.length > 1) {
                    $.messager.alert('警告操作！', '编辑记录只能选定一条数据！', 'warning');
                } else if (rows.length == 1) {
                    $.ajax({
                        url: 'Service/UserManage.ashx',
                        type: 'post',
                        data: {
                            mode: 'Get',
                            userid: rows[0].UserID,
                        },
                        beforeSend: function () {
                            $.messager.progress({
                                text: '正在获取中...',
                            });
                        },
                        success: function (data, response, status) {
                            $.messager.progress('close');

                            if (data) {
                                var obj = $.parseJSON(data);
                                $('#manager_edit').form('load', {
                                    userid: obj.UserID,
                                    username: obj.UserName,
                                    userunit: obj.UserUint,
                                    userdepartment: obj.UserDepartment
                                }).dialog('open');

                                ////分配权限
                                //$('#auth_edit').combotree({
                                //    url: 'nav.php',
                                //    required: true,
                                //    lines: true,
                                //    multiple: true,
                                //    checkbox: true,
                                //    onlyLeafCheck: true,
                                //    onLoadSuccess: function (node, data) {
                                //        var _this = this;
                                //        if (data) {
                                //            $(data).each(function (index, value) {
                                //                if ($.inArray(value.text, auth) != -1) {
                                //                    $(_this).tree('check', value.target);
                                //                }
                                //                if (this.state == 'closed') {
                                //                    $(_this).tree('expandAll');
                                //                }
                                //            });
                                //        }
                                //    },
                                //});

                            } else {
                                $.messager.alert('获取失败！', '未知错误导致失败，请重试！', 'warning');
                            }
                        }
                    });
                } else if (rows.length == 0) {
                    $.messager.alert('警告操作！', '编辑记录至少选定一条数据！', 'warning');
                }
            },
            reload: function () {
                $('#gv_UserManage').datagrid('reload');
            },
            redo: function () {
                $('#gv_UserManage').datagrid('unselectAll');
            },
            remove: function () {
                var rows = $('#gv_UserManage').datagrid('getSelections');
                if (rows.length > 0) {
                    $.messager.confirm('确定操作', '您正在要删除所选的记录吗？', function (flag) {
                        if (flag) {
                            var ids = [];
                            for (var i = 0; i < rows.length; i++) {
                                ids.push(rows[i].UserID);
                            }
                            console.log(ids.join(','));
                            $.ajax({
                                type: 'POST',
                                url: 'Service/UserManage.ashx',
                                data: {
                                    mode: 'Del',
                                    userids: ids.join(','),
                                },
                                beforeSend: function () {
                                    $('#gv_UserManage').datagrid('loading');
                                },
                                success: function (data) {
                                    if (data) {
                                        $('#gv_UserManage').datagrid('loaded');
                                        $('#gv_UserManage').datagrid('load');
                                        $('#gv_UserManage').datagrid('unselectAll');
                                        $.messager.show({
                                            title: '提示',
                                            msg: data + '个用户被删除！',
                                        });
                                    }
                                },
                            });
                        }
                    });
                } else {
                    $.messager.alert('提示', '请选择要删除的记录！', 'info');
                }
            },
        };
    }
);