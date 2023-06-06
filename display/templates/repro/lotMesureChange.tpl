<script>
$(document).ready(function() {
	$(".taux").attr( {
			pattern: "[0-9]+(\.[0-9]+)?",
			size: "5",
			title: "valeur numérique",
			maxlength: "10"
	} );
	$(".entier").attr( { 
		pattern: "[0-9]+",
		size: "5em",
		title: "valeur numérique",
		maxlength: "10"
	});
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module=lotList">Retour à la liste des lots</a>&nbsp;
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">Retour au lot</a>
{include file="repro/lotDetail.tpl"}
<h2>{t}Mesures pour le lot{/t}</h2>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="lotMesureForm" method="post" action="index.php?module=lotMesureWrite">
<input type="hidden" name="lot_mesure_id" value="{$data.lot_mesure_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="" class="form-control" class="date"  name="lot_mesure_date" required value="{$data.lot_mesure_date}">

</div>
</div>
<div class="form-group"><label for="" class="control-label col-md-4">{t}Nombre de jours depuis l'éclosion :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="nb_jour" readonly class="entier" value="{$data.nb_jour}"> 
(valeur calculée à l'enregistrement)
</div>
</div>
<div class="form-group"><label for="" class="control-label col-md-4">{t}Nbre d'individus morts :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="lot_mortalite" class="entier" value="{$data.lot_mortalite}">
</div>
</div>
<div class="form-group"><label for="" class="control-label col-md-4">{t}Masse globale (en grammes) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="lot_mesure_masse" class="taux" value="{$data.lot_mesure_masse}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Masse individuelle (en grammes) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="lot_mesure_masse_indiv" class="taux" value="{$data.lot_mesure_masse_indiv}">
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
{if $data.lot_mesure_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="lotMesureDelete">
<input type="hidden" name="lot_mesure_id" value="{$data.lot_mesure_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>
