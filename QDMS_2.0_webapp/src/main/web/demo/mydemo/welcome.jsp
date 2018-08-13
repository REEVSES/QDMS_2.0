<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="com.allinpay.uhyils.http.HttpRequester" %>
<%@ page import="com.allinpay.uhyils.http.HttpRespons" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.allinpay.uhyils.util.SimilarRedis" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/1/001
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<%
    String today = new SimpleDateFormat("YYYY-MM-dd").format(new Date());
    HttpRequester httpRequester = new HttpRequester();
    HttpRespons httpRespons = httpRequester.sendPost("http://sentence.iciba.com/index.php?callback=jQuery190042792435989382316_1533108324980&c=dailysentence&m=getdetail&title=" + today + "&_=1533108324984", null);

    String bo = httpRespons.getContent();
    bo = bo.substring(bo.indexOf("(") + 1, bo.length() - 1);

    ObjectMapper objectMapper = new ObjectMapper();
    HashMap<String, Object> map = (HashMap<String, Object>) objectMapper.readValue(bo, Object.class);
%>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>欢迎页</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <link rel="icon" href="/frame/static/image/code.png">
    <script src="/js/jquery-3.3.1.min.js"></script>
</head>
<body class="body">

<div class="layui-row layui-col-space10 my-index-main">
    <div class="layui-col-xs4 layui-col-sm2 layui-col-md2">
        <div class="my-nav-btn layui-clear" data-href="./demo/btn.html">
            <div class="layui-col-md5">
                <button class="layui-btn layui-btn-big layui-btn-danger layui-icon">&#xe756;</button>
            </div>
            <div class="layui-col-md7 tc">
                <p class="my-nav-text">40</p>
                <p class="my-nav-text layui-elip">按钮</p>
            </div>
        </div>
    </div>
    <div class="layui-col-xs4 layui-col-sm2 layui-col-md2">
        <div class="my-nav-btn layui-clear" data-href="./demo/form.html">
            <div class="layui-col-md5">
                <button class="layui-btn layui-btn-big layui-btn-warm layui-icon">&#xe735;</button>
            </div>
            <div class="layui-col-md7 tc">
                <p class="my-nav-text">40</p>
                <p class="my-nav-text layui-elip">表单</p>
            </div>
        </div>
    </div>
    <div class="layui-col-xs4 layui-col-sm2 layui-col-md2">
        <div class="my-nav-btn layui-clear" data-href="./demo/table.html">
            <div class="layui-col-md5">
                <button class="layui-btn layui-btn-big layui-icon">&#xe715;</button>
            </div>
            <div class="layui-col-md7 tc">
                <p class="my-nav-text">40</p>
                <p class="my-nav-text layui-elip">表格</p>
            </div>
        </div>
    </div>
    <div class="layui-col-xs4 layui-col-sm2 layui-col-md2">
        <div class="my-nav-btn layui-clear" data-href="./demo/tab-card.html">
            <div class="layui-col-md5">
                <button class="layui-btn layui-btn-big layui-btn-normal layui-icon">&#xe705;</button>
            </div>
            <div class="layui-col-md7 tc">
                <p class="my-nav-text">40</p>
                <p class="my-nav-text layui-elip">选项卡</p>
            </div>
        </div>
    </div>
    <div class="layui-col-xs4 layui-col-sm2 layui-col-md2">
        <div class="my-nav-btn layui-clear" data-href="./demo/progress-bar.html">
            <div class="layui-col-md5">
                <button class="layui-btn layui-btn-big layui-bg-cyan layui-icon">&#xe6b2;</button>
            </div>
            <div class="layui-col-md7 tc">
                <p class="my-nav-text">40</p>
                <p class="my-nav-text layui-elip">进度条</p>
            </div>
        </div>
    </div>
    <div class="layui-col-xs4 layui-col-sm2 layui-col-md2">
        <div class="my-nav-btn layui-clear" data-href="./demo/folding-panel.html">
            <div class="layui-col-md5">
                <button class="layui-btn layui-btn-big layui-bg-black layui-icon">&#xe698;</button>
            </div>
            <div class="layui-col-md7 tc">
                <p class="my-nav-text">40</p>
                <p class="my-nav-text layui-elip">折叠面板</p>
            </div>
        </div>
    </div>

    <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
        <div class="layui-collapse">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">公告</h2>
                <div class="layui-colla-content layui-show">
                    <%=SimilarRedis.getInfo("notice")%>
                </div>
            </div>
        </div>
    </div>


    <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
        <div class="layui-collapse">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title">每日一句</h2>
                <div class="layui-colla-content layui-show">
                    <blockquote class="layui-elem-quote layui-quote-nm" id="day_1"><%=map.get("content")%>
                        <br><img src="/pic/music.png" alt="播放" onclick="document.getElementById('audio').play();"
                                 style="cursor:pointer;"/>
                        <audio id="audio" preload="none"
                               src="http://news.iciba.com/admin/tts/<%=map.get("title")%>-day.mp3"
                        />
                    </blockquote>
                    <blockquote class="layui-elem-quote layui-quote-nm" id="day_2"><%=map.get("note")%>
                    </blockquote>
                    <blockquote class="layui-elem-quote layui-quote-nm" id="day_3"><%=map.get("translation")%>
                    </blockquote>
                </div>
            </div>
        </div>
    </div>


</div>

<script type="text/javascript" src="/frame/layui/layui.js"></script>
<script type="text/javascript" src="/js/index.js"></script>
<script type="text/javascript" src="/frame/echarts/echarts.min.js"></script>
<script type="text/javascript">
    layui.use(['element', 'form', 'table', 'layer', 'vip_tab', 'upload'], function () {
        var form = layui.form
            , table = layui.table
            , layer = layui.layer
            , vipTab = layui.vip_tab
            , element = layui.element
            , $ = layui.jquery;


        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main-line'));

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption({
            title: {
                text: '示例'
            },
            tooltip: {},
            legend: {
                data: ['销量']
            },
            xAxis: {
                data: ["衬衫", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子"]
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: [5, 20, 36, 10, 10, 20]
            }]
        });

        // 打开选项卡
        $('.my-nav-btn').on('click', function () {
            if ($(this).attr('data-href')) {
                //vipTab.add('','标题','路径');
                vipTab.add($(this), '<i class="layui-icon">' + $(this).find("button").html() + '</i>' + $(this).find('p:last-child').html(), $(this).attr('data-href'));
            }
        });


        // you code ...


    });
</script>

</body>
</html>
