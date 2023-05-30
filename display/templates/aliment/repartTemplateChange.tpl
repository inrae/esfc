<script>
$(document).ready(function() { 
	$("#repart_template_date").datepicker({ dateFormat: "dd/mm/yy" });
	$(".num3").attr("pattern", "[0-9]+(\.[0-9]+)?");
} ) ;
</script>
<h2{t}Modification d'un modèle de répartition d'aliment{/t}</h2>

<a href="index.php?module=repartTemplateList">Retour à la liste</a>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="repartTemplateForm" method="post" action="index.php?module=repartTemplateWrite">
<input type="hidden" name="repart_template_id" value={$data.repart_template_id}>
<fieldset>
<legend>{t}Données générales{/t}<legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de création <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="repart_template_date" id="repart_template_date" value="{$data.repart_template_date}" required>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Description  <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="repart_template_libelle" value="{$data.repart_template_libelle}" autofocus required size="40">

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Catégorie d'alimentation <span class="red">*</span> :{/t}</label> 
<div class="col-md-8">
<select id="" class="form-control" name="categorie_id" id="categorie_id" {if $data.repart_template_id > 0}disabled{/if}>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $data.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Modèle utilisable ?{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="radio" name="actif" value="1" {if $data.actif == 1}checked{/if}>oui
<input type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if}>non

</div>
</fieldset>

{if $data.repart_template_id > 0}
<fieldset>
<legend>{t}Aliments distribués{/t}<legend>
{section name=lst loop=$dataAliment}
<input type="hidden" name="repart_aliment_id_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].repart_aliment_id}">
<input type="hidden" name="aliment_id_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].aliment_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}{$dataAliment[lst].aliment_libelle}{/t}</label>
<dd>
<label for="repart_alim_taux_{$dataAliment[lst].aliment_id}">Pourcentage de la ration :</label>
<input class="num3" id="repart_alim_taux_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].repart_alim_taux}" style="width:3em;" name="repart_alim_taux_{$dataAliment[lst].aliment_id}" title="Taux de répartition de l'aliment (le total de tous les aliments doit faire 100)" >
<br>
<label>Répartition quotidienne, en pourcentage</label>
<br>
Matin : 
<input class="num3" type="text" name="matin_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].matin}" style="width:3em;"  >
Midi : 
<input class="num3" type="text" name="midi_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].midi}" style="width:3em;"  >
Soir : 
<input class="num3" type="text" name="soir_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].soir}" style="width:3em;"  >
Nuit : 
<input class="num3" type="text" name="nuit_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].nuit}" style="width:3em;"  >
<br>
<label for="consigne">Consignes : </label>
<input id="consigne" name="consigne_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].consigne}" size="30">

</div>
{/section}
</fieldset>
{/if}

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>


{if $data.repart_template_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="repart_template_id" value="{$data.repart_template_id}">
<input type="hidden" name="module" value="repartTemplateDelete">
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

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>