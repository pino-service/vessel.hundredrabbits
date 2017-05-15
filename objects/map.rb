class Google_Map

  def initialize events
    
    @events = events
    @sails = find_sails
    
  end
  
  def find_sails
    
    sails = []
    @events.sort_by{|k,to_i,v| k}.each do |date,event|
      if event.type != "sail" then next end
      sails.push(event)
    end
    
    return sails
    
  end

	def to_s

		return '<div id="map" style="height:100vh"></div>

<script>
var map;
function initMap()
{
  map = new google.maps.Map(document.getElementById(\'map\'), { center: {lat: '+(@sails.last.latitude.to_s)+', lng: '+(@sails.last.longitude.to_s)+'}, zoom: 8, disableDefaultUI: true });

  '+_styles+'

  var flightPlanCoordinates = ['+_path+'];
  var flightPath = new google.maps.Polyline({ path: flightPlanCoordinates, geodesic: true, strokeColor: \'#FF0000\', strokeOpacity: 1.0, strokeWeight: 2 });

  flightPath.setMap(map);

  var myLatLng = {lat: '+@sails.last.latitude.to_s+', lng: '+@sails.last.longitude.to_s+'};
  
  var pos_polynesia = {lat: -8.826494, lng: -140.142672};
  var pos_tokyo = {lat: 35.626411, lng: 139.776893};
  var pos_auckland = {lat: -36.841539, lng: 174.761052};
  var pos_vladivostok = {lat: 43.114753, lng: 131.872834};
  var pos_vancouver = {lat: 48.802228, lng: -123.601410};
  var marker = new google.maps.Marker({ position: myLatLng, icon: { path: google.maps.SymbolPath.CIRCLE, strokeColor: \'red\', scale: 2, strokeWeight: 0, fillOpacity: 1, fillColor:\'white\' }, draggable: false, map: map });
  var marker2 = new google.maps.Marker({ position: pos_polynesia, icon: { path: google.maps.SymbolPath.CIRCLE, strokeColor: \'white\', scale: 2, strokeWeight: 0, fillOpacity: 1, fillColor:\'white\' }, draggable: false, map: map });
  var marker_tokyo = new google.maps.Marker({ position: pos_tokyo, icon: { path: google.maps.SymbolPath.CIRCLE, strokeColor: \'white\', scale: 2, strokeWeight: 0, fillOpacity: 1, fillColor:\'white\' }, draggable: false, map: map });
  var marker_auckland = new google.maps.Marker({ position: pos_auckland, icon: { path: google.maps.SymbolPath.CIRCLE, strokeColor: \'white\', scale: 2, strokeWeight: 0, fillOpacity: 1, fillColor:\'white\' }, draggable: false, map: map });
  var marker_vladivostok = new google.maps.Marker({ position: pos_vladivostok, icon: { path: google.maps.SymbolPath.CIRCLE, strokeColor: \'white\', scale: 2, strokeWeight: 0, fillOpacity: 1, fillColor:\'white\' }, draggable: false, map: map });
  var marker_vancouver = new google.maps.Marker({ position: pos_vancouver, icon: { path: google.maps.SymbolPath.CIRCLE, strokeColor: \'white\', scale: 2, strokeWeight: 0, fillOpacity: 1, fillColor:\'white\' }, draggable: false, map: map }); 
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

  def _styles

    return '
map.set(\'styles\', [
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [{ "color": "#000000" }]
  },{
    "featureType": "landscape",
    "stylers": [{ "color": "#222222" }]
  },{
    "featureType": "transit",
    "stylers": [{ "visibility": "off" }
  ]
  },{
    "featureType": "road",
    "stylers": [{ "visibility": "off" }
  ]
  },{
    "featureType": "poi",
    "stylers": [{ "visibility": "off" }
  ]
  },{
    "featureType": "administrative",
    "stylers": [{ "visibility": "off" }
  ]
  },{
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [{ "visibility": "on" },{ "color": "#222222" }]
  },{
    "featureType": "landscape",
    "elementType": "labels",
    "stylers": [{ "color": "#555555" },{ "visibility": "simplified" }]
  },{
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [{ "visibility": "on" },{ "weight": 0.1 },{ "color": "#111111" }]
  },{
    "elementType": "labels.text.stroke",
    "stylers": [{ "visibility": "off" }]
  }
  ]);'

  end

end