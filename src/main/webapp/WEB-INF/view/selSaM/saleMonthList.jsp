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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <script type="text/javascript">

        // 페이징 설정
        var pageSize = 5;
        var pageBlockSize = 5;
        function fn_aa() {
            // 오늘 날짜 가져오기
            var currentDate = new Date();

            // Date 객체의 날짜를 7일씩 증가시키면서 label 생성
            var labels = [];
            for (var i = 0; i < 7; i++) {
                var date = new Date(currentDate);
                date.setDate(date.getDate() + i);
                var formattedDate = formatDate(date); // 날짜를 원하는 형식으로 포맷팅
                labels.push(formattedDate);
            }
            new Chart(document.getElementById("bar-chart-horizontal"), {
                type: 'horizontalBar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: "Population (millions)",
                            backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
                            data: [2478, 5267, 734, 784, 433]
                        }
                    ]
                },
                options: {
                    legend: {display: false},
                    title: {
                        display: true,
                        text: '월별 매출 순이익'
                    }
                }
            });
        }
            // 날짜를 'YYYY-MM-DD' 형식으로 포맷팅하는 함수
            function formatDate(date) {
                var year = date.getFullYear();
                var month = ('0' + (date.getMonth() + 1)).slice(-2);
                var day = ('0' + date.getDate()).slice(-2);
                return year + '-' + month + '-' + day;
            }
            /** OnLoad event */
            $(function () {
                // 버튼 이벤트 등록
                fRegisterButtonClickEvent();

                fn_saleMonthList();
                fn_aa();

            });



        /** 버튼 이벤트 등록 */
        function fRegisterButtonClickEvent() {
            $('a[name=btn]').click(function (e) {
                e.preventDefault();

                var btnId = $(this).attr('id');

                switch (btnId) {
                    case 'btnSearch' :
                        fn_saleMonthList();
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

        function fn_saleMonthList(pagenum) {
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

                $("#listProduct").empty().append(returnValue);

                var totalCnt = $("#totalCnt").val();

                console.log("totalCnt: " + totalCnt);

                var paginationHtml = getPaginationHtml(pagenum, totalCnt, pageSize, pageBlockSize, 'fn_productList');
                console.log("paginationHtml: " + paginationHtml);

                $("#productPagination").empty().append(paginationHtml);

                $("#pageno").val(pagenum);
            };

            callAjax("/selSaM/saleMonthList.do", "post", "text", false, param, listCallBack);
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
                                class="btn_nav bold">매출</span> <span class="btn_nav bold">월별 매출 현황
								</span> <a href="../busPd/productInfo.do" class="btn_set refresh">새로고침</a>
                        </p>


                        <p class="conTitle">
                            <span>월별 매출 현황</span> <span class="fr">
					</span>
                        </p>

                        <!-- 검색창 영역 시작 -->

                        <div style="display:flex; justify-content:center; align-content:center; border:1px solid DeepSkyBlue; padding:10px 10px; margin-bottom: 8px;">
                            <label for="start" style="font-size: 15px; margin-right:5px; ">기간 조회 : </label>
                            <input type="date" id="start" name="start" min="2023-01-01"
                                   style="height: 25px; width: 120px;">
                            <label for="clicombo" style="margin-left: 15px; font-size: 15px;">거래처명 : </label>
                            <select id="clicombo" name="clicombo" style="height: 25px; width: 120px;">
                            </select>

                            <label for="acccombo" style="margin-left: 15px; font-size: 15px;">계정 대분류 : </label>
                            <select id="acccombo" name="acccombo" style="height: 25px; width: 100px;">
                                <option value="">전체</option>
                            </select>

                            </select>
                            <input type="text" style="width: 200px; height: 25px; margin-right:5px; " id="pname"
                                   name="pname">
                            <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
                            </p>
                        </div>
                        <!-- 검색창 영역 끝 -->


                        <div class="saleMonthList">
                            <div style="display:flex; flex-grow: 1; justify-content: space-evenly;">
                                <div class="items" style="width: 50%"><canvas id="bar-chart-horizontal" width="300" height="250"></canvas></div>
                                </div>
                            </div>
                            <table class="col">
                                <caption>caption</caption>
                                <colgroup>
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="10%">
                                </colgroup>

                                <thead>
                                <tr>
                                    <th scope="col">연월</th>
                                    <th scope="col">총 주문 건수</th>
                                    <th scope="col">매출</th>
                                    <th scope="col">매출 원가</th>
                                    <th scope="col">매출 총이익</th>
                                    <th scope="col">영업이익률</th>


                                </tr>
                                </thead>
                                <tbody id="listSaleMonth"></tbody>
                            </table>


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
                        <th scope="row">제품종류 <span class="font_red">*</span></th>
                        <td>
                            <select id="ltypecombo" name="ltypecombo">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">제조사 <span class="font_red">*</span></th>
                        <td>
                            <select id="mtypecombo" name="mtypecombo">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">품명 <span class="font_red">*</span></th>
                        <td><input type="text" class="inputTxt p100" name="product_name" id="product_name"/></td>
                        <th scope="row">모델명 <span class="font_red">*</span></th>
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