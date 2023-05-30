<h2{t}Modification d'un type d'anomalie dans la base de données{/t}</h2>

<a href="index.php?module=anomalieDbTypeList">Retour à la liste</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="anomalieDbTypeForm" method="post" action="index.php?module=anomalieDbTypeWrite">
<input type="hidden" name="anomalie_db_type_id" value="{$data.anomalie_db_type_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Type d'anomalieDb <span class="red">*</span> :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="anomalie_db_type_libelle" size="40" value="{$data.anomalie_db_type_libelle}" autofocus>
</div>


<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>

{if $data.anomalie_db_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="formBouton">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="anomalie_db_type_id" value="{$data.anomalie_db_type_id}">
<input type="hidden" name="module" value="anomalieDbTypeDelete">
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