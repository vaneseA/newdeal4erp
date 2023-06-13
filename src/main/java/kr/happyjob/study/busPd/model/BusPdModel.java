package kr.happyjob.study.busPd.model;



public class BusPdModel {

    public String getLoginID() {
        return loginID;
    }
    public void setLoginID(String loginID) {
        this.loginID = loginID;
    }
    public String getSal_date() {
        return sal_date;
    }
    public void setSal_date(String sal_date) {
        this.sal_date = sal_date;
    }
    public String getEmp_name() {
        return emp_name;
    }
    public void setEmp_name(String emp_name) {
        this.emp_name = emp_name;
    }
    public String getDept_cd() {
        return dept_cd;
    }
    public void setDept_cd(String dept_cd) {
        this.dept_cd = dept_cd;
    }
    public String getLevel_cd() {
        return level_cd;
    }
    public void setLevel_cd(String level_cd) {
        this.level_cd = level_cd;
    }
    public int getEmp_yr_sal() {
        return emp_yr_sal;
    }
    public void setEmp_yr_sal(int emp_yr_sal) {
        this.emp_yr_sal = emp_yr_sal;
    }
    public int getSal_pre() {
        return sal_pre;
    }
    public void setSal_pre(int sal_pre) {
        this.sal_pre = sal_pre;
    }
    public int getSal_san() {
        return sal_san;
    }
    public void setSal_san(int sal_san) {
        this.sal_san = sal_san;
    }
    public int getSal_ko() {
        return sal_ko;
    }
    public void setSal_ko(int sal_ko) {
        this.sal_ko = sal_ko;
    }
    public int getSal_kun() {
        return sal_kun;
    }
    public void setSal_kun(int sal_kun) {
        this.sal_kun = sal_kun;
    }
    public int getSal_kuk() {
        return sal_kuk;
    }
    public void setSal_kuk(int sal_kuk) {
        this.sal_kuk = sal_kuk;
    }
    public int getSal_after() {
        return sal_after;
    }
    public void setSal_after(int sal_after) {
        this.sal_after = sal_after;
    }
    public int getEmp_final_money() {
        return emp_final_money;
    }
    public void setEmp_final_money(int emp_final_money) {
        this.emp_final_money = emp_final_money;
    }
    public String getEmp_meno() {
        return emp_meno;
    }
    public void setEmp_meno(String emp_meno) {
        this.emp_meno = emp_meno;
    }
    public String getSal_pay_yn() {
        return sal_pay_yn;
    }
    public void setSal_pay_yn(String sal_pay_yn) {
        this.sal_pay_yn = sal_pay_yn;
    }
    private String loginID; //사번
    private String sal_date;  //해당년월
    private String emp_name;  //사원명
    private String dept_cd;  //부서코드
    private String level_cd;  //직급코드
    private int emp_yr_sal;  //연봉
    private int sal_pre; //세전급여(기본급)
    private int sal_san;  //산재보험
    private int sal_ko;  //고용보험
    private int sal_kun;  //건강보험
    private int sal_kuk;  //국민연금
    private int sal_after;  //실급여
    private int emp_final_money;  //퇴직금
    private String emp_meno;  //비고
    private String sal_pay_yn;  //당월 급여 지급여부


}
