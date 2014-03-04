<table class="tableaffichage">
<tr>
<td>
<label>Matricule : </label>{$dataPoisson.matricule} {$dataPoisson.prenom}
<br>
<label>Sexe : </label>{$dataPoisson.sexe_libelle} - {$dataPoisson.poisson_statut_libelle}
<br>
<label>(Pit)tag : </label>{$dataPoisson.pittag_valeur}
<br>
<label>Cohorte : </label>{$dataPoisson.cohorte}
{if strlen($dataPoisson.capture_date) > 0} - <label>capturé le </label>{$dataPoisson.capture_date}{/if}
</td>
</tr>
</table>
