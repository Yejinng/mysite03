<%@ page contentType="text/html;charset=UTF-8" %>
	  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<%
	pageContext.setAttribute("newLine", "\n");     
%>
<!doctype html>
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath }/assets/css/guestbook.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
var isEnd = false;
var page = 0;
var render = function( vo, where ) {
	//
	//현업에서는 이부분을 template library ex) ejs
	//
					var htmls=
						"<li id='gb-" + vo.no + "'>" +
						"<strong>" + vo.name + "</strong>" +
						"<p>" + vo.content + "</p>" +
						"<strong>" + vo.regDate + "</strong>" +
						"<a href=''>삭제</a>" +
						"</li>";
						/* "<li id='gb-" + vo.no + "'>  <table> <tr>" +
						"<td>" + vo.name + "</td>" +
						"<td>" + vo.regDate + "</td>" +
						"<td><a href=''>삭제</a></td>" +
					"</tr>" +
					"<tr> <td colspan='4'>" + vo.content + "</td> </tr>" +
				"</table>" +
				"</li>" */
				if(where == "append") {
					$("#list-guestbook").append(htmls);
				} else {
					$("#list-guestbook").prepend(htmls);
				}
}

var fetchList = function() {
		if(isEnd == true) {
			return;
		}
		++page;
		$.ajax({
			url: "${pageContext.request.contextPath }/api/guestbook?a=ajax-list&p=" + page,
			type: "get",
			dataType: "json",
			data: "",
			success: function(response) {		// response.result = "success" or "fail"
												// response.data = [{},{},{}....]
				if(response.result != "success"){
					console.error(response.message);
					isEnd = true;
					return;
				}
				//rendering
				$(response.data).each(function(index, vo){
					render( vo, "append" );
				});
				if(response.data.length < 5) {
					isEnd = true;
					$("#btn-fetch").prop("disabled", true);
				}
			},
			error: function(jqXHR, status, e) {
				console.error(status + ":" + e);
			}
		});
}

$(function(){
			$(".errorMsg").hide();
			var $no = null;
			//삭제버튼 click event
			$(document).on("click","#list-guestbook li a", function( event ){
				event.preventDefault();
				$no= $(this).parent().attr("id");
				dialog.dialog( "open" );
				
			});
			
			var deleteGuestbook = function(){
				
			      if($("#password").val() == "") {
			    	    $(".errorMsg").show();
						$(".errorMsg").html("<font color=blue><strong>비밀번호를 입력하세요.</strong></font>");
			    	  return;
			      }
			      
				no = $no.replace("gb-","");
				$.ajax({
					url: "${pageContext.request.contextPath }/api/guestbook",
					type: "post",
					dataType: "json",
					data: "a=ajax-delete&no=" + no +"&password=" + $("#password").val() ,
					success: function(response) {		// response.result = "success" or "fail"
														// response.data = [{},{},{}....]
						if(response.result != "success"){
							console.error(response.message);
							$(".errorMsg").show();
							$(".errorMsg").html("<font color=red><strong>비밀번호가 일치하지 않습니다.</strong></font>");
							isEnd = true;
							$("#password").val("").focus();
							return;
						}
						console.log(response.data);
						$("#gb-" + response.data).remove();
						dialog.dialog( "close" );
					},
					error: function(jqXHR, status, e) {
						console.error(status + ":" + e);
					}
				});
			};
			dialog = $( "#dialog-form" ).dialog({
			      autoOpen: false,
			      height: 400,
			      width: 350,
			      modal: true,
			      buttons: {
			    	  
			        "삭제하기": deleteGuestbook,
			        Cancel: function() {
			          dialog.dialog( "close" );
			        }
			      },
			      close: function() {
   			       	  form[ 0 ].reset();
			          $(".errorMsg").hide();
			       // allFields.removeClass( "ui-state-error" );
			      }
			    });
			 
			    form = dialog.find( "form" ).on( "submit", function( event ) {
				      event.preventDefault();
				      //addUser();
			      deleteGuestbook();
			    }); 
			
			$("#add-form").submit( function(event) {
				event.preventDefault();
				//ajax insert
				var name = $("#addname").val();
				if( name == "") {
					alert("이름을 입력해주세요");
					return;
				}
				var password = $("#addpassword").val();
				if( password == "") {
					alert("비밀번호를 입력해주세요");
					return;
				}
				var content = $("#addcontent").val();
				if( content == "") {
					alert("내용을 입력해주세요");
					return;
				}
			
				$.ajax({
					url: "${pageContext.request.contextPath }/api/guestbook",
					type: "post",
					dataType: "json",
					data: "a=ajax-add&name=" + name +"&pass=" + password + "&content=" + content,
					success: function(response) {		// response.result = "success" or "fail"
														// response.data = [{},{},{}....]
						if(response.result != "success"){
							console.error(response.message);
							isEnd = true;
							return;
						}
						console.log(response.data);
						render( response.data, "prepend" );
					},
					error: function(jqXHR, status, e) {
						console.error(status + ":" + e);
					}
				});
			});
			
			$(window).scroll(function(){
				var $window = $(this);
				var scrollTop = $window.scrollTop();
				var windowHeight = $window.height();
				var documentHeight = $(document).height();
				
			//스크롤바가 바닥까지 왔을때 ( 20px 덜왔을때 )
				if(scrollTop + windowHeight + 10 > documentHeight ) {
					//console.log("call fetchList");
					fetchList();
				}
			});
			
		//1번째 리스트 가져오기
		fetchList();
		
});

</script>
</head>
<body>
	<div id="dialog-form" title="삭제">
  <p class="validateTips">비밀번호를 입력하세요</p>
 	<p class="errorMsg"></p>
  <form>
    <fieldset>
      <label for="password">비밀번호</label>
      <input type="password" name="password" id="password" value="" >
 
      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>
</div>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<div id="content">
			<div id="guestbook">
				<form id="add-form" action="${pageContext.request.contextPath }/api/guestbook" method="post">
					<table>
						<tr>
							<td>이름</td><td><input type="text" name="addname" id="addname"></td>
							<td>비밀번호</td><td><input type="password" name="addpassword" id="addpassword"></td>
						</tr>
						<tr>
							<td colspan=4><textarea name="addcontent" id="addcontent"></textarea></td>
						</tr>
						<tr>
							<td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
						</tr>
					</table>
				</form>
				<ul id="list-guestbook"></ul>
				<button style="margin-top:20px" id="btn-fetch">가져오기</button>
			</div>
		</div>
		
		<c:import url="/WEB-INF/views/includes/navigation.jsp">
			<c:param name="menu" value="guestbook-ajax"></c:param></c:import>
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		</div>
</body>
</html>