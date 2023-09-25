<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@page import="com.team2.payment.db.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Off The Lamp</title>
<link href="./css/orderList.css" rel="stylesheet">
<link href="./css/footer.css" rel=stylesheet>
<script src="./js/code.jquery.com_jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	});
</script>
</head>
<body>
	<header>
		<jsp:include page="/inc/topBar.jsp"></jsp:include>
	</header>
	<main>
		<div id="body-wrapper">
		<div id="body-content">
		<section id="section">
		<div id="serchForm">
			<form action="./managerList.or">
			아이디<input type="text" name="idcheck">
				<input type="submit" value="검색" onclick="">
			</form>
		</div>
		
			<div id="orderBoard">
				<table class="table">
					<tr>
						<td>NO.</td>
						<td>예매번호</td>	
						<td>아이디</td>	
						<td>성명</td>	
						<td>영화이름</td>	
						<td>예매날짜</td>	
						<td>상세보기</td>				
					</tr>
			
			<c:set var ="listNum" value="-1" />
			<c:set var ="bno" value="${startRow -1 }" />
			<c:forEach var="i" begin="1" end="${olist.size() }" step="1">
				<tr>
					<td>${bno=bno+1 }</td>
					<td>${olist.get(i-1).order_id }</td>
					<td>${ulist.get(i-1).user_id }</td>
					<td>${ulist.get(i-1).user_name }</td>
					<td>${olist.get(i-1).movie_name }</td>
					<td>${olist.get(i-1).order_date }</td>
					<td id="openModalBtn${listNum=listNum+1 }" class="openModalBtn">상세내역</td>
				</tr>
			</c:forEach>
		</table>
		
					<div id="page_control">
							<c:if test="${startPage > pageBlock }">
								<a href="./managerList.or?pageNum=${startPage-pageBlock }&idcheck=${idcheck}">Prev</a>
							</c:if>
							
							<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
								<a href="./managerList.or?pageNum=${i}&idcheck=${idcheck}">${i }</a>
							</c:forEach>
							
							<c:if test="${endPage < pageCount }">
								<a href="./managerList.or?pageNum=${startPage+pageBlock }&idcheck=${idcheck}">Next</a>
							</c:if>
						</div>
					</div>
				</section>
				</div>
			</main>

<style>

    .modal {
      display: none;
      position: fixed;
      top: 150px;
      left: 340px;
      width: 650px;
      height: 450px;
      background-color: #eeeeee;
    }

    .modal-content {
      position: relative;
      margin: 10px;
      padding: 10px;
      background-color: #eeeeee;
      width: 600px;
      height: 400px;
      text-align: center;
      color: black;
    }


  </style>
</head>
<body>
  <div id="myModal" class="modal">
    <div class="modal-content">
      예매번호:<input type="text" id="idNum1" readonly>
       예매날짜:<input type="text" id="idNum2" readonly><br>
       성명:<input type="text"  value=""id="idNum3" readonly>
       영화이름:<input type="text" value=""id="idNum4" readonly><br>
       휴대폰번호:<input type="text" value=""id="idNum5" readonly>
       차번호:<input type="text" value=""id="idNum6" readonly><br>
       상영일:<input type="text" value=""id="idNum7" readonly><br>
       결제금액:<input type="text" value="" id="idNum8" readonly><br>
      <input type="button" value="확인" class="close" onclick="cancelPay()">
      <input type="button"  value="결제취소" >
    </div>
  </div>
  <script>
  var choice =0;
  var ojlist = JSON.parse('${requestScope.ojlist}');
  var ujlist = JSON.parse('${requestScope.ujlist}');
  var pjlist = JSON.parse('${requestScope.pjlist}');
  
  $('#openModalBtn0').click(function(){
     choice=0
  });
  $('#openModalBtn1').click(function(){
     choice=1
  });
  $('#openModalBtn2').click(function(){
     choice=2
  });
  $('#openModalBtn3').click(function(){
     choice=3
  });
  $('#openModalBtn4').click(function(){
     choice=4
  });
  
  $('td[id^="openModalBtn"]').click(function(){
	  console.log(choice);
   $('#idNum1').val(ojlist[choice].order_id);
   $('#idNum2').val(ojlist[choice].order_date);
   $('#idNum3').val(ujlist[choice].user_name);
   $('#idNum4').val(ojlist[choice].movie_name);
   $('#idNum5').val(ujlist[choice].user_phone);
   $('#idNum6').val(ojlist[choice].car_num);
   $('#idNum7').val(ojlist[choice].screening_time);
   $('#idNum8').val(pjlist[choice].price);

  });
  

    $(document).ready(function(){
      // 모달과 닫기 버튼의 객체를 가져옵니다.
      var modal = $("#myModal");
      var closeBtn = $(".close");

      // 'Open Modal' 버튼을 클릭하면 모달을 표시합니다.
      $(".openModalBtn").click(function(){
        modal.css("display", "block");
      });

      // 닫기 버튼을 클릭하면 모달을 숨깁니다.
      closeBtn.click(function(){
        modal.css("display", "none");
      });

      // 모달 외부를 클릭하면 모달을 숨깁니다.
      $(window).click(function(event){
        if (event.target === modal[0]) {
          modal.css("display", "none");
        }
      });
    });

    
  </script>
  	<footer>
  		<jsp:include page="/inc/bottomBarPix.jsp"></jsp:include>
  	</footer>

</body>
</html>