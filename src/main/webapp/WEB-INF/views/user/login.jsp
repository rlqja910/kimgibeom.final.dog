<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>
<script type="text/javascript" src='../res/cookie.js'></script>
<style>
/* header */
.header {
	width: 100%;
	height: 380px;
	background-color: #ccc;
	background-image: url('../attach/banner/banner.jpg');
	background-position: center;
}

.header .headerBackground {
	background: rgba(0, 0, 0, .4);
	height: 380px;
}

.subHr {
	width: 45px;
	margin-top: 140px;
	border: 1px solid #f5bf25;
}

.header .subTitle {
	text-align: center;
	font-size: 42px;
	color: #fff;
	margin-top: 20px;
}

/* 로그인 */
.login {
	width: 80%;
	margin: 0 auto;
	font-size: 14px;
	clear: both;
	margin-bottom: 140px;
	margin-top: 140px;
}

#login_box ul {
	list-style-type: none;
}

.login form {
	width: 450px;
	margin: 0 auto;
}

#input_button input {
	width: 450px;
	height: 50px;
	border: 1px solid #ccc;
}

#id_pass span {
	width: 20px;
}

#pass input {
	margin-top: -1px;
}

.login form p {
	font-size: 20px;
	font-weight: bold;
}

.login form .newUser a {
	padding: 14px 0;
	text-align: center;
	width: 450px;
	background: #fff;
	color: #666;
	margin-top: 20px;
	border: 1px solid #ccc;
}

#login_btn {
	padding: 12px;
	width: 452px;
	height: 50px;
	background: #f5bf25;
	border: 0;
	color: #fff;
	margin-top: 20px;
	font-size: 16px;
}

.login .btns {
	color: #959595;
	font-size: 14px;
	width: 450px;
	overflow: hidden;
}

.login .btns div {
	float: left;
}

.login .btns div a {
	float: left;
	margin-top: 17px;
}

.login .btns div:nth-child(2) {
	float: right;
}

.login .btns input, label {
	margin-top: 20px;
}

#autoLogin {
	margin: 0;
	line-height: 16px;
}

.logintext {
	color: #959595;
	text-align: center;
	margin-top: 10px;
}

.newUser:hover a {
	background-color: #333;
	color: #fff;
	transition-duration: .5s;
}

/* 모바일 스타일 */
@media screen and (max-width:768px) {
	.subHr {
		margin-top: 20%;
	}
	.header .subTitle {
		font-size: 36px;
		margin-top: 0;
		padding-bottom: 5%;
	}
	#input_button input {
		width: 100%;
	}
	.login {
		margin-top: 15%;
		margin-bottom: 15%;
	}
	.login form {
		width: 100%;
		text-align: center;
	}
	.login .btns {
		width: 100%;
		text-align: left;
	}
	.login form .newUser a {
		width: 100%;
		margin: 0 auto;
		margin-top: 4%;
	}
	#login_btn {
		width: 100%;
		margin-top: 4%;
	}
}
</style>

<script>
	$(()=>{   
		login(); 
		idSave();
	});
	function idSave(){ //아이디 저장
		$('#userId').val($.cookie('userId'));
		if($('#userId').val()!=''){
			$('#userIdSave').attr('checked',true);
		}
			
		$('#userIdSave').change(()=>{
			if($('#userIdSave').is(':checked')){ 
				$.cookie('userId',$('#userId').val(),{expires:7});
			}else{
				$.removeCookie('userId');
			} 
		});
		
		$('#userId').keyup(()=>{
			if($('#userIdSave').is(':checked')){
				$.cookie('userId',$('#userId').val(),{expires:7});
			}
		});
	}
	
	function clearMsg(){
		$('#idCheckMsg').text('');
		$('#pwCheckMsg').text('');
	}
	
	function login(){ 
		$('#login_btn').click((e)=>{
			e.preventDefault();
			$.ajax({ 
				url:'loginProc',
				method:'post',
				data:{
					'userId':$('#userId').val(),
					'userPw':$('#userPw').val(),
				},
				success:(result)=>{  
					if($('#userId').val()===''&&$('#userPw').val()===''){
						return;
					}else if(result==1){
						if($('#userId').val()==='admin'){
							location.href='../admin';
						}else{
							$('#loginf').submit();
						}
					}else if(result==0){
						clearMsg();
						$('#idCheckMsg').text('없는 아이디입니다');
						return;
					}else if(result==-1){
						clearMsg();
						$('#pwCheckMsg').text('암호가 일치하지 않습니다');
						return;
					}
				},
			});
		});
	}
</script>
<%
	
%>
</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
				<header><%@ include file="../common/header.jsp"%>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>로그인</div>
			</div>
		</div>

		<!-- 로그인 -->
		<div class="content">
			<div class="login">
				<form name="loginform" action='../' id='loginf' method='post'>
					<div id="login_box">
						<font color='tomato'><p id='idCheckMsg'></p> </font><font
							color='tomato'><p id='pwCheckMsg'></p> </font>
						<ul id="input_button">
							<li id="id_pass"><input name="id" type="text" id='userId'
								maxlength='12' placeholder=" 아이디" value='' required></li>
							<li id="pass"><input name="pwd" type="password" id='userPw'
								placeholder=" 암호" maxlength='16' required></li>
						</ul>

					</div>
					<input type='submit' id="login_btn" value='로그인'>
					<div class="btns">
						<div>
							<input type="checkbox" id='userIdSave' /> <label>아이디 저장</label>
						</div>
						<div class='idPw'>
							<a href='idFindIn'>아이디 /&nbsp;</a><a href='pwFindIn'>비밀번호 찾기</a>
						</div>
					</div>
					<div class='newUser'>
						<a href='join'>회원가입</a>
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