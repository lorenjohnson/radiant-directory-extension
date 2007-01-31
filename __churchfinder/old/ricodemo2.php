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
	
		#data_grid {
			table-layout : fixed;
			width:780px;
			border-left:1px solid #ababab;
		}
		.fixedTable td {
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

</head>
<body onload="javascript:bodyOnLoad();" onunload="GUnload()">
	<div id="map" style="width: 780px; height: 300px"></div>

	<form id="nameSearchForm">
		<label for="nameSearch">Search by Name</label>
		<input type="text" id="nameSearch" name="nameSearch" value="<?= $_GET['nameSearch']?>" onkeyup="javascript:searchByName();" />
		<input type="button" onClick="javascript:searchByName();" value="Search" />
	</form>

	<label for="addressSearch">Your Address</label>
	<input type="text" id="addressSearch" name="addressSearch" value="<?= $_GET['addressSearch']?>" />
	<input type="button" value="Show Nearby Churches" onClick="javascript:searchByProximity();" >

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
	    map = new GMap2(document.getElementById("map"));
		geocoder = new GClientGeocoder();

		// Create our "tiny" marker icon
		redicon = new GIcon();
		redicon.image = "http://labs.google.com/ridefinder/images/mm_20_red.png";
		redicon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
		redicon.iconSize = new GSize(12, 20);
		redicon.shadowSize = new GSize(22, 20);
		redicon.iconAnchor = new GPoint(6, 20);
		redicon.infoWindowAnchor = new GPoint(5, 1);

		// Create our "tiny" marker icon
		blueicon = new GIcon();
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
					    		marker.openInfoWindowHtml(content);
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
	var myGrid;
	
	function bodyOnLoad()
	{
		var qs = new Querystring();
		var nameSearch = 'nameSearch=' + $('nameSearchForm').nameSearch.value;
		var opts = { 
				prefetchBuffer: true, 
				onscroll : updateHeader,
				sortAscendImg: 'your_path/images/sort_asc.gif',
				sortDescendImg: 'your_path/images/sort_desc.gif',
				requestParameters: nameSearch
			};
		//dont forget to upload the .gif on your server
		myGrid = new Rico.LiveGrid ("data_grid",11, 160, "xml_maker.php", opts);
	}
	
	// the following function sets the header when scrolling and sorting and makes bookmarks 
	// possible saving parameters
	function updateHeader( liveGrid, offset ) {
		$('bookmark').innerHTML = "Listing records " + (offset+1) + " - " + (offset+liveGrid.metaData.getPageSize()) + " of " + liveGrid.metaData.getTotalRows();
		var sortInfo = "";
		if (liveGrid.sortCol) {
			sortInfo = "&data_grid_sort_col=" + liveGrid.sortCol + "&data_grid_sort_dir=" + liveGrid.sortDir;
					}
		$('bookmark').href="ricodemo2.php" + "?data_grid_index=" + offset + sortInfo;
		map.clearOverlays();
		document.getElementById("debug").innerHTML = "";
		for(i=0; i<10; i++) { 
			address = $("data_grid").rows[i].cells[9].innerHTML;
			lat = $("data_grid").rows[i].cells[10].innerHTML;
			lng = $("data_grid").rows[i].cells[11].innerHTML;
			var point = new GLatLng(lat,lng); 
			if (!point) {}
			else {
				var marker = new GMarker(point,redicon);
	        	map.addOverlay(marker);
			  	GEvent.addListener(
					marker, 
					"click", 
					function() {
			    	marker.openInfoWindowHtml(address);
					}
				); 
			} 
			document.getElementById("debug").innerHTML += ("<br />address: " + address + "<br />"+ lat + ", " + lng);
		} 
	} 

	
	function mapResults()
	{
/*		myGrid.fetchBuffer(0, false, true); */
/*		myGrid.requestContentRefresh(0, true); */
	}
	
	function searchByName(text) {
		var nameSearch =  'nameSearch=' + $('nameSearchForm').nameSearch.value;
		myGrid.setRequestParams(nameSearch);
		myGrid.resetContents();
		myGrid.fetchBuffer(0);
//		updateHeader(myGrid,0);
		alert(nameSearch);
	}
	function searchByProximity(text)
	{
		
		add_address("Your Address: ", $("addressSearch").value,blueicon); 
		address_recenter_zoom($("addressSearch").value, 11);
	}
	</script>
	<a id="bookmark"></a>
	<table id="data_grid_header" class="fixedTable" cellspacing="0" cellpadding="0">
		<tr>
			<th class="first tableCellHeader" style="text-align:center">Name</th>
			<th class="tableCellHeader">Address</th>
			<th class="tableCellHeader">City</th>
			<th class="tableCellHeader">State</th>
			<th class="tableCellHeader">Zip</th>
			<th class="tableCellHeader">Phone</th>
			<th class="tableCellHeader">Fax</th>
			<th class="tableCellHeader">Website</th>
			<th class="tableCellHeader">Deanery</th>
			<th class="tableCellHeader" style="display:none;">map_address</th>
			<th class="tableCellHeader" style="display:none;">lat</th>
			<th class="tableCellHeader" style="display:none;">lng</th>
		</tr>
	</table>
	<div id="viewPort" style="float:left">
	<table id="data_grid" class="fixedTable">
		<? 
		$i=0;
		while($i<10) {
		?>
		<tr>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell"></td>
			<td class="cell" style="display:none;"></td>
			<td class="cell" style="display:none;"></td>
			<td class="cell" style="display:none;"></td>
		</tr>
		<? 
		$i++;
		} 
		?>
	</table>
	</div>
	<div id="debug"></div>
</body>
</html>
