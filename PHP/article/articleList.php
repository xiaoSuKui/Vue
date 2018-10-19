<?php
header("Content-Type:application/json;charset=utf-8;");
require_once("../init.php");
$sql="select aid,title,html,posted_time,(select cname from zhs_category where cid=category_id) category,praise,pageView,(select path from zhs_img where aid=article_aid limit 0,1) img from zhs_article";
echo json_encode(sql_execute($sql));