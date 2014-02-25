<table class="tableaffichage">
<tr>
<td>
Matricule : {$dataPoisson.matricule} {$dataPoisson.prenom}
<br>
Sexe : {$dataPoisson.sexe_libelle} - {$dataPoisson.poisson_statut_libelle}
<br>
(Pit)tag : {$dataPoisson.pittag_valeur}
<br>
Cohorte : {$dataPoisson.cohorte}
{if strlen($dataPoisson.capture_date) > 0} - capturé le {$dataPoisson.capture_date}{/if}
</td>
</tr>
</table>
