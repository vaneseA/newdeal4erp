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
    <c:forEach items="${productSearchList}" var="list">
        <tr>
            <td>${list.product_no}</td>

                <td>
                    <select id="proLgCd" name="proLgCd">
                        <option value="" >전체</option>
                        <option value="9005" <c:if test ="${list.pro_lg_cd eq '9005'}">selected="selected"</c:if>>그래픽카드</option>
                        <option value="9001" <c:if test ="${list.pro_lg_cd eq '9001'}">selected="selected"</c:if>>메인보드</option>

                    </select>
                </td>

            <td>
                <select id="proMgCd" name="proMgCd">
                    <option value="" >전체</option>
                    <option value="8005" <c:if test ="${list.pro_md_cd eq '8005'}">selected="selected"</c:if>>삼성</option>
                    <option value="8001" <c:if test ="${list.pro_md_cd eq '8001'}">selected="selected"</c:if>>LG</option>

                </select>
            </td>
            --%>

            <td><a href="javascript:fn_selectOne('${list.product_no}')">${list.pro_sm_cd}</a></td>
            <td>${list.product_serial}</td>
            <td>${list.product_unit_price}</td>
            <td>${list.product_price}</td>



        </tr>
    </c:forEach>
</c:if>

<input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt}"/>