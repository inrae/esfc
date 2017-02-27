<!-- script type="text/javascript" charset="utf-8" src="display/javascript/DataTables-1.9.4/media/js/jquery.js"></script-->
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-1.12.4.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-ui-1.12.0.custom/jquery-ui.min.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-ui-1.12.0.custom/i18n/datepicker-fr.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-ui-1.12.0.custom/i18n/datepicker-en.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/datatables-1.10.13/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/buttons-1.2.4/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jszip.min.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/pdfmake.min.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/vfs_fonts.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/buttons-1.2.4/js/buttons.html5.min.js"></script>

<script type="text/javascript" charset="utf-8" src="display/javascript/carhartl-jquery-cookie-3caf209/jquery.cookie.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-timepicker-addon/jquery-ui-timepicker-addon.min.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-timepicker-addon/i18n/jquery-ui-timepicker-fr.js"></script>


<!-- script type="text/javascript" charset="utf-8" src="display/javascript/jquery.datetimepicker.full.min.js"></script-->
<style type="text/css" > 
@import "display/javascript/datatables-1.10.13/css/jquery.dataTables.min.css";
@import "display/javascript/buttons-1.2.4/css/buttons.dataTables.min.css";
@import "display/javascript/datatables-1.10.13/css/dataTables.jqueryui.min.css";
@import "display/javascript/jquery-ui-1.12.0.custom/jquery-ui.min.css";
@import "display/CSS/timepicker.css";
@import "display/javascript/jquery-timepicker-addon/jquery-ui-timepicker-addon.min.css";

</style>
<!--  Definition des balises titre par defaut -->
<script>
$(document).ready(function() {
	 
	 $.datepicker.setDefaults($.datepicker.regional['fr']);
	<!--$('.taux').attr('placeholder', '100, 95.5...');-->
	$(".date").datepicker( { 
		dateFormat: "dd/mm/yy",
	} );
	$(".date").attr( { 
		'maxlength': '10'
	});
	$('.taux').attr( {
		'pattern': '[0-9]+(\.[0-9]+)?',
		'maxlength' : "10",
		'title' : "Nombre avec ou sans décimales (séparateur : point)"
	} );
	$('.nombre').attr( {
		'pattern': '[0-9]+',
		'maxlength' : "10",
		'title' : 'Nombre entier (sans décimales)'
	}
	);
	$('.timepicker').attr( {
		'pattern': '[0-9][0-9]\:[0-9][0-9]\:[0-9][0-9]',
		'maxlength': "8"
	});
	$.timepicker.setDefaults($.timepicker.regional['fr']);
	$('.datetimepicker').datetimepicker({ 
		dateFormat: "dd/mm/yy",
		timeFormat: 'HH:mm:ss',
	});
	$('.datetimepicker').attr( {
		'maxlength': '19'
	});
} ) ;
</script>