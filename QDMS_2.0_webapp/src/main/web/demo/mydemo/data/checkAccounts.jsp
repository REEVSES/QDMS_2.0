<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/1/001
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>对账单</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <script src="/frame/layui/layui.js" charset="utf-8"></script>
    <script src="/js/jquery-3.3.1.min.js" charset="utf-8"></script>
</head>
<body>
<style>
    .all {
        margin: 15px;
    }
</style>
<div class="all">
    <blockquote class="layui-elem-quote">对账单业务处理</blockquote>

    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
        <legend><b>第一次上传:业务初始化</b> &nbsp;&nbsp;&nbsp; ps:若业务逻辑变更可以从此处重新上传,即时生效</legend>
    </fieldset>
    <button type="button" class="layui-btn first" id="first1"><i class="layui-icon"></i>上传BM交易明细</button>
    <button type="button" class="layui-btn first" id="first2"><i class="layui-icon"></i>上传网关交易明细</button>
    <button type="button" class="layui-btn first" id="first3"><i class="layui-icon"></i>上传预交手续费</button>
    <button type="button" class="layui-btn first" id="first4"><i class="layui-icon"></i>上传B2C套餐及账号验证费率</button>
    <button type="button" class="layui-btn first" id="first5"><i class="layui-icon"></i>上传便捷付终端保底费</button>

    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
        <legend><b>每月上传:必要文件</b></legend>
    </fieldset>
    <button type="button" class="layui-btn" id="daily1"><i class="layui-icon"></i>上传A文件</button>
    <button type="button" class="layui-btn" id="daily2"><i class="layui-icon"></i>上传B文件</button>

    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
        <legend><b>pdf文件操作</b></legend>
    </fieldset>
    <button type="button" class="layui-btn layui-btn-disabled" id="pdf1"><i class="layui-icon"></i>在线预览</button>
    <button type="button" class="layui-btn layui-btn-disabled" id="pdf2"><i class="layui-icon"></i>下载pdf</button>


</div>
</body>
<script>
    layui.use(['upload', 'layer'], function () {
        var $ = layui.jquery
            , upload = layui.upload
            , layer = layui.layer;


        //指定允许上传的文件类型
        upload.render({
            elem: '#first1'
            , url: '/upload/checkAccount'
            , method: "post"
            , data: {
                id: $(this).attr("id")
            }
            , accept: 'file' //普通文件
            , exts: "xls|xlsx"
            , accept: 'file'
            , done: function (res) {
                layer.alert(res);
            }
        });
    });
</script>
</html>
