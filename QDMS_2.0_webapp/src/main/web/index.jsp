<%@ page import="java.util.Enumeration" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/26/026
  Time: 9:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>青岛通联支付公司QDMS2.0系统</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <link rel="stylesheet" href="/css/index.css">
    <link rel="icon" href="/pic/index_icon.png">
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/index.js"></script>
</head>

<body>

<div class="layui-layout layui-layout-admin skin-0">
    <!-- 添加skin-1类可手动修改主题为纯白，添加skin-2类可手动修改主题为蓝白 -->
    <!-- header -->
    <div class="layui-header my-header">
        <a href="index.jsp">
            <!--<img class="my-header-logo" src="" alt="logo">-->
            <div class="my-header-logo"><img src="/pic/QDMS.png" class="QDMS_png"></div>
        </a>

        <div class="my-header-btn">
            <button class="layui-btn layui-btn-small btn-nav"><i class="layui-icon">&#xe65f;</i></button>
        </div>

        <!-- 顶部左侧添加选项卡监听 -->
        <ul class="layui-nav" lay-filter="side-top-left">
        </ul>

        <!-- 顶部右侧添加选项卡监听 -->
        <ul class="layui-nav my-header-user-nav" lay-filter="side-top-right">

            <li class="layui-nav-item">
                <a class="name" href="javascript:;"><i class="layui-icon">&#xe629;</i>主题</a>
                <dl class="layui-nav-child">
                    <dd data-skin="0">
                        <a href="javascript:;">默认</a>
                    </dd>
                    <dd data-skin="1">
                        <a href="javascript:;">纯白</a>
                    </dd>
                    <dd data-skin="2">
                        <a href="javascript:;">天蓝</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a class="name" href="javascript:;"><img src="/frame/static/image/code.png"
                                                         alt="logo">${sessionScope.userInfo['username']}</a>
                <dl class="layui-nav-child">

                    <dd>
                        <a href="javascript:;" href-url="/demo/mydemo/update_password.jsp"><i class="layui-icon">&#xe621;</i>修改密码</a>
                    </dd>
                    <dd>
                        <a href="javascript:;" onclick="cancel_login();"><i class="layui-icon">&#x1006;</i>退出</a>
                    </dd>
                </dl>
            </li>
        </ul>

    </div>
    <!-- side -->
    <div class="layui-side my-side">
        <div class="layui-side-scroll">
            <!-- 左侧主菜单添加选项卡监听 -->
            <ul class="layui-nav layui-nav-tree" lay-filter="side-main" lay-accordion>
            </ul>
        </div>
    </div>

    <!-- body -->
    <div class="layui-body my-body">
        <div class="layui-tab layui-tab-card my-tab" lay-filter="card" lay-allowClose="true">
            <ul class="layui-tab-title">
                <li class="layui-this" lay-id="1"><span><i class="layui-icon">&#xe638;</i>欢迎页</span></li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe id="iframe" src="/demo/mydemo/welcome.jsp" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- footer -->
    <div class="layui-footer my-footer" style="text-align: center;justify-content: center;color: #555;">

        <span>
            <a href="javascript:;" class="pay_author">支持作者</a>
        </span>
        <span>
            <a href="javascript:;" class="pay" href-url="">微信公众号</a>
        </span>
        <span>
            3
        </span>
    </div>
</div>

<!-- pay -->
<div class="my-pay-box none pay1" style="display: none;">
    <div><img src="/pic/weixin.jpg" alt="公众号二维码">
        <p>通联支付青岛分公司</p></div>
</div>

<!-- pay -->
<div class="my-pay-box none pay2" style="display: none;">
    <div><img src="/pic/weixin/uhyils.png" alt="龙龙">
        <p>龙龙</p></div>
    <div><img src="/pic/weixin/lqyk.png" alt="刘瑶">
        <p>刘瑶</p></div>
</div>


<!-- 右键菜单 -->
<div class="my-dblclick-box none">
    <table class="layui-tab dblclick-tab">
        <tr class="card-refresh">
            <td><i class="layui-icon">&#x1002;</i>刷新当前标签</td>
        </tr>
        <tr class="card-close">
            <td><i class="layui-icon">&#x1006;</i>关闭当前标签</td>
        </tr>
        <tr class="card-close-all">
            <td><i class="layui-icon">&#x1006;</i>关闭所有标签</td>
        </tr>
    </table>
</div>

<script type="text/javascript" src="/frame/layui/layui.js"></script>
<script type="text/javascript" src="/frame/static/js/vip_comm.js"></script>
<script type="text/javascript">

    layui.use(['layer', 'vip_nav', 'form','upload'], function () {

        // 操作对象
        var layer = layui.layer,
            form = layui.form,
            vipNav = layui.vip_nav,
            upload = layui.upload,
            $ = layui.jquery;

        /*// 顶部左侧菜单生成 [请求地址,过滤ID,是否展开,携带参数]
        vipNav.top_left('/json/nav_top_left.json', 'side-top-left', false);*/
        // 主体菜单生成 [请求地址,过滤ID,是否展开,携带参数]
        vipNav.main('/login/menu', 'side-main', false);
        // vipNav.main('/json/nav_main.json', 'side-main', false);

        // you code ...
        //拖拽上传
        upload.render({
            elem: '#test10'
            , url: '/upload/test'
            , done: function (res) {
                console.log(res)
            }
        });

    });
</script>


</body>

</html>