// turbolinks messes up with foundation triggers, especially the image selector modal
var foundation_ready_trigger;
foundation_ready_trigger = function() {
    $(document).foundation();
};
$(document).ready(foundation_ready_trigger);
$(document).on('page:load', foundation_ready_trigger);

var current_page_datatables;

// sort by Turkish and some other language special letters
$.extend($.fn.dataTableExt.oSort, {
  "turkish-pre": function ( a ) {
    var special_letters = {
      "C": "ca", "c": "ca", "Ç": "cb", "ç": "cb",
      "G": "ga", "g": "ga", "Ğ": "gb", "ğ": "gb",
      "I": "ia", "ı": "ia", "İ": "ib", "i": "ib",
      "O": "oa", "o": "oa", "Ö": "ob", "ö": "ob",
      "S": "sa", "s": "sa", "Ş": "sb", "ş": "sb",
      "U": "ua", "u": "ua", "Ü": "ub", "ü": "ub",
      "A": "aa", "a": "aa", "Ä": "ab", "ä": "ab"
    };

    for (var val in special_letters) {
      a = a.split(val).join(special_letters[val]).toLowerCase();
    }

    return a;
  },

  "turkish-asc": function (a, b) {
    return ((a < b) ? -1 : ((a > b) ? 1 : 0));
  },

  "turkish-desc": function (a, b) {
    return ((a < b) ? 1 : ((a > b) ? -1 : 0));
  }
});

// override defaults for DataTables initialisation since defaults are for 12 column grid
$.extend(true, $.fn.dataTable.defaults, {
  dom:
    "<'row'<'small-6 columns'l><'small-12 columns'f>r>"+
    "t"+
    "<'row'<'small-6 columns'i><'small-12 columns'p>>",
  renderer: 'foundation'
});

function filter_game_list(filter_key, filter_value) {
  console.log('filter_game_list called with key: ' + filter_key + ' value: ' + filter_value);

  var filter_value_display = '';
  datatables_filter_base[filter_key].current_value = filter_value;

  if (datatables_filter_base[filter_key].is_bool) {
    if (filter_value === '1' || filter_value === 1) {
      // filter_value_display = '<i class="fi-check green fonticon"></i>';
      filter_value_display = datatables_filter_base[filter_key].bool_true_display;
    } else {
      // filter_value_display = '<i class="fi-x red fonticon"></i>';
      filter_value_display = datatables_filter_base[filter_key].bool_false_display;
    }
  } else {
    filter_value_display = filter_value;
  }

  $('a[data-dropdown=dropdown_' + filter_key + ']').html(datatables_filter_base[filter_key].label +': ' + filter_value_display);
  $('table.kutu_datatables').DataTable().draw();
}

var kutu_datatable_str = {
  all: 'Hepsi',
  empty_table: 'Sonuç bulunamadı',
  search: '\uf16c',
  info: 'Toplam _TOTAL_',
  first: 'İlk',
  last: 'Son',
  // next: 'Sonraki',
  // previous: 'Önceki'
  next: '>>',
  previous: '<<'
};

var datatables_default_config = {
  iDisplayLength: 50,
  // lengthMenu: [[20, 50, 100, 250, -1], [20, 50, 100, 250, kutu_datatable_str.all]],
  lengthMenu: [[20, 50, 100, 250, -1], [20, 50, 100, 250, kutu_datatable_str.all]],
  bPaginate: true,
  bSearchable: true,
  order: [[1, 'asc']],
  // aaSorting: [],
  language: {
    search: '',
    lengthMenu: "_MENU_",
    emptyTable: kutu_datatable_str.empty_table,
    zeroRecords: kutu_datatable_str.empty_table,
    info: kutu_datatable_str.info,
    infoEmpty: '',
    infoFiltered: '',
    paginate: {
      first: kutu_datatable_str.first,
      last: kutu_datatable_str.last,
      next: kutu_datatable_str.next,
      previous: kutu_datatable_str.previous
    }
  }
};

// turbolinks doesnot work with ready, use page:change instead
$(document).on('page:change', function() {
  if ($('table#games_index').length > 0) {
    datatables_default_config.columnDefs = [
      {
        targets: [2],
        visible: false
      }
    ];

    $.fn.dataTable.ext.search.push(
      function(settings, data, dataIndex) {
        var filter_matches = true;

        $.each(datatables_filter_base, function(key, value) {
          if (filter_matches &&
            value.current_value !== value.default_value &&
            value.current_value !== data[value.data_offset]) {
            console.log('returning false');

            filter_matches = false;
          }

          /*
          if (key === 'active' && !filter_matches) {
            console.log('value.current_value: ' + value.current_value);
            console.log('value.default_value: ' + value.default_value);
            console.log('value.data_offset: ' + value.data_offset);
            console.log('data[value.data_offset]: ' + data[value.data_offset]);
          }
          */
        });

        return filter_matches;
      }
    );

  } else {
    datatables_filter_base = {};
  }

  current_page_datatables = $('table.kutu_datatables').DataTable(datatables_default_config);

  $('.dataTables_filter input').attr("placeholder", kutu_datatable_str.search);

  $('select.image-picker').imagepicker({show_label: false});

});

