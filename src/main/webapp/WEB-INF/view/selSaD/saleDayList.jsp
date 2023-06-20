<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>일별 매출 현황</title>
    <jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

    <script type="text/javascript">

        // 페이징 설정
        var pageSize = 5;
        var pageBlockSize = 5;


        /** OnLoad event */
        $(function () {
            // 버튼 이벤트 등록
            fRegisterButtonClickEvent();

            fn_saleDayList();

        });


        /** 버튼 이벤트 등록 */
        function fRegisterButtonClickEvent() {
            $('a[name=btn]').click(function (e) {
                e.preventDefault();

                var btnId = $(this).attr('id');

                switch (btnId) {
                    case 'btnSearch' :
                        fn_saleDayList();
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

        function fn_saleDayList(pagenum) {
            pagenum = pagenum || 1;

            var param = {
                // proName: $("#proName").val()
                // , splrName: $("#splrName").val()
                // , searchKey: $("#searchKey").val()
                // , pname: $("#pname").val()
                // , pageSize: pageSize
                // , pageBlockSize: pageBlockSize
                // , pagenum: pagenum
            };

            var listCallBack = function (returnValue) {
                console.log(returnValue);

                $("#listSaleDay").empty().append(returnValue);

                var totalCnt = $("#totalCnt").val();

                console.log("totalCnt: " + totalCnt);

                var paginationHtml = getPaginationHtml(pagenum, totalCnt, pageSize, pageBlockSize, 'fn_productList');
                console.log("paginationHtml: " + paginationHtml);

                $("#saleDayPagination").empty().append(paginationHtml);

                $("#pageno").val(pagenum);
            };

            callAjax("/selSaD/saleDayList.do", "post", "text", false, param, listCallBack);
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
                        fn_saleDayList($("#pageno").val());
                    } else {
                        fn_saleDayList();
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
                                class="btn_nav bold">매출</span> <span class="btn_nav bold">일별 매출 현황
								</span> <a href="../busPd/productInfo.do" class="btn_set refresh">새로고침</a>
                        </p>


                        <p class="conTitle">
                            <span>일별 매출 현황</span> <span class="fr">
					</span>
                        </p>

                        <!-- 검색창 영역 시작 -->
                        <div style="display:flex; justify-content:center; align-content:center; border:1px solid DeepSkyBlue; padding:40px 40px; margin-bottom: 8px;">
                            <select id="proName" name="proName" style="width: 170px; margin-right:5px;">
                                <option value="">검색 조건</option>
                                <option value="저장장치">주문 일자</option>
                                <option value="CPU">고객기업명</option>
                                <option value="메모리">제조사</option>
                                <option value="그래픽카드">품명</option>
                                <option value="메인보드">모델명</option>
                            </select>
                            <input type="text" style="width: 200px; height: 25px; margin-right:5px; " id="pname"
                                   name="pname">
                            <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
                            </p>
                        </div>
                        <!-- 검색창 영역 끝 -->


                        <div class="saleDayList">
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
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                </colgroup>

                                <thead>
                                <tr>
                                    <th scope="col">주문 일자</th>
                                    <th scope="col">주문 번호</th>
                                    <th scope="col">고객기업명</th>
                                    <th scope="col">제조사</th>
                                    <th scope="col">품명</th>
                                    <th scope="col">모델명</th>
                                    <th scope="col">납품단가</th>
                                    <th scope="col">판매가</th>
                                    <th scope="col">수량</th>
                                    <th scope="col">총액</th>

                                </tr>
                                </thead>
                                <tbody id="listSaleDay"></tbody>
                            </table>
                        </div>

                        <div class="paging_area" id="saleDayPagination"></div>


                    </div> <!--// content -->

                    <h3 class="hidden">풋터 영역</h3>
                    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                </li>
            </ul>
        </div>
    </div>


</form>
</body>
</html>