// From http://www.tutorialspoint.com/javascript/array_map.htm
if (!Array.prototype.map) {
  Array.prototype.map = function(fun /*, thisp*/) {
    var len = this.length;

    if (typeof fun !== "function") {
      throw new TypeError();
    }

    var res = new Array(len);
    var thisp = arguments[1];

    for (var i = 0; i < len; i++) {
      if (i in this) {
        res[i] = fun.call(thisp, this[i], i, this);
      }
    }

    return res;
  };
}

L.Control.KutuFilter = L.Control.extend({

  includes: L.Mixin.Events,

  options: {
    position: 'topright',
    title: 'Search',
    panelTitle: '',
    placeholder: 'Search',
    caseSensitive: false,
    threshold: 0.5,
    maxResultLength: null,
    showResultFct: null,
    showInvisibleFeatures: true
  },

  initialize: function(options) {
    L.setOptions(this, options);
    this._panelOnLeftSide = (this.options.position.indexOf("left") !== -1);
  },

  onAdd: function(map) {
    var ctrl = this._createControl();

    this._createPanel(map);
    this._setEventListeners();
    map.invalidateSize();

    return ctrl;
  },

  onRemove: function(map) {
    this.hidePanel(map);
    this._clearEventListeners();
    this._clearPanel(map);
    this._clearControl();

    return this;
  },

  _createControl: function() {
    var className = 'leaflet-kutufilter-control',
        container = L.DomUtil.create('div', className);

    // Control to open the search panel
    var butt = this._openButton = L.DomUtil.create('a', 'magnify_glass', container);

    butt.href = '#';
    butt.title = this.options.title;
    var stop = L.DomEvent.stopPropagation;

    L.DomEvent.on(butt, 'click', stop)
              .on(butt, 'mousedown', stop)
              .on(butt, 'touchstart', stop)
              .on(butt, 'mousewheel', stop)
              .on(butt, 'MozMousePixelScroll', stop);
    L.DomEvent.on(butt, 'click', L.DomEvent.preventDefault);
    L.DomEvent.on(butt, 'click', this.showPanel, this);

    return container;
  },

  _clearControl: function() {
    // Unregister events to prevent memory leak
    var butt = this._openButton;
    var stop = L.DomEvent.stopPropagation;

    L.DomEvent.off(butt, 'click', stop)
              .off(butt, 'mousedown', stop)
              .off(butt, 'touchstart', stop)
              .off(butt, 'mousewheel', stop)
              .off(butt, 'MozMousePixelScroll', stop);
    L.DomEvent.off(butt, 'click', L.DomEvent.preventDefault);
    L.DomEvent.off(butt, 'click', this.showPanel);
  },

  _bindPanelSelectEvent: function(elem_id, filter_key) {
    var elem = L.DomUtil.get('filter_' + elem_id);
    var that = this;

    L.DomEvent.on(elem, 'change', function(k) {
      // console.log('select ' + elem.id + ' changed to ' + elem.value);
      var new_value = elem.value;

      if (new_value === 'null') {
        new_value = null;
      } else if (elem_id === 'actives') {
          new_value = new_value === 'true';
      } else {
          new_value = Number(elem.value);
      }

      game_filter[filter_key] = new_value;
      refresh_games();
      that.refresh();
    });
  },

  _createPanelSelect: function(key, data, label) {
    var ret = '<div id="filter_' + key + '_container" class="filter_select_container">';

    ret += '<label class="filter_label">' + label + '</label>';
    ret += '<select id="filter_' + key + '" class="filter_select">';

    for (var k = 0; k < data.length; k++) {
      ret += '<option value="' + data[k][1] + '">' + data[k][0] + '</option>';
    };

    ret += '</select></div>';

    return ret;
  },

  _createPanel: function(map) {
    var _this = this;

    // Create the search panel
    var mapContainer = map.getContainer();
    var className = 'leaflet-kutufilter-panel',
        pane = this._panel = L.DomUtil.create('div', className, mapContainer);

    // Make sure we don't drag the map when we interact with the content
    var stop = L.DomEvent.stopPropagation;

    L.DomEvent.on(pane, 'click', stop)
            .on(pane, 'dblclick', stop)
            .on(pane, 'mousedown', stop)
            .on(pane, 'touchstart', stop)
            .on(pane, 'mousewheel', stop)
            .on(pane, 'MozMousePixelScroll', stop);

    // place the pane on the same side as the control
    if (this._panelOnLeftSide) {
      L.DomUtil.addClass(pane, 'left');
    } else {
      L.DomUtil.addClass(pane, 'right');
    }

    // Intermediate container to get the box sizing right
    var container = L.DomUtil.create('div', 'content', pane);
    var header = L.DomUtil.create('div', 'header', container);

    if (this.options.panelTitle) {
      var title = L.DomUtil.create('p', 'panel-title', header);
      title.innerHTML = this.options.panelTitle;
    }

    // Search image and input field
    L.DomUtil.create('img', 'search-image', header);

    this._input = L.DomUtil.create('input', 'search-input', header);
    this._input.maxLength = 30;
    this._input.placeholder = this.options.placeholder;
    this._input.onkeyup = function(evt) {
      var searchString = evt.currentTarget.value;
      game_filter_search = searchString;
      refresh_games();
      _this.refresh();
    };

    // Close button
    var close = this._closeButton = L.DomUtil.create('a', 'close', header);
    close.innerHTML = '&times;';
    L.DomEvent.on(close, 'click', this.hidePanel, this);

    var select_container = L.DomUtil.create('div', 'filter', container);
    select_container.innerHTML = this._createPanelSelect('cities', cities, 'Şehir') +
                                 this._createPanelSelect('game_categories', game_categories, 'Kategori') +
                                 this._createPanelSelect('actives', actives, 'Durum');

    this._bindPanelSelectEvent('cities', 'city_id');
    this._bindPanelSelectEvent('game_categories', 'game_category_id');
    this._bindPanelSelectEvent('actives', 'active');

    L.DomUtil.create('hr', '', container);

    // Where the result will be listed
    this._resultList = L.DomUtil.create('div', 'result-list', container);

    return pane;
  },

  _clearPanel: function(map) {
    // Unregister event handlers
    var stop = L.DomEvent.stopPropagation;

    L.DomEvent.off(this._panel, 'click', stop)
              .off(this._panel, 'dblclick', stop)
              .off(this._panel, 'mousedown', stop)
              .off(this._panel, 'touchstart', stop)
              .off(this._panel, 'mousewheel', stop)
              .off(this._panel, 'MozMousePixelScroll', stop);

    L.DomEvent.off(this._closeButton, 'click', this.hidePanel);

    var mapContainer = map.getContainer();
    mapContainer.removeChild(this._panel);

    this._panel = null;
  },

  _setEventListeners : function() {
    var that = this;
    var input = this._input;

    this._map.addEventListener('overlayadd', function() {
      that.updateSearchResults();
    });

    this._map.addEventListener('overlayremove', function() {
      that.updateSearchResults();
    });
  },

  _clearEventListeners: function() {
    this._map.removeEventListener('overlayadd');
    this._map.removeEventListener('overlayremove');
  },

  isPanelVisible: function () {
    return L.DomUtil.hasClass(this._panel, 'visible');
  },

  showPanel: function () {
    if (! this.isPanelVisible()) {
      L.DomUtil.addClass(this._panel, 'visible');

      // Preserve map centre
      this._map.panBy([this.getOffset() * 0.5, 0], {duration: 0.5});
      this.fire('show');
      this._input.select();
      this.updateSearchResults();
    }
  },

  hidePanel: function (e) {
    if (this.isPanelVisible()) {
      L.DomUtil.removeClass(this._panel, 'visible');

      // Move back the map center only if we still hold this._map
      // as this might already have been cleared up by removeFrom()
      if (null !== this._map) {
          this._map.panBy([this.getOffset() * -0.5, 0], {duration: 0.5});
      };
      this.fire('hide');

      if(e) {
        L.DomEvent.stopPropagation(e);
      }
    }
  },

  getOffset: function() {
    if (this._panelOnLeftSide) {
      return - this._panel.offsetWidth;
    } else {
      return this._panel.offsetWidth;
    }
  },

  updateSearchResults: function() {
    var result = marker_cluster.getLayers();
    var resultList = document.querySelector('.result-list');

    // Empty result list
    var listItems = document.querySelectorAll(".result-item");

    for (var i = 0 ; i < listItems.length ; i++) {
      // yet another IE incompatibility
      // listItems[i].remove();
      resultList.removeChild(listItems[i]);
    }

    var num = 0;
    var max = this.options.maxResultLength;

    for (var i in result) {
      var feature = result[i].feature;
      // console.log(feature);
      var popup = this._getFeaturePopupIfVisible(feature);

      if (undefined !== popup || this.options.showInvisibleFeatures) {
        this.createResultItem(feature, resultList, popup);

        if (undefined !== max && ++num === max) {
          break;
        }
      }
    }
  },

  refresh: function() {
    // Reapply the search on the indexed features - useful if features have been filtered out
    if (this.isPanelVisible()) {
      this.updateSearchResults();
    }
  },

  _getFeaturePopupIfVisible: function(feature) {
    var layer = feature.layer;

    if (undefined !== layer && this._map.hasLayer(layer)) {
      return layer.getPopup();
    }
  },

  findLayer: function(slug) {
    var layers = marker_cluster.getLayers();
    var found_layer = layers.filter(function(k) {
      return k.feature.properties.slug == slug;
    });

    return found_layer[0];
  },

  createResultItem: function(feature, container, popup) {
    var _this = this;
    var props = feature.properties;

    // Create a container and open the associated popup on click
    var resultItem = L.DomUtil.create('p', 'result-item', container);

    L.DomUtil.addClass(resultItem, 'clickable');

    resultItem.onclick = function() {
      // console.log(feature);
      var layer;

      if (window.matchMedia("(max-width:480px)").matches) {
        _this.hidePanel();
      }

      var zoom_factor = map.getZoom();
      if (zoom_factor < 17) {
        zoom_factor = 17;
      }

      layer = _this.findLayer(props.slug);

      if (layer) {
        marker_cluster.zoomToShowLayer(layer, function(e) {
          layer.openPopup();
        });
      }
    };

    // Fill in the container with the user-supplied function if any,
    // otherwise display the feature properties used for the search.
    if (null !== this.options.showResultFct) {
      this.options.showResultFct(feature, resultItem);
    } else {
      str = '<b>' + props[this._keys[0]] + '</b>';

      for (var i = 1; i < this._keys.length; i++) {
        str += '<br/>' + props[this._keys[i]];
      }

      resultItem.innerHTML = str;
    };

    return resultItem;
  },

  _panAndPopup : function(feature, popup) {
    // Temporarily adapt the map padding so that the popup is not hidden by the search pane
    if (this._panelOnLeftSide) {
      var oldPadding = popup.options.autoPanPaddingTopLeft;
      var newPadding = new L.Point(- this.getOffset(), 10);

      popup.options.autoPanPaddingTopLeft = newPadding;
      feature.layer.openPopup();
      popup.options.autoPanPaddingTopLeft = oldPadding;
    } else {
      var oldPadding = popup.options.autoPanPaddingBottomRight;
      var newPadding = new L.Point(this.getOffset(), 10);

      popup.options.autoPanPaddingBottomRight = newPadding;
      feature.layer.openPopup();
      popup.options.autoPanPaddingBottomRight = oldPadding;
    }
  }
});

L.control.kutu_filter = function(options) {
  return new L.Control.KutuFilter(options);
};


