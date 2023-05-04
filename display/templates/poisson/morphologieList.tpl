<script>
setDataTablesFull("cmorphologieList");
</script>
<table class="table table-bordered table-hover datatable" id="cmorphologieList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date de mesure</th>
<th>Longueur<br>à la fourche (cm)</th>
<th>Longueur<br>totale (cm)</th>
<th>Masse (g)</th>
<th>Circon<br>férence (cm)</th>
<th>Commentaire</th>
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
