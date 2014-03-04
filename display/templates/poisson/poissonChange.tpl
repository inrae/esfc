<a href="index.php?module=poissonList">
Retour à la liste des poissons
</a>
{if $data.poisson_id > 0}
 > 
 <a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
 Retour au poisson
 </a>
 {/if}
 <h2>Modification d'un poisson</h2>
<table class="tablesaisie">
<form class="cmxform" id="poissonForm" method="post" action="index.php?module=poissonWrite">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<tr>
<td class="libelleSaisie">
Statut <span class="red">*</span> :</td>
<td class="datamodif">
<select id="cpoisson_statut_id" name="poisson_statut_id" required>
{section name=lst loop=$poissonStatut}
<option value="{$poissonStatut[lst].poisson_statut_id}" {if $poissonStatut[lst].poisson_statut_id == $data.poisson_statut_id}selected{/if}>
{$poissonStatut[lst].poisson_statut_libelle}
</option>
{/section}
</select>
</td>
</tr>
<tr>
<td class="libelleSaisie">
Sexe <span class="red">*</span> :</td>
<td class="datamodif">
<select id="csexe_id" name="sexe_id" required>
{section name=lst loop=$sexe}
<option value="{$sexe[lst].sexe_id}" {if $sexe[lst].sexe_id == $data.sexe_id}selected{/if}>
{$sexe[lst].sexe_libelle}
</option>
{/section}
</select>
</td>
</tr>
<tr>
<td class="libelleSaisie">
Matricule <span class="red">*</span> :
</td>
<td class="datamodif">
<input name="matricule" id="cmatricule" value="{$data.matricule}" required size="30">
</td>
</tr>
<tr>
<td class="libelleSaisie">
Prénom :
</td>
<td class="datamodif">
<input name="prenom" id="cprenom" value="{$data.prenom}"  size="30">
</td>
</tr>
<td class="libelleSaisie">
Cohorte :
</td>
<td class="datamodif">
<input name="cohorte" id="ccohorte" value="{$data.cohorte}" size="10">
</td>
</tr>
<tr>
<td class="libelleSaisie">Date de capture :</td>
<td class="datamodif">
 <script>
 
$(function() { 
$( "#ccapture_date" ).datepicker( { dateFormat: "dd/mm/yy" } );
 } );
</script>
<input name="capture_date" id="ccapture_date" size="10" maxlength="10" value="{$data.capture_date}">
</td>
</tr>

<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
</form>


{if $data.poisson_id > 0 &&$droits["admin"] == 1}
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="module" value="poissonDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>