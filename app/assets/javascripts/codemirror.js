$(document).ready(function() {
  $("#text_area").each(function() {
      CodeMirror.fromTextArea($(this).get(0), {
        lineNumbers: true,
        mode: "text/htmlmixed"
      });
    });
})