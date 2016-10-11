class Layout

	def page_home

		@sails = eventsOfType("sail").reverse

		return map+""

	end

	def map

		return '<div id="map" style="height:100vh"></div>

<script>
var map;
function initMap() {

  map = new google.maps.Map(document.getElementById(\'map\'), { center: {lat: '+(@sails.last.latitude.to_s)+', lng: '+(@sails.last.longitude.to_s)+'}, zoom: 9, disableDefaultUI: true });

  map.set(\'styles\', [
  {
  "featureType": "water",
  "elementType": "geometry",
  "stylers": [
  { "color": "#000000" }
  ]
  },{
  "featureType": "landscape",
  "stylers": [
  { "color": "#222222" }
  ]
  },{
  "featureType": "transit",
  "stylers": [
  { "visibility": "off" }
  ]
  },{
  "featureType": "road",
  "stylers": [
  { "visibility": "off" }
  ]
  },{
  "featureType": "poi",
  "stylers": [
  { "visibility": "off" }
  ]
  },{
  "featureType": "administrative",
  "stylers": [
  { "visibility": "off" }
  ]
  },{
  "featureType": "water",
  "elementType": "labels.text.fill",
  "stylers": [
  { "visibility": "on" },
  { "color": "#222222" }
  ]
  },{
  "featureType": "landscape",
  "elementType": "labels",
  "stylers": [
  { "color": "#555555" },
  { "visibility": "simplified" }
  ]
  },{
  "featureType": "road",
  "elementType": "geometry.stroke",
  "stylers": [
  { "visibility": "on" },
  { "weight": 0.1 },
  { "color": "#111111" }
  ]
  },{
  "elementType": "labels.text.stroke",
  "stylers": [
  { "visibility": "off" }
  ]
  }
  ]);

  var flightPlanCoordinates = ['+_path+'];
  var flightPath = new google.maps.Polyline({ path: flightPlanCoordinates, geodesic: true, strokeColor: \'#FF0000\', strokeOpacity: 1.0, strokeWeight: 2 });

  flightPath.setMap(map);

  var myLatLng = {lat: '+@sails.last.latitude.to_s+', lng: '+@sails.last.longitude.to_s+'};
  var marker = new google.maps.Marker({ position: myLatLng, icon: { path: google.maps.SymbolPath.CIRCLE, strokeColor: \'red\', scale: 2, strokeWeight: 2 }, draggable: false, map: map });

}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD8Xytok8C1LF183ydZ3mpjflPTgx835e4&callback=initMap"
async defer></script>'

	end

	def _path

		html = ""

		@sails.each do |event|
      event.geolocation.each do |position|
        lat = position.split(",").first.strip.to_f
        lon = position.split(",").last.strip.to_f
        html += "{lat: #{lat}, lng: #{lon}}," 
      end
		end

		html = html[0,html.length-1]

		return html
	end

end