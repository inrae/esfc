<script>
setDataTables("cbassinList");
</script>
<table class="table table-bordered table-hover datatable" id="cbassinList" class="tableliste">
<thead>
<tr>
<th>Bassin</th>
<th>Date<br>d'arrivée</th>
<th>Date de<br>départ</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataBassin}
<tr>
<td>
<a href="index.php?module=bassinDisplay&bassin_id={$dataBassin[lst].bassin_id}">
{$dataBassin[lst].bassin_nom}
</a>
</td>
<td>
{$dataBassin[lst].bassin_date_arrivee}
</td>
<td>{$dataBassin[lst].bassin_date_depart}</td>
</tr>
{/section}
</tbody>
</table>