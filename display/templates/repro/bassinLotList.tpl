{if $droits["reproGestion"] == 1}
<a href="index.php?module=bassinLotChange&bassin_lot_id=0&lot_id={$dataLot.lot_id}">
Nouvelle affectation de bassin...
</a>
{/if}

<table id="cBassinLot" class="tableliste">
<thead>
<tr>
<th>Date de début<br>d'utilisation</th>
<th>Nom du bassin</th>
<th>Date de fin<br>d'utilisation</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$bassinLot}
<tr>
<td class="center">
{if $droits["reproGestion"] == 1}
<a href="index.php?module=bassinLotChange&bassin_lot_id={$bassinLot[lst].bassin_lot_id}">
{$bassinLot[lst].bl_date_arrivee}
</a>
{else}
{$bassinLot[lst].bl_date_arrivee}
{/if}
</td>
<td>{$bassinLot[lst].bassin_nom}</td>
<td>{$bassinLot[lst].bl_date_depart}</td>
</tr>
{/section}
</tbody>
</table>
