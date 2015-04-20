<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserManage.aspx.cs" Inherits="UserManage" %>

<!DOCTYPE html>

<table id="gv_UserManage"></table>

<%--//用户模块的工具栏--%>
<div id="manage_tool" style="padding: 5px;">
    <div style="margin-bottom: 5px;">
        <a href="#" class="easyui-linkbutton" iconcls="icon-add-new" plain="true" onclick="manage_tool.add();">添加</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-edit-new" plain="true" onclick="manage_tool.edit();">修改</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-delete-new" plain="true" onclick="manage_tool.remove();">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-reload" plain="true" onclick="manage_tool.reload();">刷新</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-redo" plain="true" id="redo" onclick="manage_tool.redo();">取消选择</a>
    </div>
    <%-- <div style="padding: 0 0 0 7px; color: #333;">
        查询用户：<input type="text" class="textbox" name="search_manager" style="width: 110px">
        创建时间从：<input type="text" name="date_from" class="easyui-datebox" editable="false" style="width: 110px">
        到：<input type="text" name="date_to" class="easyui-datebox" editable="false" style="width: 110px">
        <a href="#" class="easyui-linkbutton" iconcls="icon-search" onclick="manage_tool.search();">查询</a>
    </div>--%>
</div>

<form id="manager_edit" style="margin: 0; padding: 5px 0 0 25px; color: #333;">
    <input type="text" name="userid" class="textbox" style="width: 200px; display: none;">
    <p>用户名：<input type="text" name="username" class="textbox" style="width: 200px;"></p>
    <p>单  位：<input type="text" name="userunit" class="textbox" style="width: 200px;"></p>
    <p>部  门：<input type="text" name="userdepartment" class="textbox" style="width: 200px;"></p>
</form>

<script type="text/javascript" src="js/UserManage.js"></script>
