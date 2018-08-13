<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/26/026
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>修改密码</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <link rel="stylesheet" href="/css/index.css">
    <link rel="icon" href="/pic/index_icon.png">
</head>
<body class="login-body body">

<div class="login-box">
    <form id="update_password" class="layui-form layui-form-pane" method="post" action="/user/update_password">
        <input type="hidden" name="username" value="${sessionScope.userInfo['username']}">
        <div class="layui-form-item">
            <h3>您的账号为:${sessionScope.userInfo['username']}</h3>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">旧密码：</label>
            <div class="layui-input-inline">
                <input type="password" name="oldpwd" class="layui-input" lay-verify="password" autocomplete="on"
                       maxlength="20"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码：</label>
            <div class="layui-input-inline">
                <input type="password" name="newpwd" class="layui-input" lay-verify="password" autocomplete="on"
                       maxlength="20"/>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">again：</label>
            <div class="layui-input-inline">
                <input type="password" class="layui-input" lay-verify="again" maxlength="20" mark="true"/>
            </div>
        </div>
        <div class="layui-form-item">
            <button type="reset" class="layui-btn layui-btn-danger btn-reset">重置</button>
            <button type="button" class="layui-btn btn-submit" lay-submit="" lay-filter="sub">确定修改</button>
        </div>
    </form>
</div>

<script type="text/javascript" src="/frame/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer'], function () {

        // 操作对象
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery;

        // 验证
        form.verify({
            password: function (value) {
                if (value == "") {
                    return "请输入密码";
                }
            },
            again: function (value) {
                if (value != $("[name=newpwd]").val()) {
                    return "两次输入密码不一致";
                }
            }
        });

        // 提交监听
        form.on('submit(sub)', function (data) {
            var _data = JSON.stringify(data.field);
            var fo = $("#update_password");
            var _action = fo.attr("action");
            var _methos = fo.attr("method");
            alert(_data);
            $.ajax({
                url: _action,
                type: _methos,
                data: data.field,
                success: function (value) {
                    var da = JSON.parse(value);
                    layer.alert(da.info, {
                        title: "提示"
                    });
                }
            });
            return false;
        });

        // you code ...
    })

</script>
</body>
</html>
