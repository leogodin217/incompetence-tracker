$(document).ready(function() {
	$('.rounded').corner('20px');
	$('.rounded-bottom').corner('bottom');
	$('.rounded-top').corner('top');
	oTable = $('#contact-records-index').dataTable({
		"bJQueryUI"			: true,
		"sPaginationType"	: "full_numbers",
		"bLengthChange"		: false,
		"bAutoWidth"		: true
	});

	oTable = $('#problems-index').dataTable({
		"bJQueryUI"			: true,
		"sPaginationType"	: "full_numbers",
		"bLengthChange"		: false,
		"bAutoWidth"		: true
	});

	$('input:submit').button();
	$('.button-link').button();
	$('.table-link>a').button();
	$('#instructions').tabs({fx : {opacity : 'toggle'}});
});$
