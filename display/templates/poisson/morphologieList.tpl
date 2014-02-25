<script>
setDataTables("cmorphologieList");
</script>
<table id="cmorphologieList" class="tableaffichage">
<thead>
<tr>
<th>Date de mesure</th>
<th>Longueur<br>à la fourche</th>
<th>Longueur<br>totale</th>
<th>Masse</th>
<th>Commentaire</th>
<th>Événement associé</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataMorpho}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=morphologieChange&poisson_id={$dataMorpho[lst].poisson_id}&morphologie_id={$dataMorpho[lst].morphologie_id}">
{$dataMorpho[lst].morphologie_date}
</a>
{else}
{$dataMorpho[lst].morphologie_date}
{/if}
</td>
<td>{$dataMorpho[lst].longueur_fourche}</td>
<td>{$dataMorpho[lst].longueur_totale}</td>
<td>{$dataMorpho[lst].masse}</td>
<td>{$dataMorpho[lst].morphologie_commentaire}</td>
<td>{$dataMorpho[lst].evenement_type_libelle}</td>
</tr>
{/section}
</tdata>
</table>
