<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>제품정보</title>
    <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

    <script type="text/javascript">

        // 페이징 설정
        var pageSize = 10;
        var pageBlockSize = 5;


        /** OnLoad event */
        $(function () {
            // 버튼 이벤트 등록
            fRegisterButtonClickEvent();

            fn_productList();


            // 제품분류
            productCombo("l", "lTypeCombo", "all", "", "", "", "");  // combo type( l : 대분류   m : 중분류   s : 소분류) combo_name, type(기본값  all : 전체   sel : 선택) ,  대분류 코드, 중분류코드, 소분류 코드, ""


            // 제품분류 제품등록용
            productCombo("l", "lTypeComboForCreate", "all", "", "", "", "");  // combo type( l : 대분류   m : 중분류   s : 소분류) combo_name, type(기본값  all : 전체   sel : 선택) ,  대분류 코드, 중분류코드, 소분류 코드, ""


            // 제조사
            $('#lTypeCombo').change(function () {
                productCombo("m", "mTypeCombo", "all", $("#lTypeCombo").val(), "", "", "");   // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , 선택된 상위 계정코드, ""
                $("#splrName").val($(this).val());
            });

            // 제조사 제품등록용
            $('#lTypeComboForCreate').change(function () {
                productCombo("m", "mTypeComboForCreate", "all", $("#lTypeComboForCreate").val(), "", "", "");   // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , 선택된 상위 계정코드, ""
                $("#splrName").val($(this).val());
            });

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

        function fn_productList(pagenum) {
            pagenum = pagenum || 1;

            var param = {
                lTypeCombo: $("#lTypeCombo").val()
                , mTypeCombo: $("#mTypeCombo").val()
                , searchKey: $("#searchKey").val()
                , pname: $("#pname").val()
                , pageSize: pageSize
                , pageBlockSize: pageBlockSize
                , pagenum: pagenum
            };

            var listCallBack = function (returnValue) {
                console.log(returnValue);

                $("#listProduct").empty().append(returnValue);

                var totalcnt = $("#totalcnt").val();

                console.log("totalcnt: " + totalcnt);

                var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_productList');
                console.log("paginationHtml: " + paginationHtml);

                $("#productPagination").empty().append(paginationHtml);

                $("#pageno").val(pagenum);
            };

            callAjax("/busPd/productList.do", "post", "text", false, param, listCallBack);
        }


        function fn_openPopUp() {

            popUpInit();

            // 모달 팝업
            gfModalPop("#layer1");


        }

        function popUpInit(object) {

            if (object == "" || object == null || object == undefined) {
                $("#product_no").val("");
                $("#product_name").val("");
                $("#pro_name").val("");
                $("#splr_name").val("");
                $("#product_serial").val("");
                $("#product_unit_price").val("");
                $("#product_price").val("");


                $("#btnDelete").hide();
// object 가 없는 상태로 팝업 뜰 땐, action 을 “I” 로 설정하여  INSERT
                $("#action").val("I");
            } else {
                $("#product_no").val(object.product_no);
                $("#product_name").val(object.product_name);
                $("#pro_name").val(object.pro_name);
                $("#splr_name").val(object.splr_name);
                $("#product_serial").val(object.product_serial);
                $("#product_unit_price").val(object.product_unit_price);
                $("#product_price").val(object.product_price);


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
                product_name: $("#product_name").val(),
                pro_name: $("#pro_name").val(),
                splr_name: $("#splr_name").val(),
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
                    ["pro_name", "제품분류를 선택해 주세요."]
                    , ["splr_name", "납품회사명을 선택해 주세요"]
                    , ["product_name", "품명 입력해 주세요"]
                    , ["product_serial", "시리얼넘버를 입력해 주세요"]
                    , ["product_unit_price", "납품가를 입력해 주세요"]
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
                             <a class="btnType blue" href="javascript:fn_openPopUp();"
                                name="modal"><span>제품등록</span></a>
					</span>
                        </p>

                        <!-- 검색창 영역 시작 -->
                        <div style="display:flex; justify-content:center; align-content:center; line-height:2; border:1px solid DeepSkyBlue; padding:40px 40px; margin-bottom: 8px;">
                            <label for="lTypeCombo" style="font-size:15px; font-weight:bold; margin-right:10px;">제품
                                분류</label>
                            <select id="lTypeCombo" name="lTypeCombo" style="width: 150px; margin-right:5px;">

                            </select>


                            <label for="mTypeCombo" style="font-size:15px; font-weight:bold; margin-left:10px; margin-right:10px;">제조사</label>
                            <select id="mTypeCombo" name="mTypeCombo" style="width: 170px; margin-right:5px;">

                            </select>

                            <label for="searchKey" style="font-size:15px; font-weight:bold; margin-right:10px;">검색 조건</label>
                            <select id="searchKey" name="searchKey" style="width: 120px; margin-right:5px;">

                                <option value="">전체</option>
                                <option value="product_name">제품 이름</option>
                                <option value="product_serial">시리얼넘버</option>
                            </select>
                            <input type="text" style="width: 160px; height: 25px; margin-right:5px; " id="pname"
                                   name="pname">
                            <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
                            </p>
                        </div>
                        <!-- 검색창 영역 끝 -->


                        <div class="productList">
                            <table class="col">
                                <caption>caption</caption>
                                <colgroup>
                                    <col width="8%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="28%">
                                    <col width="20%">
                                    <col width="11%">
                                    <col width="12%">
                                </colgroup>

                                <thead>
                                <tr>
                                    <th scope="col">제품 번호</th>
                                    <th scope="col">제폼 종류</th>
                                    <th scope="col">제조사</th>
                                    <th scope="col">제품 이름</th>
                                    <th scope="col">시리얼넘버</th>
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
    <div id="layer1" class="layerPop layerType2" style="width: 650px;">
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
                        <th scope="row">제품 분류 <span class="font_red">*</span></th>
                        <td>
                            <select id="lTypeComboForCreate" name="lTypeComboForCreate">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">제조사 <span class="font_red">*</span></th>
                        <td>
                            <select id="mTypeComboForCreate" name="mTypeComboForCreate">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">품명 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="product_name" id="product_name"/></td>
                        <th scope="row">시리얼넘버 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="product_serial"
                                   id="product_serial"/></td>
                    </tr>
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