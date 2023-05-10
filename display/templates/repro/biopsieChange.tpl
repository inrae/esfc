<script>
$(document).ready(function() {
	$(".commentaire").attr("size","30");
});
</script>
<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">Retour à la liste des poissons</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
Retour au reproducteur
</a>
{include file="repro/poissonCampagneDetail.tpl"}
<h2{t}Modification d'une biopsie{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="biopsieForm" method="post" action="index.php?module=biopsieWrite" enctype="multipart/form-data" >
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date du prélèvement <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="datetimepicker" name="biopsie_date" required value="{$data.biopsie_date}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Diamètre moyen (mm) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="diam_moyen" value="{$data.diam_moyen}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Écart type du diamètre moyen :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="diametre_ecart_type" value="{$data.diametre_ecart_type}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Technique de mesure utilisée :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="biopsie_technique_calcul_id">
<option value="" {if $data.biopsie_technique_calcul_id == ""}selected{/if}>
Sélectionnez...
</option>
{section name=lst loop=$techniqueCalcul}
<option value="{$techniqueCalcul[lst].biopsie_technique_calcul_id}" {if $techniqueCalcul[lst].biopsie_technique_calcul_id == $data.biopsie_technique_calcul_id}selected{/if}>
{$techniqueCalcul[lst].biopsie_technique_calcul_libelle}
</option>
{/section}
</select>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Image utilisée pour le calcul du diamètre :
{/t}</label>
<label for="" class="control-label col-md-4">{t}<input type="file" name="documentName[]" size="40" multiple>{/t}</label>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux OPI :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_opi" value="{$data.tx_opi}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux de coloration normale :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_coloration_normal" value="{$data.tx_coloration_normal}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Taux d'éclatement :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="tx_eclatement" value="{$data.tx_eclatement}">
</dd>
</div>
<fieldset>
<legend>{t}Maturation Ringer{/t}<legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}T50 :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="time" name="ringer_t50" value="{$data.ringer_t50}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}% maximal de maturation observé :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="ringer_tx_max" value="{$data.ringer_tx_max}">
 en 
 <input class="time" name="ringer_duree" value="{$data.ringer_duree}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaires :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="ringer_commentaire" value="{$data.ringer_commentaire}">
</dd>
</div>
</fieldset>
<fieldset>
<legend>{t}Maturation Leibovitz{/t}<legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}T50 :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="time" name="leibovitz_t50" value="{$data.leibovitz_t50}">
</dd>
</div><div class="form-group">
<label for="" class="control-label col-md-4">{t}% maximal de maturation observé :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="taux" name="leibovitz_tx_max" value="{$data.leibovitz_tx_max}">
 en 
 <input class="time" name="leibovitz_duree" value="{$data.leibovitz_duree}">
</dd>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaires :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="leibovitz_commentaire" value="{$data.leibovitz_commentaire}">
</dd>
</div>
</fieldset>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Commentaire général :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="commentaire" name="biopsie_commentaire" value="{$data.biopsie_commentaire}">
</dd>
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.biopsie_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="biopsieDelete">
<input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
<input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
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
{if $data.biopsie_id > 0}

<h3>Documents associés</h3>
{include file="document/documentListOnly.tpl"}
{/if}
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>