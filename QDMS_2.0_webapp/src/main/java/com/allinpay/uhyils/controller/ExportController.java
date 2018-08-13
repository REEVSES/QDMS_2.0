package com.allinpay.uhyils.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.allinpay.uhyils.entity.CollectingSilver;
import com.allinpay.uhyils.entity.FacePay;
import com.allinpay.uhyils.entity.MerchantSelect;
import com.allinpay.uhyils.entity.RealPay;
import com.allinpay.uhyils.util.SendHttpRequest;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * 类说明
 *
 * @author 龙龙 E-mail: 247452312@qq.com
 * @version 1.0
 * @date 2018-07-31 08:58
 */
@Controller
@RequestMapping("export")
public class ExportController {

    @RequestMapping(value = "merchant", produces = "application/json;charset=utf-8")
    public String merchant(MerchantSelect merchantSelect, HttpServletResponse response, HttpSession session) throws IOException {
        String columnNames[] = {"商户编码", "终端编码", "工商注册名称", "分店营业名称", "入网时间", "来源渠道", "维护人", "商户状态", "终端状态"};
        String columnName[] = {"merchantNo", "terminalNo", "business_registration_name", "store_business_name", "signon_time", "source_channel", "guardian", "business_state", "terminal_state"};
        String fileName = "受理市场商户数据导出.xls";
        String[] param = {"merchantSelect", "username"};
        String url = "/query/merchant";

        merchantSelect.setPage(1);
        merchantSelect.setLimit(Integer.MAX_VALUE);
        return setExcel(session, merchantSelect, param, url, fileName, columnName, columnNames, response);
    }


    @RequestMapping(value = "RealPay", produces = "application/json;charset=utf-8")
    public String RealPay(RealPay realPay, HttpServletResponse response, HttpSession session) throws IOException {

        String columnNames[] = {"商户号", "商户名", "终端号", "终端状态", "维护人", "一级行业", "二级行业", "商户来源渠道", "商户入网时间", "商户类型", "商户状态"};
        String columnName[] = {"merchantNo", "business_registration_name", "terminalNo", "terminal_state", "guardian", "level1", "level2", "source_channel", "signon_time", "business_type", "business_state"};

        String fileName = "受理市场商户数据导出.xls";
        String[] param = {"realPay", "username"};
        String url = "/query/realpay";

        realPay.setPage(1);
        realPay.setLimit(Integer.MAX_VALUE);

        return setExcel(session, realPay, param, url, fileName, columnName, columnNames, response);
    }


    @RequestMapping(value = "collectingSilver", produces = "application/json;charset=utf-8")
    public String collectingSilver(CollectingSilver collectingSilver, HttpServletResponse response, HttpSession session) throws IOException {

        String columnNames[] = {"商户编码", "终端编号", "工商注册名称", "商户入网时间", "终端入网时间", "维护人", "来源渠道", "终端状态", "联系人", "联系电话"};
        String columnName[] = {"merchant_num", "terminal_num", "business_registration_name", "merchant_signon_time", "terminal_signon_time", "guardian", "source_channel", "terminal_state", "contact", "contact_num"};
        String fileName = "收银宝数据导出.xls";
        String[] param = {"collectingSilver", "username"};
        String url = "/query/collectingSilver";

        collectingSilver.setPage(1);
        collectingSilver.setLimit(Integer.MAX_VALUE);

        return setExcel(session, collectingSilver, param, url, fileName, columnName, columnNames, response);
    }

    @RequestMapping(value = "facePay", produces = "application/json;charset=utf-8")
    public String facePay(FacePay facePay, HttpServletResponse response, HttpSession session) throws IOException {
        String columnNames[] = {"商户编码", "商户名", "来源渠道", "绑定时间", "商户状态", "冻结时间"};
        String columnName[] = {"merchant_num", "merchant_name", "source_channel", "bind_time", "merchant_state", "gg_time"};

        String fileName = "当面付数据导出.xls";
        String[] param = {"facePay", "username"};
        String url = "/query/facePay";

        facePay.setPage(1);
        facePay.setLimit(Integer.MAX_VALUE);

        return setExcel(session, facePay, param, url, fileName, columnName, columnNames, response);
    }

