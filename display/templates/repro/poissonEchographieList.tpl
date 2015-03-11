<fieldset>
<legend>Échographies</legend>
{if $droits.reproGestion == 1}
<a href="index.php?module=echographieChange&echographie_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle échographie...
</a>
{/if}
<table id="cechographie" class="tableaffichage">
<thead>
<tr>
<th>Date</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$echographies}
<tr>
<td>
<a href="index.php?module=echographieChange&echographie_id={$echographies[lst].echographie_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
{$echographies[lst].echographie_date}
</a>
</td>
<td>{$echographies[lst].echographie_commentaire}</td>
</tr>
{/section}
</tdata>
</table>
</fieldset>