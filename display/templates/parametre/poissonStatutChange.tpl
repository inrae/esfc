<h2>Modification d'un statut de poisson</h2>

<a href="index.php?module=poissonStatutList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="poissonStatutForm" method="post" action="index.php?module=poissonStatutWrite">
<input type="hidden" name="poisson_statut_id" value="{$data.poisson_statut_id}">
<tr>
<td class="libelleSaisie">
Nom du statut <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cpoisson_statut_libelle" name="poisson_statut_libelle" type="text" value="{$data.poisson_statut_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>

{if $data.poisson_statut_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="poisson_statut_id" value="{$data.poisson_statut_id}">
<input type="hidden" name="module" value="poissonStatutDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>