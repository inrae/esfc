<h2>{t}Modification d'un type de pathologie{/t}</h2>

<a href="index.php?module=pathologieTypeList">Retour à la liste</a>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="pathologieTypeForm" method="post" action="index.php?module=pathologieTypeWrite">
<input type="hidden" name="pathologie_type_id" value="{$data.pathologie_type_id}">
<div class="form-group">
                <label for="" class="control-label col-md-4">{t}
Nom du type de pathologie <span class="red">*</span> :{/t}</label>
                <div class="col-md-8">
<input id="cpathologie_type_libelle" name="pathologie_type_libelle" type="text" value="{$data.pathologie_type_libelle}" required autofocus/>
</div>
</div>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.pathologie_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="pathologie_type_id" value="{$data.pathologie_type_id}">
<input type="hidden" name="module" value="pathologieTypeDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{/if}
</div>
</div>
</div>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>