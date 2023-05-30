<h2>{t}Modification d'une méthode de détermination de la cohorte{/t}</h2>

<a href="index.php?module=cohorteTypeList">Retour à la liste</a>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="cohorteTypeForm" method="post" action="index.php?module=cohorteTypeWrite">
<input type="hidden" name="cohorte_type_id" value="{$data.cohorte_type_id}">
<div class="form-group">
                <label for="" class="control-label col-md-4">{t}
Méthode de détermination de la cohorte <span class="red">*</span> :{/t}</label>
                <div class="col-md-8">
<input id="ccohorte_type_libelle" name="cohorte_type_libelle" type="text" value="{$data.cohorte_type_libelle}" required autofocus/>
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

{if $data.cohorte_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="cohorte_type_id" value="{$data.cohorte_type_id}">
<input type="hidden" name="module" value="cohorteTypeDelete">
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