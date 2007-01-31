<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <title>Episcopal Diocese of Pennsylvania - Church Finder</title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAArF_W7LTIETLF9RjUNwQk4hQNlV6Z3wOP3TklmP5apSXjJq5sqRRUc817V68w-bCIYVDxh61uJIy6Zg" type="text/javascript"></script>
	<script type="text/javascript" src="prototype.js"></script>
	<script type="text/javascript" src="rico.js"></script> 
	<style type="text/css" media="screen">@import url("/clients/diopa/modx/assets/templates/default/site.css");</style>
 </head>
  <body onunload="GUnload()" >
	<div id="map" style="width: 740px; height: 300px"></div>
	<p id="message" name="message"></p>	
   	<form id="searchByName" action="mashup.php" method="post">
		<p>
			<label for="nameSearch">Search by Name</label>
			<input type="text" id="nameSearch" name="nameSearch" value="<?= $_POST['nameSearch']?>" />
			<input type="submit" value="Search" />
		</p>
	</form>

   	<form id="searchByAddress" action="mashup.php" method="post">
		<p>
			<label for="addressSearch">Address</label>
			<input type="text" id="addressSearch" name="addressSearch" value="<?= $_POST['addressSearch']?>" />
			<input type="submit" value="Find Nearest Churches" />
		</p>
	</form>
	
 <script type="text/javascript">
    //<![CDATA[
    var map = new GMap2(document.getElementById("map"));
	var geocoder = new GClientGeocoder();

	// Create our "tiny" marker icon
	var redicon = new GIcon();
	redicon.image = "http://labs.google.com/ridefinder/images/mm_20_red.png";
	redicon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
	redicon.iconSize = new GSize(12, 20);
	redicon.shadowSize = new GSize(22, 20);
	redicon.iconAnchor = new GPoint(6, 20);
	redicon.infoWindowAnchor = new GPoint(5, 1);

	// Create our "tiny" marker icon
	var blueicon = new GIcon();
	blueicon.image = "http://labs.google.com/ridefinder/images/mm_20_blue.png";
	blueicon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
	blueicon.iconSize = new GSize(12, 20);
	blueicon.shadowSize = new GSize(22, 20);
	blueicon.iconAnchor = new GPoint(6, 20);
	blueicon.infoWindowAnchor = new GPoint(5, 1);

	
	function load() {
      if (GBrowserIsCompatible()) {
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(39.9573856055042, -75.17532348632812), 10);
      }
    }

	load();
	
	function add_address(content,address,icon) {
		geocoder.getLatLng(
			address,
			function(point) {
				if (!point) {
					/* alert(address + " - " + org_id + " not found"); */
				} else {
		        	var marker = new GMarker(point, icon);
		        	map.addOverlay(marker);
				  	GEvent.addListener(
						marker, 
						"click", 
						function() {
				    		marker.openInfoWindowHtml(document.getElementById(content).innerHTML);
						}
					);
				}
			}
		);
	}

	function address_recenter_zoom(address,zoom) {
		geocoder.getLatLng(
			address,
			function(point) {
				if (!point) {
					/* alert(address + " - " + org_id + " not found"); */
				} else {
					map.setCenter(point, zoom); 
				}
			}
		);
	}
	

/*	GEvent.addListener(map, "moveend", function() {
		var center = map.getCenter();
		document.getElementById("message").innerHTML = center.toString();
	});
*/
	
    //]]>
	</script>
	<div id="viewPort" style="float:left">
		<table id="data_grid" class="fixedTable" cellspacing="0" cellpadding="0" style="float:left;width:560px; border-left:1px solid #ababab">



	</div>
<div style="display:none;" id="addressSearchQuery"><?= $_POST['addressSearch'] ?></div>
<?php
	if ( $_POST['addressSearch'] <> "" ) { ?>
		
<script type="text/javascript">
	//<![CDATA[
	add_address("Your Address: ", document.getElementById("addressSearchQuery").innerHTML,blueicon); 
	address_recenter_zoom(document.getElementById("addressSearchQuery").innerHTML, 11);
//]]>
</script>

<?php
	}
?>

</body>
</html>