<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
			var select = "<option value='start' class ='start1'>선택하세요</option>";
			$.ajax({
				url : "./CinemaSelectAction.bo",
				dataType : "json",
				success : function(data){
					
					$.each(data,function(idx,item){
						$('#region_name').append("<option value="+item.region+">"+item.region+"</option>");
					});//each
					
					$('#region_name').change(data,function(){
						$("#cinema_name").empty();
						var re = $("select#region_name option:checked").val();

						$.each(data,function(idx,item){
							if(item.region == re){
								var list = item.cinema_list.split(",");
								console.log(list);
								for(var i = 0; i < list.length; i++){
								$("#cinema_name").append("<option value="+list[i]+">"+list[i]+"</option>");
								}//for
							}//if
							});//each	
						});//change
				}//success
			});//ajax 끝
	}); //JQuery 끝 

	</script>
</head>
<body>
<!-- 상단 바 고정 -->
<header>
	<jsp:include page="/inc/topBar.jsp"></jsp:include>
</header>
<!-- 상단 바 고정 -->

	<h1>대관문의 작성 test</h1>
	
	<form action="./rentWriteAction.bo" method="post" name ="form">
<table id="notice">
	 <tr>
		<td > 아이디 : </td> 
	    <td colspan="2">
	    	<input type="text" id="wInput" name="ruser_id">
	    </td>
    </tr>
	<tr>
		<td > 이름(기업명) : </td> 
	    <td colspan="2">
	    	<input type="text" id="wInput" name="rname">
	    </td>
    </tr>
	<tr>
		<td > 극장선택 : </td> 
	    <td colspan="2">
	    	<select name = "region" id ="region_name">
	    	<option value="start" class ="start">선택하세요</option>
	    	</select>
	    	<select name = "cinema" id ="cinema_name">
	    	<option value="start" class ="start1">선택하세요</option>
	    	</select>
	    </td>
    </tr>
	<tr>
		<td > 휴대폰 번호 : </td> 
	    <td colspan="2">
	    	<input type="text" id="wInput" name="rphone">
	    </td>
    </tr>
	<tr>
		<td > 이메일 : </td> 
	    <td colspan="2">
	    	<input type="text" id="wInput" name="remail">
	    </td>
    </tr>
    <tr>
		<td> 제 목 : </td>
	    <td colspan="2">
	   		<input type="text" id="wInput" name="rsubject">
	    </td>
    </tr>
    <tr>
		<td> 내 용 : </td>
	    <td colspan="2">
	    	<textarea rows="" cols="" id="wInput" name="rcontent"
		    	></textarea>
	    </td>
    </tr>
</table>

	<div id="table_search">
		<input type="submit" value="글쓰기" class="btn">
	</div>
		<div class="clear"></div>
	<div id="page_control">
	
	</div>
</form>
	
<!-- 하단바 고정  -->
<footer>
	<jsp:include page="/inc/bottomBar.jsp"></jsp:include>
</footer>
<!-- 하단바 고정  -->

</body>
</html>