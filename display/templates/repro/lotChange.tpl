<script>
$(document).ready(function() {
	$(".taux").attr("pattern","[0-9]+(\.[0-9]+)?");
	$(".taux").attr("title","valeur numérique");
	$(".taux").attr("size", "5");
	$(".taux").attr("maxlength", "10");
	$(".commentaire").attr("size","30");
	$(".date").datepicker( { dateFormat: "dd/mm/yy" } );
});
</script>
<a href="index.php?module=lotList">Retour à la liste des lots</a>&nbsp;
{if $data.lot_id > 0}
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">
Retour au lot
</a>
{/if}
<h2{t}Caractéristiques du lot{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="lotForm" method="post" action="index.php?module=lotWrite">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Croisement d'origine <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="croisement_id" >
{section name=lst loop=$croisements}
<option value="{$croisements[lst].croisement_id}" {if $croisements[lst].croisement_id == $data.croisement_id}selected{/if}>
{$croisements[lst].parents}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom du lot <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="lot_nom" value="{$data.lot_nom}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date d'éclosion :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="eclosion_date" value="{$data.eclosion_date}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nombre de larves estimé :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="nb_larve_initial" value="{$data.nb_larve_initial}">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nombre de larves compté :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="nb_larve_compte" value="{$data.nb_larve_compte}">

</div>
<fieldset>
<legend>{t}Marquage VIE{/t}<legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date du marquage :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="vie_date_marquage" value="{$data.vie_date_marquage}">

</div>
</div>
<div class="form-group"><label for="" class="control-label col-md-4">{t}Modèle de marquage VIE utilisé :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="vie_modele_id">
<option value="" {if $data.vie_modele_id == ""}selected{/if}>
Sélectionnez...
</option>
{section name=lst loop=$modeles}
<option value="{$modeles[lst].vie_modele_id}" {if $data.vie_modele_id == $modeles[lst].vie_modele_id}selected{/if}>
{$modeles[lst].couleur}, {$modeles[lst].vie_implantation_libelle}, {$modeles[lst].vie_implantation_libelle2}
</option>
{/section}
</select>
</div>

</fieldset>
<div class="form-group"></div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.lot_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="lotDelete">
<input type="hidden" name="lot_id" value="{$data.lot_id}">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>