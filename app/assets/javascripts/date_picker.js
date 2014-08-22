$(document).on("ready page:change", function() {
  $(".date_picker").datepicker({"format": "yyyy-mm-dd"});
  $('#projects').dataTable();
  $('#report_cards').dataTable();
  $(".tip").tooltip();
});
