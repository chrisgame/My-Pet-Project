$(function(){
    $.get('/menu', function(data){
        $('div#menuContainer').html(data);
    });
    $.get('/timeline', function(data){
        $('div#timelineContainer').html(data);
    });
});jQuery();