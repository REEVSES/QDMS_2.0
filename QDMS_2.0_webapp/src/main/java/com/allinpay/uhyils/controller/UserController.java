package com.allinpay.uhyils.controller;

import com.allinpay.uhyils.config.HttpConfig;
import com.allinpay.uhyils.http.HttpRequester;
import com.allinpay.uhyils.http.HttpRespons;
import com.allinpay.uhyils.util.SendHttpRequest;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.HashMap;

/**
 * 类说明
 *
 * @author 龙龙 E-mail: 247452312@qq.com
 * @version 1.0
 * @date 2018-07-26 20:28
 */
@RestController
@RequestMapping("user")
public class UserController {


    @RequestMapping(value = "update_password", produces = "text/html;charset=utf-8")
    public String update_password(String username, String newpwd, String oldpwd) throws IOException {
        return SendHttpRequest.send(
                new String[]{"username", "newpwd", "oldpwd"},
                new String[]{username, newpwd, oldpwd},
                "/login/ResetPwd");

    }
}
