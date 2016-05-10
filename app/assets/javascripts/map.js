
var map;
var markers = {};

L.Icon.Default.imagePath = '/leaflet';

map = L.map('map_canvas', {
  center: [38.96, 35.22],
  zoom: 6
});

function zoom_to_marker(mark, zoom_target) {
  if (map.getZoom() > zoom_target) {
    zoom_target = map.getZoom();
  }

  map.flyTo(mark.getLatLng(), zoom_target);
}

function onMapClick(e) {
  console.log("You clicked the map at: " + e.latlng.toString());
}

map.on('click', onMapClick);

L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  maxZoom: 19,
  // attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
  attribution: ''
}).addTo(map);

$.each(games, function(slug, attrs) {
  markers[slug] = L.marker([attrs.lat, attrs.lng], {
    title: attrs.name
  }).addTo(map).bindPopup('<b>' + attrs.name + '</b><br>' + attrs.phone + '<br>' + attrs.address);

  markers[slug].on('click', function(mark) {
    zoom_to_marker(markers[slug], 16);
  });

});

if (focus_on && markers[focus_on]) {
  zoom_to_marker(markers[focus_on], 16);
  markers[focus_on].openPopup();
}

