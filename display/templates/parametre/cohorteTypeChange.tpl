<h2>Modification d'une méthode de détermination de la cohorte</h2>

<a href="index.php?module=cohorteTypeList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="cohorteTypeForm" method="post" action="index.php?module=cohorteTypeWrite">
<input type="hidden" name="cohorte_type_id" value="{$data.cohorte_type_id}">
<tr>
<td class="libelleSaisie">
Méthode de détermination de la cohorte <span class="red">*</span> :</td>
<td class="datamodif">
<input id="ccohorte_type_libelle" name="cohorte_type_libelle" type="text" value="{$data.cohorte_type_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.cohorte_type_id > 0 &&$droits["paramAdmin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="cohorte_type_id" value="{$data.cohorte_type_id}">
<input type="hidden" name="module" value="cohorteTypeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>