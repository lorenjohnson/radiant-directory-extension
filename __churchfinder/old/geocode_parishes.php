<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>untitled</title>
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAArF_W7LTIETLF9RjUNwQk4hQNlV6Z3wOP3TklmP5apSXjJq5sqRRUc817V68w-bCIYVDxh61uJIy6Zg" type="text/javascript"></script>
	<style type="text/css" media="screen">@import url("/clients/diopa/modx/assets/templates/default/site.css");</style>
</head>
<body>

<script type="text/javascript">
geocoder = new GClientGeocoder();
</script>

<?php
    include("utility.php");
	$username="fngroup";
	$password="500400590";
	$database="diopa";
	$database=$username."_".$database;

	mysql_connect(localhost,$username,$password);
	@mysql_select_db($database) or die( "Unable to select database");
	$query="SELECT * FROM directory_orgs WHERE org_name LIKE '%%" . $_POST['nameSearch'] . "%%' ORDER BY org_deanery, org_name";
	$query="SELECT * FROM directory_orgs WHERE org_name LIKE '%%%%' ORDER BY org_deanery, org_name";
	
	$result=mysql_query($query);
	$num=mysql_numrows($result);

	$i=0;
	while ($i < $num) {
		$org_id=mysql_result($result,$i,"org_id");
		$name=mysql_result($result,$i,"org_name");
		$address_line1=mysql_result($result,$i,"org_address_line1");
		$address_city=mysql_result($result,$i,"org_address_city");
		$address_state=mysql_result($result,$i,"org_address_state");
		$address_zip=substr(mysql_result($result,$i,"org_address_zip"),0,5);
		$phone=format_phone(mysql_result($result,$i,"org_phone"));
		$fax=format_phone(mysql_result($result,$i,"org_fax"));
		$website_url=(mysql_result($result,$i,"org_website_url") ? mysql_result($result,$i,"org_website_url") : "" );
		$deanery=mysql_result($result,$i,"org_deanery");
		echo <<<EOT
		<span id="$org_id"></span>
		<script type="text/javascript">
			geocoder.getLatLng(
				"$address_line1, $address_city, $address_state $address_zip",
				function(point) {
					if (!point) {
						alert("$name"); 
					} else {
						document.getElementById("$org_id").innerHTML = "$org_id," + point.lat() + ", " + point.lng() + "<br />";
					}
				}
			);
		</script>
EOT;
	//	$update = "UPDATE directory_orgs SET lat = ""$lat"", lng = ""$lng"" WHERE org_id = $org_id";
		
		$i++;
	}
	mysql_close();
?>
</body>
</html>
