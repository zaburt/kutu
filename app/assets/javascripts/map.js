
L.Icon.Default.imagePath = '/leaflet';

var map;
var markers = {};
var default_lng = 35.22;
var default_lat = 38.96;
var default_zoom = 6;
var popup_focus_game = false;
var initial_focused_layer = null;
var marker_cluster = L.markerClusterGroup();
var feature_layers = {};
var game_filter_search = '';
var game_filter_search_keys = ['title', 'address', 'phone', 'city'];
var game_filter = {
  active: null,
  city_id: null,
  game_category_id: null
};
var toolbar = {
  container: null,
  actions: {
    active: null,
    city: null,
    game_category: null
  }
};

function find_game_from_geojson(key, value) {
  return games_geojson.find(function(k) {
    return k.properties[key] == value;
  });
}

function init_map() {
  var map_lng = default_lng;
  var map_lat = default_lat;
  var map_zoom = default_zoom;

  if (focus_on) {
    var game_to_find = find_game_from_geojson('slug', focus_on);

    if (game_to_find) {
      map_lng = game_to_find.geometry.coordinates[0];
      map_lat = game_to_find.geometry.coordinates[1];
      map_zoom = 16;
      popup_focus_game = true;
    }
  }

  // console.log('map_lng: ' + map_lng + ' map_lat: ' + map_lat + ' zoom: ' + map_zoom);

  map = L.map('map_canvas', {
    center: [map_lat, map_lng],
    zoom: map_zoom,
    fullscreenControl: true,
      fullscreenControlOptions: {
      position: 'topleft',
      title: 'Tam Ekran',
      titleCancel: 'Normal Görünüm'
    }
  });

  L.control.scale({imperial: false}).addTo(map);
}

function zoom_to_marker(mark, zoom_target) {
  if (map.getZoom() > zoom_target) {
    zoom_target = map.getZoom();
  }

  map.flyTo(mark.getLatLng(), zoom_target);
}

function on_map_click(e) {
  console.log("You clicked the map at: " + e.latlng.toString());
}

function on_game_click(e) {
  var data = e.layer.feature.properties;
  console.log(data);
}

function on_game_add(feature, layer) {
  var attrs = layer.feature.properties;
  var popup_content = '<b>' + attrs.game_link + '</b><br>' + attrs.phone + '<br>' + attrs.address + ' / ' + attrs.city;

  layer.options.title = attrs.title;
  layer.bindPopup(popup_content);

  if (popup_focus_game && focus_on === attrs.slug) {
    initial_focused_layer = layer;
  }
}

function game_filter_callback(feature, layer) {
  var filter_matches = true;

  $.each(game_filter, function(key, value) {
    if (filter_matches && value !== null && value !== '' && typeof value !== 'undefined') {
      var layer_value = feature.properties[key];
      // console.log('comparing layer_value: ' + layer_value + ' with value: ' + value);
      filter_matches = layer_value === value;
    }
  });

  if (filter_matches && game_filter_search !== '') {
    var str_matched = false;

    $.each(game_filter_search_keys, function(ix, key) {
      str_matched = str_matched || str_includes(feature.properties[key], game_filter_search);
      // console.log('full str: ' + feature.properties[key] + ' trying to match: ' + game_filter_search + ' result: ' + filter_matches);
    });

    filter_matches = str_matched;
  }

  return filter_matches;
}

function init_tiles() {
  L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: ''
  }).addTo(map);
}

function refresh_games() {
  marker_cluster.removeLayer(feature_layers.games);
  init_games();
}

function init_games() {
  /*
  $.each(games, function(slug, attrs) {
    popup_content = '<b>' + attrs.game_link + '</b><br>' + attrs.phone + '<br>' + attrs.address + ' / ' + attrs.city;
    markers[slug] = L.marker([attrs.lat, attrs.lng], {
      title: attrs.name
    }).bindPopup(popup_content);

    markers[slug].addTo(map);
    // marker_cluster.addLayer(markers[slug]);

    if (popup_focus_game && slug === focus_on) {
      markers[slug].openPopup();
    }

    markers[slug].on('click', function(mark) {
      zoom_to_marker(markers[slug], 16);
    });
  });
  */

  feature_layers.games = L.geoJson(games_geojson, {
    // pointToLayer: function (feature, latlng) {
    //   return L.marker(latlng, {icon: baseballIcon});
    // },

    filter: function(feature, layer) {
      return game_filter_callback(feature, layer);
    },

    onEachFeature: on_game_add
  });

  feature_layers.games.on('click', function(e) {
    on_game_click(e);
  });

  marker_cluster.addLayer(feature_layers.games);
  map.addLayer(marker_cluster);

  if (!popup_focus_game) {
    map.fitBounds(marker_cluster.getBounds(), {
      // padding: [15, 15]
    });
  }
}

function build_custom_toolbar(name, iterator, filter_key) {
  /* A sub-action which completes as soon as it is activated.
   * Sub-actions receive their parent action as an argument to
   * their `initialize` function. We save a reference to this
   * parent action so we can disable it as soon as the sub-action
   * completes.
   */
  var ImmediateSubAction = L.ToolbarAction.extend({
    initialize: function(map, myAction) {
      this.map = map;
      this.myAction = myAction;
      L.ToolbarAction.prototype.initialize.call(this);
    },
    addHooks: function() {
      this.myAction.disable();
    }
  });

  var sub_actions = [];

  $.each(iterator, function(ix, c) {
    var k = c[0];
    var v = c[1];

    var iter_action = ImmediateSubAction.extend({
      options: {
        toolbarIcon: {
          html: k,
          tooltip: k
        }
      },
      addHooks: function () {
        // this.map.setView([0, 0], 0);
        game_filter[filter_key] = v;
        refresh_games();
        ImmediateSubAction.prototype.addHooks.call(this);
      }
    });

    sub_actions.push(iter_action);
  });

  var close_subtoolbar = ImmediateSubAction.extend({
    options: {
      toolbarIcon: {
        html: '<i class="fi-x"></i>',
        tooltip: 'Kapat'
      }
    }
  });

  sub_actions.push(close_subtoolbar);

  var extended_toolbar = L.Toolbar.extend({});

  return L.ToolbarAction.extend({
    options: {
      toolbarIcon: {
        // className: 'fa fa-eye',
        tooltip: name,
        html: name
      },
      /* Use L.Toolbar for sub-toolbars. A sub-toolbar is,
       * by definition, contained inside another toolbar, so it
       * doesn't need the additional styling and behavior of a
       * L.Toolbar.Control or L.Toolbar.Popup.
       */
      //subToolbar: new L.Toolbar({
      //  actions: sub_actions
      //})
      subToolbar: new extended_toolbar({
        actions: sub_actions
      })
    }
  });
}

function init_toolbars() {
  toolbar.actions.city = build_custom_toolbar('Şehir', cities, 'city_id');
  toolbar.actions.active = build_custom_toolbar('Açık', actives, 'active');
  toolbar.actions.game_category = build_custom_toolbar('Kategori', game_categories, 'game_category_id');

  toolbar.container = new L.Toolbar.Control({
    position: 'topleft',
    actions: [
      toolbar.actions.city,
      toolbar.actions.game_category,
      toolbar.actions.active
    ]
  }).addTo(map);
}

function init_events() {
  map.on('click', on_map_click);
}

function init_popups() {
  if (initial_focused_layer) {
    initial_focused_layer.openPopup();
  }
}

function init_all() {
  init_map();
  init_tiles();
  init_games();
  init_events();
  init_popups();
  init_toolbars();
}

init_all();


