<?php
set_time_limit(0);
include('./includes/loader.php');

if($LoggedIn === false){
	header("Location: index.php");
	die();
}

function get_json($url){
	$base = "https://api.github.com/";
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $base . $url);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 GTB5');
	$content = curl_exec($curl);
	curl_close($curl);
	return $content;
}

function get_commits($type){
  return json_decode(get_json("repos/BlueVM/Neon/commits/$type"),true);
}

$sDevelop = get_commits("develop");

if($sDevelop["sha"] != $sVersion->sValue){
	if(!empty($_GET['id'])){
			if (!$user_ssh->login($sUser->sUsername, $_SESSION['password'])) { exit('User Connection To Server Failed!');}
			$sUpdate = $user_ssh->exec('cd /var/neon/ >> /var/log/neon-update.log 2>&1; git pull >> /var/log/neon-update.log 2>&1; cd /var/neon/data/update/ >> /var/log/neon-update.log 2>&1; sh update.sh >> /var/log/neon-update.log 2>&1;');
			$sVersion = get_commits("develop");
			$sData = Core::UpdateSetting('version', $sVersion["sha"]);
			$array = array("content" => "Neon is now up to date.");
	}
} else {
	$array = array("content" => "Neon is now up to date.");
}

echo json_encode($array);
?>