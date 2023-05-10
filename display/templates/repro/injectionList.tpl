{if $droits["reproGestion"] == 1}
<a href="index.php?module=injectionChange&injection_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle injection...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="cinjection" class="tableliste">
<thead>
<tr>
<th>{t}Date/heure de l'injection{/t}</th>
<th>{t}Séquence correspondante{/t}</th>
<th>{t}Hormone{/t}</th>
<th>{t}Dosage{/t}</th>
<th>{t}Remarque{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$injections}
<tr>
<td>
{if  $droits["reproGestion"] == 1}
<a href="index.php?module=injectionChange&injection_id={$injections[lst].injection_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
{$injections[lst].injection_date}
</a>
{else}
{$injections[lst].injection_date}
{/if}
</td>
<td>{$injections[lst].sequence_nom}</td>
<td>{$injections[lst].hormone_nom}</td>
<td>{$injections[lst].injection_dose} {$injections[lst].hormone_unite}</td>
<td>{$injections[lst].injection_commentaire}</td>
</tr>
{/section}
</tbody>
</table>