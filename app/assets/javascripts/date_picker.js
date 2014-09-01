$(document).on("ready page:change", function() {
  $(".date_picker").datepicker({"format": "yyyy-mm-dd"});
  $('#projects').dataTable();
  $('#report_cards_overall').dataTable();
  $('#report_cards_detailed').dataTable();
  $(".tip").tooltip();
  $('.myTab').tab('show');
});
