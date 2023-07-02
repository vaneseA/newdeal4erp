package kr.happyjob.study.selSaM.model;

import java.util.Date;

public class SelSaMModel {
    // 기존 필드들...

    private String order_month; // 주문 월
    private int total_order_tot_price; // 월별 주문 총액
    private int total_product_unit_price; // 월별 제품 단위 가격의 합계
    private int net_profit; // 월별 순이익

    // 기존 getter/setter들...

    public String getOrder_month() {
        return order_month;
    }

    public void setOrder_month(String order_month) {
        this.order_month = order_month;
    }

    public int getTotal_order_tot_price() {
        return total_order_tot_price;
    }

    public void setTotal_order_tot_price(int total_order_tot_price) {
        this.total_order_tot_price = total_order_tot_price;
    }

    public int getTotal_product_unit_price() {
        return total_product_unit_price;
    }

    public void setTotal_product_unit_price(int total_product_unit_price) {
        this.total_product_unit_price = total_product_unit_price;
    }

    public int getNet_profit() {
        return net_profit;
    }

    public void setNet_profit(int net_profit) {
        this.net_profit = net_profit;
    }
    private int order_no;//주문번호
    private Date order_date;//주문일자
    private int product_no;//제품번호
    private int splr_no;//납품기업번호
    private String splr_name;//납품기업명
    private String product_name;//품명

    private String pro_cd;//제품 분류코드

    private String pro_name;//제품 분류

    private String product_serial;//모델명
    private int product_unit_price;//납품단가
    private int product_price;//판매가

    private int oder_dt_amt;//수량

    private int oder_tot_price;//총액

    public int getOrder_no() {
        return order_no;
    }

    public void setOrder_no(int order_no) {
        this.order_no = order_no;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public int getProduct_no() {
        return product_no;
    }

    public void setProduct_no(int product_no) {
        this.product_no = product_no;
    }

    public int getSplr_no() {
        return splr_no;
    }

    public void setSplr_no(int splr_no) {
        this.splr_no = splr_no;
    }

    public String getSplr_name() {
        return splr_name;
    }

    public void setSplr_name(String splr_name) {
        this.splr_name = splr_name;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getPro_cd() {
        return pro_cd;
    }

    public void setPro_cd(String pro_cd) {
        this.pro_cd = pro_cd;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public String getProduct_serial() {
        return product_serial;
    }

    public void setProduct_serial(String product_serial) {
        this.product_serial = product_serial;
    }

    public int getProduct_unit_price() {
        return product_unit_price;
    }

    public void setProduct_unit_price(int product_unit_price) {
        this.product_unit_price = product_unit_price;
    }

    public int getProduct_price() {
        return product_price;
    }

    public void setProduct_price(int product_price) {
        this.product_price = product_price;
    }

    public int getOder_dt_amt() {
        return oder_dt_amt;
    }

    public void setOder_dt_amt(int oder_dt_amt) {
        this.oder_dt_amt = oder_dt_amt;
    }

    public int getOder_tot_price() {
        return oder_tot_price;
    }

    public void setOder_tot_price(int oder_tot_price) {
        this.oder_tot_price = oder_tot_price;
    }
}
