<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/26/026
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<% response.setHeader("Access-Control-Allow-Origin", "*");%>
<html>
<head>
    <meta charset="utf-8">
    <title>青岛通联支付登录</title>
    <link rel="icon" href="/pic/index_icon.png"/>
    <link rel="stylesheet" type="text/css" href="/css/reset.css"/>
    <link rel="stylesheet" href="/css/login.css"/>
    <script src="/js/jquery-3.3.1.min.js"/>
    <script src="/js/supersized.3.2.7.min.js"></script>
    <script src="/js/supersized-init.js"></script>
    <script src="/js/scripts.js"></script>
    <script src="/js/logins.js"></script>
    <title>青岛通联支付公司QDMS2.0系统</title>
    <script>
        $(document).ready(function () {
            createCode();
        });
        document.onkeydown = keyListener;

        function keyListener(e) {
            // 当按下回车键，执行
            if (e.keyCode == 13) {
                document.getElementById("deng").click(); //回车调用登录按钮的登录事件
            }
        }
    </script>
</head>

<body>
<div class="page-container">
    <h1>QDMS 2.0</h1>
    <form action="/login/signIn" method="post" id="callLogin">
        <input type="text" name="username" class="username" placeholder="用户名">
        <input type="password" name="password" class="password" placeholder="用户密码">
        <input type="Captcha" name="yanCode" class="Captcha" id="checkCode" placeholder="验证码">
        <input type="button" id="code" onclick="createCode();" style="width:185px;height:44px" value="7WCO"/>

        <button type="button" id="deng" class="submit_button" onclick="checkL();">Sign in</button>
        <div class="error"><span> +</span></div>
    </form>
</div>
<div class="function"></div>

<ul id="supersized" class="quality" style="visibility: visible;">
    <li class="slide-0 activeslide">
        <a target="_blank"><img src="/pic/login.jpg" style="height: 636px; width: 1479.07px; left: -56.5px; top: 0px;"></a>
    </li>
</ul>

</body>

</html>