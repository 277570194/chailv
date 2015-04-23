$(
    function () {
        $('#gv_UserManage').datagrid({
            url: 'Service/UserManage.ashx',
            fit: true,
            fitColumns: true,
            rownumbers: true,
            border: false,
            pagination: true,
            striped: true,
            singleSelect: true,
            pageSize: 10,
            pageList: [10, 20, 30, 50],
            pageNumber: 1,
            idField: 'UserID',
            queryParams: { mode: 'Qry' },
            dataType: 'json',
            columns: [[
            {
                field: 'UserID',
                title: '编号',
                width: 15,
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
            }, {
                field: 'UserRole',
                title: '职别',
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
                                userunit: $('#userunit').combobox("getText"),
                                userdepartment: $('#userdepartment').combobox("getText"),
                                usergrade: $('#usergrade').combobox("getText"),
                            },
                            beforeSend: function () {
                                $.messager.progress({
                                    text: '正在保存中...',
                                });
                            },
                            success: function (data, response, status) {
                                data = $.parseJSON(data);
                                $.messager.progress('close');
                                //console.log(data);
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
            onClose: function () {
                $('#manager_edit').form('reset');
            },
        });

        manage_tool = {
            add: function () {
                $('#manager_edit').dialog({title:"添加用户"});
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
                                    //userunit: obj.UserUint,
                                    //userdepartment: obj.UserDepartment
                                }).dialog('open');
                                var ddlDepartment = $('#userdepartment');
                                var ddlGrade = $('#usergrade');
                                $.ajax({
                                    type: "POST",
                                    url: "UserManage.aspx/GetDepartment",
                                    dataType: "json",
                                    async: true,
                                    data: "{'strUnit':'" + obj.UserUint + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data1) {
                                        var dataValues = eval(data1.d);
                                        ddlDepartment.combobox("loadData", dataValues);
                                    },
                                    error: function (err) {
                                        console.log(err);
                                    }
                                });
                                $.ajax({
                                    type: "POST",
                                    url: "UserManage.aspx/GetGrade",
                                    dataType: "json",
                                    async: true,
                                    data: "{'strUnit':'" + obj.UserUint + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    success: function (data1) {
                                        var dataValues = eval(data1.d);
                                        ddlGrade.combobox("loadData", dataValues);
                                    },
                                    error: function (err) {
                                        console.log(err);
                                    }
                                });

                                $('#userunit').combobox("setValue", obj.UserUint);
                                ddlDepartment.combobox("setValue", obj.UserDepartment);
                                ddlGrade.combobox("setValue", obj.UserRole);
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
            reset: function () {
                var rows = $('#gv_UserManage').datagrid('getSelections');
                if (rows.length > 1) {
                    $.messager.alert('警告操作！', '一次只能选定一条记录！', 'warning');
                } else if (rows.length == 1) {
                    $.messager.confirm('确定操作', '您确定要重置该用户密码吗？', function (flag) {
                        if (flag) {
                            $.ajax({
                                type: 'POST',
                                url: 'Service/UserManage.ashx',
                                data: {
                                    mode: 'ResetPwd',
                                    userid: rows[0].UserID,
                                },
                                beforeSend: function () {
                                    $('#gv_UserManage').datagrid('loading');
                                },
                                success: function (data) {
                                    if (data) {
                                        data = $.parseJSON(data);
                                        //console.log(data);
                                        $('#gv_UserManage').datagrid('loaded');
                                        $('#gv_UserManage').datagrid('load');
                                        $('#gv_UserManage').datagrid('unselectAll');
                                        $.messager.show({
                                            title: '提示',
                                            msg: data.UserName + ' 密码重置成功！',
                                        });
                                    }
                                },
                            });
                        }
                    });
                } else if (rows.length == 0) {
                    $.messager.alert('警告操作！', '编辑记录至少选定一条数据！', 'warning');
                }

            },
            resetquery: function () {
                $('#search_username').val("");
                $('#search_userunit').combobox("setText", "　");
                $("#search_userdepartment").combobox("setText", "　");
                $("#search_usergrade").combobox("setText", "　");
            },
            search: function () {
                $('#gv_UserManage').datagrid('load', {
                    mode: 'Qry',
                    username: $('#search_username').val(),
                    userunit: $('#search_userunit').combobox("getText"),
                    userdpm: $("#search_userdepartment").combobox("getText"),
                    usergrade: $("#search_usergrade").combobox("getText"),
                });
            }
        };

        //获取所有单位，部门，职别
        $.ajax({
            type: "POST",
            url: "UserManage.aspx/GetUnit",
            dataType: "json",
            async: true,
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                //#region 编辑窗口下拉
                var umunit = eval(data.d);
                var ddlUnit = $('#userunit');
                var ddlDepartment = $("#userdepartment");
                var ddlGrade = $("#usergrade");

                ddlGrade.combobox({ valueField: 'id', textField: 'name', editable: true, }).combo({ panelHeight: 100, });
                ddlDepartment.combobox({ valueField: 'id', textField: 'name', }).combo({ panelHeight: 100, });
                ddlUnit.combobox({
                    valueField: 'id', textField: 'name',
                    onSelect: function (n) {
                        ddlDepartment.combobox("setValue", "");
                        ddlGrade.combobox("setValue", "");
                        $.ajax({
                            type: "POST",
                            url: "UserManage.aspx/GetDepartment",
                            dataType: "json",
                            async: true,
                            data: "{'strUnit':'" + n.id + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data1) {
                                var dataValues = eval(data1.d);
                                ddlDepartment.combobox("loadData", dataValues);
                                ddlDepartment.combobox("setText", "　");
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                        $.ajax({
                            type: "POST",
                            url: "UserManage.aspx/GetGrade",
                            dataType: "json",
                            async: true,
                            data: "{'strUnit':'" + n.id + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data1) {
                                var dataValues = eval(data1.d);
                                ddlGrade.combobox("loadData", dataValues);
                                ddlGrade.combobox("setText", "　");
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    },
                });
                ddlUnit.combobox("loadData", umunit).combo({ panelHeight: 100, });
                ddlUnit.combobox("setText", "　");
                ddlDepartment.combobox("setText", "　");
                ddlGrade.combobox("setText", "　");
                //#endregion 

                //region 查询下拉
                var ddlSearchUnit = $('#search_userunit');
                var ddlSearchDepartment = $("#search_userdepartment");
                var ddlSearchGrade = $("#search_usergrade");

                ddlSearchGrade.combobox({ valueField: 'id', textField: 'name', editable: false, }).combo({ panelHeight: 100, });
                ddlSearchDepartment.combobox({ valueField: 'id', textField: 'name', editable: false, }).combo({ panelHeight: 100, });
                ddlSearchUnit.combobox({
                    valueField: 'id', textField: 'name', editable: false,
                    onSelect: function (n) {
                        ddlSearchDepartment.combobox("setValue", "");
                        ddlSearchGrade.combobox("setValue", "");
                        $.ajax({
                            type: "POST",
                            url: "UserManage.aspx/GetDepartment",
                            dataType: "json",
                            async: true,
                            data: "{'strUnit':'" + n.id + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data1) {
                                var dataValues = eval(data1.d);
                                ddlSearchDepartment.combobox("loadData", dataValues);
                                ddlSearchDepartment.combobox("setText", "　");
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                        $.ajax({
                            type: "POST",
                            url: "UserManage.aspx/GetGrade",
                            dataType: "json",
                            async: true,
                            data: "{'strUnit':'" + $('#search_userunit').combobox("getValue") + "'}",
                            contentType: "application/json; charset=utf-8",
                            success: function (data1) {
                                var dataValues = eval(data1.d);
                                ddlSearchGrade.combobox("loadData", dataValues);
                                ddlSearchGrade.combobox("setText", "　");
                            },
                            error: function (err) {
                                console.log(err);
                            }
                        });
                    },
                });
                ddlSearchUnit.combobox("loadData", umunit).combo({ panelHeight: 100, });

                ddlSearchUnit.combobox("setText", "　");
                ddlSearchDepartment.combobox("setText", "　");
                ddlSearchGrade.combobox("setText", "　");
                //endregion
            },
            error: function (err) {
                console.log(err);
            }
        });
    }
);