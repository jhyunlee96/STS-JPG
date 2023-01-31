<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
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
		<ul class="nav navbar-nav navbar-right">
			<li><a href="bbs.jsp">게시판</a></li>
		</ul>
	</nav>
	<div class="container">
		<div class="col-lg-3 col-sm-3"></div>
		<div class="col-lg-6 col-sm-6">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align: center;">로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="패스워드" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary" value="로그인">
					<a href="join.jsp" class="btn btn-link">회원가입</a>
				</form>
			</div>
		</div>
		<div class="col-lg-3 col-sm-3"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>