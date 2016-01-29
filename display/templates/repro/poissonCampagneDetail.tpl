<table class="tableaffichage,lienimage">
<tr>
<td>
<label>Identification : </label>{$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} - {$dataPoisson.sexe_libelle}
<span class="lienimage"><a href=index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}>
<img src="display/images/fish.png" height="24" title="Accéder à la fiche détaillée du poisson">
</a> 
</span>
<br>
<label>Année de reproduction : </label>{$dataPoisson.annee}
&nbsp;<label>Statut : </label>{$dataPoisson.repro_statut_libelle}
<br>
<label>Taux de croissance journalier / spécifique : </label>{$dataPoisson.tx_croissance_journalier}
/ {$dataPoisson.specific_growth_rate}
</td>
</tr>
</table>
