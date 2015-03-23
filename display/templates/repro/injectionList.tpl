{if $droits["reproGestion"] == 1}
<a href="index.php?module=injectionChange&injection_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle injection...
</a>
{/if}
<table id="cinjection" class="tableliste">
<thead>
<tr>
<th>Date/heure de l'injection</th>
<th>Séquence correspondante</th>
</tr>
</thead>
<tdata>
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
</tr>
{/section}
</tdata>
</table>