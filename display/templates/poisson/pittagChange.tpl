<a href="index.php?module=poissonList">
Retour à la liste des poissons
</a>
 > 
 <a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
 Retour au poisson
 </a>
 {include file="poisson/poissonDetail.tpl"}
<h2>{t}Modification d'un (pit)tag{/t}</h2>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="pittagForm" method="post" action="index.php?module=pittagWrite">
<input type="hidden" name="pittag_id" value="{$data.pittag_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<div class="form-group">
                <label for="" class="control-label col-md-4">{t}Valeur de la marque <span class="red">*</span> :{/t}</label>
                <div class="col-md-8">
<input name="pittag_valeur" id="cpittag_valeur" required size="20" value="{$data.pittag_valeur}" pattern="(([A-F0-9][A-F0-9])+|[0-9]+)" placeholder="01AB2C ou 12345" title="Nombre hexadécimal ou numérique" autofocus>
</div>
</div>

<div class="form-group">
                <label for="" class="control-label col-md-4">{t}Type de marque :{/t}</label>
                <div class="col-md-8">
<select name="pittag_type_id">
<option value="" {if $pittagType.pittag_type_id == ""}selected{/if}>
Sélectionnez le type de marque...
</option>
{section name=lst loop=$pittagType}
<option value="{$pittagType[lst].pittag_type_id}" {if $pittagType[lst].pittag_type_id == $data.pittag_type_id}selected{/if}>
{$pittagType[lst].pittag_type_libelle}
</option>
{/section}
</select>
</div>
</div>

<div class="form-group">
                <label for="" class="control-label col-md-4">{t}Date de pose :{/t}</label>
                <div class="col-md-8">
 <script>
 
$(function() { 
$( "#cpittag_date_pose" ).datepicker( { dateFormat: "dd/mm/yy" } );
 } );
</script>
<input name="pittag_date_pose" id="cpittag_date_pose" size="10" maxlength="10" value="{$data.pittag_date_pose}">
</div>
</div>

<div class="form-group">
                <label for="" class="control-label col-md-4">{t}Commentaire :{/t}</label>
                <div class="col-md-8">
<input name="pittag_commentaire" value="{$data.pittag_commentaire}" size="40">
</div>
</div>

<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
{if $data.pittag_id > 0 &&$droits["poissonGestion"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="pittag_id" value="{$data.pittag_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="module" value="pittagDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>
{/if}
</div>
</div>
</div>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>