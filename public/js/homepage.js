$(function(){

    $('div  .countUpTimer').countUpTimer();
    $(document).everyTime(1000,function(){
        $('div.countUpTimer').countUpTimer();
    }, 0);

});jQuery();
