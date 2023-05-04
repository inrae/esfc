<h2{t}Modification d'une catégorie d'aliment{/t}</h2>

<a href="index.php?module=categorieList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="categorieForm" method="post" action="index.php?module=categorieWrite">
<input type="hidden" name="categorie_id" value="{$data.categorie_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type de poisson nourri <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="categorie_libelle" size="40" value="{$data.categorie_libelle}" autofocus></dd>
</div>

<div class="formBouton">
<br>
<input class="submit" type="submit" value="Enregistrer">
</div>
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>

{if $data.categorie_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="categorie_id" value="{$data.categorie_id}">
<input type="hidden" name="module" value="categorieDelete">
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