
$(document).on("page:change", function() {
  $(".dropdown").on("shown.bs.dropdown", function() {
    $(".navlink.open").removeClass("open");
  });
  $(".dropdown").on("hidden.bs.dropdown", function() {
    $(".navlink").addClass("open");
  });
  $("#avatar").fadeOut(8000);
});
