
var i=50;

function addModifyRow(){
	
	// table element 찾기
  const table = document.getElementById('registerTable');
  
  // 새 행(Row) 추가
  const newRow = table.insertRow();
  
  // 새 행(Row)에 Cell 추가
  const newCell1 = newRow.insertCell(0);
  const newCell2 = newRow.insertCell(1);
  const newCell3 = newRow.insertCell(2);
  const newCell4 = newRow.insertCell(3);
  const newCell5 = newRow.insertCell(4);
  
  
  // Cell에 텍스트 추가
  newCell1.innerHTML = '<input type="text" id="category'+i+'" name="category" style="width:80" placeholder="분류">';
  newCell2.innerHTML = '<input type="text" id="menuName'+i+'" name="menuName" style="width:135px" placeholder="메뉴명">';
  newCell3.innerHTML = '<input type="number" id="unitPrice'+i+'" name="unitPrice" placeholder="가격" style="width:100px">';
  newCell4.innerHTML = '<input type="file" id="menuImage'+i+'" name="menuImage" style="display:none;" onchange="previewImg(this)">'+
  						'<label for="menuImage'+i+'"><img name="menuImage'+i+'" src="resources/img/icon/upload.png" width="40"></label>';
  newCell5.innerHTML = "<button type='button' name='delMenu' onclick='deleteRow(this)'>삭제</button>";

  i++;
}

function deleteRow(del){
	$(del).parent().parent().remove();
}

// 메뉴 이미지 이미보기
function previewImg(input){
	if(input.files && input.files[0]){
		var imgName = input.getAttribute('id');
		var reader = new FileReader();
		reader.onload = function (e){
			$('img[name='+imgName+']').attr('src',e.target.result);
			$('img[name='+imgName+']').attr('height',40);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

// 메뉴판 미리보기
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
      				.attr('width', 210).attr('height', 280)
      				.appendTo(placeToInsertImagePreview);
                }
                reader.readAsDataURL(input.files[i]);
            }
        }
    };

    $('#inWholeMenu').on('change', function() {
	  	
        imagesPreview(this, 'div.wholeMenuPreview');
    });
});

// 메뉴 입력했을 때
/*function inputMenu() {
	var menuNameArr = document.getElementsByName('menuName');
	var unitPrice = document.getElementsByName('unitPrice');
	
	var count = menuNameArr.length;
	for(var i=0; i<count; i++){
		if(menuNameArr[i].value == ""){
			alert('메뉴명은 필수 입력 항목입니다.');
			return;
		}else if(unitPrice[i].value == ""){
			alert('가격은 필수 입력 항목입니다.');
			return;
		}
	}
    document.getElementById('inputOrNot').value = "yes";
    $('form[name="f"]').submit();
}*/

// 메뉴 입력하지 않았을 때
/*function noMenu() {
	document.getElementById('inputOrNot').value = "no";
    $('form[name="f"]').submit();
}*/
