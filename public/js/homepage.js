$(function(){

    $('div.countUpTimer').click(function(){
        $('div.countUpTimer').animate({height:'0px'}, {queue:false, duration:1});
        $('div.centreBar').animate( { top:'0px'}, {queue:false, duration:1000})
                .animate({height:'0px'}, 500)
                .animate({backgroundColor:'#666666'},1)
                .animate({height:'50px'}, 500, function(){
                    $(this).parent().find('div.menu').css({'visibility':'visible'});
                    $(this).parent().find('div.centreBar').fadeOut(function(){
                        window.location = $('div.menu a#timelineLink').attr('href')
                    })
                })
        ;
        $('div.edge').animate({height:'0px'}, {queue:false, duration:1000})
            .animate({height:'5px'}, 200)
            .animate({height:'5px'}, 200)
            .animate({height:'0px'}, 0)
        ;
        $('div.text').fadeOut({height:'0px'}, 5)
        ;
    });

    if(window.location.href.indexOf('#final')!=-1){
        $('div.centreBar').hide();
        $('div.countUpTimer').hide();
        $('div.menu').css({'visibility':'visible'});
    }
    else{
        $('div.countUpTimer').countUpTimer();
        $(document).everyTime(1000,function(){
            $('div.countUpTimer').countUpTimer();
        }, 0);

        $('div.countUpTimer').delay('3000').queue(function(){
            $(this).triggerHandler('click')
        });
    }
});jQuery();
