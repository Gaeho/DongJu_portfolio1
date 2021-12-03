<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<%
	String context = request.getContextPath();
%>
<html>
<head>
<link href="css/dj/annoWriteForm.css" rel="stylesheet" type="text/css">
<link href="css/header.css" rel="stylesheet" type="text/css">
<link href="css/reset.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>공고작성</title>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/httpRequest.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
<script type="text/javascript">

	function buttontoggle(){
		
		var t = document.getElementById("pay_info")
		
		if(parseInt(t.value) >= 0){
			t.value = '-1'
				pay_info.disabled = true;
	
		}else if(parseInt(t.value) < 0){
			t.value = '0'
			
				pay_info.disabled = false;
		}
	}
	
	function addMonth(){
/* 		var anno_regdate =  $('#anno_regdate').val();
		var anno_regdate3 = new Date(anno_regdate);
		var anno_c_regdate = new Date(anno_regdate3.setMonth(anno_regdate3.getMonth() + 1));	// 한달 후

		alert('anno_c_regdate->'+anno_c_regdate);
		$('[name="anno_c_regdate"]').val(anno_c_regdate);
 */
		 var regdate = document.getElementById("regdate").value;
		  console.log(regdate);
		  var c = new Date(regdate);
		  console.log(c);
		  var c_regdate = new Date(c.setMonth(c.getMonth() + 1));
		  console.log(c_regdate);
		  document.getElementById("c_regdate").valueAsDate = c_regdate;	
 
		 var regdateValidate = document.getElementById("c_regdate").value;
			alert('regdateValidate->'+regdateValidate);
	}
	
	/* 회사 대문 이미지 input관련 시작  */
		function addFilePath(msg) {
			alert(msg);
			document.getElementById("form1").reset();
		}	
	/* 회사 대문 이미지 input관련 끝 */

//form데이터 전송
function dataSubmit() {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
 
    var data=new FormData($("#storeAddForm")[0]);
 
    $.ajax({
        beforeSend: function(xhr){
            xhr.setRequestHeader(header,token);
        },
        url: "url",
        data: data,
        processData:false,
        contentType:false,
        enctype:'multipart/form-data',
        type:"POST",
    }).done(function (fragment) {
        $("#resultDiv").replaceWith(fragment);
    });
}
	
	
function uploadFile() {
    alert('uploadFile Start...');
    var form = new FormData();
    var comId1 = document.getElementById('comId1').value;
    alert('comId1>>'+comId1);
    
    form.append( "file1", $("#file1")[0].files[0] );
	form.append( "comId1", $("#comId1")[0].value);
    
	$.ajax({
	    url: "/DjComImguploadForm",
	    type: "POST",
	    data: form,
	    enctype: 'multipart/form-data',
	    processData: false,
	    contentType: false,
	    datatype:'text',
	    success: function (data) {
	    	alert("성공");
	     /*  $('input[name=com_img11]').attr('src',data); */
	     	alert("도대체 뭔가 들어있긴 하니?->"+data)
	    	document.getElementById('imagesquare1').src=data;
	    	
	    },
	    error: function () {
	    	alert("실패");
	      // Handle upload error
	      // ...
	    }
	});
}


function deleteFile() {
    alert('deleteFile Start...');
    var form1 = new FormData();
   alert('삭제할 내용'+document.getElementById('imagesquare1').value);

   //form1.append( "comImg123", $("#imagesquare1")[0].value);
   
  var comImg123 ={"comImg123": document.getElementById('imagesquare1').value.toString()}

  /*    comImg123.value = null; */

/* 	 this.clearImage()  */
 
/* 	form1.append( "imgpath11", document.getElementById('imagesquare1').value);
 */    
	$.ajax({
	    url: "DjComImguploadForm",
	    data: comImg123,
	    dataType:'text',
	    success: function (data) {
	    	alert("삭제성공!!"+data);
	    	document.getElementById('imagesquare1').src='src=/img/dj/no_Image.gif';
	    	
	    },
	    error: function () {
	    	alert("삭제실패ㅜㅜ");
	      // Handle upload error
	      // ...
	    }
	});
}

