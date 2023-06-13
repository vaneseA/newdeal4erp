<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>공지사항</title>
    <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

    <script type="text/javascript">

        // 페이징 설정
        var pageSize = 10;
        var pageBlockSize = 5;


        /** OnLoad event */
        $(function () {
            // 버튼 이벤트 등록
            fRegisterButtonClickEvent();

            fn_productInfoList();


        });


        /** 버튼 이벤트 등록 */

        /* function fRegisterButtonClickEvent() {
            $('a[name=btn]').click(function(e) {
                e.preventDefault();

                var btnId = $(this).attr('id');

                switch (btnId) {
                    case 'btnSearch' :
                        fn_noticelist();
                        break;
                    case 'btnSave' :
                        fn_save();
                        break;
                    case 'btnDelete' :
                        $("#action").val("D");
                        fn_save();
                        break;
                    case 'btnDeleteFile' :
                        $("#action").val("D");
                        fn_savefile();
                        break;
                    case 'btnSaveFile' :
                        fn_savefile();
                        break;
                    case 'btnClose' :
                    case 'btnCloseFile' :
                        gfCloseModal();
                        break;
                }
            });
        } */


        //리스트 뿌려주기
        function fn_empSamList(pagenum) {

            pagenum = pagenum || 1;

            var param = {
                dep_cd: $("#dep_cd").val()
                , level_cd: $("#level_cd").val()
                , sal_pay_yn: $("#sal_pay_yn").val()
                , emp_info: $("#emp_info").val()
                , sname: $("#sname").val()
                , pageSize: pageSize
                , pageBlockSize: pageBlockSize
                , pagenum: pagenum
            }

            var listCallBack = function (returnvalue) {
                console.log(returnvalue);

                $("#listEmpSam").empty().append(returnvalue);//noticelistgrd.jsp가 append됨

                var totalcnt = $("#totalcnt").val();

                console.log("totalcnt : " + totalcnt);

                var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_empSamList');
                console.log("paginationHtml : " + paginationHtml);

                $("#empSamPagination").empty().append(paginationHtml);

                $("#pageno").val(pagenum);
            }

            callAjax("/empSam/salManagementList.do", "post", "text", false, param, listCallBack);

        }

        function fn_openpopup() {

            popupinit();

            // 모달 팝업
            gfModalPop("#layer1");


        }

        function popupinit(object) {

            if (object == "" || object == null || object == undefined) {
                $("#notice_title").val("");
                $("#notice_cont").val("");
                $("#notice_no").val("");

                $("#btnDelete").hide();

                $("#action").val("I");
            } else {
                $("#notice_title").val(object.notice_title);
                $("#notice_cont").val(object.notice_cont);
                $("#notice_no").val(object.notice_no);

                $("#btnDelete").show();

                $("#action").val("U");
            }
        }

        function fn_selectone(no) {

            //alert(no);

            var param = {
                notice_no: no
            }

            var selectoncallback = function (returndata) {
                console.log(JSON.stringify(returndata));

                popupinit(returndata.noticesearch);

                // 모달 팝업
                gfModalPop("#layer1");

            }

            callAjax("/mngNot/noticeselectone.do", "post", "json", false, param, selectoncallback);

        }

        function fn_save() {

            if (!fn_Validate()) {
                return;
            }

            var param = {
                action: $("#action").val(),
                notice_no: $("#notice_no").val(),
                notice_title: $("#notice_title").val(),
                notice_cont: $("#notice_cont").val()
            }

            var savecollback = function (reval) {
                console.log(JSON.stringify(reval));

                if (reval.returncval > 0) {
                    alert("저장 되었습니다.");
                    gfCloseModal();

                    if ($("#action").val() == "U") {
                        fn_productInfoList($("#pageno").val());
                    } else {
                        fn_productInfoList();
                    }
                } else {
                    alert("오류가 발생 되었습니다.");
                }
            }

            //callAjax("/mngNot/noticesave.do", "post", "json", false, param, savecollback) ;
            callAjax("/mngNot/noticesave.do", "post", "json", false, $("#myForm").serialize(), savecollback);

        }

        function fn_Validate() {

            var chk = checkNotEmpty(
                [
                    ["notice_title", "제목을 입력해 주세요."]
                    , ["notice_cont", "내용을 입력해 주세요"]
                ]
            );

            if (!chk) {
                return;
            }

            return true;
        }

        //////////////////////////   위는 파일 업이 처리
        /////////////////////////    file upload

        function fn_openpopupfile() {
            popupinitfile();

            // 모달 팝업
            gfModalPop("#layer2");
        }

        function popupinitfile(object) {

            if (object == "" || object == null || object == undefined) {
                $("#file_notice_title").val("");
                $("#file_notice_cont").val("");
                $("#notice_no").val("");
                $("#upfile").val("");

                $("#previewdiv").empty();

                $("#btnDeleteFile").hide();

                $("#action").val("I");
            } else {
                /*
                "notice_del_yn":"N"
                "loginID":"admin"
                 "notice_no":71
                 "notice_title":"oofile"
                  "notice_date":"2023-06-12 09:16:58.0"
                  "notice_cont":"ddddd"
                  "file_no":30
                  "file_name":"0524.sql"
                 "logic_path":"/serverfile\\\\notice\\0524.sql"
                  "physic_path":"W:\\FileRepository\\\\notice\\0524.sql"
                  "file_size":34498
                  "exten":"sql"
                  "name":"관리자"
                 */
                $("#file_notice_title").val(object.notice_title);
                $("#file_notice_cont").val(object.notice_cont);
                $("#notice_no").val(object.notice_no);
                $("#upfile").val("");

                var inserthtml = "<a href='javascript:fn_filedownload()'>";

                if (object.file_name == "" || object.file_name == null || object.file_name == undefined) {
                    inserthtml += "";
                } else {
                    var selfile = object.file_name;
                    var selfilearr = selfile.split(".");
                    var lastindex = selfilearr.length - 1;
                    if (selfilearr[lastindex].toLowerCase() == "jpg" || selfilearr[lastindex].toLowerCase() == "gif" || selfilearr[lastindex].toLowerCase() == "jpge" || selfilearr[lastindex].toLowerCase() == "png") {
                        inserthtml += "<img src='" + object.logic_path + "' style='width:100px; height:80px' />";
                    } else {
                        inserthtml += object.file_name;
                    }
                }


                inserthtml += "</a>"

                $("#previewdiv").empty().append(inserthtml);

                $("#btnDeleteFile").show();

                $("#action").val("U");
            }
        }

        function preview(event) {
            var image = event.target;

            //alert(image.files[0].file_name + " : " + image.files[0].file_nm + " : " + image.files[0].name);

            if (image.files[0]) {
                //alert(window.URL.createObjectURL(image.files[0]));

                var selfile = image.files[0].name;
                var selfilearr = selfile.split(".");
                var inserthtml = "";
                var lastindex = selfilearr.length - 1;


                if (selfilearr[lastindex].toLowerCase() == "jpg" || selfilearr[lastindex].toLowerCase() == "gif" || selfilearr[lastindex].toLowerCase() == "jpge" || selfilearr[lastindex].toLowerCase() == "png") {
                    inserthtml = "<img src='" + window.URL.createObjectURL(image.files[0]) + "' style='width:100px; height:80px' />";
                } else {
                    inserthtml = selfile;
                }


                $("#previewdiv").empty().append(inserthtml);
            }


        }

        function fn_savefile() {

            var frm = document.getElementById("myForm");
            frm.enctype = 'multipart/form-data';
            var fileData = new FormData(frm);

            var filesavecallback = function (returnval) {
                console.log(JSON.stringify(returnval));

                if (returnval.returncval > 0) {
                    alert("저장 되었습니다.");
                    gfCloseModal();

                    if ($("#action").val() == "U") {
                        fn_productInfoList($("#pageno").val());
                    } else {
                        fn_productInfoList();
                    }
                } else {
                    alert("오류가 발생 되었습니다.");
                }
            }

            callAjaxFileUploadSetFormData("/mngNot/noticesavefile.do", "post", "json", true, fileData, filesavecallback);

        }

        function fn_selectonefile(no) {

            //alert(no);

            var param = {
                notice_no: no
            }

            var selectoncallback = function (returndata) {
                console.log(JSON.stringify(returndata));

                popupinitfile(returndata.noticesearch);

                // 모달 팝업
                gfModalPop("#layer2");

            }

            callAjax("/mngNot/noticeselectone.do", "post", "json", false, param, selectoncallback);

        }

        function fn_filedownload() {
            alert("다운로드");

            var params = "";
            params += "<input type='hidden' name='notice_no' id='notice_no' value='" + $("#notice_no").val() + "' />";

            jQuery("<form action='/mngNot/downloadnoticefile.do' method='post'>" + params + "</form>").appendTo('body').submit().remove();

        }


    </script>

