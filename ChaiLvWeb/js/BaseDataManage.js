$(
    function () {
        $('#gv_BaseDataManage').datagrid({
            url: 'Service/BaseDataManage.ashx',
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
            idField: 'DataDictionaryID',
            queryParams: { mode: 'Qry' },
            dataType: 'json',
            columns: [[{
                field: 'DataDictionaryID',
                title: '编号',
                width: 15,
                //checkbox: true,
            }, {
                field: 'DataDictionaryType',
                title: '项目类型',
                width: 100,
            }, {
                field: 'DataDictionaryValue',
                title: '项目名称',
                width: 100,
            }, {
                field: 'DataDictionaryDesc',
                title: '项目描述',
                width: 100,
            }
            ]],
            toolbar: "#basedatamanage_tool"
        });

        $('#basedatamanager_edit').dialog({
            width: 350,
            title: '编辑用户',
            modal: true,
            closed: true,
            iconCls: 'icon-user-add',
            buttons: [{
                text: '保存',
                iconCls: 'icon-add-new',
                handler: function () {
                    if ($('#basedatamanager_edit').form('validate')) {
                        $.ajax({
                            url: 'Service/BaseDataManage.ashx',
                            type: 'post',
                            data: {
                                mode: 'Edit',
                                ddid: $('#ddid').val(),
                                ddtype: $('#ddtype').combobox("getText"),
                                ddvalue: $('#ddvalue').val(),
                                dddesc: $('#dddesc').val(),
                            },
                            beforeSend: function () {
                                $.messager.progress({
                                    text: '正在保存中...',
                                });
                            },
                            success: function (data, response, status) {
                                data = $.parseJSON(data);
                                $.messager.progress('close');
                                if (data) {
                                    $.messager.show({
                                        title: '提示',
                                        msg: '保存成功',
                                    });
                                    $('#basedatamanager_edit').dialog('close').form('reset');
                                    $('#gv_BaseDataManage').datagrid('reload');
                                    $('#gv_BaseDataManage').datagrid('unselectAll');
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
                    $('#basedatamanager_edit').dialog('close').form('reset');
                },
            }],
            onClose: function () {
                $('#basedatamanager_edit').form('reset');
            },
        });

        basedatamanage_tool = {
            add: function () {
                $('#basedatamanager_edit').dialog({ title: "添加项目" });
                $('#basedatamanager_edit').dialog('open');
                $('#ddtype').focus();
                $.ajax({
                    type: "POST",
                    url: "BaseDataManage.aspx/GetDataDicAllType",
                    dataType: "json",
                    async: true,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var umunit = eval(data.d);
                        var ddtype = $('#ddtype');
                        ddtype.combobox("loadData", umunit);
                        ddtype.combobox("setText", "");

                        var search_ddtype = $('#search_ddtype');
                        search_ddtype.combobox("loadData", umunit);
                        search_ddtype.combobox("setText", "　");
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            },
            edit: function () {
                var rows = $('#gv_BaseDataManage').datagrid('getSelections');
                if (rows.length > 1) {
                    $.messager.alert('警告操作！', '编辑记录只能选定一条数据！', 'warning');
                } else if (rows.length == 1) {
                    $.ajax({
                        url: 'Service/BaseDataManage.ashx',
                        type: 'post',
                        data: {
                            mode: 'Get',
                            ddid: rows[0].DataDictionaryID,
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
                                console.log(obj);
                                $('#basedatamanager_edit').form('load', {
                                    ddid: obj.DataDictionaryID,
                                    ddvalue: obj.DataDictionaryValue,
                                    dddesc: obj.DataDictionaryDesc
                                }).dialog('open');

                                $('#ddtype').combobox("setValue", obj.DataDictionaryType);

                            } else {
                                $.messager.alert('获取失败！', '未知错误导致失败，请重试！', 'warning');
                            }
                        }
                    });
                } else if (rows.length == 0) {
                    $.messager.alert('警告操作！', '编辑记录至少选定一条数据！', 'warning');
                }
            },
            redo: function () {
                $('#gv_BaseDataManage').datagrid('unselectAll');
            },
            remove: function () {
                var rows = $('#gv_BaseDataManage').datagrid('getSelections');
                if (rows.length > 0) {
                    $.messager.confirm('确定操作', '您正在要删除所选的记录吗？', function (flag) {
                        if (flag) {
                            var ddid = rows[0].DataDictionaryID;
                            //console.log(ddid);
                            $.ajax({
                                type: 'POST',
                                url: 'Service/BaseDataManage.ashx',
                                data: {
                                    mode: 'Del',
                                    ddid: ddid,
                                },
                                beforeSend: function () {
                                    $('#gv_BaseDataManage').datagrid('loading');
                                },
                                success: function (data) {
                                    $('#gv_BaseDataManage').datagrid('loaded');
                                    console.log(data.toString().toUpperCase());
                                    if (data.toString().toUpperCase() == "TRUE") {
                                        $('#gv_BaseDataManage').datagrid('loaded');
                                        $('#gv_BaseDataManage').datagrid('load');
                                        $('#gv_BaseDataManage').datagrid('unselectAll');
                                        $.messager.show({ title: '提示', msg: '项目删除成功！', });
                                    } else {
                                        $.messager.show({ title: '提示', msg: '项目删除失败！', });
                                    }
                                },
                            });
                        }
                    });
                } else {
                    $.messager.alert('提示', '请选择要删除的记录！', 'info');
                }
            },
            resetquery: function () {
                $('#search_ddtype').combobox("setText", "　");
                $('#search_ddvalue').val("");
            },
            search: function () {
                $('#gv_BaseDataManage').datagrid('load', {
                    mode: 'Qry',
                    ddtype: $('#search_ddtype').combobox("getText"),
                    ddvalue: $('#search_ddvalue').val()
                });
            }
        };

        $.ajax({
            type: "POST",
            url: "BaseDataManage.aspx/GetDataDicAllType",
            dataType: "json",
            async: true,
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                var umunit = eval(data.d);
                var ddtype = $('#ddtype');
                ddtype.combobox({ valueField: 'id', textField: 'value', });
                ddtype.combobox("loadData", umunit).combo({ panelHeight: 100, });
                ddtype.combobox("setText", "");
                //#endregion 

                //region 查询下拉
                var search_ddtype = $('#search_ddtype');
                search_ddtype.combobox({ valueField: 'id', textField: 'value', });
                search_ddtype.combobox("loadData", umunit).combo({ panelHeight: 100, });
                search_ddtype.combobox("setText", "　");
                //endregion
            },
            error: function (err) {
                console.log(err);
            }
        });

    }
);