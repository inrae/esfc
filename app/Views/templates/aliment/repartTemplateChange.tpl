<script>
	$(document).ready(function() { 
		$(".num3").attr("pattern", "[0-9]+(\.[0-9]+)?");
	} ) ;
	</script>
<h2>{t}Modification d'un modèle de répartition d'aliment{/t}</h2>

<a href="repartTemplateList">{t}Retour à la liste{/t}</a>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="repartTemplateForm" method="post" action="repartTemplateWrite">

<input type="hidden" name="moduleBase" value="repartTemplate">
<input type="hidden" name="repart_template_id" value={$data.repart_template_id}>
<div class="form-group center">
	<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
</div>
<fieldset>
<legend>{t}Données générales{/t}</legend>
<div class="form-group">
<label for="repart_template_date" class="control-label col-md-4">{t}Date de création :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="repart_template_date" class="form-control" class="date form-control" name="repart_template_date" value="{$data.repart_template_date}" required>

</div>
</div>
<div class="form-group">
<label for="repart_template_libelle" class="control-label col-md-4">{t}Description  :{/t}<span class="red">*</span></label>
<div class="col-md-8">
<input id="repart_template_libelle" class="form-control" name="repart_template_libelle" value="{$data.repart_template_libelle}" autofocus required>

</div>
</div>
<div class="form-group">
<label for="categorie_id" class="control-label col-md-4">{t}Catégorie d'alimentation :{/t}<span class="red">*</span></label> 
<div class="col-md-8">
<select class="form-control" name="categorie_id" id="categorie_id" {if $data.repart_template_id > 0}disabled{/if}>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $data.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>

</div>
</div>
<div class="form-group">
<label for="actif1" class="control-label col-md-4">{t}Modèle utilisable ?{/t}</label>
<div class="col-md-8">
	<label class="radio-inline">
		<input id="actif1" type="radio" name="actif" value="1" {if $data.actif == 1}checked{/if}>{t}oui{/t}
	</label>
	<label class="radio-inline">
		<input id="actif0" type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if}>{t}non{/t}
	</label>
</div>
</div>
</fieldset>

{if $data.repart_template_id > 0}
<fieldset>
<legend>{t}Aliments distribués{/t}</legend>
{section name=lst loop=$dataAliment}
<fieldset>
	<legend>
		<div class="col-lg-8">
		{t}{$dataAliment[lst].aliment_libelle}{/t} - {t}Pourcentage de la ration :{/t}
		</div>
		<div class="col-lg-3">
			<input class="num3" id="repart_alim_taux_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].repart_alim_taux}" style="width:3em;" name="repart_alim_taux_{$dataAliment[lst].aliment_id}" title="{t}Taux de répartition de l'aliment (le total de tous les aliments doit faire 100){/t}" >
		</div>
	</legend>
	<input type="hidden" name="repart_aliment_id_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].repart_aliment_id}">
	<input type="hidden" name="aliment_id_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].aliment_id}">
	<div class="col-lg-12">
	<div class="row">
		<label class="col-md-8">{t}Répartition quotidienne, en pourcentage :{/t}</label>
	</div>
	<div class="col-lg-12">
	<div class="row">
	{t}Matin :{/t}
	<input class="num3" type="text" name="matin_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].matin}" style="width:3em;"  >
	&nbsp;{t}Midi :{/t}
	<input class="num3" type="text" name="midi_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].midi}" style="width:3em;"  >
	&nbsp;{t}Soir :{/t} 
	<input class="num3" type="text" name="soir_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].soir}" style="width:3em;"  >
	&nbsp;{t}Nuit :{/t} 
	<input class="num3" type="text" name="nuit_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].nuit}" style="width:3em;"  >
	</div>
	<div class="row">
		<label for="consigne">{t}Consignes :{/t}</label>
	<input id="consigne" name="consigne_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].consigne}" size="30">
	</div>
	<div class="row">&nbsp;</div>
	</div>
	</div>
</fieldset>
{/section}
</fieldset>
{/if}

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
{if $data.repart_template_id > 0 &&$rights["bassinAdmin"] == 1}
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
{$csrf}</form>
</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>