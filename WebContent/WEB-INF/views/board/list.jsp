<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath }/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp" />
		<div id="content">
			<div id="board">
				<form id="search_form" action="" method="post">
					<input type="text" id="kwd" name="kwd" value="">
					<input type="submit" value="찾기">
				</form>
				<table class="tbl-ex">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>	
					<c:forEach items="${list }" var="vo" varStatus="status" >			
						<tr>
							<td>${totalCount - (currentPage - 1) * listSize - status.index }</td>
								<c:choose>
									<c:when test="${vo.depth >0 }">
										<td class="left" style="padding-left:${20*vo.depth}px">
											<img src="${pageContext.request.contextPath }/assets/images/reply.png">
											<a href="${pageContext.request.contextPath }/board?a=view&no=${vo.no}&p=${currentPage}">${vo.title }</a>
										</td>
									</c:when>
									<c:otherwise>
										<td class="left">
											<a href="${pageContext.request.contextPath }/board?a=view&no=${vo.no}&p=${currentPage}">${vo.title }</a>
										</td>
									</c:otherwise>
								</c:choose>
							<td>${vo.userName }</td>
							<td>${vo.hit }</td>
							<td>${vo.regDate }</td>
							<td>
								<c:choose>
									<c:when test = "${not empty authUser && authUser.no == vo.userNo}">
										<a href="${pageContext.request.contextPath }/board?a=delete&no=${vo.no}&p=${currentPage}" class="del">삭제</a>
									</c:when>
									<c:otherwise>
										&nbsp;
									</c:otherwise>
								</c:choose>
							</td>
						</tr>	
					</c:forEach>
				</table>
				<div class="pager">
					<ul>
						<c:choose>
						<c:when test="${currentBlock != 1 }">
						<li><a href="${pageContext.request.contextPath }/board?a=list&p=${prevPage}">◀</a></li>
						</c:when>
						<c:otherwise>
						<li>◀</li>
						</c:otherwise>
						</c:choose>
						<c:forEach begin="${startPage }" end="${endPage }" var="pageNo">
						<c:choose>
							<c:when test="${currentPage == pageNo }">
							<li class="selected">${pageNo }</li>
							</c:when>
							<c:otherwise>
								<c:choose>
								<c:when test="${pageCount >= pageNo }">
								<li><a href="${pageContext.request.contextPath }/board?a=list&p=${pageNo}">${pageNo }</a></li>
								</c:when>
								<c:otherwise>
								<li>${pageNo }</li>
								</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						</c:forEach>
						<c:choose>
						<c:when test="${currentBlock != totalBlock }">
						<li><a href="${pageContext.request.contextPath }/board?a=list&p=${nextPage}">▶</a></li>
						</c:when>
						<c:otherwise>
						<li>▶</li>
						</c:otherwise>
						</c:choose>
					</ul>
				</div>				
				<div class="bottom">
				<c:if test="${not empty authUser }">
					<a href="${pageContext.request.contextPath }/board?a=writeform" id="new-book">글쓰기</a>
				</c:if>
				</div>				
			</div>
		</div>
		<c:import url="/WEB-INF/views/includes/navigation.jsp">
			<c:param name="menu" value="board"/>
		</c:import>
		<c:import url="/WEB-INF/views/includes/footer.jsp" />
	</div>
</body>
</html>