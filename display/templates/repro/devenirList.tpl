{if $droits["reproGestion"] == 1}
<a href="index.php?module=devenir{$devenirOrigine}Change&devenir_id=0{if $dataLot.lot_id > 0}&lot_id={$dataLot.lot_id}{/if}&devenirOrigine={$devenirOrigine}">
Nouveau devenir (lâcher, entrée dans le stock captif, etc.)
</a>
{/if}

<table id="devenirList" class="tableliste">
<thead>
<tr>
{if $droits["reproGestion"] == 1}
<th class="center">
<img src="display/images/edit.gif" height="25">
</th>
{/if}
<th>N° de lot</th>
<th>Date</th>
<th>Catégorie</th>
<th>Nature</th>
<th>Lieu</th>
<th>Nbre<br>poissons</th>
</tr>
</thead><tbody>
{section name=lst loop=$dataDevenir}
<tr>
{if $droits["reproGestion"] == 1}
<td class="center">
<a href="index.php?module=devenir{$devenirOrigine}Change&devenir_id={$dataDevenir[lst].devenir_id}&devenirOrigine={$devenirOrigine}">
<img src="display/images/edit.gif" height="25">
</a>
</td>
{/if}
<td>{$dataDevenir[lst].lot_nom}</td>
<td>{$dataDevenir[lst].devenir_date}</td>
<td>{$dataDevenir[lst].categorie_libelle}</td>
<td>{$dataDevenir[lst].devenir_type_libelle}</td>
<td>{$dataDevenir[lst].localisation}</td>
<td class="right">{$dataDevenir[lst].poisson_nombre}</td>
</tr>
{/section}
</tbody>
</table>
