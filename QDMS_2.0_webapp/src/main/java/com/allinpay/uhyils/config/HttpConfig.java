package com.allinpay.uhyils.config;

import java.io.IOException;
import java.util.Properties;

/**
 * 类说明
 *
 * @author 龙龙 E-mail: 247452312@qq.com
 * @version 1.0
 * @date 2018-07-26 16:39
 */
public class HttpConfig {

    public static String http;

    static {
        Properties properties = new Properties();
        try {
            properties.load(HttpConfig.class.getResourceAsStream("/host.properties"));
            http = properties.getProperty("http");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
