<h2>Modification d'une méthode de détermination du sexe</h2>

<a href="index.php?module=genderMethodeList">Retour à la liste</a>
<table class="tablesaisie">
<form class="cmxform" id="genderMethodeForm" method="post" action="index.php?module=genderMethodeWrite">
<input type="hidden" name="gender_methode_id" value="{$data.gender_methode_id}">
<tr>
<td class="libelleSaisie">
Nom de la méthode de détermination du sexe <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cgender_methode_libelle" name="gender_methode_libelle" type="text" value="{$data.gender_methode_libelle}" required autofocus/>
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>
<script>
$('#genderMethodeForm').validate();
$("#genderMethodeForm").removeAttr("novalidate");
</script>

{if $data.gender_methode_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="gender_methode_id" value="{$data.gender_methode_id}">
<input type="hidden" name="module" value="genderMethodeDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>