<h2>{t}Modification d'un type de mortalite{/t}</h2>

<a href="index.php?module=mortaliteTypeList">Retour à la liste</a>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="mortaliteTypeForm" method="post" action="index.php?module=mortaliteTypeWrite">
<input type="hidden" name="mortalite_type_id" value="{$data.mortalite_type_id}">
<tr>
<td class="libelleSaisie">
Type de mortalite <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cmortalite_type_libelle" name="mortalite_type_libelle" type="text" value="{$data.mortalite_type_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.mortalite_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="mortalite_type_id" value="{$data.mortalite_type_id}">
<input type="hidden" name="module" value="mortaliteTypeDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>