function cancel_login() {
    $.ajax({
        url: "/login/cancelLogin",
        type: "POST",
        dataType: "text",
        success: function (data) {
            if (data == "true") {
                window.location.href = "/login.jsp";
            } else {

            }
        }
    });
}