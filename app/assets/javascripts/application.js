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
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require modernizr-2.0.6.min
//= require select2
//= require bootstrap-datepicker
//= require bootstrap-modalmanager
//= require bootstrap-modal
//= require parsley.min
//= require form_helpers
//= require ajax-available
//= require bootstrap-timepicker
//= require_tree .

jQuery(function($){
 		$('.multiselect').multiselect(); 

		$('.carousel').carousel();

		$('.timepicker').timepicker();

		$(".print_page").click(function(){
			window.print();
		});
//   $('#cat-nav .dropdown-menu').on('show', function() {
//       slimScroll({});
//    });


    $("#same .btn").on("click", function() {
        if ($(this).hasClass("yes")) {
            $("#user_billing_street_address_1").val($("#user_street_address_1").val());
            $("#user_billing_street_address_2").val($("#user_street_address_2").val());
            $("#user_billing_city").val($("#user_city").val());
            $("#user_billing_state").val($("#user_state").val());
            $("#user_billing_zip").val($("#user_zip").val());
        } else {
            $("#billing-address input").val("");
        }
    });

    $('a.bar.clickable').on('click', function(e) {
	e.preventDefault();
	e.stopPropagation();
	$('body').modalmanager('loading');
	$.rails.handleRemote( $(this) );
    })

    $('.get-modal').on('click', function(e) {
	e.preventDefault();
	e.stopPropagation();
	$('body').modalmanager('loading');
	$.rails.handleRemote( $(this) );
    })

    $('.fat-bar, a.producer-close').on('click', function(e) {
	$(this).parent().parent().parent().toggleClass("glowing");
	$($(this).attr("data-target")).toggleClass("collapsed");
	$(this).toggleClass("faded");
    });

    $('.row-collapse #toggle').on('click', function(e) {
	$($(e.target).attr("some")).toggleClass("expanded");
    });

    $('#target_user_id').on('change', function(e) {
        var url = $(this).val(); // get selected value
        if (url) { // require a URL
            window.location = url; // redirect
        }
        return false;
    });

    ////////////////////////////////////////////////////////////////////////////
    //// Plugin initializers

    // Initialize Select2 Plugin (pretty select fields) on select fields with class="select2"
    $('.select2').select2({minimumInputLength: 2});

    $('.bar').popover({trigger: 'hover'});
    

	    // Initialize Datepicker on select fields with data-behavior='datepicker' attribute
	    $("[data-behavior~='datepicker']").datepicker({
		"format": "yyyy-mm-dd",
		"weekStart": 1,
		"autoclose": true
	    });
	    ////////////////////////////////////////////////////////////////////////////



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

    $("#filter-toggle").on("click", function() {
	$(this).toggleClass("active");
    });

    // Initialize field errors in popover
    $('.fieldWithErrors').popover()


    ////////////////////////////////////////////////////////////////////////////
    // Rails add/remove js for has_many associated model forms
    // Render fields for an associated object
    $(document).on('click', 'a.add_child', function() {
	var assoc = $(this).attr('data-association');
	var content = $(this).parents('tr').first().find('#' + assoc + '_fields_template').html();
	if (content == null) {
		content = $('#' + assoc + '_fields_template').html();
		
	}	
	var regexp = new RegExp('new_' + assoc, 'g');
	var new_id = new Date().getTime();
	content=content.replace(regexp, new_id+'');
	$(this).parent().parent().before(content);
	$(this).parents('tr').first().find("select[id$='selling_unit_id']").val($(this).parents('tr').first().find("select[id='good_selling_unit_id']").val());
	

	//inputPrompts();
	return false;
    });
    // Remove fields for new object
    $(document).on("click", 'form a.remove-new-child', function() {
	$(this).parents('.child-field').remove();
	return false;
    });
    // Remove fields for existing object
    $(document).on("click", 'a.remove-old-child', function() {
	var hidden_destroy_field = $(this).parent().next('input.destroy-field');
	hidden_destroy_field.val(1);
	$(this).parents('.child-field').hide();
	$(this).parents(".good").first().find(".save_line").show()
	
	return false;
    });
    // Toggling fields from a select box
    $('.toggle-fields').on('click', function(){
        $("."+$(this).attr('toggle_fields')+":visible").hide();
        $('#'+$(this).attr('toggle_field')).show();
        return true;
    });
    $('.toggle').on('change', function() {
        if ($(this).is(':checked')) {
	    $("."+$(this).attr('data-off')).hide();
	    $("."+$(this).attr('data-on')).show();
	} else {
	    $("."+$(this).attr('data-off')).show();
	    $("."+$(this).attr('data-on')).hide();
	}
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
	    //$.getScript(location.href);
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
    function addZero(num) {
	(String(num).length < 3) ? num = String("0" + num) :  num = String(num);
	return num;
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

    function toggleProducts() {
	$("#product_selection input.root_box:checked").parent().siblings(".categories").show();
	$("#product_selection input.root_box:not(:checked)").parent().siblings(".categories").hide();
	$("#product_selection input.category_box:checked").parent().siblings(".products").show();
	$("#product_selection input.category_box:not(:checked)").parent().siblings(".products").hide();
    }
    $("#product_selection input[type='checkbox']").on("change", function() {toggleProducts()});
    toggleProducts();

    
    /** AGREEMENT FORM **/
    function resetSelect(elem, data) {
	elem.empty();	
	elem.append($('<option>', {value : ""}).text("-- Please Select --"))
	$.each(data, function(k,v) {
	    elem.append($('<option>', {value : v[1]}).text(v[0]));
	    elem.attr("disabled", false);
	});
    }

    $("#category_id").on("change", function() {
	resetSelect($("#subcategory_id"), categories[$("#category_id").val()]["option_children"]);
    });
    $("#subcategory_id").on("change", function() {
	resetSelect($("#fake_product_id"), categories[$("#subcategory_id").val()]["option_products"]);
    });
    $("#fake_product_id").on("change", function() {
	$("#agreement_product_id").val($("#fake_product_id").val()).trigger("change");
    });
    function populateBrowsingFields() {
	var productNameSelectID = $("#agreement_name");
	if (typeof products !== 'undefined') {
	    var product = products[$('#agreement_product_id').val()];
	    if (product) {
		var subcategory = categories[product["category_id"]];
		var category = categories[subcategory["parent_id"]];
		productNameSelectID.val($('#agreement_product_id option:selected').html());
		
		$("#category_id").val(category["id"]);
		resetSelect($("#subcategory_id"), categories[$("#category_id").val()]["option_children"]);
		$("#subcategory_id").val(subcategory["id"]);
		resetSelect($("#fake_product_id"), categories[$("#subcategory_id").val()]["option_products"]);
		$("#fake_product_id").val(product["id"]);
		$.ajax({
		    url: "/products/" + $("#agreement_product_id option:selected").val() + "/pic",
		    type: 'GET'
		});
	    }
	}
    }
    $('#agreement_product_id').on("change", function(e) {populateBrowsingFields();});
    populateBrowsingFields();


    
    $('#agreement_selling_unit').on("change", function(e) {
	$("#quantity_add_on").html($('#agreement_selling_unit option:selected').html());
    });

    $("#agreement_agreement_type").on("change", function() {
	displayFields("agreement_agreement_type");
    });
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
