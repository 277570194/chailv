<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CLRequest.aspx.cs" Inherits="CLRequest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link type="text/css" href="easyui/themes/default/easyui.css" rel="stylesheet" />
    <link type="text/css" href="easyui/themes/icon.css" rel="stylesheet" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <form id="myform" style="text-align: center">
        <table border="0" style="padding-left: 25%; padding-top: 10px; line-height: 20px">
            <tr>
                <td style="text-align: right">申请人：
                </td>
                <td style="text-align: left">
                    <input type="text" name="txtUsername" class="easyui-validatebox textbox" readonly="true" required="true" missingmessage="请输入姓名!" /></td>
            </tr>
            <tr>
                <td style="text-align: right">审核领导：</td>
                <td style="text-align: left">
                    <input id="txtDepartUser" name="txtDepartUser" class="easyui-combobox" required="true" editable="false" valuefield="id" textfield="name" missingmessage="请选择审核领导!" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">出差地点：</td>
                <td style="text-align: left">
                    <input type="text" name="txtPlace" class="easyui-validatebox textbox" required="true" missingmessage="请输入出差地点!" /></td>
            </tr>
            <tr>
                <td style="text-align: right">出差类型：</td>
                <td style="text-align: left">
                    <%-- <input id="ddlType" name="ddlType" class="easyui-combobox" required="true" editable="false" valuefield="id" textfield="name" missingmessage="请选择出差类型!" />--%>
                    <select id="ddlChuChaiType" class="easyui-combobox" editable="false" name="ddlChuChaiType" required="true" missingmessage="请选择出差类型!" style="width: 139px;">
                        <option></option>
                        <option value="会议">会议</option>
                        <option value="维护">维护</option>
                        <option value="合同谈判">合同谈判</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">计划出差时间：</td>
                <td style="text-align: left">
                    <input type="text" id="txtStartDate" name="txtStartDate" class="easyui-datetimebox textbox" style="width: 142px; height: 22px" required="true" missingmessage="请输入出差开始时间!" /></td>
                <td>至</td>
                <td style="text-align: left">
                    <input type="text" id="txtEndDate" name="txtEndDate" class="easyui-datetimebox textbox" style="width: 142px; height: 22px" required="true" missingmessage="请输入出差结束时间!" /></td>
            </tr>
            <tr>
                <td style="text-align: right">预计天数：</td>
                <td style="text-align: left">
                    <input type="text" id="txtDays" name="txtDays" class="easyui-numberbox textbox" required="true" missingmessage="请输入出差天数!" /></td>
            </tr>
            <tr>
                <td style="text-align: right">是否在朋友家住宿：</td>
                <td style="text-align: left">是<input type="radio" checked="checked" name="radStay" value="是" />
                    否<input type="radio" name="radStay" value="否" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">是否在单位就餐：</td>
                <td style="text-align: left">是<input type="radio" checked="checked" name="radEat" value="是" />
                    否<input type="radio" name="radEat" value="否" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">是否安排食宿：</td>
                <td style="text-align: left">是<input type="radio" checked="checked" name="radRoomEat" value="是" />
                    否<input type="radio" name="radRoomEat" value="否" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">交通工具：</td>
                <td style="text-align: left">
                    <select id="ddlJiaoTong" class="easyui-combobox" editable="false" name="ddlJiaoTong" required="true" missingmessage="请选择交通工具!" style="width: 139px;">
                        <option></option>
                        <option value="火车">火车</option>
                        <option value="汽车">汽车</option>
                        <option value="高铁">高铁</option>
                        <option value="飞机">飞机</option>
                        <option value="轮渡">轮渡</option>
                    </select>
            </tr>
            <tr>
                <td style="text-align: right">出差目的：</td>
                <td colspan="3" style="text-align: left">
                    <%--<input type="text" id="txtDescription" name="txtDescription" multiline="true" class="easyui-validatebox textbox" style="width: 300px; height: 100px" required="true" missingmessage="请输入出差天数目的!" />--%>
                    <textarea id="txtDescription" name="txtDescription" style="width: 300px; height: 80px; border: 1px solid #95B8E7; border-radius: 5px" /></textarea>
                </td>

            </tr>
            <tr>
                <td style="text-align: right">预估出差住宿费用：</td>
                <td style="text-align: left">
                    <input type="text" id="txtZhuSu" name="txtZhuSu" class="easyui-numberbox textbox" required="true" missingmessage="请输入住宿费用!" /></td>
            </tr>
            <tr>
                <td style="text-align: right">预估出差伙食费用：</td>
                <td style="text-align: left">
                    <input type="text" id="txtHuoShi" name="txtHuoShi" class="easyui-numberbox textbox" required="true" missingmessage="请输入伙食费用!" /></td>
            </tr>
            <tr>
                <td style="text-align: right">预估出差交通费用：</td>
                <td style="text-align: left">
                    <input type="text" id="txtJiaoTong" name="txtJiaoTong" class="easyui-numberbox textbox" required="true" missingmessage="请输入交通费用!" /></td>
            </tr>
            <tr>
                <td style="text-align: right">预估出差总费用：</td>
                <td style="text-align: left">
                    <input type="text" id="txtSum" name="txtSum" class="easyui-validatebox textbox" readonly="true" /></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 60px"><a class="easyui-linkbutton">申&nbsp;&nbsp;请</a></td>
            </tr>
        </table>
    </form>
    <script type="text/javascript" src="js/CLRequest.js"></script>
</body>
</html>
