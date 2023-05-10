{if $droits["reproGestion"] == 1}
<a href="index.php?module=devenir{$devenirOrigine}Change&devenir_id=0{if $dataLot.lot_id > 0}&lot_id={$dataLot.lot_id}{/if}&devenirOrigine={$devenirOrigine}">
Nouvelle destination (lâcher, entrée dans le stock captif, etc.)
</a>
{/if}

<table class="table table-bordered table-hover datatable" id="devenirList" class="tableliste">
<thead>
<tr>
{if $droits["reproGestion"] == 1}
<th class="center">
<img src="display/images/edit.gif" height="25">
{/t}<th>
{/if}
<th>{t}N° de lot{/t}<th>
<th>{t}Date{/t}<th>
<th>{t}Destination{/t}<th>
<th>{t}Nbre<br>poissons{/t}<th>
<th>{t}Destination parente{/t}<th>
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
<td>{$dataDevenir[lst].site_name} - {$dataDevenir[lst].lot_nom}</td>
<td>{$dataDevenir[lst].devenir_date}</td>
<td>{$dataDevenir[lst].devenir_type_libelle}&nbsp;
{$dataDevenir[lst].categorie_libelle}&nbsp;
{$dataDevenir[lst].localisation}</td>
<td class="right">{$dataDevenir[lst].poisson_nombre}</td>
<td>
{if strlen($dataDevenir[lst].devenir_date_parent)>0}
{$dataDevenir[lst].devenir_date_parent}&nbsp;
{$dataDevenir[lst].devenir_type_libelle_parent}&nbsp;
{$dataDevenir[lst].categorie_libelle_parent}&nbsp;
{$dataDevenir[lst].localisation_parent}&nbsp;
({$dataDevenir[lst].poisson_nombre_parent} poissons)
{/if}
</tr>
{/section}
</tbody>
</table>
