


/*	document.getElementById("mapShowHideButton").onclick = function() {
		toggleVisible("map");
		return false;
	}
*/


/*,icon,recenter,zoom
var icon = (icon == null) ? redicon : icon;
var recenter = (recenter == null) ? false : true;
var zoom = (zoom == null) ? 10 : zoom;
*/
/*		if (recenter == true) { map.setCenter(point, 10); } */
		
/*			resultRow.style.backgroundColor =  "rgb(200,200,200);"*/
/*			resultRow.toggleClassName("highlight");*/
/*			resultsRows = this.getElementsByTagName("tr")*/


/*		GEvent.addListener(
			marker,
			"mouseover", 
			function() {
				resultRow.className = className + " highlight";
			}
		);	
		GEvent.addListener(
			marker,
			"mouseout", 
			function() {
				resultRow.className = "";
			}
		);
*/

/*	defaultNameSearch = 'Philadelphia Cathedral';*/
/*	document.nameSearchForm.nameSearch.value = defaultNameSearch;*/
/*	searchByName(defaultNameSearch);*/
/*function searchByDeanery(deanery) {
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

function showChurchesNearAddress(address,content,icon,zoom) {
	document.deanerySearchForm.deanerySearch.selectedIndex = 0;
	document.nameSearchForm.nameSearch.value = '';
	geocoder.getLatLng(
		address,
		function(point) {
			if (!point) {
			} else {
				map.setCenter(point, zoom); 
	        	var marker = new GMarker(point, icon);
				map_add_gpoint(point,marker,content);
			}
		}
	);	
	var pars = 'addressSearch=' + address; 
	churchSearch(pars);
}*/


/*function churchSearch(pars) {
	map.clearOverlays();
	var url = '/search';
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
*/

/*
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
*/


/*function Key(e){
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
*/