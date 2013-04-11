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

    ////////////////////////////////////////////////////////////////////////////
    //// Plugin initializers

    // Initialize Select2 Plugin (pretty select fields) on select fields with class="select2"
    $('.select2').select2({minimumInputLength: 2});

    // Initialize Parsley Plugin (javascript validations) on forms with class="parsley"
    $('form.parsley').parsley({
	errors: {
	    errorsWrapper: '<span class="span0" style="display: none;"></span>',
	    errorElem: '<small></small>'
	}
    });

    // Initialize bootstrap file field formatting on all file fields
    $(":file").filestyle({
	icon: true
    });

    // Initialize field errors in popover
    $('.fieldWithErrors').popover()


    /**    
    // Initialize Datepicker on select fields with data-behavior='datepicker' attribute
    $("[data-behavior~='datepicker']").datepicker({
	"format": "yyyy-mm-dd",
	"weekStart": 1,
	"autoclose": true
    });
    */
    ////////////////////////////////////////////////////////////////////////////


    ////////////////////////////////////////////////////////////////////////////
    // Rails add/remove js for has_many associated model forms
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



    ////////////////////////////////////////////////////////////////////////////
    // AJAX filtering system
    if (history && history.pushState) {
	$("#agreementAdminTable select, #agreementAdminTable input:checkbox").on("change", function() {
	    var form = $("#agreement-filter");
	    form.submit();
	    history.pushState(null, document.title, form.attr("action") + "?" + form.serialize());
	});
	$("#agreementAdminTable input").keyup(function() {
	    var form = $("#agreement-filter");
	    form.submit();
	    history.replaceState(null, document.title, form.attr("action") + "?" + form.serialize());
	});

	$(window).bind("popstate", function() {
	    $.getScript(location.href);
	});
    } else {
	$("#agreementAdminTable select, #agreementAdminTable input:checkbox").on("change", function() {
	    $(':text.hasPlaceholder').val('');
	    $("#agreement-filter").submit();
	});
	$("#agreementAdminTable input").keyup(function() {
	    $(':text.hasPlaceholder').val('');
	    $("#agreement-filter").submit();
	});
    }
    ////////////////////////////////////////////////////////////////////////////



    ////////////////////////////////////////////////////////////////////////////
    // Toggleable fields JS
    //   Assumes all hide/showable fields have same class as selector id attribute 
    //   and ids equal to the corresponding option values
    function displayFields(selectorID) {
	if (selectorID !== "") {
	    $(".df" + selectorID).hide();
	    if ($("#" + selectorID).val()) {
		$('.df' + $("#" + selectorID).val()).show(); // Show currently selected
	    }
	}
    }


    function toggleActive() {
	$(".growing_methods").removeClass("active"); // Show currently selected
	$(".growing_methods input:checked").parent().parent().addClass("active");
    }
    $(".growing_methods input").on("change", function() {toggleActive()}); // Show currently selected
    toggleActive();


    function toggleCerts() {
	$("#specific_certs input.yes:checked").parent().parent().siblings(".certs").show();
	$("#specific_certs input.no:checked").parent().parent().siblings(".certs").hide();
    }
    $("#specific_certs input[type='radio']").on("change", function() {toggleCerts()}); // Show currently selected
    toggleCerts();

    
    /** AGREEMENT FORM **/
    $('#agreement_product_id').on("change", function(e) {
	var name = $("#agreement_name");
	if (name.val() == "") {
	    name.val($('#agreement_product_id option:selected').html());
	}
    });

    $('#agreement_selling_unit').on("change", function(e) {
	$("#quantity_add_on").html($('#agreement_selling_unit option:selected').html());
    });

    $("#agreement_agreement_type").on("change", function() {displayFields("agreement_agreement_type")});
    displayFields("agreement_agreement_type");
    $("#agreement_frequency").on("change", function() {displayFields("agreement_frequency")});
    displayFields("agreement_frequency");
    
    // For duplicating address fields
    $('#sameAddress .btn').click( function() {
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
    ////////////////////////////////////////////////////////////////////////////





    
    ////////////////////////////////////////////////////////////////////////////
    // Placeholder attribute fix for IE
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