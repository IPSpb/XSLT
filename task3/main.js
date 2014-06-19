$(function () {
    function find_container(input) {
        return input.parent().parent();
    }
    function remove_validation_markup(input) {
        var cont = find_container(input);
        cont.removeClass('has-error has-success has-warning');
        $('.help-inline.has-error, span.glyphicon.form-control-feedback, .help-inline.has-success, .help-inline.has-warning',
            cont).remove();
    }
    function add_validation_markup(input, cls, caption) {
        var cont = find_container(input);
        cont.addClass(cls);
        input.addClass(cls);
        if(cls === 'has-success'){
            input.after('<span class="glyphicon glyphicon-ok form-control-feedback"></span>');
        }
        if (caption) {
            var msg = $('<span class="help-inline"/>');
            msg.addClass(cls);
            msg.text(caption);
            input.after(msg);
            input.after('<span class="glyphicon glyphicon-remove form-control-feedback"></span>');
        }
    }
    function remove_all_validation_markup(form) {
        $('.help-inline.has-error, span.glyphicon.form-control-feedback, .help-inline.has-success, .help-inline.has-warning',
            form).remove();
        $('.has-error, .has-success, .has-warning', form)
            .removeClass('has-error has-success has-warning');
    }

    $.tools.validator.localize("rus", {
        '*'			: 'Пожалуйста введите корректное значение',
        ':email'  	: 'Пожалуйста введите валидный емайл адресс',
        ':number' 	: 'Пожалуйста введите число',
        ':url' 		: 'Пожалуйста укажите корректный url',
        '[max]'	 	: 'Пожалуйста введите значение меньше $1',
        '[min]'		: 'Пожалуйста введите значение больше $1',
        '[required]': 'Пожалуйста заполните обязательное поле'
    });

    $('form').each(function () {
        var form = $(this);

        form
            .validator({
                lang: 'rus'
            })
            .bind('reset.validator', function () {
                remove_all_validation_markup(form);
            })
            .bind('onSuccess', function (e, ok) {
                $.each(ok, function() {
                    var input = $(this);
                    remove_validation_markup(input);
                    add_validation_markup(input, 'has-success');
                });
            })
            .bind('onFail', function (e, errors) {
                $.each(errors, function() {
                    var err = this;
                    var input = $(err.input);
                    remove_validation_markup(input);
                    add_validation_markup(input, 'has-error',
                        err.messages.join(' '));
                });
                return false;
            });
    });
});