var map;
var geocoder;
var redicon;
var blueicon;
var markerContent = new Array();

window.onload = function bodyOnLoad() {
	if (GBrowserIsCompatible()) {
		map = new GMap2($('map')); 
		geocoder = new GClientGeocoder();
		// Create our red "tiny" marker icon
		redicon = new GIcon();
		redicon.image = 'assets/snippets/churchfinder/images/mm_20_red.png';
//		redicon.shadow = 'assets/snippets/churchfinder/images/mm_20_shadow.png';
		redicon.iconSize = new GSize(12, 20);
//		redicon.shadowSize = new GSize(22, 20);
		redicon.iconAnchor = new GPoint(6, 20);
		redicon.infoWindowAnchor = new GPoint(5, 1);

		// Create our blue "tiny" marker icon
		blueicon = new GIcon();
		blueicon.image = 'assets/snippets/churchfinder/images/mm_20_blue.png';
//		blueicon.shadow = 'assets/snippets/churchfinder/images/mm_20_shadow.png';
		blueicon.iconSize = new GSize(12, 20);
//		blueicon.shadowSize = new GSize(22, 20);
		blueicon.iconAnchor = new GPoint(6, 20);
		blueicon.infoWindowAnchor = new GPoint(5, 1);
		
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		map.setCenter(new GLatLng(39.9573856055042, -75.17532348632812), 10);
	}
	defaultNameSearch = 'Philadelphia Cathedral';
	document.nameSearchForm.nameSearch.value = defaultNameSearch;
	searchByName(defaultNameSearch);
}

function searchByDeanery(deanery) {
	var deanerySearch = (($F('deanerySearch') !== '') ? $F('deanerySearch') : deanery);
	document.nameSearchForm.nameSearch.value = '';
	document.addressSearchForm.addressSearch.value = '';
	var pars = 'deanerySearch=' + deanerySearch;
	churchSearch(pars);
}

function searchByName(name) {
	var nameSearch = (($F('nameSearch') !== '') ? $F('nameSearch') : name);
	document.deanerySearchForm.deanerySearch.selectedIndex = 0;
	document.addressSearchForm.addressSearch.value = '';
	var pars = 'nameSearch=' + nameSearch;
	churchSearch(pars);
}

function showAllParishes() {
	document.getElementById('nameSearch').value = ' ';
	var pars = 'nameSearch=' + ' ';
	churchSearch(pars);
}

function churchSearch(pars) {
	map.clearOverlays();
	var url = 'assets/snippets/churchfinder/churcheshtml.php';
	var myAjax = new Ajax.Updater(
		'searchResults',
		url, 
		{
			method: 'get', 
			parameters: pars,
			evalScripts: true,
			onLoading: function() { $('status').innerHTML = 'Loading, please wait...'; },
			onComplete: function() { $('status').innerHTML = 'Search complete.'; }
		});
}

function showChurchesNearAddress(address,content,icon,zoom) {
	document.deanerySearchForm.deanerySearch.selectedIndex = 0;
	document.nameSearchForm.nameSearch.value = '';
	geocoder.getLatLng(
		address,
		function(point) {
			if (!point) {
				/* alert(address + " - " + org_id + " not found"); */
			} else {
				map.setCenter(point, zoom); 
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
	showAllParishes();
}

function map_results() {
	var rows =  $('churches').rows;
	var total_rows = rows.length;
	for(i=0; i < total_rows; i++) {
		id = rows[i].cells[0].innerHTML
		markerContent[i] = rows[i].cells[1].innerHTML
		lat = rows[i].cells[2].innerHTML
		lng = rows[i].cells[3].innerHTML

		if( !(lat== 0) && !(lng==0) ) {
			var point = new GLatLng(lat,lng);
			var marker = new GMarker(point, redicon);
			map.addOverlay(marker);
			GEvent.addListener(
				marker, 
				"click", 
				function() { marker.openInfoWindowHtml(markerContent[i]); }
			);
		}		
	}
//	rows.each( function(row,index) {	} );
}

function map_address_add(address,content,icon) {
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

function Key(e){
 try {
   var key = window.event.keyCode;
 } catch(ex){
   var key = e.which;
 }
 if(key == 13){
   return searchByName(); // we execute our AJAX program if the enter key was pressed.
 }
}

try {
	document.addEventListener("keypress", Key, true);
} catch(e){
	try {
		document.attachEvent("onkeypress", Key);
	} catch(e){
		searchByName();
	}
}