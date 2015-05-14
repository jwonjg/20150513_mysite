<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="/mysite/assets/css/guestbook.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<div id="header">
			<jsp:include page="/views/include/header.jsp" flush="false"/>
		</div>
		<div id="content">
			<div id="guestbook">
				<table>
					<tr>
						<td>제목</td><td>${ requestScope.board.title }</td>
					</tr>
					<tr>
						<td>작성자</td><td>${ requestScope.board.userName }</td>
					</tr>
					<tr>
						<td>작성일</td><td>${ requestScope.board.regDate }</td>
					</tr>
					<tr>
						<td colspan=2>${ requestScope.board.content }</td>
					</tr>
					<c:choose>
					<c:when test="${ requestScope.board.userNo eq sessionScope.authUser.no }">
					<tr>
						<td colspan=4 align=right>
							<form action="board" method="post">
								<input type="submit" value="수정">
								<input type="hidden" name="a" value="updateForm">
								<input type="hidden" name="boardNo" value="${ requestScope.board.no }">
							</form>
							<form action="board" method="post">
								<input type="submit" value="삭제">
								<input type="hidden" name="a" value="delete">
								<input type="hidden" name="no" value="${ requestScope.board.no }">
							</form>
						</td>
					</tr>
					</c:when>
					</c:choose>
				</table>
				<ul>
					<li>
						<c:if test="${ not empty sessionScope.authUser }">
							<form action="board" method="post">
								<input type="hidden" name="a" value="comment">
								<input type="hidden" name="boardNo" value="${ requestScope.board.no }">
								<table>
									<tr>
										<td>댓글</td>
										<td>
											<input type="text" name="content">
											<input type="submit" value="등록">
										</td>
									</tr>
								</table>
							</form>
						</c:if>
						<br>
						<c:if test="${ not empty requestScope.commentList }">
							<table>
							<c:forEach var="item" items="${ requestScope.commentList }">
								<tr>
									<td>[${ pageScope.item.orderNo}]</td>
									<td>${ pageScope.item.content }</td>
									<td>${ pageScope.item.userName }</td>
									<c:choose>
										<c:when test="${ pageScope.item.userNo eq sessionScope.authUser.no }">
											<td>${ pageScope.item.regDate}</td>
											<td>
											<form action="board" method="post">
												<input type="hidden" name="a" value="deleteComment">
												<input type="hidden" name="boardNo" value="${ pageScope.item.boardNo }">
												<input type="hidden" name="no" value="${ pageScope.item.no }">
												<input type="submit" value="삭제">
											</form>
											</td>
										</c:when>
										<c:otherwise>
											<td colspan="2">${ pageScope.item.regDate}</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
							</table>
							<br>
						</c:if>
					</li>
				</ul>
			</div>
		</div>
		<div id="navigation">
			<c:import url="/views/include/navigation.jsp">
				<c:param name="type" value="board"></c:param>
			</c:import>
		</div>
		<div id="footer">
			<p>(c)opyright 2014 </p>
		</div>
	</div>
</body>
</html>