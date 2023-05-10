<h2{t}Modification d'un aliment{/t}</h2>

<a href="index.php?module=alimentList">Retour à la liste</a>
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="alimentForm" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value="aliment">
<input type="hidden" name="aliment_id" value="{$data.aliment_id}">
<div class="form-group">
<label for="aliment_libelle" class="control-label col-md-4"><span class="red">*</span>{t}Nom de l'aliment :{/t}</label>
<div class="col-md-8">
<input id="aliment_libelle" class="form-control" name="aliment_libelle" value="{$data.aliment_libelle}"" autofocus required></dd>
</div>
</div>
<div class="form-group">
<label for="aliment_libelle_court" class="control-label col-md-4"><span class="red">*</span>{t}Nom court (pour éditions) :{/t}</label>
<div class="col-md-8">
<input id="aliment_libelle_court" class="form-control" name="aliment_libelle_court" value="{$data.aliment_libelle_court}" size="8" maxlength="8" required></dd>
</div>
</div>
<div class="form-group">
<label for="aliment_type_id" class="control-label col-md-4"><span class="red">*</span>{t}Type d'aliment :{/t}</label>
<div class="col-md-8">
<select id="aliment_type_id" class="form-control" name="aliment_type_id">
{section name=lst loop=$alimentType}
<option value="{$alimentType[lst].aliment_type_id}" {if $alimentType[lst].aliment_type_id == $data.aliment_type_id}selected{/if}>
{$alimentType[lst].aliment_type_libelle}
</option>
{/section}
</select>
</dd>
</div>
</div>
<div class="form-group">
<label for="actif" class="control-label col-md-4">{t}Aliment actuellement utilisé ?{/t}</label>
<div class="col-md-8">
<input id="actif"  type="radio" name="actif" value="1" {if $data.actif == 1 or $data.actif == ""}checked{/if}>&nbsp;{t}oui{/t}
&nbsp;<input type="radio" name="actif" value="0" {if $data.actif == 0}checked{/if}>&nbsp;{t}non{/t}
</dd>
</div>
</div>
<fieldset>
<legend>{t}Catégories de poissons nourris{/t}<legend>

<!-- gestion de la saisie des categories -->
{section name=lst loop=$categorie}
<div class="form-group">
<label for="categorie" class="control-label col-md-4">{$categorie[lst].categorie_libelle}</label>
<div class="col-md-8">
<input id="categorie" class="form-control" type="checkbox" name="categorie[]" value="{$categorie[lst].categorie_id}" {if $categorie[lst].checked == 1}checked{/if}>
</dd>
</div>
</div>
{/section}
</fieldset>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
{if $data.aliment_id > 0 &&$droits["bassinAdmin"] == 1}
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>