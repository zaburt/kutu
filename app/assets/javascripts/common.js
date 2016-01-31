// turbolinks messes up with foundation triggers, especially the image selector modal
var foundation_ready_trigger;
foundation_ready_trigger = function() {
    $(document).foundation();
};
$(document).ready(foundation_ready_trigger);
$(document).on('page:load', foundation_ready_trigger);


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

$(function() {
  var kutu_datatable_str = {
    all: 'Hepsi',
    empty_table: 'Sonuç bulunamadı',
    search: 'Ara',
    info: 'Toplam _TOTAL_',
    first: 'İlk',
    last: 'Son',
    next: 'Sonraki',
    previous: 'Önceki'
  };

  $('.kutu_datatable').DataTable({
    // iDisplayLength: 100,
    // lengthMenu: [[20, 50, 100, 250, -1], [20, 50, 100, 250, kutu_datatable_str.all]],
    bPaginate: true,
    bSearchable: true,
    // order: [[2, 'asc']],
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
  });

  // TODO: replace with magnifying glass
  $('.dataTables_filter input').attr("placeholder", kutu_datatable_str.search);
});


