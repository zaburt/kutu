
L.Icon.Default.imagePath = '/leaflet';

var map;
var markers = {};
var default_lng = 35.22;
var default_lat = 38.96;
var default_zoom = 6;
var popup_focus_game = false;
var marker_cluster = L.markerClusterGroup();


function init_map() {
  var map_lng = default_lng;
  var map_lat = default_lat;
  var map_zoom = default_zoom;

  if (focus_on && games[focus_on]) {
    // zoom_to_marker(markers[focus_on], 16);
    // markers[focus_on].openPopup();
    map_lng = games[focus_on].lng;
    map_lat = games[focus_on].lat;
    map_zoom = 16;
    popup_focus_game = true;
  }

  // console.log('map_lng: ' + map_lng + ' map_lat: ' + map_lat + ' zoom: ' + map_zoom);

  map = L.map('map_canvas', {
    center: [map_lat, map_lng],
    zoom: map_zoom
  });
}

function zoom_to_marker(mark, zoom_target) {
  if (map.getZoom() > zoom_target) {
    zoom_target = map.getZoom();
  }

  map.flyTo(mark.getLatLng(), zoom_target);
}

function onMapClick(e) {
  console.log("You clicked the map at: " + e.latlng.toString());
}

function init_tiles() {
  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: ''
  }).addTo(map);
}

function init_games() {
  $.each(games, function(slug, attrs) {
    popup_content = '<b>' + attrs.game_link + '</b><br>' + attrs.phone + '<br>' + attrs.address + ' / ' + attrs.city;
    markers[slug] = L.marker([attrs.lat, attrs.lng], {
      title: attrs.name
    }).bindPopup(popup_content);

    // markers[slug].addTo(map);
    marker_cluster.addLayer(markers[slug]);

    if (popup_focus_game && slug === focus_on) {
      markers[slug].openPopup();
    }

    markers[slug].on('click', function(mark) {
      zoom_to_marker(markers[slug], 16);
    });
  });

  map.addLayer(marker_cluster);
}

function init_events() {
  map.on('click', onMapClick);
}

function init_all() {
  init_map();
  init_tiles();
  init_games();
  init_events();
}

init_all();


