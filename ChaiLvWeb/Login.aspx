<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link type="text/css" href="easyui/themes/default/easyui.css" rel="stylesheet" />
    <link type="text/css" href="easyui/themes/icon.css" rel="stylesheet" />
    <link type="text/css" href="style/Css/Login.css" rel="stylesheet" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <div class="easyui-window" title="用户登录" style="width: 270px; height: 204px; padding: 5px;" maximizable="false"
        iconcls='icon icon-users' minimizable="false" closable="false" modal="false" collapsible="false" resizable="false" draggable="false">
        <form id="myform">
            <div class="easyui-panel" fit="true" style="text-align: center;">
                <table border="0" width="100%" style="line-height: 25px">
                    <tr>
                        <td align="right">单&nbsp;&nbsp;位:</td>
                        <td align="center">
                            <input name="txtUnit" id="txtUnit" class="easyui-combobox" editable="false" required="true" valuefield="id" textfield="name" missingmessage="请选择机关!" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">部&nbsp;&nbsp;门:</td>
                        <td align="center">
                            <input id="txtDepartment" name="txtDepartment" class="easyui-combobox" required="true" editable="false" valuefield="id" textfield="name" missingmessage="请选择职别!" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">姓&nbsp;&nbsp;名:</td>
                        <td align="center">
                            <input type="text" name="username" class="easyui-validatebox textbox" required="true" missingmessage="请输入姓名!" /></td>
                    </tr>
                    <tr>
                        <td align="right">密&nbsp;&nbsp;码:</td>
                        <td align="center">
                            <input type="password" name="password" class="easyui-validatebox textbox" required="true" missingmessage="请输入密码!" /></td>
                    </tr>
                    <tr align="right">
                        <td colspan="2">
                            <table border="0" width="100%">
                                <tr>
                                    <td>
                                        <label id="lblErrorMessage" style="color: red; padding-right: 10px;"></label>
                                    </td>
                                    <td style="text-align: right; padding-right: 15px;"><a id="btnLogin" class="easyui-linkbutton">登&nbsp;陆</a></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
    <script type="text/javascript" src="js/Login.js"></script>
</body>
</html>
