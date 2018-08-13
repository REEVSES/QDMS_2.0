<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/1/001
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>500 服务器发生错误~</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <link rel="icon" href="/frame/static/image/code.png">
</head>
<body class="body">

<div class="my-page-box">
    <h3>500</h3>
    <p class="msg">服务器发生错误</p>
    <p class="text">请联系专业人员,此次错误为: <br><%=exception%> <br> 错误内容:
        <br><%=exception.printStackTrace(response.getWriter())%>
    </p>
</div>


<script type="text/javascript" src="/frame/layui/layui.js"></script>
<script type="text/javascript">
    // you code ...
</script>
</body>
</html>