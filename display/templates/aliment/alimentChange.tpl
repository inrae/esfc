<h2{t}Modification d'un aliment{/t}</h2>

<a href="index.php?module=alimentList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="alimentForm" method="post" action="index.php?module=alimentWrite">
<input type="hidden" name="aliment_id" value="{$data.aliment_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom de l'aliment <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="aliment_libelle" value="{$data.aliment_libelle}" size="40" autofocus required></dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Nom court (pour éditions) <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="aliment_libelle_court" value="{$data.aliment_libelle_court}" size="8" maxlength="8" required></dd>
</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type d'aliment <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="aliment_type_id">
{section name=lst loop=$alimentType}
<option value="{$alimentType[lst].aliment_type_id}" {if $alimentType[lst].aliment_type_id == $data.aliment_type_id}selected{/if}>
{$alimentType[lst].aliment_type_libelle}
</option>
{/section}
</select>
</dd>
</div>

<div class="form-group">
<label for="" class="control-label col-md-4">{t}Aliment actuellement utilisé ?{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="radio" name="actif" value="1" {if $data.actif == 1 or $data.actif == ""}checked{/if}>oui
<input type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if}>non
</dd>
</div>

<fieldset>
<legend>Catégories de poissons nourris</legend>

<!-- gestion de la saisie des categories -->
{section name=lst loop=$categorie}
<div class="form-group">
<label for="" class="control-label col-md-4">{t}{$categorie[lst].categorie_libelle}{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="checkbox" name="categorie[]" value="{$categorie[lst].categorie_id}" {if $categorie[lst].checked == 1}checked{/if}>
</dd>
</div>
{/section}
</fieldset>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>

{if $data.aliment_id > 0 &&$droits["bassinAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="aliment_id" value="{$data.aliment_id}">
<input type="hidden" name="module" value="alimentDelete">
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