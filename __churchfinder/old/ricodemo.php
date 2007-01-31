<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>untitled</title>
	<meta name="generator" content="TextMate http://macromates.com/">
	<meta name="author" content="Loren Johnson">
	
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAArF_W7LTIETLF9RjUNwQk4hQNlV6Z3wOP3TklmP5apSXjJq5sqRRUc817V68w-bCIYVDxh61uJIy6Zg" type="text/javascript"></script>
	<script src="prototype.js" type="text/javascript"></script>
	<script src="rico.js" type="text/javascript"></script>
	
	<style type="text/css" media="screen">@import url("/clients/diopa/modx/assets/templates/default/site.css");</style>
	<style>
		.fixedTable {
			table-layout : fixed;
		}
		td {
			padding : 2px 0px 2px 3px;
			margin : 0px;
			border-bottom : 1px solid #b8b8b8;
			border-right : 1px solid #b8b8b8;
			height : 40px;
			overflow : hidden;
			font-size : 11px;
			font-family: "Lucida Grande", verdana, arial, helvetica, sans-serif;
			line-height: 12px;
			vertical-align:top;
		}
		.first {
			border-left : 1px solid #b8b8b8;
		}
			.tableCellHeader {
			padding : 2px 0px 2px 3px;
			text-align : left;
			font-size : 11px;
			border-top : 1px solid #b8b8b8;
			border-right : 1px solid #b8b8b8;
			background-color : #cedebd;
		}
	</style>

	<!-- Date: 2006-06-22 -->
</head>
<body onload="javascript:bodyOnLoad();" onunload="GUnload()">
	<div id="map" style="width: 740px; height: 300px"></div>
   	<form id="searchByName" action="ricodemo.php" method="get">
		<label for="nameSearch">Search by Name</label>
		<input type="text" id="nameSearch" name="nameSearch" value="<?= $_POST['nameSearch']?>" />
		<input type="submit" value="Search" />
	</form>

   	<form id="searchByAddress" action="ricodemo.php" method="get">
		<label for="addressSearch">Address</label>
		<input type="text" id="addressSearch" name="addressSearch" value="<?= $_POST['addressSearch']?>" />
		<input type="submit" value="Find Nearest Churches" />
	</form>

	 <script type="text/javascript">
	    //<![CDATA[
		function Querystring()
		{
		// get the query string, ignore the ? at the front.
			var querystring=location.search.substring(1,location.search.length);

		// parse out name/value pairs separated via &
			var args = querystring.split('&');

		// split out each name = value pair
			for (var i=0;i<args.length;i++)
			{
				var pair = args[i].split('=');

				// Fix broken unescaping
				temp = unescape(pair[0]).split('+');
				name = temp.join(' ');

				temp = unescape(pair[1]).split('+');
				value = temp.join(' ');

				this[name]=value;
			}

			this.get=Querystring_get;
		}

		function Querystring_get(strKey,strDefault)
		{
			var value=this[strKey];
			if (value==null)
			{
				value=strDefault;
			}

			return value;
		}
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

	// Function called to create the LiveGrid :
	// opt are used for sorting columns
	// 4 parameters : table id to scroll, number of lines to display,
	// total number of lines in table, and request handler url that we will write after
	// (xml_maker.php)
	function bodyOnLoad()
	{
	QueryString();
	var nameSearch = 'nameSearch=' + QueryString_get('nameSearch','');
	alert(nameSearch);
	var opts = { 
			prefetchBuffer: true, onscroll : updateHeader,
			sortAscendImg: 'your_path/images/sort_asc.gif',
			sortDescendImg: 'your_path/images/sort_desc.gif',
			requestParameters: nameSearch
		};
	//dont forget to upload the .gif on your server
	parishes_grid = new Rico.LiveGrid ("data_grid",10, 160, "xml_maker.php", opts);
	alert(document.getElementById("test").innerHTML = parishes_grid.options.requestParameters[0].value);
	}
	
	// the following function sets the header when scrolling and sorting and makes bookmarks 
	// possible saving parameters
	function updateHeader( liveGrid, offset ) {
	//	$('bookmark').innerHTML = "Listing records " + (offset+1) + " - " + (offset+liveGrid.metaData.getPageSize()) + " of " + liveGrid.metaData.getTotalRows();
		var sortInfo = "";
		if (liveGrid.sortCol) {
			sortInfo = "&data_grid_sort_col=" + liveGrid.sortCol + "&data_grid_sort_dir=" + liveGrid.sortDir;
		}
	//	$('bookmark').href="ricodemo.php" + "?data_grid_index=" + offset + sortInfo;
	} 
	</script>
	<table id="data_grid_header" class="fixedTable" cellspacing="0" cellpadding="0" style="width:760px">
		<tr>
			<th class="first tableCellHeader" style="text-align:center">Name</th>
			<th class="tableCellHeader" style="text-align:center">Address</th>
			<th class="tableCellHeader" style="text-align:center">Phone</th>
			<th class="tableCellHeader" style="text-align:center">Website</th>
			<th class="tableCellHeader" style="text-align:center">Deanery</th>
		</tr>
	</table>

	<div id="viewPort" style="float:left">
	<table id="data_grid" class="fixedTable" cellspacing="0" cellpadding="0" style="width:760px; border-left:1px solid #ababab">
	<?
	    include("utility.php");
		$username="fngroup";
		$password="500400590";
		$database="diopa";
		$database=$username."_".$database;

		mysql_connect(localhost,$username,$password);
		@mysql_select_db($database) or die( "Unable to select database");
		$query="SELECT * FROM directory_orgs WHERE org_name LIKE '%%" . $_GET['nameSearch'] . "%%' ORDER BY org_deanery, org_name LIMIT 11 ";

		$result=mysql_query($query);
		
		$num = mysql_num_rows($result);
		$nb_msg = mysql_num_rows($result);

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
			$website_url=(mysql_result($result,$i,"org_website_url") ? mysql_result($result,$i,"org_website_url") : "" );
			$deanery=mysql_result($result,$i,"org_deanery");
		?>
			<tr>
				<td>
					<?= $name ?>
				</td>
				<td>
					<?= $address_line1 ?><br />
					<?= $address_line2 ? ("<br />" . $address_line2) : "" ?>
					<?= $address_city ?>, <?= $address_state ?> <?= $address_zip ?>
				</td>
				<td>
					<?= $phone ?> Phone
					<?= $fax ? ("<br />" . $fax . " Fax") : "" ?>
				</td>
				<td>
					<?= $website_url ? ("<p><a href='http://".$website_url."'>".$website_url."</a></p>") : ""  ?>
				</td>
				<td>
					<?= $deanery ?>
				</td>
					<div id="org_id" name="org_id" style="display:none;"><?= $org_id ?></div>
					<div id="map_address" name="map_address" style="display:none;"><?= $address_line1 ?>,<?= $address_state ?> <?= substr($address_zip,0,5) ?></div>	
					<script type="text/javascript">
				    //<![CDATA[
						add_address(document.getElementById("org_id").innerHTML, document.getElementById("map_address").innerHTML,redicon); 
					//	add_address(<?=$org_id?>, <?= $address_line1 ?>,<?= $address_state ?> <?= substr($address_zip,0,5) ?>); 
				    //]]>
				    </script>
				</td>
			</tr>
		<?
		$deanery_temp=$deanery;
		$i++;
		}
		?>
		</table>
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
