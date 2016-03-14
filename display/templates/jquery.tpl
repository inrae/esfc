<!-- script type="text/javascript" charset="utf-8" src="display/javascript/DataTables-1.9.4/media/js/jquery.js"></script-->
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-ui.custom.min.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript//DataTables-1.9.4/media/js/jquery.dataTables.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/DataTables-1.9.4/extras/TableTools/media/js/TableTools.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/DataTables-1.9.4/extras/TableTools/media/js/ZeroClipboard.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/carhartl-jquery-cookie-3caf209/jquery.cookie.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" charset="utf-8" src="display/javascript/jquery.datetimepicker.full.min.js"></script>
<style type="text/css" > 
@import "display/CSS/TableTools.css";
@import "display/CSS/dataTables.css";
@import "display/CSS/jquery-ui-1.10.4.custom.css";
@import "display/CSS/timepicker.css";
@import "display/CSS/jquery.datetimepicker.css";

</style>
<!--  Definition des balises titre par defaut -->
<script>
$(document).ready(function() {
	<!--$('.taux').attr('placeholder', '100, 95.5...');-->
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
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
	$('.timepicker').attr('pattern', '[0-9][0-9]\:[0-9][0-9]\:[0-9][0-9]');
	$('.datetimepicker').datetimepicker({ 
		format:'d/m/Y H:i:s'
	});
} ) ;
</script>