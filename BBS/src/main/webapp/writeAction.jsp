<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		
		//파일업로드 설정
		BbsDAO bbsDAO = new BbsDAO();

		bbs.setBbsID(bbsDAO.getNext());
		int bbsID = bbs.getBbsID();
		String directory = application.getRealPath("/upload/"+bbsID+"/");
		
		File targetDir = new File(directory);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		int maxSize = 1024*1024*100;
		String encoding = "UTF-8";
		
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		
		MultipartRequest multipartRequest = new MultipartRequest(request,directory,maxSize,encoding,policy);
		
		String bbsTitle = multipartRequest.getParameter("bbsTitle");
		String bbsContent = multipartRequest.getParameter("bbsContent");
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");

		bbs.setBbsTitle(bbsTitle);
		bbs.setBbsContent(bbsContent);
	

			if (userID ==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 후 이용해주세요')");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			} else {
				if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('임력이 안 된 사항이 있습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {

					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), fileName, fileRealName);
					if (result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('성공적으로 글을 등록했습니다')");
						script.println("location.href = 'bbs.jsp'");
						script.println("</script>");
					}
				}
			}

	%>
</body>
</html>