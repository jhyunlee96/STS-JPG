<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="java.io.File" %> 
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="bbs.Bbs" %>    
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
		int bbsID = 0;
		if (request.getParameter("bbsID") !=null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,11)+ bbs.getBbsDate().substring(11,13)+ "시"
						+ bbs.getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;")
						.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td colspan="2" style="text-align: left;">
						<%
						//파일 다운로드 설정
						String directory = application.getRealPath("/upload/"+bbsID+"/");
						
						File targetDir = new File(directory);
						if(!targetDir.exists()){
							targetDir.mkdirs();
						}
						
						String files[] = new File(directory).list();
						
						for(String file : files){
							
							out.write("<a href=\"" + request.getContextPath() + "/downloadAction?bbsID=" + bbsID + "&file="
							+java.net.URLEncoder.encode(file,"UTF-8") + "\">" + file + "</a><br>");
							
						}
						%>
						</td>
					</tr>
				</tbody>
			</table>
			<%
				if(userID !=null && userID.equals(bbs.getUserID())){
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제 하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			<a href="bbs.jsp" class="btn btn-primary pull-right">목록</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>