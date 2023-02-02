<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
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
		String userID=null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		User user=new UserDAO().getUser(userID);
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
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-3 col-sm-3"></div>
		<div class="col-lg-6 col-sm-6">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="userUpdateAction.jsp">
					<h3 style="text-align: center;">회원정보</h3>
					<div class="form-group">
						아이디: <input type="text" class="form-control" value=<%=user.getUserID()%> name="userID" maxlength="20" readonly>
					</div>
					<div class="form-group">
						패스워드 : <input type="password" class="form-control" placeholder="패스워드" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						이름 : <input type="text" class="form-control" placeholder="이름" value=<%=user.getUserName()%> name="userName" maxlength="20">
					</div>
					<div class="form-group"	style="text-align:center;">
						<div class="btn-group" data-toggle="buttons">
							<%
								if(user.getUserGender().equals("M")){
							%>
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete='off' value="M" checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete='off' value="F" checked>여자
							</label>
							<%
								} else {
							%>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete='off' value="M" checked>남자
							</label>
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete='off' value="F" checked>여자
							</label>
							<%
								}
							%>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" value=<%=user.getUserEmail()%> name="userEmail" maxlength="50">
					</div>
					<input type="submit" class="btn btn-primary pull-right" value="수정하기">
				</form>
	            <a onclick="return confirm('정말로 탈퇴 하시겠습니까?')" 
	            	href="userDeleteAction.jsp?userID=<%= userID %>" class="btn btn-danger">탈퇴하기</a>
			</div>
		</div>
		<div class="col-lg-3 col-sm-3"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>