
//주소 가져오기
function daumPost(){
	new daum.Postcode({
		oncomplete:function(data){
			var addr = "";
			if(data.userSelectedType === "R"){//도로명 주소일 경우( R )
				addr = data.roadAddress;
			}else{//지번일 경우( J )
				addr = data.jibunAddress;
			}
			document.getElementById("zipcode").value = data.zonecode;
			document.getElementById("addr1").value = addr;
			document.getElementById("addr2").focus();
		
		}
	}).open();
	
}

// 카카오 제공 : 주소로 좌표 가져와서 hidden값에 넣어놓기-> 행정동 가져오기 위함
function findCor(){
	var addr = document.getElementById("addr1").value;
	var geocoder = new kakao.maps.services.Geocoder();
	var callback = function(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result);
	        document.getElementById("corX").value= result[0].x;
	        document.getElementById("corY").value= result[0].y;
	    }
	};
	geocoder.addressSearch(addr, callback); 
} 

// 식당 종류 직접 입력 선택시 입력 공간 뜨게 하기
$(function(){
	$('#typeDirect').hide();
	$('#type').change(function(){
		if($('#type').val() == "direct"){
			$('#typeDirect').show();
		}else{
			$('#typeDirect').hide();
		}
	})
});

// 휴무를 선택할 경우 시간이 뜨지 않게 함
$(function(){
	$('#openingSel').change(function(){
		if($('#openingSel').val() == "휴무"){
			$('#hours').hide();
			$('#start').val("");
			$('#end').val(""); 
		}else{
			$('#hours').show();
		}
	})
});

// 오프닝 시간 start-end 설정
$(document).ready(function() {
    // INPUT 박스에 들어간 ID값을 적어준다.
    $("#start,#end").timepicker({
        'minTime': '11:00am', // 조회하고자 할 시작 시간 ( 09시 부터 선택 가능하다. )
        'maxTime': '24:00pm', // 조회하고자 할 종료 시간 ( 20시 까지 선택 가능하다. )
        'timeFormat': 'H:i',
        'step': 30 // 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
	});
	$(window).scroll(function(){
	    $(".ui-timepicker-wrapper").hide();
	});

});

// 영업시간 추가
function addOpening(){
 	var day = document.getElementById("openingDay").value;
	var st = document.getElementById("start").value;
	var en = document.getElementById("end").value; 
	var sel = document.getElementById("openingSel").value; 
	var op = document.getElementById("openHour").innerHTML;
	var openStr;
	if(start == "" || end == ""){
		return;
	}
	if(sel == "휴무"){
		openStr = "<div><input type='text' name='openHour' style='border:none;' value='"+ day + " " + sel + "'> <button name='delMenu'>삭제</button></div>"; 
	}else{
		if(st=="" || end==""){
			return;
		}else{
			openStr = "<div><input type='text' name='openHour' style='border:none;' value='"+day+" "+sel+" "+st+"-"+en+"'><button name='delMenu'>삭제</button></div>"; 		
		}
	}
	if(op ==""){
		document.getElementById("openHour").innerHTML = openStr;	
	}else{
		document.getElementById("openHour").innerHTML = op+openStr;
	}

}
// 영업시간 삭제
$(document).on("click","button[name=delMenu]",function(){
    var trHtml = $(this).parent();
    trHtml.remove(); //tr 테그 삭제
    
});


$(document).ready(function() { 
	$("input:checkbox").on('click', function() { 
		if ( $(this).prop('checked') ) { 
			$(this).addClass("selected"); 
		} else { 
			$(this).removeClass("selected"); 
		} 
	});
});

function submitBtn(){
	$('#warnRestName').html("");
	$('#warnRestIntro').html("");
	$('#warnAddr').html("");
	$('#warnType').html("");
	$('#warnOpenHour').html("");
	$('#warnCapacity').html("");
	
	
	if($('#restName').val() ==""){
		$('#restName').focus();
		$('#warnRestName').html("식당 이름을 입력하세요.");		
		return;
	}else if($('#restIntro').val() ==""){
		$('#restIntro').focus();
		$('#warnRestIntro').html("한줄 소개 글을 입력하세요.");		
		return;
	}else if($('#addr1').val() =="" || $('#addr2').val() ==""){
		$('#addr2').focus();
		$('#warnAddr').html("주소를 입력하세요.");		
		return;
	}else if($('#type').val() =="" || $('#type').val() =="direct" && $('#typeDirect').val()==""){
		$('#warnType').html("식당 종류를 선택하세요.");		
		return;
	}else if($('#openHour').text()==""){
		$('#warnOpenHour').html("영업 시간을 선택하세요.");		
		return;
	}else if($('#capacity').val()==""){
		$('#warnCapacity').html("수용가능 인원 입력하세요.");		
		return;
	}
	
	var corX = document.getElementById("corX").value;
    var corY = document.getElementById("corY").value;
	var geocoder = new kakao.maps.services.Geocoder();
 	var callback = function(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	    	var strResult = result[0].address_name;
	    	var strArray = strResult.split(' ');
	    	document.getElementById("dong").value = strArray[2];
			document.getElementById("f").submit(); 
	    }
	};
	if(corX=="" || corY==""){
		document.getElementById("f").submit(); 
	}else{
		geocoder.coord2RegionCode(corX, corY, callback);		
	}
	
}


