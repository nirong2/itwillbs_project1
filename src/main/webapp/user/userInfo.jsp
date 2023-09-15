<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/userInfo.css">
</head>
<body>
<c:if test="${empty sessionScope.user_id}">
	<script>
		alert('로그인 해주세요.');
		location.href='./UserLogin.me';
	</script>
</c:if>
<header>
	<jsp:include page="/inc/topBar.jsp"></jsp:include>
</header>
<!--center -------------------------------------------------------------  -->
<main>
	<h1>${sessionScope.user_id } 님 환영합니다</h1>
	<div id="container">
		<input id="btn1" type="button" value="예매/취소내역"	onclick="">
		<input id="btn2" type="button" value="회원정보수정"	onclick="./UserInfoCheck.me">
		
	</div>
	<form action="./UserInfoChangeAction.me" method="post">
	<div id="userInfo_box">
			<fieldset id="userInfo_wrap">
				<label>이름 </label> <br><input type="text" name="user_name" value="${userInfo.user_name }" placeholder="이름입력"> <br>
				<p id='hiddenMsgName'></p>
				<label>전화번호 </label><br> <input type="text" name="user_phone" value="${userInfo.user_phone }" placeholder="-없이 휴대폰 번호 입력"> <br> 
				<p id='hiddenMsgPhone'></p>
				<label>아이디 </label><br><input type="text" name="user_id" value="${userInfo.user_id }" readonly> 
				<p id='chId'></p>
				<input type="hidden" id="isCheckId" value="false">
				<label>비밀번호 </label><br> <input type="password" name="user_pass" placeholder="비밀번호 입력"> <br>
				<p id='hiddenMsgPw'></p>
				 <label>비밀번호 확인 </label><br> <input type="password" name="user_chpw" placeholder="비밀번호 입력 확인"> <br> 
				<p id='hiddenMsgPwCheck'></p>
				
				 <input type="hidden"name="isCertification"> 
				 <input type="submit" value="정보 수정"	onclick="return check()">
				 <input type="button" value="회원 탈퇴" onclick="location.href='./UserDelete.me'">
			</fieldset>
	</div>
	</form>


	<!-- <table id="table">
		<tr>
			<td><h5>No.</h5></td>		
			<td>예매번호</td>		
			<td>영화이름</td>		
			<td>예매날짜</td>		
			<td>차 번호</td>		
			<td>상태</td>		
			<td>상세내역</td>		
		</tr>
		<tr>
			<td>1</td>		
			<td>123123</td>		
			<td>오팬하이머</td>		
			<td>2023.05.05</td>		
			<td>12소5455</td>		
			<td>결제완료</td>		
			<td>상세내역</td>		
		</tr>
		<tr>
			<td>1</td>		
			<td>123123</td>		
			<td>오팬하이머</td>		
			<td>2023.05.05</td>		
			<td>12소5455</td>		
			<td>결제완료</td>		
			<td>상세내역</td>		
		</tr>
		
	</table> -->

</main>
<!--center end-------------------------------------------------------------  -->
<footer>
	<jsp:include page="/inc/bottomBar.jsp"></jsp:include>
</footer>

<script type="text/javascript">
//입력값 공백 및 비밀번호 일치확인 및 인증체크
	function check() {
	//		var str = "";
		let reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		let phoneRule = /^(01[016789]{1})[0-9]{4}[0-9]{4}$/;
		
		/* 이름 유효성 검사 */
		if ($('input[name="user_name"]').val().length == 0) {
			$("#hiddenMsgName").text("이름을 입력하세요.");
			$("#hiddenMsgName").css('color', 'red');
			$('input[name="user_name"]').focus();
			return false;
		}else{
			$("#hiddenMsgName").text("");
		}
	
		/* 휴대폰번호 유효성 검사 */
		if ($('input[name="user_phone"]').val().length == 0) {
			$("#hiddenMsgPhone").text("전화번호를 입력하세요.");
			$("#hiddenMsgPhone").css('color', 'red');
			$('input[name="user_phone"]').focus();
			return false;
		}else if(phoneRule.test($('input[name="user_phone"]').val()) === false){
			$("#hiddenMsgPhone").text("-없이 올바르게 입력하세요.");
			$("#hiddenMsgPhone").css('color', 'red');
			return false;
		}else{
			$("#hiddenMsgPhone").text("");
		}
	
		/* 비밀번호 및 비밀번호 확인 유효성 검사 */
		if ($('input[name="user_pass"]').val().length == 0) {
			$("#hiddenMsgPw").text("비밀번호를 입력해 주세요.");
			$("#hiddenMsgPw").css('color', 'red');
			$('input[name="user_pass"]').focus();
			return false;
		}else if(reg.test($('input[name="user_pass"]').val()) === false) {
			$("#hiddenMsgPw").text("비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.");
			$("#hiddenMsgPw").css('color', 'red');
			return false;
		}else{
			$("#hiddenMsgPw").text("");
		}
	
		if ($('input[name="user_chpw"]').val().length == 0) {
			$("#hiddenMsgPwCheck").text("비밀번호 확인을 입력해주세요.");
			$("#hiddenMsgPwCheck").css('color', 'red');
			$('input[name="user_chpw"]').focus();
			return false;
		}else{
			$("#hiddenMsgPwCheck").text("");
		}
	
		if ($('input[name="user_pass"]').val() != $('input[name="user_chpw"]').val()) {
			$("#hiddenMsgPw").text("비밀번호가 일치하지 않습니다.");
			$("#hiddenMsgPw").css('color', 'red');
			$('input[name="user_pass"]').select(); 
			return false;
		}
	
	}
</script>


</body>
</html>