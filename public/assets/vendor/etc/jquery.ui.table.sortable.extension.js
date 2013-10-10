$(function(){
  $("table.sortable tbody").sortable({
    axis: "y",
    handle: ".handle",
    update: function(){
      $.post(
        $(this).data("update-url"),
        { ids: _.map($("#items table tbody").find("tr"), function(element) { return $(element).attr("data-id"); } ) }
      )
    },
    helper: function(e, tr){
      var $originals = tr.children();
      var $helper = tr.clone();
      $helper.children().each(function(index)
      {
        // Set helper cell sizes to match the original sizes
        $(this).width($originals.eq(index).width())
      });
      return $helper;
    },
  });
});