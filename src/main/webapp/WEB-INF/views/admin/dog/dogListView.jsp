<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Dog Manage</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>

<script>
function dogDel() {
	$('#delete').click(() => {
		if($('input:checkbox').is(':checked')) {
			let delDogs = $('input[name=dogCheckBox]:checked');
			let delDogsArray=[];
			
			for(let i=0;i<delDogs.length;i++){
				delDogsArray.push(delDogs[i].value);
			}
			
		   swal({
		      title: '',
		      text: '유기견 정보를 정말 삭제하시겠습니까?',
		      type: 'warning',
		      showCancelButton: true,
		      cancelButtonText: '아니오',
		      confirmButtonText: '예',
		      closeOnConfirm: false,
		      closeOnCancel: true
		   },
		   function(isConfirm){
		      if(isConfirm){
		    	  $.ajax({
						url:'dogDelProc',
						data:{
							delDogsNum:JSON.stringify(delDogsArray),
						},
						success:()=>{
							swal({	  title: '',
								      text: '유기견 정보가 삭제되었습니다',
								      type: 'success',
								      showCancelButton: false,
								      confirmButtonText: '확인',
								      closeOnConfirm: false,
								      },function(isConfirm){
								    	  location.href='dogListView';
								      }
								);
						},
						error:()=>{
						}
					});
		      }else{
		    	  ('취소','','error');
		      }
		   });	
		}else{
			swal('','항목을 선택해주세요','warning');
		}
	});
}
function reportSearch(){
	$('#search').click(() => {
		if($('#searchContent').val().trim()) {
			
		}	
	});
}
let totalPageCnt=${totalPageCnt};
let isOnePage=${isOnePage};
let lastPageDataCnt=${lastPageDataCnt};
let sdogData=null;
let dogsCnt=${dogsCnt};
	$(()=>{
		if(${isData}===false){
			swal({
		         title: '',
		         text: '등록된 유기견이 없습니다.',
		         type: 'warning',
		         confirmButtonText: '확인',
		         closeOnConfirm: false
		      },
		      function(isConfirm){
		         if(isConfirm){
		            let url = "dogListView";
		            url = url +"?isData=" + true;
		            location.href = url;
		         }
		      });
		}
		
		dogDel();
		dogList();
		
		$('#beforeAdoptBtn').click(()=>{
			$('#afterAdoptBtn').removeAttr("style","background-color");
			$('#beforeAdoptBtn').attr("style","background-color: silver;");
			
			let dogTitle = $('#dogTitle').val();
			
			$.ajax({
				url:'beforeAdoptSearch',
				data:{
					'dogTitle':dogTitle,
				},
				success:(data)=>{
					$('.pagination').empty();
					$('#dogPost').empty();
					
					totalPageCnt=data.totalPageCnt;
					isOnePage=data.isOnePage;
					lastPageDataCnt=data.lastPageDataCnt;
					dogsData=null;
					dogsCnt=data.dogsCnt;
					
					$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
					for(let i=1; i<=totalPageCnt;i++){
						$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
						if(i==1){
							$('#'+i+'page').attr("style","font-weight:bold;");
						}
					}
					$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
					
					$('.reviewCont').empty();
					
					if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
						dogsData=data.pageData; //controller에서 뽑은 데이터들을 준비한다.
						
						for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
							let contentStr=dogsData[i-1].dogContent.replace(/<p>/gi,' ');
							$('#dogPost').append('<a href="../dog/dogView/'+dogsData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[i-1].attachName+'" />" /></li><li>'+dogsData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[i-1].dogNum+'"/></li></ul></a>');
						}
						
					}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
						if(dogsCnt==0){ //아예 데이터가 없을때
							$('.pagination').empty();
							$('#dogPost').append('<div>검색된 유기견이 없습니다.</div>');
						}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
							let onlyOnePageData=data.onlyOnePageData;
							for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
								let contentStr=onlyOnePageData[i-1].dogContent.replace(/<p>/gi,' ');
								$('#dogPost').append('<a href="../dog/dogView/'+onlyOnePageData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+onlyOnePageData[i-1].attachName+'" />" /></li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+onlyOnePageData[i-1].dogNum+'"/></li></ul></a>');
							}
						}
					}
					
					$('#firstViewBtn').click(()=>{
						$('#1page').trigger('click');
						return false;
					});
					
					$('#lastViewBtn').click(()=>{
						$('#'+totalPageCnt+'page').trigger('click');
						return false;
					});
					
					for(let i=1; i<=totalPageCnt;i++){
						$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
							for(let j=1; j<=totalPageCnt; j++){
								$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
							}
							$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
							
							$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
							
							if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
								dogsData=data.onlyOnePageData;
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
								
							}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								
								
								let cnt=0;
								for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
									let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}
							
							return false;
						});
					}
				},
			});
		});
		
		$('#afterAdoptBtn').click(()=>{
			$('#beforeAdoptBtn').removeAttr("style","background-color");
			$('#afterAdoptBtn').attr("style","background-color: silver;");
			
			let dogTitle = $('#dogTitle').val();
			
			$.ajax({
				url:'afterAdoptSearch',
				data:{
					'dogTitle':dogTitle,
				},
				success:(data)=>{
					$('.pagination').empty();
					$('#dogPost').empty();
					
					totalPageCnt=data.totalPageCnt;
					isOnePage=data.isOnePage;
					lastPageDataCnt=data.lastPageDataCnt;
					dogsData=null;
					dogsCnt=data.dogsCnt;
					
					$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
					for(let i=1; i<=totalPageCnt;i++){
						$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
						if(i==1){
							$('#'+i+'page').attr("style","font-weight:bold;");
						}
					}
					$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
					
					$('.reviewCont').empty();
					
					if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
						dogsData=data.pageData; //controller에서 뽑은 데이터들을 준비한다.
						
						for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
							let contentStr=dogsData[i-1].dogContent.replace(/<p>/gi,' ');
							$('#dogPost').append('<a href="../dog/dogView/'+dogsData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[i-1].attachName+'" />" /></li><li>'+dogsData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[i-1].dogNum+'"/></li></ul></a>');
						}
						
					}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
						if(dogsCnt==0){ //아예 데이터가 없을때
							$('.pagination').empty();
							$('#dogPost').append('<div>검색된 유기견이 없습니다.</div>');
						}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
							let onlyOnePageData=data.onlyOnePageData;
							
							for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
								let contentStr=onlyOnePageData[i-1].dogContent.replace(/<p>/gi,' ');
								$('#dogPost').append('<a href="../dog/dogView/'+onlyOnePageData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+onlyOnePageData[i-1].attachName+'" />" /></li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+onlyOnePageData[i-1].dogNum+'"/></li></ul></a>');
							}
						}
					}
					
					$('#firstViewBtn').click(()=>{
						$('#1page').trigger('click');
						return false;
					});
					
					$('#lastViewBtn').click(()=>{
						$('#'+totalPageCnt+'page').trigger('click');
						return false;
					});
					
					for(let i=1; i<=totalPageCnt;i++){
						$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
							for(let j=1; j<=totalPageCnt; j++){
								$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
							}
							$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
							
							$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
							
							if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
								dogsData=data.onlyOnePageData;
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								
								let cnt=0;
								for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
									let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
								
							}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
								dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
								
								let cnt=0;
								for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
									let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
									cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
								}
							}
							
							return false;
						});
					}
				}
			});
		});
		
		$('#searchDogBtn').click(()=>{
				$('#afterAdoptBtn').removeAttr("style","background-color");
				$('#beforeAdoptBtn').removeAttr("style","background-color");
			
				let dogTitle = $('#dogTitle').val();
				
				if(dogTitle===''){ //아무것도 입력안하면 리스트 전체 출력
					$('.pagination').empty();
					$('#dogPost').empty();
					totalPageCnt=${totalPageCnt};
					isOnePage=${isOnePage};
					lastPageDataCnt=${lastPageDataCnt};
					dogsData=null;
					dogsCnt=${dogsCnt};
					dogList();
				}else{
					$.ajax({
						url:'dogSearch',
						data:{
							'dogTitle':dogTitle,
						},
						success:(data)=>{  
							$('.pagination').empty();
							$('#dogPost').empty();
							
							totalPageCnt=data.totalPageCnt;
							isOnePage=data.isOnePage;
							lastPageDataCnt=data.lastPageDataCnt;
							dogsData=null;
							dogsCnt=data.dogsCnt;
							
							$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
							for(let i=1; i<=totalPageCnt;i++){
								$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
								if(i==1){
									$('#'+i+'page').attr("style","font-weight:bold;");
								}
							}
							$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
							
							$('.reviewCont').empty();
							
							if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
								dogsData=data.pageData; //controller에서 뽑은 데이터들을 준비한다.
								
								for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
									let contentStr=dogsData[i-1].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[i-1].attachName+'" />" /></li><li>'+dogsData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[i-1].dogNum+'"/></li></ul></a>');
								}
								
							}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
								if(dogsCnt==0){ //아예 데이터가 없을때
									$('.pagination').empty();
									$('#dogPost').append('<div>검색된 유기견이 없습니다.</div>');
								}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
									let onlyOnePageData=data.onlyOnePageData;
									
									for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
										let contentStr=onlyOnePageData[i-1].dogContent.replace(/<p>/gi,' ');
										$('#dogPost').append('<a href="../dog/dogView/'+onlyOnePageData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+onlyOnePageData[i-1].attachName+'" />" /></li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+onlyOnePageData[i-1].dogNum+'"/></li></ul></a>');
									}
								}
							}
							
							$('#firstViewBtn').click(()=>{
								$('#1page').trigger('click');
								return false;
							});
							
							$('#lastViewBtn').click(()=>{
								$('#'+totalPageCnt+'page').trigger('click');
								return false;
							});
							
							for(let i=1; i<=totalPageCnt;i++){
								$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
									for(let j=1; j<=totalPageCnt; j++){
										$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
									}
									$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
									
									$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
									
									if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
										dogsData=data.onlyOnePageData;
										
										let cnt=0;
										for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
											let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
											$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
									}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
										dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
										
										let cnt=0;
										for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
											let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
											$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
										
									}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
										dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
										
										let cnt=0;
										for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
											let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
											$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
									}
									
									return false;
								});
							}
							
						},error: function (xhr, ajaxOptions, thrownError) {
		                }
					});
				}
		});
	});
	
	function dogList(){
		$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
		for(let i=1; i<=totalPageCnt;i++){
			$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
			if(i==1){
				$('#'+i+'page').attr("style","font-weight:bold;");
			}
		}
		$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
		
		$('.reviewCont').empty();
		
		if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
			dogsData=${pageData}; //controller에서 뽑은 데이터들을 준비한다.
			
			for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
				let contentStr=dogsData[i-1].dogContent.replace(/<p>/gi,' ');
				$('#dogPost').append('<a href="../dog/dogView/'+dogsData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[i-1].attachName+'" />" /></li><li>'+dogsData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[i-1].dogNum+'"/></li></ul></a>');
			}
			
		}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
			if(dogsCnt==0){ //아예 데이터가 없을때
				$('.pagination').empty();
				$('#dogPost').append('<div>등록된 유기견이 없습니다.</div>');
			}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
				let onlyOnePageData=${onlyOnePageData};
				
				for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
					let contentStr=onlyOnePageData[i-1].dogContent.replace(/<p>/gi,' ');
					$('#dogPost').append('<a href="../dog/dogView/'+onlyOnePageData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+onlyOnePageData[i-1].attachName+'" />" /></li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+onlyOnePageData[i-1].dogNum+'"/></li></ul></a>');
				}
			}
		}
		
		$('#firstViewBtn').click(()=>{
			$('#1page').trigger('click');
			return false;
		});
		
		$('#lastViewBtn').click(()=>{
			$('#'+totalPageCnt+'page').trigger('click');
			return false;
		});
		
		for(let i=1; i<=totalPageCnt;i++){
			$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
				for(let j=1; j<=totalPageCnt; j++){
					$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
				}
				$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
				
				$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
				
				if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
					dogsData=${onlyOnePageData};
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
						let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
						$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
					dogsData=${pageData}; //그리고 Controller에서 불러온 데이터를 준비한다.
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
						let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
						$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
					
				}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
					dogsData=${pageData}; //그리고 Controller에서 불러온 데이터를 준비한다.
					
					let cnt=0;
					for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
						let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
						$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li><li class="checkB"><input type="checkbox" name="dogCheckBox" value="'+dogsData[(i-1)*8+cnt].dogNum+'"/></li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}
				
				return false;
			});
		}
	}