    @RequestMapping(value = "examine", produces = "application/json;charset=utf-8")
    public String examine(String id, String month, String name, HttpSession session, HttpServletResponse response) throws IOException {
        String url = "/query/examine" + id.substring(1);
        HashMap<String, Object> userInfo = (HashMap<String, Object>) session.getAttribute("userInfo");
        String username = (String) userInfo.get("username");
        String send = SendHttpRequest.send(new String[]{"username", "month"}, new String[]{username, month}, url);

        //从send的重复段的每个开始截取出来
        /*第一个冒号*/
        int i = send.indexOf("\"");
        if (i == -1) {
            return "{\"status\":2}";
        }
        /*第二个冒号*/
        int j = send.indexOf("\"", i + 1);
        /*第一个属性的名字,格式为  "id"   */
        String first = send.substring(i, j + 1);
        /*记录所有first出现的位置*/
        List<Integer> firstIndex = new ArrayList<Integer>();
        /*第一个索引出现的位置*/
        int i1 = send.indexOf(first);

        while (i1 != -1) {
            firstIndex.add(i1);
            i1 = send.indexOf(first, i1 + 1);
        }
        List<String> strings = new ArrayList<String>();
        if (firstIndex.size() == 1) {
            strings.add(send);
        } else {
            for (int m = 1; m < firstIndex.size(); m++) {
                Integer start = firstIndex.get(m - 1);
                Integer end = firstIndex.get(m);
                String substring = send.substring(start, end);
                strings.add("{" + substring + "}");
            }
        }

        ObjectMapper objectMapper = new ObjectMapper();
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("sheet");

        /* 创建表头 */
        Row hearder = sheet.createRow(0);
        String heard = strings.get(0);
        HashMap<String, String> o = (HashMap<String, String>) objectMapper.readValue(heard, Object.class);
        int s = 0;
        for (String s1 : o.keySet()) {
            hearder.createCell(s).setCellValue(s1);
            s++;
        }

        /* 创建表身 */
        s = 0;
        for (String string : strings) {
            Row row = sheet.createRow(s + 1);
            HashMap<String, String> o1 = (HashMap<String, String>) objectMapper.readValue(string, Object.class);
            int x = 0;
            for (String s1 : o1.keySet()) {
                String s2 = o1.get(s1);
                if ("null".equalsIgnoreCase(s2)) {
                    s2 = "无";
                }
                row.createCell(x).setCellValue(s2);
                x++;
            }
            s++;
        }


        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        }
        byte[] content = os.toByteArray();
        InputStream is = new ByteArrayInputStream(content);
        // 设置response参数，可以打开下载页面
        response.reset();
        response.setHeader("Set-Cookie", "fileDownload=true; path=/");
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + new String((name).getBytes(), "iso-8859-1") + ".xls");
        ServletOutputStream out = response.getOutputStream();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        try {
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(out);
            byte[] buff = new byte[2048];
            int bytesRead;
            // Simple read/write loop.
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
        } catch (final IOException e) {
            throw e;
        } finally {
            if (bis != null) {
                bis.close();
            }
            if (bos != null) {
                bos.close();
            }
        }


        return "{\"status\":1}";

    }


    public String setExcel(HttpSession session, Object object, String[] param, String url, String fileName, String[] columnName, String[] columnNames, HttpServletResponse response) throws IOException {
        HashMap<String, Object> map = (HashMap<String, Object>) session.getAttribute("userInfo");
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(object);

        String result = SendHttpRequest.send(
                param,
                new String[]{json, map.get("username").toString()},
                url);

        HashMap<String, Object> o = (HashMap<String, Object>) objectMapper.readValue(result, Object.class);
        if (o == null || o.size() == 0) {
            return null;
        }

        List<HashMap<String, String>> data = (List<HashMap<String, String>>) o.get("data");

        Workbook wb = new HSSFWorkbook();

        Sheet sheet = wb.createSheet("sheet1");

        Row row = sheet.createRow(0);
        //设置列名
        for (int i = 0; i < columnNames.length; i++) {
            Cell cell = row.createCell(i);
            cell.setCellValue(columnNames[i]);
        }

        //同理可以设置数据行
        for (int i = 0; i < data.size(); i++) {
            Row ro = sheet.createRow(i + 1);
            for (int i1 = 0; i1 < columnName.length; i1++) {
                ro.createCell(i1).setCellValue(data.get(i).get(columnName[i1]));
            }
        }
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            wb.write(os);
        } catch (IOException e) {
            e.printStackTrace();
        }
        byte[] content = os.toByteArray();
        InputStream is = new ByteArrayInputStream(content);
        // 设置response参数，可以打开下载页面
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + new String((fileName).getBytes(), "iso-8859-1"));
        ServletOutputStream out = response.getOutputStream();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        try {
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(out);
            byte[] buff = new byte[2048];
            int bytesRead;
            // Simple read/write loop.
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
        } catch (final IOException e) {
            throw e;
        } finally {
            if (bis != null) {
                bis.close();
            }
            if (bos != null) {
                bos.close();
            }
        }
        return null;

    }


}
