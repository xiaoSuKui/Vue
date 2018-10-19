<?php
header("Content-Type:application/json;charset=utf-8");
require_once('../../init.php');
echo $_REQUEST;
@$title=$_SESSION["title"];
@$md=$_REQUEST["md"];
@$html=$_REQUEST["html"];
@$posted_time=$_REQUEST["posted_time"];
@$category_id=$_REQUEST["category_id"];
@$stick=$_REQUEST["stick"];
$sql=sprintf("INSERT INTO zhs_article VALUES(NULL,$title,$md,$html,$posted_time,$category_id,'1','999','123','1',$stick,'',1,'');");
$result=mysqli_query($conn,$sql);
if($result){
	echo '{"code":1,"msg":"发表成功"}';
}else{
	echo '{"code":-1,"msg":"发表失败"}';
}