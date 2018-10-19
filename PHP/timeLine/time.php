<?php
header("Content-Type:application/json;charset=utf-8");
require_once("../init.php");

$sql="select title,posted_time, from zhs_banner ";
echo json_encode(sql_execute($sql));