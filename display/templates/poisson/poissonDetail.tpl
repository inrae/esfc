<table class="tableaffichage">
<tr>
<td>
(<span style="font-size:small;font-style:italic;">{$dataPoisson.poisson_id}</span>)
<label>Matricule : </label>{$dataPoisson.matricule} {$dataPoisson.prenom}
<br>
<label>Sexe : </label>{$dataPoisson.sexe_libelle} - {$dataPoisson.poisson_statut_libelle}
<br>
<label>(Pit)tag : </label>{$dataPoisson.pittag_valeur}
<br>
<label>Cohorte : </label>{$dataPoisson.cohorte}
{if strlen($dataPoisson.capture_date) > 0} - <label>capturé le </label>{$dataPoisson.capture_date}{/if}
{if strlen($dataPoisson.date_naissance) > 0} - <label>né le </label>{$dataPoisson.date_naissance}{/if}
{if $dataPoisson.poisson_statut_id != 3 and $dataPoisson.poisson_statut_id != 4}
<br>
<label>Bassin : </label>
<a href="index.php?module=bassinDisplay&bassin_id={$dataPoisson.bassin_id}" style="display:inline;">
{$dataPoisson.bassin_nom}
</a>
{/if}
</td>
</tr>
</table>
