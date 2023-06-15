<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${accmanagementsearchlist}" var="list">
									<tr>
<%-- 										<td>${list.splr_no}</td>
										<td><a href="javascript:fn_selectone('${list.splr_no}')">${list.splr_name}</a></td>
 --%>								
 
 										<td>${list.accmanagement_indst_no}</td>
										<td>${list.accmanagement_add} ${list.splr_add_dt}</td>
										<td>${list.accmanagement_tel}</td>
										<td>${list.accmanagement_acnt_dt_sbjct_inout}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>