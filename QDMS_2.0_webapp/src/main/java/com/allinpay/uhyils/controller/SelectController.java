package com.allinpay.uhyils.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.allinpay.uhyils.entity.*;
import com.allinpay.uhyils.http.HttpRequester;
import com.allinpay.uhyils.http.HttpRespons;
import com.allinpay.uhyils.util.SendHttpRequest;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * 类说明
 *
 * @author 龙龙 E-mail: 247452312@qq.com
 * @version 1.0
 * @date 2018-07-30 08:47
 */
@RestController
@RequestMapping("/select")
public class SelectController {

    @RequestMapping(value = "merchant", produces = "application/json;charset=utf-8")
    public String merchant(MerchantSelect key, String username, HttpSession session) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(key);
        if (username == null || username.equals("")) {
            HashMap<String, Object> map = (HashMap<String, Object>) session.getAttribute("userInfo");
            return SendHttpRequest.send(
                    new String[]{"merchantSelect", "username"},
                    new String[]{json, map.get("username").toString()},
                    "/query/merchant");
        } else {
            return SendHttpRequest.send(
                    new String[]{"merchantSelect", "username"},
                    new String[]{json, username},
                    "/query/merchant");
        }


    }


    @RequestMapping(value = "realPay", produces = "application/json;charset=utf-8")
    public String realPay(RealPay key, String username, HttpSession session) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(key);
        if (username == null || username.equals("")) {
            HashMap<String, Object> map = (HashMap<String, Object>) session.getAttribute("userInfo");
            return SendHttpRequest.send(
                    new String[]{"realPay", "username"},
                    new String[]{json, map.get("username").toString()},
                    "/query/realpay");
        } else {
            return SendHttpRequest.send(
                    new String[]{"realPay", "username"},
                    new String[]{json, username},
                    "/query/realpay");
        }
    }

    @RequestMapping(value = "collectingSilver", produces = "application/json;charset=utf-8")
    public String collectingSilver(CollectingSilver key, String username, HttpSession session) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(key);
        if (username == null || username.equals("")) {
            HashMap<String, Object> map = (HashMap<String, Object>) session.getAttribute("userInfo");
            return SendHttpRequest.send(
                    new String[]{"collectingSilver", "username"},
                    new String[]{json, map.get("username").toString()},
                    "/query/collectingSilver");
        } else {
            return SendHttpRequest.send(
                    new String[]{"collectingSilver", "username"},
                    new String[]{json, username},
                    "/query/collectingSilver");
        }
    }

    @RequestMapping(value = "facePay", produces = "application/json;charset=utf-8")
    public String facePay(FacePay key, String username, HttpSession session) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(key);
        if (username == null || username.equals("")) {
            HashMap<String, Object> map = (HashMap<String, Object>) session.getAttribute("userInfo");
            return SendHttpRequest.send(
                    new String[]{"facePay", "username"},
                    new String[]{json, map.get("username").toString()},
                    "/query/facePay");
        } else {
            return SendHttpRequest.send(
                    new String[]{"facePay", "username"},
                    new String[]{json, username},
                    "/query/facePay");
        }
    }

    @RequestMapping(value = "merchantMonthTrade", produces = "application/json;charset=utf-8")
    public String merchantMonthTrade(String merchantNo, String month) throws IOException {
        String result2 = SendHttpRequest.send(
                new String[]{"merchantNo", "month", "tablename"},
                new String[]{merchantNo, month, merchantNo.substring(0, 7)},
                "/tradeInfo/merchantMonthTrade");

        return result2;
    }

    @RequestMapping(value = "onLineMonthTrade", produces = "application/json;charset=utf-8")
    public String onLineMonthTrade(String merchantNo, String month) throws IOException {
        String result2 = SendHttpRequest.send(
                new String[]{"merchantNo", "month"},
                new String[]{merchantNo, month},
                "/tradeInfo/onlineMonthTrade");

        return result2;
    }

    @RequestMapping(value = "faceMonthTrade", produces = "application/json;charset=utf-8")
    public String faceMonthTrade(String merchantNo, String month) throws IOException {
        String result2 = SendHttpRequest.send(
                new String[]{"merchantNo", "month"},
                new String[]{merchantNo, month},
                "/tradeInfo/faceMonthTrade");

        return result2;
    }

    @RequestMapping(value = "csilverMonthTrade", produces = "application/json;charset=utf-8")
    public String csilverMonthTrade(String merchantNo, String month) throws IOException {
        String result2 = SendHttpRequest.send(
                new String[]{"merchantNo", "month"},
                new String[]{merchantNo, month},
                "/tradeInfo/csMonthTrade");

        return result2;
    }





}
