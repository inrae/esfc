<h2>Modification d'un type de pathologie</h2>

<a href="index.php?module=pathologieTypeList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="pathologieTypeForm" method="post" action="index.php?module=pathologieTypeWrite">
<input type="hidden" name="pathologie_type_id" value="{$data.pathologie_type_id}">
<tr>
<td class="libelleSaisie">
Nom du type de pathologie <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cpathologie_type_libelle" name="pathologie_type_libelle" type="text" value="{$data.pathologie_type_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.pathologie_type_id > 0 &&$droits["paramAdmin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="pathologie_type_id" value="{$data.pathologie_type_id}">
<input type="hidden" name="module" value="pathologieTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>