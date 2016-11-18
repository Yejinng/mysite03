<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath }/assets/css/user.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(function(){
	$("#join-form").submit(function(){
		// 1. 이름이 비어있는지 체크
		if($("#name").val() == "") {
			$("#dialog p").text("이름을 입력해주세요!");
			$("#dialog").dialog();
			$("#name").focus();
			return false;
		}
		// 2.이메일 
		if($("#email").val() == "") {
			$("#dialog p").text("이메일을 입력해주세요!");
			$("#dialog").dialog();
			$("#email").focus();
			return false;
		}
		// 2-2 이메일 중복 체크유무
		if($("#img_chkemail").is(":visible") == false ) {
			$("#dialog p").text("이메일 중복체크를 해주세요!");
			$("#dialog").dialog();
			return false;
		}
		if($("input[type='password']").val() == "") {
			$("#dialog p").text("비밀번호를 입력해주세요!");
			$("#dialog").dialog();
			$("input[type='password']").focus();
			return false;
		}
		if($("#agree-prov").is(":checked") == false ) {
			$("#dialog p").text("약관동의를 해주세요!");
			$("#dialog").dialog();
			return false;
		}
		return true;
	})
	$("#email").change(function(){
		$("#img_chkemail").hide();
		$("#btn_chkemail").show();
	})
	$("#btn_chkemail").click(function(){
		var email = $("#email").val();
		if( email == "") {
			return;
		}
		$.ajax({
			url:"${pageContext.request.contextPath }/api/user?a=chkemail&email=" + email,
			type:"get",
			dataType:"json",
			data:"",
			success: function(response){
				console.log(response);
				if( response.result == "fail"){
					console.log(response.message);
					return;
				}
				//success
				if( response.data == "exist") {
					alert("이미 존재하는 이메일입니다. 다른 이메일을 입력해주세요");
					$("#email").val("").focus();
					return;
				}
				//존재하지 않는 이메일
				$("#img_chkemail").show();
				$("#btn_chkemail").hide();
			},
			error: function(jqXHR, status, e) {
				console.error(status + ":" + e);
			}
		});
	});
	
});
</script>
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<div id="content">
			<div id="user">

				<form id="join-form" name="joinForm" method="post" action="${pageContext.request.contextPath }/user">
					<input type="hidden" name="a" value="join">
					<label class="block-label" for="name">이름</label>
					<input id="name" name="name" type="text" value="">

					<label class="block-label" for="email">이메일</label>
					<input id="email" name="email" type="text" value="">
					<img id="img_chkemail" style="width: 14px; display:none" src="${pageContext.request.contextPath }/assets/images/button-check.png"/>
					<input id="btn_chkemail" type="button" value="중복체크">
					
					<label class="block-label">패스워드</label>
					<input name="password" type="password" value="">
					
					<fieldset>
						<legend>성별</legend>
						<label>여</label> <input type="radio" name="gender" value="female" checked="checked">
						<label>남</label> <input type="radio" name="gender" value="male">
					</fieldset>
					
					<fieldset>
						<legend>약관동의</legend>
						<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
						<label>서비스 약관에 동의합니다.</label>
					</fieldset>
					
					<input type="submit" value="가입하기">
					
				</form>
		</div>
	</div>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
	<div id="dialog" title="" style="display:none">
	  <p></p>
	</div>
</body>

</html>