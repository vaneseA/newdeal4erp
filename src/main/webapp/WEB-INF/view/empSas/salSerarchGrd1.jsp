<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						
						
							<c:if test="${totalcount eq 0}">
								<tr>
									<td colspan="3">데이터가 없습니다</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcount eq 1 }">
								<tr>
									<td>${empSasSearchList1.list1[0]}</td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_kuk_com}" type="number" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_kuk_emp}" type="number" pattern="#,###" /></td>
								</tr>
								<tr>
									<td>${empSasSearchList1.list1[1]}</td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_kun_com}" type="number" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_kun_emp}" type="number" pattern="#,###" /></td>
								</tr>
								<tr>
									<td>${empSasSearchList1.list1[2]}</td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_ko_com}" type="number" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_ko_emp}" type="number" pattern="#,###" /></td>
								</tr>
								<tr>
									<td>${empSasSearchList1.list1[3]}</td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_san_com}" type="number" pattern="#,###" /></td>
									<td><fmt:formatNumber value="${empSasSearchList1.sal_san_emp}" type="number" pattern="#,###" /></td>
								</tr>
									
							</c:if>
						</div>	
						
						
						
						