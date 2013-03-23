// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// Bootstrap changes: 
//  bootstrap-popover.js addition:
//    html: 'true'
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require modernizr-2.0.6.min
//= require select2
//= require parsley.min
//= require_tree .
jQuery(function($){
    $('.select2').select2({minimumInputLength: 2});

    $('.parsley').parsley({
	errors: {
	    errorsWrapper: '<span class="span0" style="display: none;"></span>',
	    errorElem: '<small></small>'
	}
    });

    $(":file").filestyle({
	icon: true
    });

    ////////////////////////////////////////////////////////////////////////////
    // For associated model forms
    // Render fields for an associated object
	$('form a.add_child').on('click', function() {
	    var assoc = $(this).attr('data-association');
	    var content = $('#' + assoc + '_fields_template').html();
	    var regexp = new RegExp('new_' + assoc, 'g');
	    var new_id = new Date().getTime();
	    content=content.replace(regexp, new_id+'');
	    $(this).parent().parent().before(content);
	    //inputPrompts();
	    return false;
	});
    // Remove fields for new object
	$('form a.remove-new-child').on('click', function() {
	    $(this).parents('.child-field').remove();
	    return false;
	});
    // Remove fields for existing object
	$('form a.remove-old-child').on('click', function() {
	    var hidden_destroy_field = $(this).parent().next('input.destroy-field');
	    hidden_destroy_field.val(1);
	    $(this).parents('.child-field').hide();
	    return false;
	});
    // Toggling fields from a select box
        $('.toggle-fields').on('click', function(){
            $("."+$(this).attr('toggle_fields')+":visible").hide();
            $('#'+$(this).attr('toggle_field')).show();
            return true;
	});
    ////////////////////////////////////////////////////////////////////////////


    /**
     * ALL Student AJAX select
     */
    // SELECT 
    if (history && history.pushState) {
	$("#formAdminTable select, #formAdminTable input:checkbox").on("change", function() {
	    var form = $("#form-filter");
	    form.submit();
	    history.pushState(null, document.title, form.attr("action") + "?" + form.serialize());
	});
	$("#formAdminTable input").keyup(function() {
	    var form = $("#form-filter");
	    form.submit();
	    history.replaceState(null, document.title, form.attr("action") + "?" + form.serialize());
	});

	$(window).bind("popstate", function() {
	    $.getScript(location.href);
	});
    } else {
	$("#formAdminTable select, #formAdminTable input:checkbox").on("change", function() {
	    $(':text.hasPlaceholder').val('');
	    $("#form-filter").submit();
	});
	$("#formAdminTable input").keyup(function() {
	    $(':text.hasPlaceholder').val('');
	    $("#form-filter").submit();
	});
    }
/**    
    $("[data-behavior~='datepicker']").datepicker({
	"format": "yyyy-mm-dd",
	"weekStart": 1,
	"autoclose": true
    });
*/

    $('.fieldWithErrors').popover()

    $('#same .btn').click( function() {
	if ($(this).hasClass('yes')) {
//	    $('#pastAddress').hide();
            $('#form_l_street_address_1').val($('#form_p_street_address_1').val());
            $('#form_l_street_address_2').val($('#form_p_street_address_2').val());
            $('#form_l_city').val($('#form_p_city').val());
            $('#form_l_state').val($('#form_p_state').val());
            $('#form_l_zip_code').val($('#form_p_zip_code').val());
	} else {
//	    $('#pastAddress').show();
	    $('#pastAddress input').val('');
	}
    })

    function displayFields() {
	$("form .specificFields").hide();
	$('.' + $("#form_form_type").val()).show(); // Show currently Selected
    }
    $("#form_form_type").on("change", function() {displayFields()});
    displayFields();


    /** 
     * Swap out fieldsets depending on user input
     */
    function grantingConsent() {
        if ($('#form_consent_to_treatment option:selected').val() == "true") {
            $('#grant').show();
            $('#refuse').hide();
        } else if ($('#form_consent_to_treatment option:selected').val() == "false") {
            $('#grant').hide();
            $('#refuse').show();
        } else {
            $('#grant').hide();
            $('#refuse').hide();
	}
    }
    $('#form_consent_to_treatment').change(function() {grantingConsent()});
    grantingConsent();



    
    ////////////////////////////////////////////////////////////////////////////
    // Placeholder fix for IE
    jQuery.support.placeholder = false;
    test = document.createElement('input');
    if('placeholder' in test) jQuery.support.placeholder = true;

    // This adds placeholder support to browsers that wouldn't otherwise support it. 
    if(!$.support.placeholder) { 
	var active = document.activeElement;
	$(':text[placeholder]').focus(function () {
	    if ($(this).attr('placeholder') != '' && $(this).val() == $(this).attr('placeholder')) {
		$(this).val('').removeClass('hasPlaceholder');
	    }
	}).blur(function () {
	    if ($(this).attr('placeholder') != '' && ($(this).val() == '' || $(this).val() == $(this).attr('placeholder'))) {
		$(this).val($(this).attr('placeholder'));
		$(this).addClass('hasPlaceholder');
	    }
	});
	$(':text').blur();
	$(active).focus();
	$('form:eq(0)').submit(function () {
	    $(':text.hasPlaceholder').val('');
	});
    }
    ////////////////////////////////////////////////////////////////////////////

});