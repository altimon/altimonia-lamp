<?php
$link = mysql_connect('altimonia-sqldb.cxtdgg1qk2s5.us-east-1.rds.amazonaws.com', 'admin', 'altimonia-dbpassword');
if (!$link)
{
die('Could not connect: ' . mysql_error());
}
else
{
$selectdb = mysql_select_db("altimoniadb");
if (!$selectdb)
{
die('Could not connect: ' . mysql_error());
}
else
{
$data = mysql_query("SELECT visits FROM counter");
if (!$data)
{
die('Could not connect: ' . mysql_error());
}
else
{
$add=mysql_query("UPDATE counter SET visits = visits+1");
if(!$add)
{
die('Could not connect: ' . mysql_error());
}
else
{
print "<table><tr><th>Visits</th></tr>";
while($value=mysql_fetch_array($data))
{
print "<tr><td>".$value['visits']."</td></tr>";
}
print "</table>";
}
}
}
}
mysql_close($link);
?>
