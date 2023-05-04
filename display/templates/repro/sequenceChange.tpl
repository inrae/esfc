 <script>
 
$(document).ready(function() { 
$( "#cdate_debut" ).datepicker( { dateFormat: "dd/mm/yy" } );
});
</script>
<a href="index.php?module=sequenceList">
Retour à la liste des séquences
</a>
<h2{t}Modification d'une séquence{/t}</h2>
<div class="formSaisie">
<div>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="sequenceForm" method="post" action="index.php?module=sequenceWrite">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
<fieldset>
<legend>Séquence</legend>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Année <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="annee" required readonly size="10" maxlength="10" value="{$data.annee}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Site <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" id="site_id" name="site_id">
{section name=lst loop=$site}
<option value="{$site[lst].site_id}"} {if $site[lst].site_id == $data.site_id}selected{/if}>
{$site[lst].site_name}
</option>
{/section}
</select>
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom de la séquence <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="sequence_nom" required size="20" maxlength="30" value="{$data.sequence_nom}">
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de début de la séquence <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="date" name="sequence_date_debut" id="cdate_debut" required size="10" maxlength="10" value="{$data.sequence_date_debut}">
</dd>
</div>
</fieldset>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{if $data.sequence_id > 0 &&$droits["reproAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="module" value="sequenceDelete">
<input type="hidden" name="sequence_id" value="{$data.sequence_id}">
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
