This is a quick mock panel created with a single hardcoded command to execute on the bot, the intention was for it to be both too simple to be a ready made tool but also complete enough to be able to generate signatures and test environments.

You can change the server IP in the bot script and it should work fine
$URL="http://192.168.1.91";

If you don't want the log file in the php side then just remove it.


Files:
first.ps1 - ver1 of bot script
index_first.php - php for ver1 of bot
second.ps1 - more recent version of bot script
generic_version.php - more generic php for both versions of bot
