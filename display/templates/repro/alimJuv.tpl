<script>
$('document').ready(function() { 
	var duree = $('#duree').val();
	if (duree > 1) {
		$('#densite').prop("disabled", true);
	}
	$('#duree').change(function () { 
		var duree = $(this).val();
		if (duree == 1) {
			$('#densite').prop("disabled", false);
		} else {
			$("#densite").prop("disabled", true);
		}
	});
});
</script>
<fieldset><legend>{t}Alimentation quotidienne{/t}<legend>
<form name="alimJuv" method="post" action="index.php">
<input type="hidden" name="module" value="lotalimGenerate">
Date de début d'alimentation :
<input name="date_debut_alim" class="date" value="{$dataAlim.date_debut_alim}">
Durée d'alimentation (en jours) : 
<input id="duree" name="duree" required value="{$dataAlim.duree}" class="nombre">
<br>
Nombre d'artémies par ml : 
<input id="densite" name="densite" value="{$dataAlim.densite}" class="nombre">
<br>
<div class="center">
<input type="submit" value="Générer la fiche d'alimentation">
</div>
</form>
</fieldset>