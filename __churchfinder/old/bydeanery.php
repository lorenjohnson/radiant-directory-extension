<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>untitled</title>
	<meta name="generator" content="TextMate http://macromates.com/">
	<meta name="author" content="Loren Johnson">
	<!-- Date: 2006-06-20 -->
</head>
<body>

<?php
include("utility.php");
$username="fngroup";
$password="500400590";
$database="diopa";
$database=$username."_".$database;

mysql_connect(localhost,$username,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="SELECT * FROM directory_orgs WHERE org_name LIKE '%%%%' ORDER BY org_deanery, org_name ";
$result=mysql_query($query);

$num=mysql_numrows($result);

mysql_close();

$i=0;
while ($i < $num) {
	$org_id=mysql_result($result,$i,"org_id");
	$name=mysql_result($result,$i,"org_name");
	$address_line1=mysql_result($result,$i,"org_address_line1");
	$address_city=mysql_result($result,$i,"org_address_city");
	$address_state=mysql_result($result,$i,"org_address_state");
	$address_zip=mysql_result($result,$i,"org_address_zip");
	$phone=format_phone(mysql_result($result,$i,"org_phone"));
	$fax=format_phone(mysql_result($result,$i,"org_fax"));
	$website_url=(mysql_result($result,$i,"org_website_url") ? "http://".mysql_result($result,$i,"org_website_url") : "" );
	$deanery=mysql_result($result,$i,"org_deanery");
	
	if (strcasecmp($deanery, $deanery_temp) <> 0)  {  
?>
<h1><?= $deanery ?></h1>
<?	} ?>

<h2>
	<?= $name ?>
</h2>
<p>
	<?= $address_line1 ?><br />
	<?= $address_line2 ? ("<br />" . $address_line2) : "" ?>
	<?= $address_city ?>, <?= $address_state ?> <?= $address_zip ?>
</p>
<p>
	<?= $phone ?> Phone
	<?= $fax ? ("<br />" . $fax . " Fax") : "" ?>
</p>
<?= $website_url ? ("<p><a href='http://".$website_url."'>".$website_url."</a></p>") : ""  ?>
<p>
   <a href="index.php?id=54&org_id=<?=$org_id?>">Update</a>
</p>
<?
$deanery_temp=$deanery;
$i++;
}
?>
</body>
</html>