</script>
<style>
#leftNav #sidebar {
	position: fixed;
	width: 200px;
	height: 100%;
	background: #4b4276;
	padding: 20px 0;
}

#leftNav #sidebar ul li {
	padding: 15px;
	list-style: none;
	border-bottom: 1px solid rgba(0, 0, 0, 0.05);
	border-top: 1px solid rgba(225, 225, 225, 0.05);
}

#leftNav #sidebar ul li a {
	color: #bdb8d7;
	display: black;
}

#leftNav #sidebar ul li a span {
	width: 25px;
}

#leftNav #sidebar ul li:hover {
	background: #594f8d;
}

#leftNav #sidebar ul li:hover a {
	color: #fff;
	text-decoration: none;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.marker {
	background-color: yellow;
}

p {
	margin-top: 0;
	margin-bottom: 0;
	float: left;
}

.marker {
	background-color: yellow;
}

p {
	margin-top: 0;
	margin-bottom: 0;
	float: left;
}

h1, h2, h3, h4, h5, h6 {
	font-size: 1em;
	border-style: none;
	font-weight: normal;
}

#title {
	color: #fff;
	text-align: center;
	margin-bottom: 30px;
	font-size: 30px;
}

strong {
	font-weight: normal;
}

big, small {
	font-size: 1em;
}

