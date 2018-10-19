<?php
header("Content-Type:application/json;charset=utf-8");
require_once("../init.php");
$sql="select * from zhs_banner order by bid limit 0,5";
echo json_encode(sql_execute($sql));