<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${saleMonthSearchList}" var="list">
									<tr>
										<td>${list.order_month}</td>
										<td>${list.total_order_dt_amt}</td>
										<td>${list.total_order_tot_price}</td>
										<td>${list.total_product_unit_price}</td>
										<td>${list.product_name}</td>
										<td>${list.net_profit}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>