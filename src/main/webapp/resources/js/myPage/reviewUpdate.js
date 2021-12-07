$(document).ready(function(){
	// 사진 미리보기
		$("#img_file1").change(function(){
			readURL(this);
		});
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$('#ph1').attr('src', e.target.result);
					$('#ph1').css('visibility', 'visible');
					$('#ph1').parent().parent().addClass('on');
				}                    
				reader.readAsDataURL(input.files[0]);
			}
		}
		
		$("#img_file2").change(function(){
			readURL2(this);
		});
		function readURL2(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$('#ph2').attr('src', e.target.result);
					$('#ph2').css('visibility', 'visible');
					$('#ph2').parent().parent().addClass('on');
				}                    
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#img_file3").change(function(){
			readURL3(this);
		});
		function readURL3(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$('#ph3').attr('src', e.target.result);
					$('#ph3').css('visibility', 'visible');
					$('#ph3').parent().parent().addClass('on');
				}                    
				reader.readAsDataURL(input.files[0]);
			}
		}
		$("#img_file4").change(function(){
			readURL4(this);
		});
		function readURL4(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					$('#ph4').attr('src', e.target.result);
					$('#ph4').css('visibility', 'visible');
					$('#ph4').parent().parent().addClass('on');
				}                    
				reader.readAsDataURL(input.files[0]);
			}
		}
		
		// 사진 삭제 버튼
		$('.delBtn').on('click',function(){
			var answer = confirm("정말 삭제하겠습니까?");
			if(answer){
			var target = $(this);
			var n = $(this).attr('data-id');
			var f = $(this).attr('data-fileName');
			$.ajax({	
		 	   url : "delFileProc", type: "POST",
		 	   data : "reviewNum="+n + "&fileName="+f,
		 	   contentType: "application/x-www-form-urlencoded; charset=utf-8",
		 	   success : function(data) {
				if(data.result == "success"){
					$(target).parent().find('img').attr('src', "resources/img/review/starrate.png");
					$(target).attr('disabled', 'true');
					}else{
						alert("삭제 실패했습니다. 관리자에게 문의바랍니다.");
						}
				},
		 	   error: function(e){
		 		   alert("error" + e);
		 	   }
			});
			
			}
		});

	});
	
	// 글자 수 실시간 체크
	$(function(){
		$('#content').keyup(function(){
		bytesHandler(this);
		});
	});
	
	function getTextLength(str) {
	var len = 0;
	
	for (var i = 0; i < str.length; i++) {
		if (escape(str.charAt(i)).length == 6) {
			len++;
			}
		len++;
		}
	return len;
	}
	
	function bytesHandler(obj){
	var text = $(obj).val();
	$('p.bytes').text(getTextLength(text) + "/ 500");
	if (getTextLength(text) > 500) {
		alert("최대 500bytes까지 입력 가능합니다.");
		//$(obj).val(text.substring(0, 50));
		}
	}
	
	// 미리보기
	function preview(target) {
		var files = target.files[0];
		var reader = new FileReader();
		reader.onload = function(e) {
			$(target).prev('img').attr('src', e.target.result);
			$(target).prev('div').append(img);
		}
		reader.readAsDataURL(files);
				}
	
	// 수정 완료 체크
	function submitCheck(){
		var point = $('#point').val();
		if(point == 0){
			alert("별점을 선택해주세요.");
			return;
		}
		document.getElementById("f").action = "modifyProc";
		document.getElementById("f").submit();
	}
	
	//별점 마킹 모듈 프로토타입으로 생성
	function Rating(){};
	Rating.prototype.rate = 0;
	Rating.prototype.setRate = function(newrate){
	    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
	    this.rate = newrate;
	    let items = document.querySelectorAll('.rate_radio');
	    items.forEach(function(item, idx){
	        if(idx < newrate){
	            item.checked = true;
	        }else{
	            item.checked = false;
	        }
	    });
	}
	let rating = new Rating();//별점 인스턴스 생성
	
	document.addEventListener('DOMContentLoaded', function(){
	    //별점선택 이벤트 리스너
	    document.querySelector('.rating').addEventListener('click',function(e){
	        let elem = e.target;
	        if(elem.classList.contains('rate_radio')){
	            rating.setRate(parseInt(elem.value));
	        }
	        $("#point").val(parseInt(elem.value));
	    });
	});