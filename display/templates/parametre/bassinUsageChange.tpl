<h2>Modification d'un type d'utilisation des bassins</h2>

<a href="index.php?module=bassinUsageList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="bassinUsageForm" method="post" action="index.php?module=bassinUsageWrite">
<input type="hidden" name="bassin_usage_id" value="{$data.bassin_usage_id}">
<tr>
<td class="libelleSaisie">
Utilisation <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cbassin_usage_libelle" name="bassin_usage_libelle" type="text" value="{$data.bassin_usage_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.bassin_usage_id > 0 &&$droits["paramAdmin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="bassin_usage_id" value="{$data.bassin_usage_id}">
<input type="hidden" name="module" value="bassinUsageDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>