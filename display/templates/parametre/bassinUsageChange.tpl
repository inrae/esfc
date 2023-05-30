<h2>{t}Modification d'un type d'utilisation des bassins{/t}</h2>

<a href="index.php?module=bassinUsageList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="bassinUsageForm" method="post" action="index.php?module=bassinUsageWrite">
<input type="hidden" name="bassin_usage_id" value="{$data.bassin_usage_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Utilisation <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" id="cbassin_usage_libelle" name="bassin_usage_libelle" type="text" value="{$data.bassin_usage_libelle}" required autofocus/>

</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Catégorie d'alimentation :{/t}</label>
<div class="col-md-8">
<select id="" class="form-control" name="categorie_id">
<option value="" {if $data.categorie_id == ""}selected{/if}>
Sélectionnez la catégorie...
</option>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $categorie[lst].categorie_id == $data.categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.bassin_usage_id > 0 &&$droits["paramAdmin"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_usage_id" value="{$data.bassin_usage_id}">
<input type="hidden" name="module" value="bassinUsageDelete">
<div class="formBouton">
<input class="submit" type="submit" value="Supprimer">
</div>
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>