// 프로모션 이미지 미리보기
$(document).on('input','#promotion', function () {
	readURL(this);
}); 
function readURL(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function (e){
			$('#previewPromotion').attr('src',e.target.result);
			$('#previewPromotion').attr('width', 100);
		}
		 reader.readAsDataURL(input.files[0]);
	}
}

// 레스토랑 사진 미리보기
$(function() {
    // Multiple images preview in browser
    var imagesPreview = function(input, placeToInsertImagePreview) {
        if (input.files) {
			$(placeToInsertImagePreview).empty();
            var filesAmount = input.files.length;
            for (i = 0; i < filesAmount; i++) {
                var reader = new FileReader();
                reader.onload = function(event) {
      				$($.parseHTML('<img>')).attr('src', event.target.result)
      				.attr('height', 200)
      				.attr('weight', 100)      				
      				.appendTo(placeToInsertImagePreview);
                }
                reader.readAsDataURL(input.files[i]);
            }
        }
    };

    $('#restImage').on('change', function() {
        imagesPreview(this, 'div.previewImgs');
    });
});



/* 
imageView = function imageView(previewImgs, restImage){

	var preview = document.getElementById(previewImgs);
	var restImage = document.getElementById(restImage);
	var sel_files = [];
	
	// 이미지와 체크 박스를 감싸고 있는 div 속성
	var div_style = 'display:inline-block;position:relative;'
	              + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
	// 미리보기 이미지 속성
	var img_style = 'width:100%;height:100%;z-index:none';
	// 이미지안에 표시되는 체크박스의 속성
	var chk_style = 'width:40px;height:25px;position:absolute;font-size:12px;'
	              + 'right:0px;top:0px;background:none;color:#f00;border:none;';
	
	restImage.onchange = function(e){
		if ($('#restImage')[0].files.length > 6) {
		    alert('6개를 초과하였습니다.')
			return;
		}	
	    var files = e.target.files;
	    var fileArr = Array.prototype.slice.call(files)
	    for(f of fileArr){
	      imageLoader(f);
	    }
	}
	
	// 탐색기에서 드래그앤 드롭 사용
    preview.addEventListener('dragenter', function(e){
      e.preventDefault();
      e.stopPropagation();
    }, false)
    
    preview.addEventListener('dragover', function(e){
      e.preventDefault();
      e.stopPropagation();
      
    }, false)
  
    preview.addEventListener('drop', function(e){
      var files = {};
      e.preventDefault();
      e.stopPropagation();
      var dt = e.dataTransfer;
      files = dt.files;
      for(f of files){
        imageLoader(f);
      }
      
    }, false)	
    
    
    imageLoader = function(file){
      sel_files.push(file);
      var reader = new FileReader();
      reader.onload = function(ee){
        let img = document.createElement('img')
        img.setAttribute('style', img_style)
        img.setAttribute('name', 'choice')
        img.src = ee.target.result;
        preview.appendChild(makeDiv(img, file));
      }
      
      reader.readAsDataURL(file);
    }
	
    
    makeDiv = function(img, file){
      var div = document.createElement('div')
      div.setAttribute('style', div_style)
      
      var btn = document.createElement('input')
      btn.setAttribute('type', 'button')
      btn.setAttribute('value', '삭제')
      btn.setAttribute('delFile', file.name);
      btn.setAttribute('style', chk_style);
      btn.onclick = function(ev){
        var ele = ev.srcElement;
        var delFile = ele.getAttribute('delFile');
        for(var i=0 ;i<sel_files.length; i++){
          if(delFile== sel_files[i].name){
            sel_files.splice(i, 1);      
          }
        }
        
        dt = new DataTransfer();
        for(f in sel_files) {
          var file = sel_files[f];
          dt.items.add(file);
        }
        preview.files = dt.files;
        var p = ele.parentNode;
        preview.removeChild(p)
      }
      div.appendChild(img)
      div.appendChild(btn)
      return div
    }
}('previewImgs', 'restImage')  */












