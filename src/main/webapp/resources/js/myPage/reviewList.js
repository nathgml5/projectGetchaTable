// 리뷰 삭제 버튼
$(document).ready(function(){
		$('.delBtn').on('click',function(){
			var answer = confirm("정말 삭제하겠습니까?");
			if(answer){
			var n = $(this).attr('data-id');
			var f = $(this).attr('data-fileName');
			$.ajax({	
		 	   url : "deleteProc", type: "POST",
		 	   data : "reviewNum="+n + "&fileNames="+f,
		 	   //{'reviewNum' : n}
		 	   contentType: "application/x-www-form-urlencoded; charset=utf-8",
		 	   success : function(data) {
				if(data.result == "success"){
					location.reload();
					}else{
						alert("삭제 실패했습니다. 관리자에게 문의바랍니다.");
						}
				},
		 	   error: function(e){
		 		   alert("error: " + e);
		 	   }
			});
			}else return;
		});
		
		$('#sidebar').find('span').text('OPEN');
	});
	