map = new GMap2(document.getElementById("map"));
geocoder = new GClientGeocoder();

// Create our red "tiny" marker icon
redicon = new GIcon();
redicon.image = "http://labs.google.com/ridefinder/images/mm_20_red.png";
redicon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
redicon.iconSize = new GSize(12, 20);
redicon.shadowSize = new GSize(22, 20);
redicon.iconAnchor = new GPoint(6, 20);
redicon.infoWindowAnchor = new GPoint(5, 1);

// Create our blue "tiny" marker icon
blueicon = new GIcon();
blueicon.image = "http://labs.google.com/ridefinder/images/mm_20_blue.png";
blueicon.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
blueicon.iconSize = new GSize(12, 20);
blueicon.shadowSize = new GSize(22, 20);
blueicon.iconAnchor = new GPoint(6, 20);
blueicon.infoWindowAnchor = new GPoint(5, 1);

function gmap_load() {
  if (GBrowserIsCompatible()) {
	map.addControl(new GSmallMapControl());
	map.addControl(new GMapTypeControl());
    map.setCenter(new GLatLng(39.9573856055042, -75.17532348632812), 10);
  }
}

function gmap_address_add(address,content,icon) {
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

function gmap_address_recenter_zoom(address,zoom) {
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

