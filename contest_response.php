<?php
include_once("config.php");
$loc = $_SESSION["user"]->getLocationProfile();
$id_worker = $_SESSION["user"]->getWorkerID();


if($_GET['type']==0){
    $id_order = $_GET["id_order"];
    $status = $_GET["status"];
	$sql="select cstatus from dbo.[contest] WHERE id_order=$id_order";
	$_SESSION["user"]->db->select($sql);
	$i=0;
	while ( $row = $_SESSION["user"]->db->fetchArray() ){
		$i++;
	}

	if($i>0){
		$sql0="UPDATE dbo.[order] set contest_status='".$status."' WHERE id=$id_order";
		if ($_SESSION["user"]->db->select($sql0))
			$data = 0;
		else{
			$sql1="UPDATE dbo.[contest] set cstatus='".$status."' WHERE id_order=$id_order";
			if ($_SESSION["user"]->db->select($sql1))
				$data = 0;
			else
				$data = $id_order;
		}
		
	}
	else{
		$sql="INSERT INTO dbo.[contest](id_order, cstatus)VALUES($id_order,'".$status."')";
       	if ($_SESSION["user"]->db->select($sql))
       		 $data = 0;
		 else
			 $data = $id_order;
	}
 }

if($_GET['type']==1){
    $sql_status = "select value as valor, description from dbo.contest_status order by id";
    $_SESSION["user"]->db->select($sql_status);
    $html ='<select name="cbx_status_'.$_GET['control_id'].'" id="cbx_status_'.$_GET['control_id'].'" style="width: 120px;">
                <option value="-1">Select Status</option>';
                while ( $row = $_SESSION["user"]->db->fetchArray() ){
                    $html .='<option value="'.$row['valor'].'">'.$row['description'].'</option>';
                }
    $html .='</select>';
    $data = $html."&".$_GET['control_id'];
}

if($_GET['type']==2){
    $id_order = $_GET["id_order"];
	$text = $_GET["text"];
    $sql="UPDATE dbo.contest set reason_cancel='".$text."' WHERE id_order=$id_order";
    if ($_SESSION["user"]->db->select($sql))
        $data = 0;
    else
        $data = 1;
 }
 
 if($_GET['type']==3){
	$id_order = $_GET["id_order"];
    $sql = "select reason_cancel from dbo.contest where id_order=$id_order";
    $_SESSION["user"]->db->select($sql);
	while ( $row = $_SESSION["user"]->db->fetchArray() ){
		$text = $row['reason_cancel'];
	}
    $data = $text;
}


 
 if($_GET['type']==4){
	$id_order = $_GET["id_order"];
    $sql = "select notes from dbo.contest where id_order=$id_order";
    $_SESSION["user"]->db->select($sql);
	while ( $row = $_SESSION["user"]->db->fetchArray() ){
		$text = $row['notes'];
	}
    $data = $text;
}

if($_GET['type']==5){
    $id_order = $_GET["id_order"];
	$text = $_GET["text"];
    $sql="UPDATE dbo.contest set notes='".$text."' WHERE id_order=$id_order";
    if ($_SESSION["user"]->db->select($sql))
        $data = 0;
    else
        $data = 1;
 }

echo $data;
