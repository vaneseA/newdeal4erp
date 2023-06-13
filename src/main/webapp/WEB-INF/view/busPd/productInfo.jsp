<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>제품정보</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

	<script type="text/javascript">

		// 페이징 설정
		var pageSize = 10;
		var pageBlockSize = 5;



		/** OnLoad event */
		$(function() {
			// 버튼 이벤트 등록
			fRegisterButtonClickEvent();

			fn_productInfoList();


		});


		/** 버튼 이벤트 등록 */

		// function fRegisterButtonClickEvent() {
		// 	$('a[name=btn]').click(function(e) {
		// 		e.preventDefault();
		//
		// 		var btnId = $(this).attr('id');
		//
		// 		switch (btnId) {
		// 			case 'btnSearch' :
		// 				fn_noticelist();
		// 				break;
		// 			case 'btnSave' :
		// 				fn_save();
		// 				break;
		// 			case 'btnDelete' :
		// 				$("#action").val("D");
		// 				fn_save();
		// 				break;
		// 			case 'btnDeleteFile' :
		// 				$("#action").val("D");
		// 				fn_savefile();
		// 				break;
		// 			case 'btnSaveFile' :
		// 				fn_savefile();
		// 				break;
		// 			case 'btnClose' :
		// 			case 'btnCloseFile' :
		// 				gfCloseModal();
		// 				break;
		// 		}
		// 	});
		// }


		function fn_productInfoList(pagenum) {

			pagenum = pagenum || 1;

			var param = {
				delyn : $("#delyn").val()
				,	searchKey : $("#searchKey").val()
				, 	sname : $("#sname").val()
				, pageSize : pageSize
				, pageBlockSize : pageBlockSize
				, pagenum : pagenum
			}

			var listcollabck = function(returnvalue) {
				console.log(returnvalue);

				$("#listnotice").empty().append(returnvalue);

				var  totalcnt = $("#totalcnt").val();

				console.log("totalcnt : " + totalcnt);

				var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_productInfo');
				console.log("paginationHtml : " + paginationHtml);

				$("#noticePagination").empty().append( paginationHtml );

				$("#pageno").val(pagenum);
			}

			callAjax("/busPd/productInfo.do", "post", "text", false, param, listcollabck) ;

		}

		function fn_openpopup() {

			popupinit();

			// 모달 팝업
			gfModalPop("#layer1");


		}

		function popupinit(object) {

			if(object == "" || object == null || object == undefined) {
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

			//alert(no);

			var param = {
				notice_no : no
			}

			var selectoncallback = function(returndata) {
				console.log( JSON.stringify(returndata) );

				popupinit(returndata.productSearch);

				// 모달 팝업
				gfModalPop("#layer1");

			}

			callAjax("/busPd/productSelectOne.do", "post", "json", false, param, selectoncallback) ;

		}

		function fn_save() {

			if ( ! fn_Validate() ) {
				return;
			}

			var param = {
				action : $("#action").val(),
				notice_no : $("#product_no").val(),
				notice_title : $("#product_name").val(),
				notice_cont : $("#splr_name").val()
			}

			//

			var savecollback = function(reval) {
				console.log( JSON.stringify(reval) );

				if(reval.returncval > 0) {
					alert("저장 되었습니다.");
					gfCloseModal();

					if($("#action").val() == "U") {
						fn_productInfoList($("#pageno").val());
					} else {
						fn_productInfoList();
					}
				}  else {
					alert("오류가 발생 되었습니다.");
				}
			}

			callAjax("/busPd/productSave.do", "post", "json", false, $("#myForm").serialize() , savecollback) ;

		}

		function fn_Validate() {

			var chk = checkNotEmpty(
					[
						[ "notice_title", "제목을 입력해 주세요." ]
						,	[ "notice_cont", "내용을 입력해 주세요" ]
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



		function preview(event) {
			var image = event.target;

			//alert(image.files[0].file_name + " : " + image.files[0].file_nm + " : " + image.files[0].name);

			if(image.files[0]){
				//alert(window.URL.createObjectURL(image.files[0]));

				var selfile = image.files[0].name;
				var selfilearr = selfile.split(".");
				var inserthtml = "";
				var lastindex = selfilearr.length - 1;


				if(selfilearr[lastindex].toLowerCase() == "jpg" || selfilearr[lastindex].toLowerCase() == "gif" || selfilearr[lastindex].toLowerCase() == "jpge" || selfilearr[lastindex].toLowerCase() == "png") {
					inserthtml = "<img src='" + window.URL.createObjectURL(image.files[0]) + "' style='width:100px; height:80px' />";
				} else {
					inserthtml = selfile;
				}


				$("#previewdiv").empty().append(inserthtml);
			}


		}



		function fn_selectonefile(no) {

			//alert(no);

			var param = {
				notice_no : no
			}

			var selectoncallback = function(returndata) {
				console.log( JSON.stringify(returndata) );

				popupinitfile(returndata.noticesearch);

				// 모달 팝업
				gfModalPop("#layer2");

			}

			callAjax("/mngNot/noticeselectone.do", "post", "json", false, param, selectoncallback) ;

		}





	</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action"  name="action"  />
	<input type="hidden" id="notice_no"  name="notice_no"  />
	<input type="hidden" id="pageno"  name="pageno"  />

	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">영업</span> <span class="btn_nav bold">제품정보
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>제품정보</span> <span class="fr">
							<select id="delyn" name="delyn" style="width: 150px;">
							        <option value="" >전체</option>
									<option value="Y" >삭제</option>
									<option value="N" >미삭제</option>
							</select>
							 <select id="searchKey" name="searchKey" style="width: 150px;" >
							        <option value="" >전체</option>
									<option value="writer" >작성자</option>
									<option value="title" >제목</option>
							</select>
							<input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>제품등록</span></a>
							</span>
						</p>

						<div class="noticeList">
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
								</colgroup>

								<thead>
								<tr>
									<th scope="col">제품번호</th>
									<th scope="col">납품기업번호</th>
									<th scope="col">납품기업명</th>
									<th scope="col">품명</th>
									<th scope="col">모델명</th>
									<th scope="col">납품단가</th>
									<th scope="col">판매가</th>
									<th scope="col">수량</th>

								</tr>
								</thead>
								<tbody id="listnotice"></tbody>
							</table>
						</div>

						<div class="paging_area"  id="noticePagination"> </div>


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
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
					<tr>
						<th scope="row">제품명 <span class="font_red">*</span></th>
						<td colspan="3"><input type="text" class="inputTxt p100" name="notice_title" id="notice_title" /></td>
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
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
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
						<td colspan="3"><input type="text" class="inputTxt p100" name="file_notice_title" id="file_notice_title" /></td>
					</tr>
					<tr>
						<th scope="row">내용 <span class="font_red">*</span></th>
						<td colspan="3">
							<textarea id="file_notice_cont" name="file_notice_cont"> </textarea>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<input type="file" id="upfile"  name="upfile"  onchange="javascript:preview(event)" />
						</td>
						<td colspan=2>
							<div id="previewdiv" ></div>
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