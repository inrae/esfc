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
<h2>Mesures pour le lot</h2>
<div class="formSaisie">
<div>
<form id="lotMesureForm" method="post" action="index.php?module=lotMesureWrite">
<input type="hidden" name="lot_mesure_id" value="{$data.lot_mesure_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<dl>
<dt>Date <span class="red">*</span> :</dt>
<dd>
<input class="date"  name="lot_mesure_date" required value="{$data.lot_mesure_date}">
</dd>
</dl>
<dl><dt>Nombre de jours depuis l'éclosion :</dt>
<dd><input name="nb_jour" readonly class="entier" value="{$data.nb_jour}"> 
(valeur calculée à l'enregistrement)</dd>
</dl>
<dl><dt>Nbre d'individus morts :</dt>
<dd><input name="lot_mortalite" class="entier" value="{$data.lot_mortalite}"></dd>
</dl>
<dl><dt>Masse globale (en grammes) :</dt>
<dd><input name="lot_mesure_masse" class="taux" value="{$data.lot_mesure_masse}">
</dd>
</dl>
<dl>
<dt>Masse individuelle (en grammes) :</dt>
<dd><input name="lot_mesure_masse_indiv" class="taux" value="{$data.lot_mesure_masse_indiv}">
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
{if $data.lot_mesure_id > 0 &&$droits["reproGestion"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="lotMesureDelete">
<input type="hidden" name="lot_mesure_id" value="{$data.lot_mesure_id}">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>
