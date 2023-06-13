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
  <c:forEach items="${empSearchList}" var="list">
    <tr>
      <td>${list.loginId}</td>
      <td><a href="javascript:fn_selectone('${list.loginId}')">${list.name}</a></td>
      <td>${list.dept_cd}</td>
      <td>${list.dept_cd}
      <select id="deptcd" name="deptcd">
        <option value="" >전체</option>
        <option value="100" >관리자</option>
        <option value="200" >임원직</option>
        <option value="300" >회계팀</option>
        <option value="400" >영업팀</option>
        <option value="500" >인사팀</option>
      </select>
      </td>
      <td>${list.level_cd}
        <select id="lvcd" name="lvcd">
          <option value="" >전체</option>
          <option value="10" >사원</option>
          <option value="20" >주임</option>
          <option value="30" >대리</option>
          <option value="40" >과장</option>
          <option value="50" >부장</option>
          <option value="60" >상무</option>
          <option value="70" >전무</option>
          <option value="80" >이사</option>
          <option value="90" >대표</option>
        </select>
      </td>
      <td>${list.emp_sdate}</td>
      <td>${list.notice_del_yn}</td>
    </tr>
  </c:forEach>
</c:if>

<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>