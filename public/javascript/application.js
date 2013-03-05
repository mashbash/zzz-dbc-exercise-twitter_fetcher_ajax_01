$(document).ready(function(){
  $(".form").submit(function(e){
    e.preventDefault();
    $('.tweet_results').hide();
    $('#wait-icon').show();
    // debugger
    $.ajax({
      url: this.action,
      type: this.method,
      data: $(this).serialize(),
      dataType: "html"
    }).success(function(response){
      $('.tweet_results').html(response);
      $('.tweet_results').show();
      $('#wait-icon').hide();
    });
    });
});
