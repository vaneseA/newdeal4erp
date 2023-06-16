package kr.happyjob.study.selSaD.model;



public class SelSaDModel {

    private int product_no;//제품번호
    private int splr_no;//납품기업번호
    private String splr_name;//납품기업명
    private String product_name;//품명
    private String product_serial;//모델명
    private int product_unit_price;//납품단가
    private int product_price;//판매가
    private int pro_sm_cd;
    private int pro_md_cd;
    private int pro_lg_cd;

    private String pro_lg_name;
    private String pro_md_name;
    private String pro_sm_name;

    public String getPro_lg_name() {
        return pro_lg_name;
    }

    public void setPro_lg_name(String pro_lg_name) {
        this.pro_lg_name = pro_lg_name;
    }

    public String getPro_md_name() {
        return pro_md_name;
    }

    public void setPro_md_name(String pro_md_name) {
        this.pro_md_name = pro_md_name;
    }

    public String getPro_sm_name() {
        return pro_sm_name;
    }

    public void setPro_sm_name(String pro_sm_name) {
        this.pro_sm_name = pro_sm_name;
    }

    //제품번호
    public int getProduct_no() { return product_no; }
    public void setProduct_no(int product_no) {
        this.product_no = product_no;
    }

    //납품기업번호
    public int getSplr_no() { return splr_no; }
    public void setSplr_no(int splr_no) {
        this.splr_no = splr_no;
    }


    //납품기업명
    public String getSplr_name() {
        return splr_name;
    }
    public void setSplr_name(String splr_name) {
        this.splr_name = splr_name;
    }


    //품명
    public String getProduct_name() {
        return product_name;
    }
    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    //모델명
    public String getProduct_serial() {
        return product_serial;
    }
    public void setProduct_serial(String product_serial) {
        this.product_serial = product_serial;
    }

    //판매가
    public int getProduct_price() { return product_price; }
    public void setProduct_price(int product_price) {
        this.product_price = product_price;
    }

    //납품단가
    public int getProduct_unit_price() { return product_unit_price; }
    public void setProduct_unit_price(int product_unit_price) {
        this.product_unit_price = product_unit_price;
    }

    public int getPro_sm_cd() {
        return pro_sm_cd;
    }

    public void setPro_sm_cd(int pro_sm_cd) {
        this.pro_sm_cd = pro_sm_cd;
    }

    public int getPro_md_cd() {
        return pro_md_cd;
    }

    public void setPro_md_cd(int pro_md_cd) {
        this.pro_md_cd = pro_md_cd;
    }

    public int getPro_lg_cd() {
        return pro_lg_cd;
    }

    public void setPro_lg_cd(int pro_lg_cd) {
        this.pro_lg_cd = pro_lg_cd;
    }





}
