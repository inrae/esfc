<h2>Modification d'un type de pittag</h2>

<a href="index.php?module=pittagTypeList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="pittagTypeForm" method="post" action="index.php?module=pittagTypeWrite">
<input type="hidden" name="pittag_type_id" value="{$data.pittag_type_id}">
<tr>
<td class="libelleSaisie">
Nom du type de pittag <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cpittag_type_libelle" name="pittag_type_libelle" type="text" value="{$data.pittag_type_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>
<script>
$("#pittagTypeForm").validate();
$("#pittagTypeForm").removeAttr("novalidate");
</script>
{if $data.pittag_type_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="pittag_type_id" value="{$data.pittag_type_id}">
<input type="hidden" name="module" value="pittagTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>