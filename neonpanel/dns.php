<?php
include('./includes/loader.php');

if($LoggedIn === false){
	header("Location: index.php");
	die();
} else {
	
	// Get the variables if they exist and check them.
	if(!empty($_GET['action'])){
		$sAction = $_GET['action'];
	}
	
	if(!empty($_GET['domain'])){
		$uDomain = $_GET['domain'];
		if($sDomainReturn = $database->CachedQuery("SELECT * FROM domains WHERE `user_id` = :UserId AND `domain_name` = :Domain", array(':UserId' => $sUser->sId, ':Domain' => $uDomain), 1)){
			$sDomain = $sDomainReturn->data[0]["domain_name"];
		} else {
			header("Location: dns.php");
			die();
		}
	}
	
	// Perform actions before loading records.
	if(($sAction ==  edit_record) && (!empty($sDomain))){
	
	}
	
	if(($sAction == delete_record) && (!empty($sDomain))){
	
	}
	
	if(($sAction == add_record) && (!empty($sDomain))){
		$sName = $_POST['name'];
		$sType = $_POST['type'];
		$sContent = $_POST['content'];
		if($sDomain = $database->CachedQuery("SELECT * FROM dns.domains WHERE `name` = :Domain", array(':Domain' => $sDomain), 1)){
			$sAdd = $database->CachedQuery("INSERT INTO dns.records(domain_id, name, type, content, ttl, prio) VALUES(:DomainId, :Name, :Type, :Content, :TTL, :Prio)", array(':DomainId' => $sDomain->sId, ':Name' => $sName, ':Type' => $sType, ':Content' => $sContent, ':TTL' => "120", ':Prio' => "0"), 1);
		}
	}
	
	// Setup domain list if the user hasn't selected a domain yet.
	if(empty($sDomain)){
		if($sDomains = $database->CachedQuery("SELECT * FROM domains WHERE `user_id` = :UserId", array(':UserId' => $sUser->sId), 1)){
			foreach($sDomains->data as $key => $value){
				$sDomainList[] = $value["domain_name"];
			}
		}
	}
	
	// Setup a list of records if the user has already selected a domain.
	if(!empty($sDomain)){
		if($sPowerDomain = $database->CachedQuery("SELECT * FROM dns.domains WHERE `name` = :Domain", array(':Domain' => $sDomain), 1)){
			$sPowerRecords = $database->CachedQuery("SELECT * FROM dns.records WHERE `domain_id` = :DomainId", array(':DomainId' => $sPowerDomain->data[0]["id"]), 1);
			foreach($sPowerRecords->data as $key => $value){
				$sRecords[] = array("name" => $value["name"], "type" => $value["type"], "content" => $value["content"]);
			}
		}
	}
	
	// Display result to user.
	$sContent = Templater::AdvancedParse('/blue_default/dns', $locale->strings, array(
		'ErrorMessage'	=>	"",
		'DomainList' => $sDomainList,
		'Domain' => $sDomain,
		'Records' => $sRecords,
	));
	echo Templater::AdvancedParse('/blue_default/master', $locale->strings, array(
		'PageTitle'  => "DNS Manager",
		'PageName'	=>	"dns",
		'ErrorMessage'	=>	"",
		'Content'	=>	$sContent
	));
}
?>