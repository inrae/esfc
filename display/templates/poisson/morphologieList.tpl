<script>
setDataTables("cmorphologieList");
</script>
<table id="cmorphologieList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date de mesure</th>
<th>Longueur<br>à la fourche</th>
<th>Longueur<br>totale</th>
<th>Masse</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
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
<td>
{$dataMorpho[lst].morphologie_date}
</td>
<td>{$dataMorpho[lst].longueur_fourche}</td>
<td>{$dataMorpho[lst].longueur_totale}</td>
<td>{$dataMorpho[lst].masse}</td>
<td>{$dataMorpho[lst].morphologie_commentaire}</td>
</tr>
{/section}
</tdata>
</table>
