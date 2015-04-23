<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserManage.aspx.cs" Inherits="UserManage" %>

<!DOCTYPE html>

<table id="gv_UserManage"></table>

<%--//用户模块的工具栏--%>
<div id="manage_tool" style="padding: 0px;">
    <div style="margin: 5px;">
        <a href="#" class="easyui-linkbutton" iconcls="icon-add-new" plain="true" onclick="manage_tool.add();">添加</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-edit-new" plain="true" onclick="manage_tool.edit();">修改</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-delete-new" plain="true" onclick="manage_tool.remove();">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-reload" plain="true" onclick="manage_tool.reload();">刷新</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-redo" plain="true" id="redo" onclick="manage_tool.redo();">取消选择</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-undo" plain="true" id="reset" onclick="manage_tool.reset();">重置密码</a>
    </div>
    <div style="padding: 0 0 0 10px; color: #333; border-top: solid 1px #ccc">
        查询用户：<input type="text" class="textbox" id="search_username" name="search_username" style="width: 110px;">&nbsp;&nbsp;
        单&nbsp;位：<input id="search_userunit" name="userunit" class="easyui-combobox" style="width: 130px;">&nbsp;&nbsp;
        部&nbsp;门：<input id="search_userdepartment" name="userdepartment" class="easyui-combobox" style="width: 130px;">&nbsp;&nbsp;
        职&nbsp;别：<input id="search_usergrade" name="search_usergrade" class="easyui-combobox" style="width: 130px;">&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" iconcls="icon-search" onclick="manage_tool.search();">查询</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-undo" onclick="manage_tool.resetquery();">重置</a>
    </div>
</div>

<form id="manager_edit" style="margin: 0; padding: 5px 0 0 25px; color: #333;">
    <input type="text" name="userid" class="textbox" style="width: 200px; display: none;">
    <p>用户名：<input type="text" name="username" class="textbox" style="width: 193px;"></p>
    <p>单&nbsp;位：<input id="userunit" name="userunit" class="easyui-combobox" style="width: 200px;"></p>
    <p>部&nbsp;门：<input id="userdepartment" name="userdepartment" class="easyui-combobox" style="width: 200px;"></p>
    <p>职&nbsp;别：<input id="usergrade" name="usergrade" class="easyui-combobox" style="width: 200px;"></p>
</form>

<script type="text/javascript" src="js/UserManage.js"></script>
