<h2>{t}Modification d'un type d'aliment{/t}</h2>

<a href="index.php?module=alimentTypeList">Retour à la liste</a>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="alimentTypeForm" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value="alimentType">
<input type="hidden" name="aliment_type_id" value="{$data.aliment_type_id}">
<div class="form-group">
<label for="" class="control-label col-md-4"><span class="red">*</span>{t}Type d'aliment :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="aliment_type_libelle" size="40" value="{$data.aliment_type_libelle}" autofocus>
</div>
</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
{if $data.aliment_type_id > 0 && $droits["paramAdmin"] == 1}
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
{/if}
</div>
</form>
</div>
</div>



<span class="red">*</span><span class="messagebas">Champ obligatoire</span>