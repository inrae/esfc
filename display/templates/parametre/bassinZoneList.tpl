<h2>{t}Zones d'implantation des bassins{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinZoneChange&bassin_zone_id=0">
Nouveau...
</a>
{/if}
<script>

</script>
<table class="table table-bordered table-hover datatable" id="cbassinZoneList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=bassinZoneChange&bassin_zone_id={$data[lst].bassin_zone_id}">
{$data[lst].bassin_zone_libelle}
</a>
{else}
{$data[lst].bassin_zone_libelle}
{/if}
</td>
<td>
</tr>
{/section}
</tbody>
</table>