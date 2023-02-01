<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="bbs.Bbs" %> 
<%@ page import="java.util.ArrayList" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
	 	String userID = null;
		if (session.getAttribute("userID") !=null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if ( request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="main.jsp">게시판 테스트 사이트</a>
		</div>
		<div class="collaps navbar-collapse" id="bs-example-navbar-collapse-1">

			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="login.jsp">로그인</a></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					 data-toggle="dropdown" role="button" aria-haspopup="true"
					 aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="userUpdate.jsp">회원정보</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" name="search" action="searchbbs.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="bbsTitle">제목</option>
								<option value="userID">작성자</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	<br>
	
	<div class="container">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getSearch(request.getParameter("searchField"),	request.getParameter("searchText"));
					if (list.size() == 0) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('검색결과가 없습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i).getBbsID()%></td>
					<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
					<td><%=list.get(i).getUserID()%></td>
					<td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
					+ list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		<div class=container style="text-align: center">
			<%
				if(pageNumber !=1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber -1 %>">◀ 이전</a>
			<%
				} 
			%>
			<%
				int n = (int) (bbsDAO.getCount() / 10 + 1);
				for (int i = 1; i <= n; i++) {
			%>
				<a href="bbs.jsp?pageNumber=<%=i%>">|<%=i%>|
				</a>
			<%
				}
			%>
			<%
				if(bbsDAO.nextPage(pageNumber+1)) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber +1 %>">다음 ▶</a>
			<%
				}
			%>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>