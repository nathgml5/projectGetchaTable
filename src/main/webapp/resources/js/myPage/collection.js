// 컬렉션 취소 버튼
$(document).ready(function(){
	$('.calBtn').on('click',function(){
			var answer = confirm("정말 취소하겠습니까?");
			if(answer){
			var n = $(this).attr('data-id');
			var info = {restNum:n}
			$.ajax({	
		 	   url : "delCollect", type: "POST",
		 	   data : JSON.stringify(info),
		 	   contentType: "application/json; charset=utf-8",
		 	   dataType: "json",
		 	   success : function(map) {
		 		   if(map.result == "success"){
		 			   location.reload();
		 			   }	
				},
		 	   error: function(){
		 		   alert("error");
		 	   }
			});
			}
		});
		$('#sidebar').find('span').text('OPEN');
});