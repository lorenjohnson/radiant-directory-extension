function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    }
  }
}

addLoadEvent(map_load);
/*addLoadEvent();*/
/*addLoadEvent(map_address_add("#{@proximity_search_address}","<b>Your address:</b><br />#{@proximity_search_address}"));*/
// addLoadEvent(convertRowsToLinks("searchResults"));
var map
var geocoder
var redicon
var blueicon
var gpointsArray = []
var search_address

function map_load() {
  if (GBrowserIsCompatible()) {

	var map_div = document.getElementById("map");

  	map = new GMap2(map_div); 
  	geocoder = new GClientGeocoder();

  	// Default base icon
  	var baseicon = new GIcon();
  	baseicon.image = '/images/mm_20_red.png';
  	baseicon.iconSize = new GSize(12, 20);
  	baseicon.iconAnchor = new GPoint(6, 20);
  	baseicon.infoWindowAnchor = new GPoint(5, 1);

  	// Red icon
  	redicon = new GIcon(baseicon);

  	// Blue icon
  	blueicon = new GIcon(baseicon);
  	blueicon.image = '/images/mm_20_blue.png';

  	map.addControl(new GSmallMapControl());
  	map.addControl(new GMapTypeControl());
    // map.setCenter(new GLatLng(45.5313220000000029585862648673355579376220703125, -122.693084), 5);
	if(search_address) {
		map_address_add(search_address,"Your address:<br />" + search_address);
	}
	add_markers();
  // resize(map,gpointsArray);
  }
} 
window.unload = function() {
	GUnload();
}

function map_address_add(address,content,icon) {
	var icon = (icon == null) ? blueicon : icon;
	geocoder.getLatLng(
		address,
		function(point) {
			if (!point) {
				/* put message here indicating that this address was able to be mapped  */
			} else {
	        	marker = new GMarker(point, { icon:icon, title:address });
				GEvent.addListener(marker, "click", function() { 
					marker.openInfoWindowHtml(content); 
				});	
				map.addOverlay(marker);
				resize(map, gpointsArray);
			}
		}
	);
}

function resize(map, points) {
	// by peter@boring.ch
	// please let me know if it works for you.

	// we have to resort to the old 'GBounds' object with it's old 'minX' etc. properties that
	// actuallay represent lat/lng values. quite weird...
	var bounds = new GBounds(points);

	var sw = new GLatLng(bounds.maxY, bounds.minX);
	var ne = new GLatLng(bounds.minY, bounds.maxX);

	var latLngBounds = new GLatLngBounds(sw, ne);

	var center = latLngBounds.getCenter();
	var zoom = map.getBoundsZoomLevel(latLngBounds);
	map.setCenter(center, zoom);
}

function add_markers() {
	for(var i=0; i < points_array.length; i++) {
		add_marker(points_array[i]);
		if(points_array[i][0] && points_array[i][1]) {
			gpointsArray[i] = new GLatLng(points_array[i][0],points_array[i][1]);
		}
	}
}

function add_marker(point) {
	var lat = point[0];
	var lng = point[1];
	var resultRow = document.getElementById(point[4]);
	if(lat && lng) {
		var label = point[2];
		var infoWindow = document.getElementById(point[3]);
		Element.extend(resultRow);

		var gpoint = new GLatLng(lat,lng);
		var marker = new GMarker(gpoint, { icon:redicon, title:label } );
		GEvent.addListener(marker, "click", function() { 
			marker.openInfoWindow(infoWindow); 
		});	
		GEvent.addListener(marker, "infowindowopen", 
			function() { 
				resultRow.getElementsByClassName("detail")[0].show();
				resultRow.addClassName("highlight");
			});
		GEvent.addListener(marker, "infowindowclose", 
			function() { 
				resultRow.getElementsByClassName("detail")[0].hide();
				resultRow.removeClassName("highlight");
			});
		GEvent.addListener(marker, "click", function() {
			resultRow.scrollIntoView(true);			
		});
		map.addOverlay(marker);							
		resultRow.onclick = function() {
			marker.openInfoWindow(infoWindow);
			$('searchResults').getElementsByClassName('result').each(
				function(r) { 
					if(r.hasClassName("highlight")) { 
						r.removeClassName("highlight");
						r.getElementsByClassName("detail")[0].hide();
					} 
				}
			);
		}
	} else {
		resultRow.onclick = function() {
			$('searchResults').getElementsByClassName('result').each(
				function(r) { 
					if(r.hasClassName("highlight")) { 
						r.removeClassName("highlight");
						r.getElementsByClassName("detail")[0].hide();
					} 
				}
			);
			map.closeInfoWindow();
			resultRow.getElementsByClassName("detail")[0].show();
			resultRow.addClassName("highlight");
		}			
	}
}

function convertRowsToLinks(xTableId) {
  var rows = document.getElementById(xTableId).getElementsByTagName("tr");
  for(i=0;i<rows.length;i++){
    var link = rows[i].getElementsByTagName("a")
    if(link.length == 1){
      rows[i].onclick = new Function("document.location.href='" + link[0].href + "'");
    }
  }
}
