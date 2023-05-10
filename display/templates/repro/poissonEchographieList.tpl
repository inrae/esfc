<fieldset>
<legend>{t}Échographies{/t}<legend>
{if $droits.reproGestion == 1}
<a href="index.php?module=echographieChange&echographie_id=0&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
Nouvelle échographie...
</a>
{/if}
<table class="table table-bordered table-hover datatable" id="cechographie" class="tableliste">
<thead>
<tr>
<th>{t}Date{/t}</th>
<th>{t}Commentaire{/t}</th>
</tr>
</thead>
<tbody>
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
</tbody>
</table>
</fieldset>