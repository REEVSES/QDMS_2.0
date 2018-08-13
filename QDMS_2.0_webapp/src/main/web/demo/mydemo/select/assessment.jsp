<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/1/001
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考核信息</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <script src="/frame/layui/layui.js" charset="utf-8"></script>
    <script src="/js/jquery-3.3.1.min.js" charset="utf-8"></script>
</head>
<body>

<style>
    .layui-form {
        line-height: 60px;
    }

    .layui-form > * {
        margin: 5px;
    }

    .loding {
        position: fixed;
        left: 34%;
        top: 21%;
        text-align: center;

    }
</style>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>绩效考核报表下载页</legend>
</fieldset>

<div class="layui-form">

    <div class="layui-form-item">
        <div class="layui-inline">
            <div class="layui-input-inline">
                <select class="yearSelect" lay-filter="select" id="year-select">
                    <option value="">请选择</option>
                    <option value="19">2019</option>
                    <option value="18" selected="">2018</option>
                    <option value="17">2017</option>
                    <option value="16">2016</option>
                    <option value="15">2015</option>
                    <option value="14">2014</option>
                    <option value="13">2013</option>
                    <option value="12">2012</option>
                    <option value="11">2011</option>
                    <option value="10">2010</option>
                    <option value="09">2009</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <div class="layui-input-inline">
                <select class="monthSelect" lay-filter="select" id="month-select">
                    <option value="">请选择</option>
                    <option value="01">1</option>
                    <option value="02">2</option>
                    <option value="03">3</option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option value="06">6</option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option value="09">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select>
            </div>
        </div>
    </div>
    <button class="layui-btn layui-btn-radius" id="b1">绩效考核利润汇总</button>
    <button class="layui-btn layui-btn-radius" id="b2">线下终端商户</button>
    <button class="layui-btn layui-btn-radius" id="b3">当面付商户</button>
    <button class="layui-btn layui-btn-radius" id="b4">SIM收费_拓展利润</button>
    <button class="layui-btn layui-btn-radius" id="b5">SIM收费_续费计提</button>
    <button class="layui-btn layui-btn-radius" id="b6">机具销售</button>
    <button class="layui-btn layui-btn-radius" id="b7">商户新增规模考核</button>
    <button class="layui-btn layui-btn-radius" id="b8">维护收入考核</button>
    <button class="layui-btn layui-btn-radius" id="b9">无效商户考核</button>
    <button class="layui-btn layui-btn-radius" id="b10">个人绩效考核</button>
    <button class="layui-btn layui-btn-radius" id="b11">团队绩效考核</button>
    <button class="layui-btn layui-btn-radius layui-btn-warm" id="b12">奖惩表</button>
    <button class="layui-btn layui-btn-radius" id="b13">综合支付</button>
    <button class="layui-btn layui-btn-radius" id="b14">绩效考核市场3部总表</button>
</div>
<%--<fieldset class="layui-elem-field site-demo-button" style="margin-top: 30px;">
    <legend>在线预览 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <button class="layui-btn layui-btn-normal layui-btn-radius">导出报表</button>
    </legend>
    <div id="report-table"></div>
</fieldset>--%>
<div class="loding"><img SRC="/pic/loding.gif" style="transform:scale(0.5);border-radius: 100px;"></div>
<script src="https://cdn.bootcss.com/jquery.fileDownload/1.4.2/jquery.fileDownload.min.js"></script>
<script>
    $(".loding").fadeOut();
    var form, layer, layedit, laydate;
    layui.use(['form', 'layedit', 'laydate'], function () {
        form = layui.form;
        layer = layui.layer;
        layedit = layui.layedit;
        laydate = layui.laydate;

    });

    function downloadExcel(id, name) {
        var myDate = new Date;
        var month = $("#month-select");
        var year = $("#year-select");

        var month = month.val();
        var year = year.val();
        if (month == "" || year == "") {
            layer.msg("请选择年月");
            return;
        }


        $.fileDownload("/export/examine?id=" + id + "&month=" + year + month + "&name=" + name, {
            prepareCallback: function () {
                $(".loding").fadeIn();
            },
            successCallback: function () {
                $(".loding").fadeOut();
                layer.msg("下载成功! ! !");
            },
            failCallback: function () {
                $(".loding").fadeOut();
                layer.msg("抱歉,没有数据或出错! ! !");
            }
        });


    }

    $(".layui-btn").click(function () {
        var id = $(this).attr("id");
        var name = $(this).html();
        downloadExcel(id, name);
    })
</script>
</body>
</html>
