
var map;
var markers = {};

map = L.map('map_canvas', {
  center: [38.96, 35.22],
  zoom: 7
});

L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  maxZoom: 19,
  // attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
  attribution: ''
}).addTo(map);

$.each(games, function(slug, attrs) {
  markers[slug] = L.marker([attrs.lat, attrs.lng], {
    title: attrs.name
  // }).addTo(map).bindPopup('<b>' + attrs.name + '</b><p>' + attrs.phone + '</p><p>' + attrs.address + '</p>');
  }).addTo(map).bindPopup('<b>' + attrs.name + '</b><br>' + attrs.phone + '<br>' + attrs.address);

  markers[slug].on('click', function(mark) {
    map.flyTo(markers[slug].getLatLng(), 14);
  });

});

