<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>월별 매출 현황</title>
    <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

    <script type="text/javascript">

        // 페이징 설정
        var pageSize = 5;
        var pageBlockSize = 5;


        /** OnLoad event */
        $(function () {
            // 버튼 이벤트 등록
            fRegisterButtonClickEvent();

            fn_selSaMList();


        });


        /** 버튼 이벤트 등록 */
        function fRegisterButtonClickEvent() {
            $('a[name=btn]').click(function (e) {
                e.preventDefault();

                var btnId = $(this).attr('id');

                switch (btnId) {
                    case 'btnSearch' :
                        fn_productList();
                        break;
                    case 'btnSave' :
                        fn_save();
                        break;
                    case 'btnDelete' :
                        $("#action").val("D");
                        fn_save();
                        break;
                    case 'btnClose' :
                    case 'btnCloseDtlCod' :
                        gfCloseModal();
                        break;
                }
            });
        }

        //리스트 뿌려주기
        function fn_selSaMList(pagenum) {
            pagenum = pagenum || 1;

            var param = {
                delyn: $("#delyn").val()
                , searchKey: $("#searchKey").val()
                , sname: $("#sname").val()
                , pageSize: pageSize
                , pageBlockSize: pageBlockSize
                , pagenum: pagenum
            }

            var listCallBack = function (returnValue) {
                console.log(returnValue);

                $("#listSelSaM").empty().append(returnValue);

                var totalCnt = $("#totalCnt").val();

                console.log("totalCnt: " + totalCnt);

                var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_noticelist');
                console.log("paginationHtml : " + paginationHtml);

                $("#selSaMPagination").empty().append(paginationHtml);

                $("#pageno").val(pagenum);
            }

            callAjax("/selSaM/selSaMList.do", "post", "text", false, param, listCallBack);

        }

        function fn_openPopUp() {

            popUpInit();

            // 모달 팝업
            gfModalPop("#layer1");


        }

        function popUpInit(object) {

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
        function fn_selectOne(no) {

            var param = {
                product_no: no
            }

            var selectOnCallBack = function (returndata) {
                console.log(JSON.stringify(returndata));

                popUpInit(returndata.productSearch);

                // 모달 팝업
                gfModalPop("#layer1");

            }

            callAjax("/busPd/productSelectOne.do", "post", "json", false, param, selectOnCallBack);

        }

        function fn_save() {

            if (!fn_Validate()) {
                return;
            }

            var param = {
                action: $("#action").val(),
                product_no: $("#product_no").val(),
                pro_sm_cd: $("#pro_sm_cd").val(),
                pro_lg_cd: $("#pro_lg_cd").val(),
                pro_md_cd: $("#pro_md_cd").val(),
                product_serial: $("#product_serial").val(),
                product_unit_price: $("#product_unit_price").val(),
                product_price: $("#product_price").val()
            }

            //

            var saveCollBack = function (reval) {
                console.log(JSON.stringify(reval));

                if (reval.returncval > 0) {
                    alert("저장 되었습니다.");
                    gfCloseModal();

                    if ($("#action").val() == "U") {
                        fn_productList($("#pageno").val());
                    } else {
                        fn_productList();
                    }
                } else {
                    alert("오류가 발생 되었습니다.");
                }
            }
            callAjax("/busPd/productSave.do", "post", "json", false, $("#myForm").serialize(), saveCollBack);

        }

        function fn_Validate() {

            var chk = checkNotEmpty(
                [
                    ["pro_sm_cd", "pro_sm_cd 입력해 주세요."]
                    , ["pro_lg_cd", "pro_lg_cd 입력해 주세요"]
                    , ["pro_md_cd", "pro_md_cd 입력해 주세요"]
                    , ["product_serial", "모델명을 입력해 주세요"]
                    , ["product_unit_price", "납품을 입력해 주세요"]
                    , ["product_price", "판매가을 입력해 주세요"],

                ]
            );

            if (!chk) {
                return;
            }

            return true;
        }


    </script>

</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="action" name="action"/>
    <input type="hidden" id="product_no" name="product_no"/>
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
                                class="btn_nav bold">영업</span> <span class="btn_nav bold">제품정보
								</span> <a href="../busPd/productInfo.do" class="btn_set refresh">새로고침</a>
                        </p>


                        <p class="conTitle">
                            <span>제품정보</span> <span class="fr">
						 <!-- 검색창 영역 시작 -->
							<select id="proLgCd" name="proLgCd" style="width: 170px;">
							        <option value="">(제품종류) 전체</option>
									<option value="9005">저장장치</option>
									<option value="9001">CPU</option>
							</select>
                            <select id="proMdCd" name="proMgCd" style="width: 170px;">
							        <option value="">(납품기업명) 전체</option>
									<option value="8005">삼성</option>
									<option value="8001">intel</option>
							</select>
							  <select id="searchKey" name="searchKey" style="width: 120px;">
									<option value="pro_sm_cd">제품이름</option>
							</select>
							<input type="text" style="width: 200px; height: 25px;" id="pname" name="pname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							 <a class="btnType blue" href="javascript:fn_openPopUp();"
                                name="modal"><span>제품등록</span></a>
							</span>
                        </p>
                        <!-- 검색창 영역 끝 -->
                        <div class="productList">
                            <table class="col">
                                <caption>caption</caption>
                                <colgroup>
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                </colgroup>

                                <thead>
                                <tr>
                                    <th scope="col">제품번호</th>
                                    <th scope="col">대분류명(종류)</th>
                                    <th scope="col">중분류명(납품기업명)</th>
                                    <th scope="col">제품이름</th>
                                    <th scope="col">모델명</th>
                                    <th scope="col">납품단가</th>
                                    <th scope="col">판매가</th>

                                </tr>
                                </thead>
                                <tbody id="listProduct"></tbody>
                            </table>
                        </div>

                        <div class="paging_area" id="productPagination"></div>


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
                <strong>제품 등록</strong>
            </dt>
            <dd class="content">
                <!-- s : 여기에 내용입력 -->
                <table class="row">
                    <caption>caption</caption>
                    <colgroup>
                        <col width="25%">
                        <col width="25%">
                        <col width="25%">
                        <col width="25%">
                    </colgroup>

                    <tbody>
                    <tr>
                        <th scope="row">납품기업명 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="pro_md_cd" id="pro_md_cd"/></td>
                        <th scope="row">제품종류 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="product_type" id="product_type"/></td>
                    </tr>
                    <tr>
                        <th scope="row">품명 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="pro_sm_cd" id="pro_sm_cd"/></td>
                        <th scope="row">모델명 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="product_serial"
                                   id="product_serial"/></td>
                    <tr>
                        <th scope="row">납품단가 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="product_unit_price" id="product_unit_price"/>
                        </td>
                        <th scope="row">판매가 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="product_price" id="product_price"/></td>
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


            </dd>
        </dl>
        <a href="" class="closePop"><span class="hidden">닫기</span></a>
    </div>
    <!--// 모달팝업 -->
</form>
</body>
</html>