</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="action" name="action"/>
    <input type="hidden" id="notice_no" name="notice_no"/>
    <input type="hidden" id="pageno" name="pageno"/>

    <!-- 모달 배경 -->
    <div id="mask"></div>

    <div id="wrap_area">

        <h2 class="hidden">header 영역</h2>
        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

        <h2 class="hidden">컨텐츠 영역</h2>
        <div id="container">
            <ul>
                <li class="lnb">
                    <!-- lnb 영역 -->
                    <jsp:include
                            page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
                </li>
                <li class="contents">
                    <!-- contents -->
                    <h3 class="hidden">contents 영역</h3> <!-- content -->
                    <div class="content">

                        <p class="Location">
                            <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
                                class="btn_nav bold">운영</span> <span class="btn_nav bold">공지사항
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
                        </p>

                        <p class="conTitle">
                            <span>급여지급 리스트 조회</span> <span class="fr">
							<select id="dep_cd" name="dep_cd" style="width: 150px;">
							        <option value="">부서</option>
									<option value="300">회계팀</option>
									<option value="400">영업팀</option>
									<option value="500">인사팀</option>
									
							</select> 
							 <select id="level_cd" name="level_cd" style="width: 150px;">
							        <option value="">직급</option>
									<option value="10">사원</option>
									<option value="20">주임</option>
									<option value="30">대리</option>
									<option value="40">과장</option>
									<option value="50">부장</option>
									<option value="60">상무</option>
									<option value="70">전무</option>
									<option value="80">이사</option>
							</select> 
							<select id="sal_pay_yn" name="sal_pay_yn" style="width: 150px;">
									<option value="">전체</option>
							        <option value="Y">지급</option>
									<option value="N">미지급</option>
							</select> 
							 <select id="emp_info" name="emp_info" style="width: 150px;">
							        <option value="">전체</option>
									<option value="loginID">사번</option>
									<option value="emp_name">사원명</option>
							</select> 
							<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							 <a class="btnType blue" href="javascript:fn_openpopup();"
                                name="modal"><span>신규등록</span></a>
							 <a class="btnType blue" href="javascript:fn_openpopupfile();"
                                name="modal"><span>신규등록 파일</span></a>
							</span>
                        </p>

                        <!-- 급여 상세 조회 리스트 목록 뿌리기(thead부분 tbody는 salManagementGrd에서 삽입) -->
                        <div class="empSamList">

                            <table class="col">
                                <caption>caption</caption>
                                <colgroup>
                                    <col width="5%">
                                    <col width="10%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="10%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                    <col width="5%">
                                </colgroup>

                                <thead>
                                <tr>
                                    <th scope="col">해당년월</th>
                                    <th scope="col">사번</th>
                                    <th scope="col">사원명</th>
                                    <th scope="col">부서명</th>
                                    <th scope="col">직급</th>
                                    <th scope="col">연봉</th>
                                    <th scope="col">기본급</th>
                                    <th scope="col">국민연금</th>
                                    <th scope="col">건강보험</th>
                                    <th scope="col">산재보험</th>
                                    <th scope="col">고용보험</th>
                                    <th scope="col">실급여</th>
                                    <th scope="col">퇴직금</th>
                                    <th scope="col">비고</th>
                                    <th scope="col">지급</th>

                                </tr>
                                </thead>
                                <tbody id="listEmpSam"></tbody>
                            </table>
                        </div>

                        <div class="paging_area" id="empSamPagination"></div>


                    </div> <!--// content -->

                    <h3 class="hidden">풋터 영역</h3>
                    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                </li>
            </ul>
        </div>
    </div>

    <!-- 모달팝업 -->
    <div id="layer1" class="layerPop layerType2" style="width: 600px;">
        <dl>
            <dt>
                <strong>그룹코드 관리</strong>
            </dt>
            <dd class="content">
                <!-- s : 여기에 내용입력 -->
                <table class="row">
                    <caption>caption</caption>
                    <colgroup>
                        <col width="120px">
                        <col width="*">
                        <col width="120px">
                        <col width="*">
                    </colgroup>

                    <tbody>
                    <tr>
                        <th scope="row">제목 <span class="font_red">*</span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100" name="notice_title" id="notice_title"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">내용 <span class="font_red">*</span></th>
                        <td colspan="3">
                            <textarea id="notice_cont" name="notice_cont"> </textarea>
                        </td>
                    </tr>

                    </tbody>
                </table>

                <!-- e : 여기에 내용입력 -->

                <div class="btn_areaC mt30">
                    <a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
                    <a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
                    <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
                </div>
            </dd>
        </dl>
        <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>

    <div id="layer2" class="layerPop layerType2" style="width: 600px;">
        <dl>
            <dt>
                <strong>상세코드 관리</strong>
            </dt>
            <dd class="content">

                <!-- s : 여기에 내용입력 -->

                <table class="row">
                    <caption>caption</caption>
                    <colgroup>
                        <col width="120px">
                        <col width="*">
                        <col width="120px">
                        <col width="*">
                    </colgroup>

                    <tbody>
                    <tr>
                        <th scope="row">제목 <span class="font_red">*</span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100" name="file_notice_title"
                                               id="file_notice_title"/></td>
                    </tr>
                    <tr>
                        <th scope="row">내용 <span class="font_red">*</span></th>
                        <td colspan="3">
                            <textarea id="file_notice_cont" name="file_notice_cont"> </textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan=2>
                            <input type="file" id="upfile" name="upfile" onchange="javascript:preview(event)"/>
                        </td>
                        <td colspan=2>
                            <div id="previewdiv"></div>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <!-- e : 여기에 내용입력 -->

                <div class="btn_areaC mt30">
                    <a href="" class="btnType blue" id="btnSaveFile" name="btn"><span>저장</span></a>
                    <a href="" class="btnType blue" id="btnDeleteFile" name="btn"><span>삭제</span></a>
                    <a href="" class="btnType gray" id="btnCloseFile" name="btn"><span>취소</span></a>
                </div>
            </dd>
        </dl>
        <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
    <!--// 모달팝업 -->
</form>
</body>
</html>