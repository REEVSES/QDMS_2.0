/**
 * 验证码产生和验证文件
 */
var code; //在全局定义验证
//产生验证
function createCode() {

    code = "";
    var codeLength = 4; //验证码的长度
    var checkCode = $("#code");
    var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
        'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //随机
    for (var i = 0; i < codeLength; i++) { //循环操作
        var index = Math.floor(Math.random() * 36); //取得随机数的索引0~35
        code += random[index]; //根据索引取得随机数加到code�?
    }
    checkCode.val(code); //把code值赋给验证码
}

//校验验证 登录按钮
function checkL() {
    /*
    //验证验证码
    var inputCode = document.getElementById("checkCode").value.toUpperCase(); //取得输入的验证码并转化为大写
    if (inputCode.length <= 0) { //若输入的验证码长度为0
        alert("验证码不能为空！"); //则弹出请输入验证�?
    } else if (inputCode != code) { //若输入的验证码与产生的验证码不一致时
        alert("验证码输入错误！请重新输�?"); //则弹出验证码输入错误
        createCode(); //刷新验证�?
        document.getElementById("checkCode").value = ""; //清空文本
    } else { //验证码输入正确时
        Core();
    }
    */
    Core();
}

function Core() {
    var formData = $("#callLogin").serialize();
    $.ajax({
        url: $("#callLogin").attr("action"),
        data: formData,
        type: $("#callLogin").attr("method"),
        cache: false,
        dataType: "text",
        success: function (data) {
            mySuccess(data);
        },
        error: function () {
            alert("error");
            createCode();
        }
    });
}

function mySuccess(data) {
    if (data == "") {
        alert("用户名或密码错误");
        createCode();
    } else {
        window.location.href = "/index.jsp";

    }
}

function Chaxun() {
    window.location.href = "table.php";
}

function Team() {
    alert('正在拼命开发中···');
}

function DataOperate() {
    window.location.href = "DataOperate.php";
}

function Department() {
    alert('正在拼命开发中···');
}

function Examination() {
    window.location.href = "kaohe_2018.php";
}

function Company() {
    alert('正在拼命开发中···');
}

function onError(data, status) {
    alert("服务器端异常，请联系技术人员！");
    createCode();
}