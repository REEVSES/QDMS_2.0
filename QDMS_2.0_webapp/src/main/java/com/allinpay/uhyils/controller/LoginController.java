package com.allinpay.uhyils.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.allinpay.uhyils.config.HttpConfig;
import com.allinpay.uhyils.http.HttpRequester;
import com.allinpay.uhyils.http.HttpRespons;
import com.allinpay.uhyils.util.SendHttpRequest;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;

/**
 * 类说明
 *
 * @author 龙龙 E-mail: 247452312@qq.com
 * @version 1.0
 * @date 2018-07-26 16:32
 */
@RestController
@RequestMapping("login")
public class LoginController {

    @RequestMapping(value = "signIn", produces = "application/json;charset=utf-8")
    public String signIn(String username, String password, HttpServletRequest request) throws IOException {
        HttpRequester httpRequester = new HttpRequester();
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("username", username);
        map.put("password", password);
        HttpRespons httpRespons = httpRequester.sendPost(HttpConfig.http + "/login/signIn", map);
        String user = httpRespons.getContent();
        if (user == null || user.equals("")) {
            return user;
        }
        System.out.println("user:" + user);

        ObjectMapper objectMapper = new ObjectMapper();
        Object o = objectMapper.readValue(user, Object.class);
        HashMap<String, Object> map1 = (HashMap<String, Object>) o;

        request.getSession().setAttribute("userInfo", map1);

        return user;
    }

    @RequestMapping(value = "cancelLogin", produces = "application/json;charset=utf-8")
    public String cancelLogin(HttpSession session) {
        session.setAttribute("userInfo", null);
        return "true";
    }


    @RequestMapping(value = "menu", produces = "application/json;charset=utf-8")
    public String menu(HttpSession session) throws IOException {
        HashMap<String, Object> userInfo = (HashMap<String, Object>) session.getAttribute("userInfo");

        Integer whzid = (Integer) userInfo.get("whzid");
        Integer leve = (Integer) userInfo.get("leve");
        Integer id = (Integer) userInfo.get("id");

        return SendHttpRequest.send(
                new String[]{"whzid", "leve", "id"},
                new String[]{whzid.toString(), leve.toString(), id.toString()},
                "/login/level");
    }

}
