<?php
include_once("config.php");
$loc = $_SESSION["user"]->getLocationProfile();
$id_worker = $_SESSION["user"]->getWorkerID();
include('Smarty.class.php');
$smarty = new Smarty;

//H E A D E R - MENU  --------------------------------------------------
$smarty->assign('user_profile',$_SESSION['user']->getUserName());
global $css_color,$date_format;
$smarty->assign('css_color',$css_color);
$smarty->assign('time',date($date_format,time()));
$smarty->assign('menulink',$_SESSION['user']->getMenuLink());
//----------------------------------------------------------------------

$sql = "SELECT DISTINCT o.id as id, o.address as address, o.town as town, vcr.fname + ' ' + vcr.lname AS cr_name,CONVERT(VARCHAR(10),o.date_contest ,101)+' '+CONVERT(VARCHAR(8),o.date_contest, 108) as pickup_dates,
               o.contest_status AS cstatus
          FROM dbo.[order] AS o INNER JOIN
               dbo.account AS a ON a.id = o.id_account INNER JOIN
               dbo.location AS al ON al.id = o.id_location INNER JOIN
               dbo.pay_level AS pl ON pl.id = a.id_pay_level LEFT OUTER JOIN
               dbo.worker AS vcr ON o.cr_user = vcr.id LEFT OUTER JOIN
               dbo.worker AS wy ON o.yard_salesman = wy.id LEFT OUTER JOIN
               dbo.v_user AS vc ON o.id_confirm = vc.user_id LEFT OUTER JOIN
               dbo.ord_status AS os ON o.status = os.value
         where o.contest = 1";
$_SESSION["user"]->db->select($sql);
$data = $_SESSION["user"]->db->fetchAllArrays();
//
$smarty->assign('data', $data);
$smarty->display('contest_cl.tpl');