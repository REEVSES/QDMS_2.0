<%@ page import="com.allinpay.uhyils.util.SendHttpRequest" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="java.util.Set" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String result = SendHttpRequest.send(
            new String[]{"merchantNo", "terminalNo"},
            new String[]{request.getParameter("merchantNo"), request.getParameter("terminalNo")},
            "/tradeInfo/onlineTrade");
    ObjectMapper objectMapper = new ObjectMapper();
    HashMap<String, Object> info = (HashMap<String, Object>) objectMapper.readValue(result, Object.class);

%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>线上支付详情页</title>
    <link rel="stylesheet" href="/frame/layui/css/layui.css">
    <link rel="stylesheet" href="/frame/static/css/style.css">
    <link rel="icon" href="/frame/static/image/code.png">
    <script src="/frame/layui/layui.js" charset="utf-8"></script>
    <script src="/js/jquery-3.3.1.min.js" charset="utf-8"></script>
</head>
<body>
<style>
    .table {
        width: 40%;
        margin: 15px;
        float: left;
    }

    .clean {
        clear: both;
    }

    .loding {
        position: fixed;
        left: 34%;
        top: 21%;
        text-align: center;

    }
    .all {
        -webkit-filter: blur(5px);
        -moz-filter: blur(5px);
        -o-filter: blur(5px);
        -ms-filter: blur(5px);
        filter: blur(5px);
    }
</style>
<div class="all marks">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>商户 - - -
            <b>
                <%=info.get("商户名")%>
            </b>
        </legend>
    </fieldset>

    <div class="layui-form">
        <table class="layui-table">

            <tbody>
            <tr>
                <%
                    int three = 1;
                    Set<String> keys = info.keySet();
                    for (String key : keys) {
                        if (info.get(key).equals("null") || info.get(key).equals("")) {
                            continue;
                        }
                %>
                <td><%=key%>
                </td>
                <%
                %>
                <td><%=info.get(key)%>
                </td>
                <%

                    if (three++ % 3 == 0) {
                %>
            </tr>
            <tr><%
                    }
                }
            %>
            </tr>

            <tr>
                <td colspan="6">


                    <table border="1" cellpadding="5" cellspacing="1" class="table">
                        <tbody>
                        <tr>
                            <td colspan="10" height="24" bgcolor="#7C96B8">
                                <div><font color="#FFFFFF">巡检</font></div>
                            </td>
                        </tr>
                        <tr>
                            <td>巡检时间</td>
                            <td>客户经理</td>
                            <td>备注</td>
                        </tr>

                        <tr>
                            <td colspan="3">没有巡检数据！</td>
                        </tr>

                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>

                        <tr>
                            <td>&nbsp;</td>
                            <td colspan="2"><strong>说明：</strong></td>
                        </tr>
                        </tbody>
                    </table>

                    <table border="1" cellpadding="5" cellspacing="1" class="table">
                        <tbody class="tbody">
                        <tr>
                            <td colspan="10" height="24" bgcolor="#7C96B8">
                                <div><font color="#FFFFFF">交易汇总</font></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <form class="layui-form">
                                    <div class="layui-form-item">
                                        <div class="layui-inline">
                                            <div class="layui-input-inline">
                                                <select class="yearSelect" lay-filter="select">
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
                                                <select class="monthSelect" lay-filter="select">
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

                                </form>
                            </td>
                        </tr>

                        <tr>
                            <td>交易笔数</td>
                            <td>交易金额</td>
                            <td>手续费</td>
                            <td>收益</td>
                        </tr>

                        </tbody>
                    </table>
                    <div class="clean"></div>
                </td>
            </tr>

            </tbody>
        </table>

    </div>
</div>
<div class="loding"><img SRC="/pic/loding.gif" style="transform:scale(0.5);border-radius: 100px;"></div>
<script>
    function changeData(year, month) {
        var num = "<%=request.getParameter("merchantNo")%>";
        var obj = new Object();
        obj.merchantNo = num;
        obj.month = year + month;
        $(".loding").fadeIn();
        $(".marks").addClass("all");

        $.ajax({
            url: "/select/onLineMonthTrade",
            data: obj,
            dataType: "json",
            success: function (json) {
                $(".loding").fadeOut();
                $(".marks").removeClass("all");

                if (json.length == 0) {
                    $(".willDelete").remove();
                    $(".tbody").append("<tr class='willDelete'><td colspan='5'>无交易数据!!!</td></tr>");
                    return;
                } else {
                    $(".willDelete").remove();
                    var sumTradeCount = 0;
                    var sumTradeAmount = 0;
                    var sumTradeCharge = 0;
                    var sumTradeProfit = 0;
                    for (var i = 0; i < json.length; i++) {
                        var obj = json[i];
                        var tr_ = $("<tr  class='willDelete'><td>" + obj.tradeCount + "</td><td>" + obj.tradeAmount + "</td><td>" + obj.tradeCharge + "</td><td>" + obj.tradeProfit + "</td></tr>");
                        $(".tbody").append(tr_);
                        sumTradeCount += parseFloat(obj.tradeCount);
                        sumTradeAmount += parseFloat(obj.tradeAmount);
                        sumTradeCharge += parseFloat(obj.tradeCharge);
                        sumTradeProfit += parseFloat(obj.tradeProfit);
                    }
                    // var tr_2 = $("<tr class='willDelete'><td>合计</td><td>" + sumTradeCount + "</td><td>" + sumTradeAmount + "</td><td>" + sumTradeCharge + "</td><td>" + sumTradeProfit + "</td></tr>");
                    // $(".tbody").append(tr_2);
                }
            }
        });

    }

    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;

        form.on('select(select)', function (data) {
            var year = $(".yearSelect").val();
            var month = $(".monthSelect").val();
            changeData(year, month);
        });
    });

    $(function () {
        var year = $(".yearSelect").val();
        var month = $(".monthSelect").val();
        changeData(year, month);
    });

</script>
</body>
</html>
