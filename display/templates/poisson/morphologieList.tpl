<script>
setDataTablesFull("cmorphologieList");
</script>
<table class="table table-bordered table-hover datatable" id="cmorphologieList" class="tableliste">
<thead>
<tr>
<th>{t}Événement associé{/t}<th>
<th>{t}Date de mesure{/t}<th>
<th>{t}Longueur<br>à la fourche (cm){/t}<th>
<th>{t}Longueur<br>totale (cm){/t}<th>
<th>{t}Masse (g){/t}<th>
<th>{t}Circon<br>férence (cm){/t}<th>
<th>{t}Commentaire{/t}<th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataMorpho}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataMorpho[lst].poisson_id}&evenement_id={$dataMorpho[lst].evenement_id}">
{$dataMorpho[lst].evenement_type_libelle}
</a>
{else}
{$dataMorpho[lst].evenement_type_libelle}
{/if}
</td>
<td class="center">
{$dataMorpho[lst].morphologie_date}
</td>
<td class="right">{$dataMorpho[lst].longueur_fourche}</td>
<td class="right">{$dataMorpho[lst].longueur_totale}</td>
<td class="right">{$dataMorpho[lst].masse}</td>
<td class="right">{$dataMorpho[lst].circonference}</td>
<td>{$dataMorpho[lst].morphologie_commentaire}</td>
</tr>
{/section}
</tbody>
</table>
