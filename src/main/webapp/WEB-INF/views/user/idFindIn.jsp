<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp" %>
<style>
	/* header */
	.header{width:100%; height:380px; background-color:#ccc; background-image: url('../attach/banner/banner.jpg'); background-position: center;}
	.header .headerBackground{background:rgba(0, 0, 0, .4); height:380px;}

	.subHr{width:45px; margin-top:140px; border:1px solid #f5bf25;}
	.header .subTitle{text-align:center; font-size:42px; color:#fff; margin-top:20px;}
	.contHr{width:45px; margin-top:20px; margin-bottom:60px; border:1px solid #f5bf25;}

	/* 아이디 찾기 */
	.idFind:nth-child(1){text-align:center;}
	.idFind:nth-child(1) span{font-weight:bold;}
	.idFind{width:80%;font-size:14px; margin:0 auto;}
	.idFind table input{border:1px solid #999;}
	.idFind table{border:1px solid #f5bf25;border-collapse:collapse; text-align:left; width:80%; font-size:14px; margin:0 auto;}
	.idFind table .text input{height:30px; width:45%;}
	.idFind table .number input{height:30px; width:10%;}
	.idFind form{margin:100px 0; text-align:center;}
	.idFind form .contTitle{font-size:32px; font-weight:bold;}
	.idFind form .button{overflow:hidden; width:100%; text-align:center; margin-top:60px;}
	.idFind form .button input{height:40px;}
	.idFind form .button .ok{background-color:#f5bf25; border:1px solid #f5bf25; width:70px; color:#fff; margin-left:5px;}
	.idFind form .button .no{width:70px; margin-left:5px; background-color:#fff; border:1px solid #ccc;}
	.idFind table tr{height:30px;}
	.idFind th{border-left:1px solid #fff;padding:0 10px; border-bottom:1px solid #ccc; width:100px; height:45px;background-color:#eee; color:#333;}
	.idFind td{border-right:1px solid #fff;padding:0 10px; border-bottom:1px solid #ccc; height:50px;}
	.idFind th span{color:red;}
	.idFind .text td span{font-size:12px;}
	
	/* 모바일 스타일 */
	@media screen and (max-width:768px){
		.subHr{margin-top:20%;}

		.header .subTitle{font-size:36px; margin-top:0; padding-bottom:5%;}
		.contHr{margin-top:5%; margin-bottom:10%;}
		.idFind form .contTitle{font-size:28px;}
		
		.idFind form{margin:10% 0;}
		.contHr{margin-top:5%; margin-bottom:10%;}
		.idFind table{width:100%;}
		.idFind table .text input{width:60%;}
		.idFind table .number input{width:16%;}
		table th{width:25%;}
		.idFind form .button{margin-top:10%;}
	}
</style>
<script>
//숫자 max값 초과시 제한
function maxLengthCheck(object){ 
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
  }

//이름 빈칸 체크
function isCheckName(){
	result = false;
	if($('#userName').val()) result = true;
	return result;
} 

//전화번호 빈칸 체크
function isCheckPhone(){
	result = false;
	if($('#userPhone1').val() && $('#userPhone2').val() && $('#userPhone3').val()) result= true;
	return result;
}

//사용자가 입력시 error문구 없앰
function allWrite(){
	$('#userName').keyup(()=>{
		$('#errorId').text('');
	});
	$('#userPhone1').keyup(()=>{
		$('#errorId').text('');
	});
	$('#userPhone2').keyup(()=>{
		$('#errorId').text('');
	});
	$('#userPhone3').keyup(()=>{
		$('#errorId').text('');
	});
}

//아이디 찾기
function findId(){  
	$('#ok').on('click', (e)=>{
		e.preventDefault(); 
		
		if(isCheckName() && isCheckPhone()){
			$.ajax({
				url: 'idFindProc',
				method:'post',
				data: {
						'name':  $('#userName').val().trim(),
						'phone': $('#userPhone1').val() +'-'+ $('#userPhone2').val()+'-'+ $('#userPhone3').val()
				}, 
				success: (result)=> {
						if(result){
								location.href="idFindOut?userId="+result.userId;
							}
						else{
							$('#errorId').text('이름과 전화번호가 일치하지않습니다');
						}
					}
				})
		}
		else {
			$('#errorId').text('이름과 전화번호를 모두 입력해주세요');
		}
	});
}


$(()=>{
	findId();
	allWrite();
});

</script>
</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
					<header><%@ include file="../common/header.jsp"%>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>아이디 찾기</div>
			</div>
		</div>
		
		<!-- 아이디 찾기 -->
			<div class="content">
				<div class="idFind">
					<form action="#">
						<div class='contTitle'>아이디 찾기</div>
						<hr class='contHr'>
						<table>
							<tr class="text">
								<th><span>*</span> 이름</th>
								<td>
									<input type="text" id='userName' maxlength="10"/>&nbsp;
									<span id='errorId' style='color:red;'></span>
								</td>
							</tr>
							<tr class="number">
								<th><span>*</span> 전화번호</th>
								<td>
									<input type="number" id='userPhone1' min="0" maxlength="3" oninput="maxLengthCheck(this)"/> - 
									<input type="number" id='userPhone2' min="0" maxlength="4" oninput="maxLengthCheck(this)"/> - 
									<input type="number" id='userPhone3' min="0" maxlength="4" oninput="maxLengthCheck(this)"/>
									&nbsp;<span id="errorPhone"></span>
								</td>
							</tr>
						</table>
						<div class="button">
							<input type='button' class="ok" value='확인' id="ok"/>
							<input type='button' class="no" value='취소' onClick="location.href='login'">
						</div>
					</form>
				</div>
			</div>

		<!-- 푸터 -->
			<footer><%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>
