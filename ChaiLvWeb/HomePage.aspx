<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HomePage.aspx.cs" Inherits="HomePage" %>

<%@ Import Namespace="ChaiLvService" %>
<%@ Import Namespace="ChaiLvService.SessionKey" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <link type="text/css" href="easyui/themes/default/easyui.css" rel="stylesheet" />
    <link type="text/css" href="easyui/themes/icon.css" rel="stylesheet" />
    <link type="text/css" href="style/homepage.css" rel="stylesheet" />
</head>

<body class="easyui-layout">
    <div data-options="region:'north'" style="height: 60px; background: #eee;">
        <div class="logo">后台管理</div>
        <div class="logout">您好，<%=((userinfo)Session[SessionKeys.UserInfo]).UserName %>  | <a href="#" onclick="Logout();">退出</a></div>

    </div>
    <div data-options="region:'south'" style="height: 25px; text-align: center; font-family: Arial;">
        MLFH &copy;2015 版权所有
    </div>
    <div data-options="region:'west',title:'导航',split:true" style="width: 180px; padding: 10px;">
        <ul id="nav">
        </ul>
    </div>
    <div data-options="region:'center'" style="overflow: hidden;">
        <div id="tabs">
            <div title="起始页" style="padding: 0 10px; display: block;">
                欢迎来到后台管理系统！
            </div>
        </div>
    </div>
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="js/homepage.js"></script>
</body>
</html>
