{if $droits.bassinGestion == 1}
<a href="index.php?module=analyseEauChange&analyse_eau_id={$dataAnalyse.analyse_eau_id}&circuit_eau_id={$dataAnalyse.circuit_eau_id}&origine=List">
Modifier les résultats de l'analyse...
</a>
{/if}
<table>
<tr>
<td>Circuit d'eau : </td>
<td>{$dataAnalyse.circuit_eau_libelle}</td>
<tr>
<td>Date d'analyse : </td>
<td>{$dataAnalyse.analyse_eau_date}</td>
</tr>
<tr>
<td>Température : </td>
<td>{$dataAnalyse.temperature}</td>
</tr>
<tr>
<td>Oxygène : </td>
<td>{$dataAnalyse.oxygene}</td>
</tr>
<tr>
<td>salinité : </td>
<td>{$dataAnalyse.salinite}</td>
</tr>
<tr>
<td>pH : </td>
<td>{$dataAnalyse.ph}</td>
</tr>
<tr>
<td colspan="2">
<table>
<tr>
<th></th>
<th>Valeur réelle</th>
<th>Valeur N-N</th>
<th>Valeur seuil</th>
</tr>
<tr>
<td>NH4</td>
<td>{$dataAnalyse.nh4}</td>
<td>{$dataAnalyse.n_nh4}</td>
<td>{$dataAnalyse.nh4_seuil}</td>
</tr>
<tr>
<td>NO2</td>
<td>{$dataAnalyse.no2}</td>
<td>{$dataAnalyse.n_no2}</td>
<td>{$dataAnalyse.no2_seuil}</td>
</tr>
<tr>
<td>NO3</td>
<td>{$dataAnalyse.no3}</td>
<td>{$dataAnalyse.n_no3}</td>
<td>{$dataAnalyse.no3_seuil}</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>Backwash mécanique : </td>
<td>{if $dataAnalyse.backwash_mecanique == 1}Oui{else}Non{/if}</td>
</tr>
<tr>
<td>Baskwash biologique : </td>
<td>{$dataAnalyse.backwash_biologique}</td>
</tr>
<tr>
<td>Débit d'eau de rivière : </td>
<td>{$dataAnalyse.debit_eau_riviere}</td>
</tr>
<tr>
<td>Débit d'eau de forage : </td>
<td>{$dataAnalyse.debit_eau_forage}</td>
</tr>
<tr>
<td>Observations : </td>
<td>{$dataAnalyse.observations}</td>
</tr>
</table>