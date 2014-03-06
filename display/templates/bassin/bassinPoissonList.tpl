<script>
setDataTables("cbassinList");
</script>
<table id="cbassinList" class="tableaffichage">
<thead>
<tr>
<th>Bassin</th>
<th>Date<br>d'arrivée</th>
<th>Date de<br>départ</th>
</tr>
</thead>
<tdata>
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
</tdata>
</table>