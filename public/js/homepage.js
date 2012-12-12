$(function(){

    $('div  .centredCountUpTimer').countUpTimer();
    $(document).everyTime(1000,function(){
        $('div.centredCountUpTimer').countUpTimer();
    }, 0);

});jQuery();
