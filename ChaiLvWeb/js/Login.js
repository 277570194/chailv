$(function () {
    //// 自定义的校验器
    //$.extend($.fn.validatebox.defaults.rules,{
    //    rangLength: {
    //        validator: function (value, params) {
    //            return value.length >= params[0] && value.length <= params[1];
    //        },
    //        message: '输入内容在' + params[0] + '到' + params[1] + '个字之间'
    //    },
    //    midLength: {
    //        validator: function (value, params) {
    //            return value.length < params[0];
    //        },
    //        message: '最少输入内容为' + params[0] + '个'
    //    }
    //});
    //添加登陆按钮提交事件
    $('#btnLogin').click(function () {
        $('#myform').submit();
    });
    //绑定回车
    $('#myform').find('input').on('keyup', function (event) {
        if (event.keyCode == 13) {
            $('#myform').submit();
        }
    });
    //定义form表单 
    $('#myform').form({
        url: 'ValidateUser.aspx',
        data: $('#myform').serialize(),
        dataType: 'text',
        onSubmit: function () {
            if (!$('#myform').form('validate')) {
                $.messager.show({
                    title: '提示信息',
                    msg: '请输入完整信息后,重新登陆!'
                });
                return false;
            }
        },
        success: function (result) {
            var lblErrorMessage = $("#lblErrorMessage");
            if (result != "") {
                if (result.length == 1) {
                    if (result == "1") {
                        lblErrorMessage.text("必须输入机关.");
                    }
                    else if (result == "2") {
                        lblErrorMessage.text("必须输入职别.");
                    }
                    else if (result == "3") {
                        lblErrorMessage.text("必须输入姓名.");
                    }
                    else if (result == "4") {
                        lblErrorMessage.text("姓名不能为空.");
                    }
                    else if (result == "5") {
                        lblErrorMessage.text("所输入机关不存在,请确认输入.");
                    }
                    else if (result == "6") {
                        lblErrorMessage.text("所输入职别不存在,请确认输入.");
                    }
                    else if (result == "7") {
                        lblErrorMessage.text("此用户不存在,请确认输入.");
                    }
                    else if (result == "8") {
                        lblErrorMessage.text("密码输入错误,请重新输入.");
                    }
                }
                else {
                    eval(result);
                }
            }
            else {
                lblErrorMessage.text("服务器发生错误,请重试...");
            }
        },
    });
    //获取所有机关
    $.ajax({
        type: "POST",
        url: "ValidateUser.aspx/GetDepart",
        dataType: "json",
        async: true,
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var dataValues = eval(data.d);
            $("#txtDepartment").combobox("loadData", dataValues);
        },
        error: function (err) {
        }
    });
    //添加选择事件,填充所有相关职别
    $("#txtDepartment").combobox({
        onSelect: function (n, o) {
            $.ajax({
                type: "POST",
                url: "ValidateUser.aspx/GetZhiBie",
                dataType: "json",
                async: true,
                data: "{'strJiGou':'" + n.id + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var ddlZhiBie = $("#txtZhiBie");
                    var dataValues = eval(data.d);
                    ddlZhiBie.combobox("loadData", dataValues);
                    ddlZhiBie.combobox({ disabled: false });
                },
                error: function (err) {
                }
            });
        }
    }); 
})