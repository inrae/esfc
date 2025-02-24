
<table class="table table-bordered table-hover datatable display" id="cbassinList" class="tableliste">
<thead>
<tr>
<th>{t}Bassin{/t}</th>
<th>{t}Date d'arrivée{/t}</th>
<th>{t}Date de départ{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$dataBassin}
<tr>
<td>
<a href="bassinDisplay?bassin_id={$dataBassin[lst].bassin_id}">
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