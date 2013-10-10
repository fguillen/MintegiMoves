$(function(){
  $(document).ajaxStart( function() {
    console.log( "loading" );
    $("#loading").animate({ top: "0" }, 200);
  });

  $(document).ajaxStop( function() {
    console.log( "loading finish!" );
    $("#loading").animate({ top: "-70" }, 100);
  });
});
