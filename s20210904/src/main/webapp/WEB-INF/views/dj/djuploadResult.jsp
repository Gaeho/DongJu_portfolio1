<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>

alert("작동 된다.");
var result    = '${savedName}';
var delResult = '${delResult}';

parent.addFilePath(result);
/* annoWrite의 addFilePath()함수가 실행되어야함  */
</script>