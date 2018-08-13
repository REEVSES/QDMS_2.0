<%@ page import="java.util.HashMap" %>
<%@ page import="com.allinpay.uhyils.util.SendHttpRequest" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/27/027
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>sim卡查询</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <link rel="icon" href="/frame/static/image/code.png">
    <script src="/frame/layui/layui.js" charset="utf-8"></script>
    <script src="/js/jquery-3.3.1.min.js" charset="utf-8"></script>
</head>
<body>

<div class="demoTable" style="margin-top: 10px">
    <form class="layui-form" action="/export/RealPay" method="post">
        <div class="layui-form-item" style="margin-left: 20px;">

            <div class="layui-inline">
                <input class="layui-input" name="merchant_name" id="merchant_name"
                       autocomplete="off"
                       placeholder="商户名">
            </div>

            <div class="layui-inline">
                <input class="layui-input" name="merchant_num" id="merchant_num" autocomplete="off"
                       placeholder="商户号">
            </div>

            <div class="layui-inline">
                <input class="layui-input" name="guardian" id="guardian" autocomplete="off"
                       placeholder="维护人">
            </div>


            <div class="layui-inline">
                <input class="layui-input" name="source_channel" id="source_channel" autocomplete="off"
                       placeholder="商户来源渠道">
            </div>

            <div class="layui-inline">
                <input class="layui-input" name="merchant_state" id="merchant_state" autocomplete="off"
                       placeholder="商户状态">
            </div>

            <div class="layui-inline">
                <input class="layui-input" name="startTime" type="text" id="startTime" lay-verify="date"
                       placeholder="开始时间" autocomplete="off" value="1900-01-01">
            </div>
            <div class="layui-inline">
                <input class="layui-input" name="endTime" type="text" id="endTime" lay-verify="date"
                       placeholder="结束时间"
                       autocomplete="off"
                       value="<%=new java.sql.Timestamp(System.currentTimeMillis()+1000*60*60*24).toString().substring(0,10) %>">
            </div>
            <c:if test="${sessionScope.userInfo['leve']!=1}">
                <%
                    HashMap<String, Object> map = (HashMap<String, Object>) session.getAttribute("userInfo");
                    String[] name = {};
                    if (Integer.valueOf(map.get("leve").toString()) != 1) {
                        String result = SendHttpRequest.send(new String[]{"depet", "team", "leve"}, new String[]{map.get("depet").toString(), map.get("team").toString(), map.get("leve").toString()}, "/login/containMember");
                        name = new ObjectMapper().readValue(result, String[].class);
                    }
                %>
                <div class="layui-inline">
                    <select name="username" id="username">
                        <option value="">自己</option>
                        <c:forEach items="<%=name%>" var="name">
                            <option value="${name}">${name}</option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>

            <div class="layui-inline">
                <button class="layui-btn layui-btn-radius" id="query" type="button" data-type="reload">搜索</button>
                <button class="layui-btn layui-btn-normal layui-btn-radius" type="submit" id="export">导出此次搜索</button>
            </div>

        </div>
    </form>
</div>

<table class="layui-hide" id="test" lay-filter="test"></table>


<script>
    layui.use(['table', 'laydate'], function () {
        var table = layui.table;
        var laydate = layui.laydate;

        laydate.render({
            elem: '#startTime'
        });

        laydate.render({
            elem: '#endTime'
        });

        table.render({
            elem: '#test',
            url: '/select/realPay',
            page: {
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                , groups: 1 //只显示 1 个连续页码
                , first: false //不显示首页
                , last: false //不显示尾页

            },
            where: {
                startTime: document.getElementById("startTime").value,
                endTime: document.getElementById("endTime").value
            },
            cols: [[
                {field: 'merchantNo', width: 140, event: "tt", title: '商户号'}
                , {field: 'business_registration_name', event: "tt", width: 188, title: '商户名'}
                , {field: 'terminalNo', width: 90, event: "tt", title: '终端号'}
                , {field: 'terminal_state', width: 78, event: "tt", title: '终端状态'}
                , {field: 'guardian', width: 70, event: "tt", title: '维护人'}
                , {field: 'level1', width: 90, event: "tt", title: '一级行业'}
                , {field: 'level2', width: 80, event: "tt", title: '二级行业'}
                , {field: 'source_channel', event: "tt", width: 102, title: '商户来源渠道'}
                , {field: 'signon_time', event: "tt", width: 102, title: '商户入网时间'}
                , {field: 'business_type', event: "tt", width: 85, title: '商户类型'}
                , {field: 'business_state', event: "tt", width: 85, title: '商户状态'}
            ]],
            size: "sm"
            , skin: "line"
        });
        var $ = layui.$, active = {
            reload: function () {
                //执行重载
                table.reload('test', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
                        merchant_name: $("#merchant_name").val(),
                        merchant_num: $("#merchant_num").val(),
                        guardian: $("#guardian").val(),
                        source_channel: $("#source_channel").val(),
                        merchant_state: $("#merchant_state").val(),
                        startTime: $("#startTime").val(),
                        endTime: $("#endTime").val(),
                        username: $("#username").val()
                    }
                });
            }
        };

        $('.demoTable .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        //监听单元格事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            window.open("/demo/mydemo/detail/real_pay_detail.jsp?merchantNo=" + data.merchantNo + "&terminalNo=" + data.terminalNo);
        });
    });


</script>

</body>
</html>
