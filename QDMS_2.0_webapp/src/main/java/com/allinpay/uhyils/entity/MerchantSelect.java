package com.allinpay.uhyils.entity;

/**
 * 受理市场商户查询返回json串类
 *
 * @author 龙龙 E-mail: 247452312@qq.com
 * @version 1.0
 * @date 2018-07-30 09:13
 */
public class MerchantSelect {

    private String business_registration_name;
    private String store_business_name;
    private String merchant_code;
    private String guardian;
    private String source_channel;
    private String business_state;
    private String terminal_state;
    private String startTime;
    private String endTime;
    private Integer page;
    private Integer limit;

    public String getBusiness_registration_name() {
        return business_registration_name;
    }

    public void setBusiness_registration_name(String business_registration_name) {
        this.business_registration_name = business_registration_name;
    }

    public String getStore_business_name() {
        return store_business_name;
    }

    public void setStore_business_name(String store_business_name) {
        this.store_business_name = store_business_name;
    }

    public String getMerchant_code() {
        return merchant_code;
    }

    public void setMerchant_code(String merchant_code) {
        this.merchant_code = merchant_code;
    }

    public String getGuardian() {
        return guardian;
    }

    public void setGuardian(String guardian) {
        this.guardian = guardian;
    }

    public String getSource_channel() {
        return source_channel;
    }

    public void setSource_channel(String source_channel) {
        this.source_channel = source_channel;
    }

    public String getBusiness_state() {
        return business_state;
    }

    public void setBusiness_state(String business_state) {
        this.business_state = business_state;
    }

    public String getTerminal_state() {
        return terminal_state;
    }

    public void setTerminal_state(String terminal_state) {
        this.terminal_state = terminal_state;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }


}
