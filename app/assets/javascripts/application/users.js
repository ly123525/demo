(function($){
    var usingEmail = $('input[name="signup_type"]').val() == 'email';
    $('.switch-btn').on('click',function(){
        if(usingEmail){
            $('.email-inner').addClass('hide').find('input[type="text"]').prop('disabled', 1);
            $('.cellphone-inner').removeClass('hide').find('input[type="text"]').prop('disabled',false);
            usingEmail = false;
        } else{
            $('.email-inner').removeClass('hide').find('input[type="text"]').prop('disabled', false);
            $('.cellphone-inner').addClass('hide').find('input[type="text"]').prop('disabled', 1);
            usingEmail = true;
        }
    })
    //验证码
    var CELLPHONE_RE = /^(\+86|86)?1\d{10}$/;
    var token_wait = 60,
        token_interval,
        $token_btn = $('.fetch-token-btn');
    $token_btn.on('click',function(){
        var $this = $(this),
        cellphone = $('#user_cellphone').val();
        $.ajax({
            url: $this.data('url'),
            type: 'post',
            dataType: 'json',
            data: {cellphone: cellphone},
            beforeSend: function(){
                if(!CELLPHONE_RE.test(cellphone)){
                    alert('手机号格式不正确！')
                    return false;
                }
                $this.data('old-value', $this.attr('value'));
                $this.attr('value', '发送中...').prop('disabled',true);
            },
            success: function(data){
                if (data.status=='error'){
                    alert(data.message);
                }else{
                    $this.attr('value', $this.data('old-value'));
                    $this.trigger('start_token_timer');
                }
            }
        });
    })
        .on('start_token_timer', function () {
            token_interval = setInterval(function () {
                $token_btn.trigger('token_timer');
            }, 1000);
        })
        .on('token_timer', function () {
            token_wait--;
            if (token_wait <= 0) {
                clearInterval(token_interval);
                $token_btn.attr('value', '获取短信验证码').prop('disabled', false);
                token_wait = 60;
            } else {
                $token_btn.attr('value', '重新发送 ' + token_wait + ' 秒').prop('disabled', true);
            }
        })
})(jQuery);