strong {
	font-weight: normal;
}

big, small {
	font-size: 1em;
}

body {
	background: #f3f5f9;
}

#leftNav {
	display: flex;
	position: relative;
}

#leftNav #sidebar {
	position: fixed;
	width: 200px;
	height: 100%;
	background: #4b4276;
	padding: 20px 0;
}

#leftNav #sidebar h2 {
	color: #fff;
	text-align: center;
	margin-bottom: 30px;
}

#leftNav #sidebar ul li {
	padding: 15px;
	list-style: none;
	border-bottom: 1px solid rgba(0, 0, 0, 0.05);
	border-top: 1px solid rgba(225, 225, 225, 0.05);
}

#leftNav #sidebar ul li a {
	color: #bdb8d7;
	display: black;
}

#leftNav #sidebar ul li a span {
	width: 25px;
}

#leftNav #sidebar ul li:hover {
	background: #594f8d;
}

#leftNav #sidebar ul li:hover a {
	color: #fff;
	text-decoration: none;
}

#leftNav .main_content {
	width: 100%;
	margin-left: 200px;
	overflow: hidden;
}

#leftNav .main_content .header {
	padding: 11px;
	background: #fff;
	color: #717171;
	border-bottom: 1px solid #e0e4e8;
}

#leftNav .main_content .header .border {
	font-size: 19px;
}

