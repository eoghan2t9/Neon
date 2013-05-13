<?php
include('./includes/loader.php');

if($LoggedIn === false){
	header("Location: index.php");
	die();
} else {

	if(!empty($_GET['action'])){
		$sAction = $_GET['action'];
	}
	
	if(!empty($_GET['domain'])){
		$uDomain = $_GET['domain'];
		if($sDomainReturn = $database->CachedQuery("SELECT * FROM domains WHERE `user_id` = :UserId AND `domain_name` = :Domain", array('UserId' => $sUser->sId, 'Domain' => $uDomain), 1)){
			$sDomain = $sDomainReturn->data[0]["domain_name"];
		} else {
			header("Location: dns.php");
			die();
		}
	}
	
	if(empty($sDomain)){
		if($sDomains = $database->CachedQuery("SELECT * FROM domains WHERE `user_id` = :UserId", array('UserId' => $sUser->sId), 1)){
			foreach($sDomains->data as $key => $value){
				$sDomainList[] = $value["domain_name"];
			}
		}
	}
	
	if(($sAction == view_records) && (!empty($sDomain))){
	
	}
	
	if(($sAction ==  edit_record) && (!empty($sDomain))){
	
	}
	
	if(($sAction == delete_record) && (!empty($sDomain))){
	
	}
	
	$sContent = Templater::AdvancedParse('/blue_default/dns', $locale->strings, array(
		'ErrorMessage'	=>	"",
		'DomainList' => $sDomainList,
		'Domain' => $sDomain,
	));
	echo Templater::AdvancedParse('/blue_default/master', $locale->strings, array(
		'PageTitle'  => "DNS Manager",
		'PageName'	=>	"dns",
		'ErrorMessage'	=>	"",
		'Content'	=>	$sContent
	));
}
?>