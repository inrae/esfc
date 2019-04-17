
<script>
$(document).ready(function() { 
	var documentChangeShow = 0;
	$('#documentChange').hide("") ;
	$('#documentChangeActivate').click(function () {
		if (documentChangeShow == 0) {
			$('#documentChange').show("");
			documentChangeShow = 1 ;
			
			
		} else {
			$('#documentChange').hide("");
			documentChangeShow = 0 ;
		}
		$('html, body').animate({
      scrollTop: $("#documentChangeActivate").offset().top
	   }, 10);
	});
} ) ;
</script>
{if $droits["bassinGestion"] == 1 || $droits["poissonGestion"] == 1 || $droits["reproGestion"] == 1} 
<a href="#" id="documentChangeActivate">Saisir un nouveau document...</a>
<div id="documentChange">
{include file="document/documentChange.tpl"}
</div>
{/if}
{include file="document/documentListOnly.tpl"}