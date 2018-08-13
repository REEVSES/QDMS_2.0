package com.allinpay.uhyils.controller;

import com.allinpay.uhyils.entity.upload.UploadLittle;
import com.allinpay.uhyils.entity.upload.UploadResponseJson;
import com.allinpay.uhyils.util.SendHttpRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * 类说明:
 * <p></p>
 * Author: uhyils
 * Date: 2018/8/8 8:41
 */
@Controller
@RequestMapping("upload")
public class UploadController {


    @RequestMapping("test")
    public @ResponseBody
    UploadResponseJson test(HttpServletRequest request, HttpServletResponse response) {
        String filepath = request.getSession().getServletContext().getRealPath("/uploadFile/");    //容器相对路径
        UploadResponseJson uploadResponseJson = new UploadResponseJson();
        File ww = new File(filepath);
        if (!ww.exists()) {
            ww.mkdirs();
        }
        File tmp = new File("c:\\tmp\\");
        if (!tmp.exists()) {
            tmp.mkdirs();
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();    //创建磁盘工厂
        factory.setRepository(tmp);    //文件缓存路径
        factory.setSizeThreshold(10 * 1096);

        ServletFileUpload sfu = new ServletFileUpload(factory);        //创建处理工具
        sfu.setSizeMax(-1); //服务器端可以接收的最大文件大小，-1表示无上限
        String filename = null;
        String ff = "";
        try {
            List<FileItem> list = sfu.parseRequest(request);        //解析
            for (FileItem item : list) {
                if (item.isFormField()) continue;
                filename = item.getName();
                int pos = filename.lastIndexOf(".");
                //取文件格式
                if (pos > 0) {
                    //将excel解析后修改为pdf再保存到本地,并传回前台
                    if ("xls".equalsIgnoreCase(filename.substring(pos))) {

                    } else {

                    }
//                    Date date = new Date();
//                    ff = date.getTime() + filename.substring(pos);
//                    filename = filepath + '/' + ff;
                }
//                item.write(new File(filename));    //写到磁盘
//                String p = "/uploadFile/" + ff;
            }
        } catch (Exception e) {
            uploadResponseJson.setCode(1);
        }
        uploadResponseJson.setCode(0);
        return uploadResponseJson;
    }


    private int[] uploadCheckAccount = new int[5];

    /**
     * 返回code  0为出错,1为正常,2为本月上传结束,可以下载pdf
     *
     * @param id
     * @param request
     * @return
     */
    @RequestMapping("checkAccount")
    public UploadResponseJson checkAccount(MultipartFile file, String id, HttpSession session, HttpServletRequest request) throws IOException {
        if (id == null || id.length() == 0) {
            return new UploadResponseJson(0, "系统出错", null);
        }
        int num = Integer.parseInt(id.substring(5));

        UploadResponseJson uploadResponseJson = new UploadResponseJson();
        byte[] b = file.getBytes();

        try {
            String filename = file.getOriginalFilename();
            int pos = filename.lastIndexOf(".");
            Workbook workbook = null;
            //取图片文件格式
            if (pos > 0) {
                String substring = filename.substring(pos);
                if ("xls".equalsIgnoreCase(substring)) {
                    workbook = new XSSFWorkbook(new ByteArrayInputStream(b));
                } else {
                    workbook = new HSSFWorkbook(new ByteArrayInputStream(b));
                }
                Sheet sheet = workbook.getSheetAt(0);
                int lastRowNum = sheet.getLastRowNum();
                List<List<String>> lists = new ArrayList<List<String>>();
                for (int i = 1; i < lastRowNum; i++) {
                    List<String> list = new ArrayList<String>();
                    Row row = sheet.getRow(i);
                    for (Cell cell : row) {
                        cell.setCellType(CellType.STRING);
                        String stringCellValue = cell.getStringCellValue();
                        list.add(stringCellValue);
                    }
                    lists.add(list);
                }
                if (lists.size() == 0) {
                    return new UploadResponseJson(0, "文件内容不对", null);
                }

                String send = SendHttpRequest.send(new String[]{}, new String[]{}, "");
                if (send == null) {
                    return new UploadResponseJson(0, "数据库处理出错", null);
                }
                if (!"ok".equalsIgnoreCase(send)) {
                    return new UploadResponseJson(0, send, null);
                } else {
                    uploadCheckAccount[num]++;
                    boolean bool = false;
                    for (int i : uploadCheckAccount) {
                        if (i == 0) {
                            bool = true;
                        }
                    }
                    if (bool) {
                        return new UploadResponseJson(1, "处理成功", null);
                    } else {
                        return new UploadResponseJson(2, "全部成功,可以下载pdf", null);
                    }
                }


            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return uploadResponseJson;
    }

}
