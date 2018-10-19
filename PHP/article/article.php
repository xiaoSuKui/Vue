<?php
header("Content-Type:application/json;charset=utf-8");
require_once('../init.php');
$aid=$_REQUEST['aid'];
$sql=sprintf('select aid,title,html,posted_time,(select cname from zhs_category where category_id=cid) category,(select monicker from zhs_user where uid=user_id) uname from zhs_article where aid=%d',$aid);
echo json_encode(sql_execute($sql));