<script>
$(document).ready(function() { 
	$("#repart_template_date").datepicker({ dateFormat: "dd/mm/yy" });
} ) ;
</script>
<h2>Modification d'un modèle de répartition d'aliment</h2>

<a href="index.php?module=repartTemplateList">Retour à la liste</a>
<div class="formSaisie">
<div>
<form id="repartTemplateForm" method="post" action="index.php?module=repartTemplateWrite">
<input type="hidden" name="repart_template_id" value={$data.repart_template_id}>
<fieldset>
<legend>Données générales</legend>
<dl>
<dt>Date de création <span class="red">*</span> :</dt>
<dd>
<input class="date" name="repart_template_date" id="repart_template_date" value="{$data.repart_template_date}" required>
</dd>
</dl>
<dl>
<dt>Description  <span class="red">*</span> :</dt>
<dd><input name="repart_template_libelle" value="{$data.repart_template_libelle}" autofocus required size="40">
</dd>
</dl>
<dl>
<dt>Catégorie d'alimentation <span class="red">*</span> :</dt> 
<dd>
<select name="categorie_id" id="categorie_id" {if $data.repart_template_id > 0}disabled{/if}>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $data.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
</dd>
</dl>
<dl>
<dt>Modèle utilisable ?</dt>
<dd>
<input type="radio" name="actif" value="1" {if $data.actif == 1}checked{/if}>oui
<input type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if}>non
</dd>
</dl>
</fieldset>

{if $data.repart_template_id > 0}
<fieldset>
<legend>Aliments distribués</legend>
{section name=lst loop=$dataAliment}
<input type="hidden" name="repart_aliment_id_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].repart_aliment_id}">
<input type="hidden" name="aliment_id_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].aliment_id}">
<dl>
<dt>{$dataAliment[lst].aliment_libelle}</dt>
<dd>
<label for="repart_alim_taux_{$dataAliment[lst].aliment_id}">Pourcentage de la ration :</label>
<input id="repart_alim_taux_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].repart_alim_taux}" style="width:3em;" name="repart_alim_taux_{$dataAliment[lst].aliment_id}" pattern="[0-9]*" title="Taux de répartition de l'aliment (le total de tous les aliments doit faire 100)" >
<br>
<label>Répartition quotidienne, en pourcentage</label>
<br>
Matin : 
<input type="text" name="matin_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].matin}" style="width:3em;"  pattern="[0-9]*">
Midi : 
<input type="text" name="midi_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].midi}" style="width:3em;"  pattern="[0-9]*">
Soir : 
<input type="text" name="soir_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].soir}" style="width:3em;"  pattern="[0-9]*">
Nuit : 
<input type="text" name="nuit_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].nuit}" style="width:3em;"  pattern="[0-9]*">
<br>
<label for="consigne">Consignes : </label>
<input id="consigne" name="consigne_{$dataAliment[lst].aliment_id}" value="{$dataAliment[lst].consigne}" size="30">
</dd>
</dl>
{/section}
</fieldset>
{/if}
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>


{if $data.repart_template_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="repart_template_id" value="{$data.repart_template_id}">
<input type="hidden" name="module" value="repartTemplateDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>