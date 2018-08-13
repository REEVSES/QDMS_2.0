package com.allinpay.uhyils.entity.upload;

/**
 * 类说明:
 * <p>文件上传回调</p>
 * Author: uhyils
 * Date: 2018/8/8 9:56
 */
public class UploadResponseJson {
    private Integer code;
    private String msg;
    private UploadLittle data;

    public UploadResponseJson(Integer code, String msg, UploadLittle data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public UploadResponseJson() {

    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public UploadLittle getData() {
        return data;
    }

    public void setData(UploadLittle data) {
        this.data = data;
    }
}
