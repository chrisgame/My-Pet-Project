(function($){
    $.fn.countUpTimer = function(){
        var A_MILLISECOND_YEAR = 1000*60*60*24*365;
        var A_MILLISECOND_DAY = 1000*60*60*24;
        var A_MILLISECOND_HOUR = 1000*60*60;
        var A_MILLISECOND_MINUTE = 1000*60;
        var A_MILLISECOND_SECOND = 1000;

    //input is a date time
        var startDateTimeMillis = new Date(2004, 2, 28, 12, 28, 0, 0);
    //get current date time
        var currentDateTimeMillis = new Date().getTime();
    //workout the difference
        var differenceMillis = Math.abs(startDateTimeMillis-currentDateTimeMillis);

    //convert into y:d:h:m:s
        var years = Math.floor(differenceMillis/A_MILLISECOND_YEAR);
        differenceMillis = differenceMillis-(A_MILLISECOND_YEAR*years);
        var days = Math.floor(differenceMillis/A_MILLISECOND_DAY);
        differenceMillis = differenceMillis-(A_MILLISECOND_DAY*days);
        var hours = Math.floor(differenceMillis/A_MILLISECOND_HOUR);
        differenceMillis = differenceMillis-(A_MILLISECOND_HOUR*hours);
        var minutes = Math.floor(differenceMillis/A_MILLISECOND_MINUTE);
        differenceMillis = differenceMillis-(A_MILLISECOND_MINUTE*minutes);
        var seconds = Math.floor(differenceMillis/A_MILLISECOND_SECOND);
        differenceMillis = differenceMillis-(A_MILLISECOND_SECOND*seconds);
        var milliseconds = Math.floor(differenceMillis);
    //output result
        return this.each(function(){
            $(this).html(
                    '<ol id=years>' +
                    '   <li class=value>'+years+
                    '       <span class=separator>:</span>' +
                    '   </li>' +
                    '   <li class=caption>years</li>' +
                    '</ol>' +
                    '<ol id=days>' +
                    '   <li class=value>'+days+
                    '       <span class=separator>:</span>' +
                    '   </li>' +
                    '   <li class=caption>days</li>' +
                    '</ol>' +
                    '<ol id=hours>' +
                    '   <li class=value>'+hours+
                    '       <span class=separator>:</span>' +
                    '   </li>' +
                    '   <li class=caption>hours</li>' +
                    '</ol>' +
                    '<ol id=minutes>' +
                    '   <li class=value>'+minutes+
                    '       <span class=separator>:</span>' +
                    '   </li>' +
                    '   <li class=caption>minutes</li>' +
                    '</ol>' +
                    '<ol id=seconds>' +
                    '   <li class=value>'+seconds+
                    '       <span class=separator>:</span>' +
                    '   </li>' +
                    '   <li class=caption>seconds</li>' +
                    '</ol>' +
                    '<ol id=milliseconds>' +
                    '   <li class=value>'+milliseconds+'</li>' +
                    '   <li class=caption>milliseconds</li>' +
                    '</ol>'
            );
        })
    };
})(jQuery);