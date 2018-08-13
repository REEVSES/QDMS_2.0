package com.allinpay.uhyils.util;

import com.allinpay.uhyils.config.HttpConfig;
import com.allinpay.uhyils.http.HttpRequester;
import com.allinpay.uhyils.http.HttpRespons;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 类说明
 *
 * @author 龙龙 E-mail: 247452312@qq.com
 * @version 1.0
 * @date 2018-07-30 08:49
 */
public class SendHttpRequest {

    public static String send(String[] name, String[] param, String url) throws IOException {
        if (name.length != param.length) {
            return "error";
        }
        HashMap<String, String> params = new HashMap<String, String>();

        for (int i = 0; i < name.length; i++) {
            params.put(name[i], param[i]);

        }
        HttpRequester httpRequester = new HttpRequester();

        HttpRespons httpRespons = httpRequester.sendPost(HttpConfig.http + url, params);

        String bo = httpRespons.getContent();
        System.out.println("返回值为:" + bo);

        return bo;
    }
}
