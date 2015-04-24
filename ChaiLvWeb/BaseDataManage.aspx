<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BaseDataManage.aspx.cs" Inherits="BaseDataManage" %>

<!DOCTYPE html>
<table id="gv_BaseDataManage"></table>
<div id="basedatamanage_tool" style="padding: 0px;">
    <div style="margin: 5px;">
        <a href="#" class="easyui-linkbutton" iconcls="icon-add-new" plain="true" onclick="basedatamanage_tool.add();">添加</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-edit-new" plain="true" onclick="basedatamanage_tool.edit();">修改</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-delete-new" plain="true" onclick="basedatamanage_tool.remove();">删除</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-redo" plain="true" id="redo" onclick="basedatamanage_tool.redo();">取消选择</a>
    </div>
    <div style="padding: 0 0 0 10px; color: #333; border-top: solid 1px #ccc">
        项目类型：<input id="search_ddtype" name="search_ddtype" class="easyui-combobox" style="width: 130px;">&nbsp;&nbsp;
        项目名称：<input id="search_ddvalue" name="search_ddvalue" class="textbox" style="width: 130px;">&nbsp;&nbsp;
        <a href="#" class="easyui-linkbutton" iconcls="icon-search" onclick="basedatamanage_tool.search();">查询</a>
        <a href="#" class="easyui-linkbutton" iconcls="icon-undo" onclick="basedatamanage_tool.resetquery();">重置</a>
    </div>
</div>
<form id="basedatamanager_edit" style="margin: 0; padding: 5px 0 0 25px; color: #333;">
    <input type="text" id="ddid" name="ddid" class="easyui-textbox" style="width: 200px; display: none;">
    <p>项目类型：<input id="ddtype" name="ddtype" class="easyui-textbox textbox" style="width: 200px;"></p>
    <p>项目名称：<input id="ddvalue" name="ddvalue" class="easyui-textbox textbox" style="width: 200px;"></p>
    <p>项目描述：<input id="dddesc" name="dddesc" class="easyui-textbox textbox" style="width: 200px;"></p>
</form>

<script type="text/javascript" src="js/BaseDataManage.js"></script>

