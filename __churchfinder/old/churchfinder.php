<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>untitled</title>


	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAArF_W7LTIETLF9RjUNwQk4hQNlV6Z3wOP3TklmP5apSXjJq5sqRRUc817V68w-bCIYVDxh61uJIy6Zg" type="text/javascript"></script>
	<script src="prototype.js" type="text/javascript"></script>
	<script src="utility.js" type="text/javascript"></script>
	<script src="churchfinder.js" type="text/javascript"></script> 
	
	
	<style type="text/css" media="screen">@import url("/clients/diopa/modx/assets/templates/default/site.css");</style>
</head>
<body >
	<div id="churchFinder">
		<div id="map"></div>
		<div id="searchPanel">
			<form id="nameSearchForm" name="nameSearchForm">
				<label for="nameSearch">Search by Name</label>
				<input type="text" id="nameSearch" name="nameSearch" onkeyup="" />
				<input id="searchByNameButton" name="searchByNameButton" type="button" onClick="javascript:searchByName();" value="Search" />
			</form>
			<form id="deanerySearchForm" name="deanerySearchForm">
				<label for="deanerySearch">Search by Deanery</label>
				<input type="dropdown" id="deanerySearch" name="deanerySearch" onkeyup="" />
				<input id="searchByDeaneryButton" name="searchByDeaneryButton" type="button" onClick="javascript:searchByDeanery();" value="Search" />
			</form>
			<form id="addressSearchForm" name="addressSearchForm">
				<label for="addressSearch">Your Address</label>
				<input type="text" id="addressSearch" name="addressSearch" />
				<input id="searchbyAddress" name="searchbyAddress" type="button" onClick="javascript:map_address_recenter_zoom($F(addressSearch),$F(addressSearch),blueicon,11);" value="Search" />
			</form>
		</div>
		<div id="resultsPanel">
			<div id="searchResultsLabel">Search Results</div>
			<div id="status"></div>
			<div id="searchResults"></div>
		</div>
	</div>
</body>
</html>