#leftNav .main_content .header #topButton {
	text-decoration: none;
	margin-top: 4px;
	margin-right: 20px;
	float: right;
}

#leftNav .main_content .header #topButton a {
	text-decoration: none;
}

#leftNav .main_content .info {
	margin: 50px;
	color: #717171;
}

.item {
	width: 640px;
	height: 300px;
	margin: 0 120px 50px 30px;;
	float: left;
}
/*------- 검색창 테두리-------- */
#inputBackground {
	height: 50px;
	padding: 7px;
	margin-bottom: 30px;
}
/*------- 이미지 체크박스-------- */
#chk {
	border: 2px solid black;
	width: 25px;
	height: 25px;
	position: relative;
	top: -45px;
	left: -165px;
}

.button {
	text-align: right;
	margin-right: 20px;
}

#content {
	float: left;
	margin-left: 10px;
	width: 400px;
	display: inline;
}

#h3Title {
	font-size: 24px;
	font-weight: bolder;
}

#searchDogBtn {
	background: #4b4276;
}

#spanSearch {
	color: #fff;
}

#pagination {
	display: block;
	text-align: center;
}

.report {
	font-size: 14px;
	margin-top: 10px;
	margin-bottom: 40px;
}

.report .reviewCont {
	overflow: hidden;
}

.report .reviewCont div {
	text-align: center;
}

