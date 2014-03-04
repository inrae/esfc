<h2>Modification d'un type de bassin</h2>

<a href="index.php?module=bassinTypeList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="bassinTypeForm" method="post" action="index.php?module=bassinTypeWrite">
<input type="hidden" name="bassin_type_id" value="{$data.bassin_type_id}">
<tr>
<td class="libelleSaisie">
Type de bassin <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cbassin_type_libelle" name="bassin_type_libelle" type="text" value="{$data.bassin_type_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.bassin_type_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_type_id" value="{$data.bassin_type_id}">
<input type="hidden" name="module" value="bassinTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>