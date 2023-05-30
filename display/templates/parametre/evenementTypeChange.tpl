<h2>{t}Modification d'un type d'événement{/t}</h2>

<a href="index.php?module=evenementTypeList">Retour à la liste</a>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="evenementTypeForm" method="post" action="index.php?module=evenementTypeWrite">
<input type="hidden" name="evenement_type_id" value="{$data.evenement_type_id}">
<tr>
<td class="libelleSaisie">
Nom du type d'événement <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cevenement_type_libelle" name="evenement_type_libelle" type="text" value="{$data.evenement_type_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td class="libelleSaisie">
Actif dans les sélections<span class="red">*</span> ?</td>
<td class="datamodif">
<input type="radio" name="evenement_type_actif" value="0" {if $data.evenement_type_actif == 0}checked{/if} > non
<br>
<input type="radio" name="evenement_type_actif" value="1" {if $data.evenement_type_actif == 1}checked{/if} > oui
</td>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.evenement_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="evenement_type_id" value="{$data.evenement_type_id}">
<input type="hidden" name="module" value="evenementTypeDelete">
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