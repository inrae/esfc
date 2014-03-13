<h2>Modification d'un type de mortalite</h2>

<a href="index.php?module=mortaliteTypeList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="mortaliteTypeForm" method="post" action="index.php?module=mortaliteTypeWrite">
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
</form>

{if $data.mortalite_type_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="mortalite_type_id" value="{$data.mortalite_type_id}">
<input type="hidden" name="module" value="mortaliteTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>