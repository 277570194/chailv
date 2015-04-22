<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CLReally.aspx.cs" Inherits="CLReally" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="myform">
        <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
            <tr>
                <td style="height: 15px">&nbsp;</td>
            </tr>
            <tr>
                <td align="right" style="width: 50%;">
                    <div id="divCLRequest">
                        <table border="0" style="padding-right: 30px; padding-top: 10px; line-height: 30px; height: 100%">
                            <tr>
                                <td colspan="4" style="text-align: left; background-color: #f0f3f6; height: 15px">
                                    <label style="font: bolder; font-size: 10pt; padding-left: 10px">申请信息</label></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">申请人：
                                </td>
                                <td style="text-align: left">
                                    <input type="text" name="txtUsername" class="easyui-validatebox textbox" readonly="true" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">预计出差时间：</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtStartDate" name="txtStartDate" class="easyui-datetimebox textbox" readonly="true" style="width: 142px; height: 22px" /></td>
                                <td>至</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtEndDate" name="txtEndDate" class="easyui-datetimebox textbox" readonly="true" style="width: 142px; height: 22px" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">出差地点：</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtPlace" name="txtPlace" class="easyui-validatebox textbox" readonly="true" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">出差类型：</td>
                                <td style="text-align: left">
                                    <select id="ddlChuChaiType" class="easyui-combobox" editable="false" readonly="true" name="ddlChuChaiType" style="width: 139px;">
                                        <option></option>
                                        <option value="会议">会议</option>
                                        <option value="维护">维护</option>
                                        <option value="合同谈判">合同谈判</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">预计天数：</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtDays" name="txtDays" readonly="true" class="easyui-numberbox textbox" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">是否在朋友家住宿：</td>
                                <td style="text-align: left">是<input type="radio" checked="checked" disabled="disabled" name="radStay" value="是" />
                                    否<input type="radio" disabled="disabled" name="radStay" value="否" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">是否在单位就餐：</td>
                                <td style="text-align: left">是<input type="radio" checked="checked" disabled="disabled" name="radEat" value="是" />
                                    否<input type="radio" disabled="disabled" name="radEat" value="否" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">是否安排食宿：</td>
                                <td style="text-align: left">是<input type="radio" checked="checked" disabled="disabled" name="radRoomEat" value="是" />
                                    否<input type="radio" disabled="disabled" name="radRoomEat" value="否" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">交通工具：</td>
                                <td style="text-align: left">
                                    <select id="ddlJiaoTong" name="ddlJiaoTong" class="easyui-combobox" readonly="true" editable="false" name="ddlJiaoTong" style="width: 139px;">
                                        <option></option>
                                        <option value="火车">火车</option>
                                        <option value="汽车">汽车</option>
                                        <option value="高铁">高铁</option>
                                        <option value="飞机">飞机</option>
                                        <option value="轮渡">轮渡</option>
                                    </select>
                            </tr>
                            <tr>
                                <td style="text-align: right">预估出差住宿费用：</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtZhuSu" name="txtZhuSu" readonly="true" class="easyui-numberbox textbox" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">预估出差伙食费用：</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtHuoShi" name="txtHuoShi" readonly="true" class="easyui-numberbox textbox" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">预估出差交通费用：</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtJiaoTong" name="txtJiaoTong" readonly="true" class="easyui-numberbox textbox" /></td>
                            </tr>
                            <tr>
                                <td style="text-align: right">预估出差总费用：</td>
                                <td style="text-align: left">
                                    <input type="text" id="txtSum" name="txtSum" class="easyui-validatebox textbox" readonly="true" /></td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td style="border-right: 1px solid gray;"></td>
                <td style="text-align: left">
                    <table border="0" style="padding-left: 30px; padding-top: 10px; line-height: 30px; height: 100%">
                        <tr>
                            <td colspan="4" style="text-align: left; background-color: #f0f3f6; height: 15px">
                                <label style="font: bolder; font-size: 10pt; padding-left: 10px">实际信息</label></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">实际出差时间：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealStartDate" name="txtRealStartDate" class="easyui-datetimebox textbox" style="width: 142px; height: 22px" required="true" missingmessage="请输入实际出发时间!" /></td>
                            <td>至</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealEndDate" name="txtRealEndDate" class="easyui-datetimebox textbox" style="width: 142px; height: 22px" required="true" missingmessage="请输入实际到达时间!" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">出差地点：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealPlace" name="txtRealPlace" class="easyui-validatebox textbox" required="true" missingmessage="请输入出差地点!" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">实际天数：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealDays" name="txtRealDays" class="easyui-numberbox textbox" required="true" missingmessage="请输入出差天数!" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">是否在朋友家住宿：</td>
                            <td style="text-align: left">是<input type="radio" checked="checked" name="radRealStay" value="是" />
                                否<input type="radio" name="radRealStay" value="否" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">是否在单位就餐：</td>
                            <td style="text-align: left">是<input type="radio" checked="checked" name="radRealEat" value="是" />
                                否<input type="radio" name="radRealEat" value="否" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">是否安排食宿：</td>
                            <td style="text-align: left">是<input type="radio" checked="checked" name="radRealRoomEat" value="是" />
                                否<input type="radio" name="radRealRoomEat" value="否" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right">实乘交通工具：</td>
                            <td style="text-align: left">
                                <select id="ddlRealJiaoTong" name="ddlRealJiaoTong" class="easyui-combobox" editable="false" name="ddlJiaoTong" required="true" missingmessage="请选择交通工具!" style="width: 139px;">
                                    <option></option>
                                    <option value="火车">火车</option>
                                    <option value="汽车">汽车</option>
                                    <option value="高铁">高铁</option>
                                    <option value="飞机">飞机</option>
                                    <option value="轮渡">轮渡</option>
                                </select>
                        </tr>
                        <tr>
                            <td style="text-align: right">住宿费用：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealZhuSu" name="txtRealZhuSu" class="easyui-numberbox textbox" required="true" missingmessage="请输入住宿费用!" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">伙食费用：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealHuoShi" name="txtRealHuoShi" class="easyui-numberbox textbox" required="true" missingmessage="请输入伙食费用!" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">交通费用：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealJiaoTong" name="txtRealJiaoTong" class="easyui-numberbox textbox" required="true" missingmessage="请输入交通费用!" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">总计费用：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealSum" name="txtRealSum" class="easyui-numberbox textbox" readonly="true" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">事情办理状况：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealProgressStatus" name="txtRealProgressStatus" class="easyui-numberbox textbox" required="true" missingmessage="请输入交通费用!" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right">差异说明：</td>
                            <td style="text-align: left">
                                <input type="text" id="txtRealDesc" name="txtRealDesc" class="easyui-validatebox textbox" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="3" style="padding-top: 8px"><a class="easyui-linkbutton">写实登记</a></td>
            </tr>
        </table>
    </form>
     <script type="text/javascript" src="js/CLReally.js"></script>
</body>
</html>