</script>


</head>
<body>
	<div class="Container">
		<div class="MyContainer">
			<%@ include file="header.jsp"%>
			<br>
			<br>

			<div class="annoWrite_title">공고 작성하기</div>
			<p>
			<hr size="5px">

			<div class="compInfoContainer">
				<div class="bigTitle_anno">회사 정보</div>

				<div>
					<div class="middleTitle_anno">회사명</div>
					<div class="anno1_ctx">${compInfo.com_name}</div>
				</div>
				<p>
				<div>
					<div class="middleTitle_anno">주요 사업 내용</div>
					<div class="combus_ctx">${compInfo.com_bus}</div>
				</div>
				<p>  

					<%-- <label for="complogo1" >회사 로고</label>
						<input class="textsquare1" id ="complogo1" value="${}"> <p> --%>
				<div>
					<div class="middleTitle_anno_text">
						<label for="compimg3">회사 이미지</label>
					
						<form id="fileForm" name="frm" method="post">
						  <input class="imagesquare1" name="com_img11" type="image" src="${compInfo.com_img}" 
						  		 alt="이미지 없음" onerror="this.src='/img/dj/no_Image.gif'" id="imagesquare1" 
						  		 value="${compInfo.com_img}"><p>						  
						  		 <input  type="file"  id="file1" name="file1" />
						  <input type="hidden" id="comId1" name="comId1" value ="${compInfo.com_id}" ><p> 
						  <input type="button" value="업로드" onclick="uploadFile()">
						  <input type="button" value="삭제" id="delImg12" onclick="deleteFile()">
						</form>


						
			
					</div>
					
					
				</div>
				<p>
					<!-- 회사 환경 이미지 넣기  시작-->
					
					
					
						 <form id="addForm">
						        <div style="display: inline;">
						            <label for="img_upload">
						                <img src="/img/dj/fileaddbtn.png" style="width:100px; height:100px; cursor: pointer;">
						            </label>
						            <input type="file" name="img_upload" id="img_upload"
						                   onchange="previewImage(this,'View_area')"
						                   style="display: none;" multiple>
						 
						            <span id='View_area'
						                  style='position:relative; color: black; border: 0px solid black;'>
							        </span>
							        </div>
							 
							        <div style="align-content: center; width: 100%; text-align: center;">
							            <input type="button" class="btn" style="background: #F1C40F; color: #000000;" onclick="dataSubmit();"
							                   value="전송하기">
							        </div>
							 
							        <div id="resultDiv">
							            <p ><c:out value="${log}"></c:out> </p>
						        </div>
   						 </form>


					<!-- 회사 환경 이미지 넣기 끝 -->
				<div>
					<div class="middleTitle_anno">회사 주소</div>
					<%-- <input class="textsquare_addr" type="text" name="com_addr" id="compaddr1" value="${compInfo.com_addr}"> --%>
					<div class="textsquare_addr">${compInfo.com_addr}</div>
				</div>
				<p>
			</div>

			<hr size="5px">

			<form action="DjAnnoWriting" method="post">
			
				<div style="display:none"> <!-- type hidden으로 정보가 안넘겨져서 이 방법을 사용함  -->
				<input type="text" name="com_id" value="${compInfo.com_id}">
				<input type="text" name="com_name" value="${compInfo.com_name}">
				<input type="text" name="com_bus" value="${compInfo.com_bus}">
				</div>
				<div class="annoWriteContainer">



					<div class="bigTitle_anno">모집 내용</div>

					<div class="titleContainer">
						<div class="middleTitle_anno">공고 제목</div>
						<input type="text" class="anno_title_insert" name="anno_title"
							placeholder="공고 제목을 입력하세요." required="required">
					</div>

					<div>
						<div class="middleTitle_anno">
							<label for="annoJob1">모집 직종</label>
						</div>
						<select name="job_tag" id="annoJob1">
							<c:forEach var="jobTech1" items="${jobTech1}">
								<option value="${jobTech1.sub_cat}">${jobTech1.comm_ctx}</option>
							</c:forEach>
						</select>
						<p>
						<div>
							<div class="middleTitle_anno">고용 형태</div>
							<input type="radio" id="one" name="emp_type" value="1"
								checked="checked"> 정규직 <input type="radio" id="two"
								name="emp_type" value="2"> 계약직 <input type="radio"
								id="three" name="emp_type" value="3"> 파견직
							<p>
						</div>

						<div class="middleTitle_anno">
							<label for="recVol1">모집 인원</label>
						</div>
						<input type="text" name="rec_vol" required="required">명
						<p>
						<div class="middleTitle_anno">기술 스택1</div>
						<select name="tech_tag1">
							<c:forEach var="jobTech2" items="${jobTech2}">

								<option value="${jobTech2.sub_cat}">${jobTech2.comm_ctx}</option>

							</c:forEach>
						</select>
						<p>
						<div class="middleTitle_anno">기술 스택2</div>
						<select name="tech_tag2">
							<c:forEach var="jobTech2" items="${jobTech2}">

								<option value="${jobTech2.sub_cat}">${jobTech2.comm_ctx}</option>

							</c:forEach>
						</select>
						<p>
						<div class="middleTitle_anno">
							<label for="annoteck1">학력 사항</label>
						</div>
						<select name="rec_edu">
							<c:forEach var="recEdu" items="${recEdu}">

								<option value="${recEdu.comm_ctx}">${recEdu.comm_ctx}</option>

							</c:forEach>
						</select>
						<p>
						<div>
							<div class="middleTitle_anno">경력</div>
							<input type="radio" id="one11" name="career" value="001"checked="checked"> 신입 
							<input type="radio" id="two22" name="career" value="002"> 경력직(연차무관) 
							<input type="radio" id="three33" name="career" value="003"> 경력무관 
							<input type="radio" id="four44" name="career" value="004"> 3년 이상
							<input type="radio" id="five55" name="career" value="005"> 5년 이상 
							<input type="radio" id="six66" name="career" value="006"> 10년 이상
							<p>
						</div>

						<div>
							<div class="middleTitle_anno_text">모집 상세</div>
							<textarea name="rec_dtl" rows="40" cols="50"></textarea>
						</div>
						<p>
					</div>
				</div>

				<hr size="5px">

				<div class="annoCondContainer">
					<div class="bigTitle_anno">근무 조건</div>
					<div>
						<div class="middleTitle_anno">급여정보</div>
						<input type="number" name="pay_info" id="pay_info" value='0'>
						원
						<button type="button" id="salButton" onclick="buttontoggle();">급여협의</button>

					</div>
					<p>
					<div>
						<div class="middleTitle_anno_text">상세 근무 조건</div>
						<textarea name="work_cdt" rows="30" cols="50" required="required"></textarea>
					</div>
					<p>
					<div>
						<div class="middleTitle_anno_text">기타 입력 사항</div>
						<textarea name="etc_cdt" rows="40" cols="50"></textarea>
					</div>
					<p>
				</div>

				<hr size="5px">

				<div class="annoOptContainer">
					<div class="bigTitle_anno">공고 설정</div>
					<div class="middleTitle_anno">공고 시작일</div>

					<input type="date" id="regdate" value="anno_regdate"
						name="anno_regdate" required="required" onchange="addMonth();">

					<input type="date" class="input_anno_c_regdate"
						name="anno_c_regdate" id="c_regdate">

					<div class="anno_date_notice1">
						<h2>공고는 작성일로부터 한 달간 게시됩니다.</h2>
					</div>


				</div>

				<hr size="5px">

				<button type="submit" name="gobut" class="gobut">공고 작성 완료하기
				</button>

			</form>

			<br>
			<br>
			<%@ include file="footer.jsp"%>
			<br>
			<br>
		</div>
	</div>
</body>
</html>