package com.allinpay.uhyils.util;

import java.util.HashMap;

/**
 * 类说明:
 * <p></p>
 * Author: uhyils
 * Date: 2018/8/9 10:10
 */
public class SimilarRedis {
    private static final HashMap<String, Object> map = new HashMap<String, Object>();

    public static Object getInfo(String name) {
        Object o = map.get(name);
        if (o == null) {
            return "暂无";
        }
        return o;
    }

    public static Boolean addInfo(String name, Object info) {
        if (map.get(name) != null) {
            return false;
        }
        map.put(name, info);
        return true;
    }

    public static void updateInfo(String name, Object info) {
        map.put(name, info);
    }

    public static void deleteInfo(String name) {
        map.remove(name);
    }
}
