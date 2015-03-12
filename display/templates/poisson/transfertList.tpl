<script>
setDataTables("ctransfertList");
</script>
<table id="ctransfertList" class="tableliste">
<thead>
<tr>
<th>Événement associé</th>
<th>Date de<br>transfert</th>
<th>Bassin d'origine</th>
<th>Bassin de destination</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataTransfert}
<tr>
<td>
{if $droits["poissonGestion"]==1}
<a href="index.php?module=evenementChange&poisson_id={$dataTransfert[lst].poisson_id}&evenement_id={$dataTransfert[lst].evenement_id}">
{$dataTransfert[lst].evenement_type_libelle}
</a>
{else}
{$dataTransfert[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataTransfert[lst].transfert_date}</td>
<td>
{if $dataTransfert[lst].bassin_origine > 0}
<a href="index.php?module=bassinDisplay&bassin_id={$dataTransfert[lst].bassin_origine}">
{$dataTransfert[lst].bassin_origine_nom}</a>
{/if}
</td>
<td>
{if $dataTransfert[lst].bassin_destination > 0}
<a href="index.php?module=bassinDisplay&bassin_id={$dataTransfert[lst].bassin_destination}">
{$dataTransfert[lst].bassin_destination_nom}</a>
{/if}
</td>
<td>{$dataTransfert[lst].transfert_commentaire}</td>
</tr>
{/section}
</tdata>
</table>