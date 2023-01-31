<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	 	String userID = null;
		if (session.getAttribute("userID") !=null){
			userID = (String) session.getAttribute("userID");
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
						<li><a href="logoutAction.jsp">회원정보</a></li>
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
		<div class="jumbotron">
			<div class="container">
				<h1>웹 취약점 진단 테스트</h1>
				<p>jsp 기반으로 만든 취약점 진단 테스트 사이트 입니다</p>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>