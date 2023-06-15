<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>계정과목 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- 우편번호 조회 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
                              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;     
	var pageBlockSize = 5;    
	
	
	
	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fn_accmanagementlist();
		
		// combo box 종류  acc : 회계 계정     조회 대상 테이블  tb_acnt_sbject   
		selectComCombo("acc","acccombo","all","","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "", "" 
		
		// combo box 종류  accd : 상세 회계계정   acccombo 변경시 계정 상세 재조회 event   조회 대상 테이블  tb_dt_sbject   
		$('#acccombo').change(function() {   
			selectComCombo("accd","accdcombo","all",$('#acccombo').val(),"");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , 선택된 상위 계정코드, "" 
		});
	
	});
	/** 버튼 이벤트 등록 */
	
	function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
        e.preventDefault();

        var btnId = $(this).attr('id');

        switch (btnId) {
	        case 'btnSearch' :
	            fn_accmanagementlist();
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
	
	
	function fn_accmanagementlist(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
			searchKey : $("#searchKey").val()
		  ,	sname : $("#sname").val()
		  , pageSize : pageSize
		  , pageBlockSize : pageBlockSize
		  , pagenum : pagenum
		}
		
		var listcallback = function(returnvalue) {
			console.log(returnvalue);
			
			$("#listsplr").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_accmanagementlist');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#splrPagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
		}
		
		callAjax("/accAcm/accmanagementlist.do", "post", "text", false, param, listcallback) ;
			
	}
	
	
	function fn_openpopup() {
		
		popupinit();
		
		// 모달 팝업
		gfModalPop("#layer1");
					
	}
	
	
	function popupinit(object) {
		
	    if(object == "" || object == null || object == undefined) {
	    	$("#acccombo").val("");
	    	$("#acnt_sbject_name").val("");
	    	$("#accdcombo").val("");
	    	$("#acnt_dt_sbjct_name").val("");
	    	$("#acnt_dt_sbjct_inout").val("");



	        $("#btnDelete").hide();

	        // object 가 없는 상태로 팝업 뜰 땐, action 을 “I” 로 설정하여  INSERT
	        $("#action").val("I");	
	    } else {

	        $("#acccombo").val("object_sbject_cd");
	        $("#acnt_sbject_name").val("object_acnt_sbject_name");
	        $("#accdcombo").val("object_acnt_dt_sbjct_cd");
	        $("#acnt_dt_sbjct_name").val("object_acnt_dt_sbjct_name");
	        $("#acnt_dt_sbjct_inout").val("object_acnt_dt_sbjct_inout");

	        $("#btnDelete").show();

	        // object 가 있는 상태로 팝업 뜰 땐, action 을 “U” 로 설정하여  UPDATE
	        $("#action").val("U");	
	    }
	}
	
	
	function fn_selectone(no) {
		
	    var param = {
	        splr_no : no
	    }

	    var selectoncallback = function(returndata) {			
	        
	        console.log( JSON.stringify(returndata) );

	        popupinit(returndata.splrsearch);

	        // 모달 팝업
	        gfModalPop("#layer1");

	    }

	    callAjax("/accAcm/accmanagementselectone.do", "post", "json", false, param, selectoncallback) ;

	}
	
	
	function fn_save() {
		
		// 비어있는 값으로 저장되지 않도록 유효성 검사
	    if ( ! fn_Validate() ) {
	        return;
	    }

	    var savecallback = function(reval) {
	        console.log( JSON.stringify(reval) );

	        if(reval.returncval > 0) {
	            alert("저장 되었습니다.");
	            gfCloseModal();

	            if($("#action").val() == "U") {
	                fn_accmanagementlist($("#pageno").val());
	            } else {
	                fn_accmanagementlist();
	            }
	        }  else {
	            alert("오류가 발생 되었습니다.");				
	        }
	    }

	    callAjax("/accAcm/accmanagementsave.do", "post", "json", false, $("#myForm").serialize(), savecallback) ;

	}
	
	
	function fn_Validate() {
		var chk = checkNotEmpty(
				[
						[ "acnt_sbject_cd", "계정과목코드입력." ]
					,	[ ",acnt_sbject_name", "계정과목이름입력." ]
					,	[ ",acnt_dt_sbject_cd", "계정과목상세코드입력." ]
					,	[ ",acnt_dt_sbjct_name", "계정과목상세이름입력." ]
					,	[ ",acnt_dt_sbjct_inout", "수입지출." ]

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

 <form id="myForm" action=""  method="">
	<input type="hidden" id="action"  name="action"  />
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
								class="btn_nav bold">회계</span> <span class="btn_nav bold">계정과목
								관리</span> <a href="../busSpm/splrManagement.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>계정과목 관리</span> <span class="fr">
							 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						<!-- 검색창 영역 시작 -->
						<div style="display:flex; justify-content:center; align-content:center; border:1px solid DeepSkyBlue; padding:40px 40px; margin-bottom: 8px;">
							<select id="searchKey" name="searchKey" style="width:150px; margin-right:5px;" >
						        <option value="" >검색조건</option>
								<option value="sp_name" >기업명</option>
								<option value="sp_indst_no" >사업자등록번호</option>
							</select> 
							<select id="searchKey" name="searchKey" style="width:150px; margin-right:5px;" >
						        <option value="" >검색조건</option>
								<option value="sp_name" >기업명</option>
								<option value="sp_indst_no" >사업자등록번호</option>
							</select>
							 
							<input type="text" style="width:300px; height:28px; margin-right:5px;" id="sname" name="sname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
						</div>
						<!-- 검색창 영역 끝 -->
						
						<div class="noticeList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="27%">
									<col width="15%">
									<col width="27%">
									<col width="16%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">계정 대분류코드</th>
										<th scope="col">계정 대분류명</th>
										<th scope="col">계정 상세코드</th>
										<th scope="col">계정 상세명</th>
										<th scope="col">구분</th>
										
									</tr>
								</thead>
								<tbody id="listaccmanagement"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="accmanagementPagination"> </div>
						
                     
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
				<strong>계정과목 등록</strong>
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
							<th scope="row">기업명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_name" id="splr_name" /></td>
							<th scope="row">회사 전화 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_tel" id="splr_tel" /></td>
						</tr>
						<tr>
							<th scope="row">담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_mng" id="splr_mng" /></td>
							<th scope="row">담당자 연락처 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_hp" id="splr_hp" /></td>
						</tr>
						<tr>
							<th scope="row">우편번호 <span class="font_red">*</span></th>
							<td colspan="3">
								<div style="display:flex; flex-direction:row;">
									<input type="text" class="inputTxt p100" name="splr_zip" id="splr_zip" />
									<input type="button" value="우편번호 찾기"
									       onclick="execDaumPostcode()" style="margin-left:5px; width:130px; height:30px;" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">주소 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_add" id="splr_add" /></td>
						</tr>
						<tr>
							<th scope="row">상세주소 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_add_dt" id="splr_add_dt" /></td>
						</tr>
						<tr>
							<th scope="row">회사 이메일 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_email" id="splr_email" /></td>
						</tr>
						<tr>
							<th scope="row">업종 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_indst" id="splr_indst" /></td>
						</tr>
						<tr>
							<th scope="row">사업자등록번호 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_indst_no" id="splr_indst_no" /></td>
						</tr>
						<tr>
							<th scope="row">계좌번호 <span class="font_red">*</span></th>
							<td colspan="3">
								<div style="display:flex; flex-direction:row;">
									<select id="bkcombo" name="bkcombo" style="margin-right:5px;"></select>
									<input type="text" class="inputTxt p100" name="splr_acc" id="splr_acc" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">메모 </th>
							<td colspan="3">
							    <textarea id="splr_memo" name="splr_memo"> </textarea>
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
							<th scope="row">그룹 코드 ID <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_grp_cod" name="dtl_grp_cod" /></td>
							<th scope="row">그룹 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_grp_cod_nm" name="dtl_grp_cod_nm" /></td>
						</tr>
						<tr>
							<th scope="row">상세 코드 ID <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_cod" name="dtl_cod" /></td>
							<th scope="row">상세 코드 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_cod_nm" name="dtl_cod_nm" /></td>
						</tr>
						
						<tr>
							<th scope="row">코드 설명</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="dtl_cod_eplti" name="dtl_cod_eplti" /></td>
						</tr>
					
						<tr>
							<th scope="row">사용 유무 <span class="font_red">*</span></th>
							<td colspan="3"><input type="radio" id="dtl_use_poa_1"
								name="dtl_use_poa" value="Y" /> <label for="radio1-1">사용</label>
								&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" id="dtl_use_poa_2"
								name="dtl_use_poa" value="N" /> <label for="radio1-2">미사용</label></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveDtlCod" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnDeleteDtlCod" name="btn"><span>삭제</span></a>  
					<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!--// 모달팝업 --> 
</form>--%>
</body>
</html>
	