.report .reviewCont ul {
	width: 23.5%;
	float: left;
	margin: 1% 0 0 1%;
	border: 1px solid #ccc;
	height: 480px;
}

.report .reviewCont li {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.report .reviewCont ul li:nth-child(1) {
	border-bottom: 1px solid #ccc;
	text-align: center;
	height: 68%;
}

.report .reviewCont ul li:nth-child(2) {
	font-weight: bold;
	margin: 5% 3% 3% 3%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.report .reviewCont ul li:nth-child(3) {
	margin: 0 3% 0 3%;
	color: #666;
	font-size: 12px;
}

.report .reviewCont ul li:nth-child(4) {
	text-align: right;
	margin: 6% 3% 5% 3%;
}

.report .reviewCont ul img {
	width: 100%;
	height: 100%;
}

.reviewCont ul {
	position: relative;
}

.checkB {
	position: absolute;
	top: 0;
	left: 0;
}

.checkB input {
	margin-top: 0 !important;
	width: 20px;
	height: 20px;
}
</style>
</head>
<body>
	<div class='wrapper' id='leftNav'>
		<div class='sidebar' id='sidebar'>
			<h2 id='title'>
				<b>DOG SHELTER</b>
			</h2>
			<ul>
				<li><a href='<c:url value='/admin'/>'> <span
						class='glyphicon glyphicon-home'></span>메인
				</a></li>
				<li><a href='<c:url value='/admin/user/userListView'/>'> <span
						class='glyphicon glyphicon-user'></span>회원관리
				</a></li>
				<li><a href='<c:url value='/admin/dog/dogListView'/>'> <span
						class='glyphicon glyphicon-heart'></span>유기견관리
				</a></li>
				<li><a href='<c:url value='/admin/adopt/adoptListView'/>'>
						<span class='glyphicon glyphicon-calendar'></span>입양관리
				</a></li>
				<li><a href='<c:url value='/admin/review/reviewListView'/>'>
						<span class='glyphicon glyphicon-list'></span>후기관리
				</a></li>
				<li><a href='<c:url value='/admin/report/reportListView'/>'>
						<span class='glyphicon glyphicon-bullhorn'></span>신고관리
				</a></li>
				<li><a href='<c:url value='/admin/donation/donationListView'/>'>
						<span class='glyphicon glyphicon-piggy-bank'></span>후원금 관리
				</a></li>

			</ul>
		</div>
		<div class='main_content'>
			<div class='header'>
				<strong style='font-weight: bolder'>&nbsp;&nbsp;ADMINSTRATOR</strong>
				<div id='topButton'>
					<a href='../common/logoRegist'>로고관리</a>&nbsp;|&nbsp; <a
						href='../common/bannerRegist'>배너관리</a>&nbsp;|&nbsp; <a
						href='<c:url value='/'/>'>홈페이지 돌아가기</a>&nbsp;|&nbsp; <a
						href='../../user/logout'>로그아웃</a>
				</div>
			</div>
			<div class='info'>
				<div class='content'>
					<h3 id='h3Title'>
						<span class='glyphicon glyphicon-heart'></span> 유기견 관리
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>
					<form>
						<div>
							<button class='form-control'
								style='width: 100px; height: 35px; float: left;'>제목</button>
							<div class='form-group' id='content'>
								<input type='text' id='dogTitle' class='form-control'
									placeholder='검색어를 입력해주세요.' maxlength=10 />
							</div>
							<div class='form-group'>
								<button type='button' class='btn btn-default' id='searchDogBtn'>
									<span id='spanSearch'>검색</span>
								</button>
							</div>
						</div>
						<br>
						<button type='button' class='btn btn-default' id='beforeAdoptBtn'>입양
							전</button>
						&nbsp;
						<button type='button' class='btn btn-default' id='afterAdoptBtn'>입양
							후</button>
						<br> <br>
						<div class='report'>
							<div class='reviewCont' id='dogPost'></div>

							<br> <br>
							<div class='button'>
								<button type='button' class='btn btn-primary'
									onClick="location.href='dogRegist'">등록</button>
								<button type='button' class='btn btn-warning' id='delete'>삭제</button>
							</div>
						</div>
					</form>
					<br>
					<div id="pagination">
						<ul class="pagination">
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>