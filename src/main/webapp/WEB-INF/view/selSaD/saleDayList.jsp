<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>일별 매출 현황</title>
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

            new Chart(document.getElementById("doughnut-chart"), {
                type: 'doughnut',
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
                    title: {
                        display: true,
                        text: '일별 매출 순이익'
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
            fn_saleDayList();
            fn_aa();
        });


        /** 버튼 이벤트 등록 */
        function fRegisterButtonClickEvent() {1
            $('a[name=btn]').click(function (e) {
                e.preventDefault();

                var btnId = $(this).attr('id');

                switch (btnId) {
                    case 'btnSearch' :
                        $(".selectedDayList").css("display", "block");  // Here
                        fn_selectedDayList();
                        fn_saleDayList();
                        break;
                }
            });
        }

        function fn_saleDayList(pagenum) {
            pagenum = pagenum || 1;

            var param = {
                selectedValue: $("#proName").val(),
                selectedValue: $("#splrName").val(),
                searchKey: $("#searchKey").val(),
                selectedValue: $("#pname").val(),
                pageSize: pageSize,
                pageBlockSize: pageBlockSize,
                pagenum: pagenum
            };


            var listCallBack = function (returnValue) {
                console.log(returnValue);

                $("#listSaleDay").empty().append(returnValue);

                var totalCnt = $("#totalCnt").val();

                console.log("totalCnt: " + totalCnt);

                var paginationHtml = getPaginationHtml(pagenum, totalCnt, pageSize, pageBlockSize, 'fn_saleDayList');
                console.log("paginationHtml: " + paginationHtml);

                $("#saleDayPagination").empty().append(paginationHtml);

                $("#pageno").val(pagenum);
            };

            callAjax("/selSaD/saleDayList.do", "post", "text", false, param, listCallBack);
        }

        function fn_selectedDayList() {

            var param = {
                order_date : $("#order_date").val()
            };


            var listCallBack = function (returnValue) {
                $("#selectedDayList").empty().append(returnValue);
            };

            callAjax("/selSaD/selectedDayList.do", "post", "text", false, param, listCallBack);
        }

    </script>

</head>
<body>
<form id="myForm" action="" method="">
    <input type="hidden" id="action" name="action"/>
    <input type="hidden" id="order_no" name="order_no"/>
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
								</span> <a href="../selSaD/saleDay.do" class="btn_set refresh">새로고침</a>
                        </p>


                        <p class="conTitle">
                            <span>일별 매출 현황</span> <span class="fr">
					</span>
                        </p>

                        <!-- 검색창 영역 시작 -->

                        <div style="display:flex; justify-content:center; align-content:center; border:1px solid DeepSkyBlue; padding:10px 10px; margin-bottom: 8px;">
                            <label for="order_date" style="font-size: 15px; margin-right:5px; ">날짜 조회 : </label>
                            <input type="date" id="order_date" name="order_date" min="2023-01-01"
                                   style="height: 25px; width: 120px; margin-right: 15px;">
                            <a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
                            </p>
                        </div>
                        <!-- 검색창 영역 끝 -->
                        <div class="selectedDayList" style="display: none;"> <!-- Here -->
                            <div style="display:flex; flex-grow: 1; justify-content: space-evenly;">
                                <div class="items" style="width: 100%"><canvas id="doughnut-chart" width="300" height="250"></canvas></div>
                                <div class="items"style="width: 100%; ">
                                    <table class="col" style="height:100%;" >
                                        <caption>caption</caption>
                                        <colgroup>
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="20%">
                                            <col width="20%">
                                        </colgroup>

                                        <thead>
                                        <tr>
                                            <th scope="col">선택된 일자</th>
                                            <th scope="col">총 판매량</th>
                                            <th scope="col">매출</th>
                                            <th scope="col">매출 원가</th>
                                            <th scope="col">매출 순이익</th>
                                        </tr>
                                        </thead>

                                        <tbody id="selectedDayList">

                                        </tbody>

                                    </table>
                                </div>
                            </div>
                        </div>


                        <div class="saleDayList">
                            <div style="display:flex; flex-grow: 1; justify-content: space-evenly;">

                            </div>
                        </div>
                        <table class="col">
                            <caption>caption</caption>
                            <colgroup>
                                <col width="12%">
                                <col width="5%">
                                <col width="9%">
                                <col width="9%">
                                <col width="9%">
                                <col width="12%">
                                <col width="9%">
                                <col width="9%">
                                <col width="9%">
                                <col width="5%">
                                <col width="9%">
                            </colgroup>

                            <thead>
                            <tr>
                                <th scope="col">주문 일자</th>
                                <th scope="col">주문 번호</th>
                                <th scope="col">고객기업명</th>
                                <th scope="col">제품 분류</th>
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