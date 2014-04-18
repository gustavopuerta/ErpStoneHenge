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
//---------------------------------------------------------------------




$smarty->display('contest_cancellation.tpl');