<table class="table table-bordered table-hover datatable" class="tablemulticolonne">
<tr>
<td>
<h2{t}Liste des répartitions d'aliments{/t}</h2>
{include file="aliment/repartitionSearch.tpl"}
{if $isSearch == 1}
<script>
setDataTables("crepartitionList", 0 , 0, 0, {$repartitionSearch.limit});
</script>
<table class="table table-bordered table-hover datatable" class="tablemulticolonne">
<tr>
<td style="width:25%;">
{if $repartitionSearch.offset > 0}
<a href="index.php?module=repartitionList&previous=1" class="lienNormal" title="Données précédentes" >
&lt;préc
</a>
{/if}
</td>
<td style="width:50%;"></td>
<td style="width:25%;text-align:right;">
<a href="index.php?module=repartitionList&next=1" class="lienNormal" title="Données suivantes">
suiv&gt;
</a>
</td>
</tr>
<tr>
<td colspan="3">
<table class="table table-bordered table-hover datatable" id="repartitionList">
<thead>
<tr>
{if $droits.bassinGestion == 1}
<th>{t}Modif{/t}<th>
{/if}
<th>{t}Catégorie{/t}<th>
<th>{t}Nom{/t}<th>
<th>{t}Date début{/t}<th>
<th>{t}Date fin{/t}<th>
{if $droits.bassinGestion == 1}
<th>{t}Saisir<br>les restes{/t}<th>
<th>{t}Dupliquer{/t}<th>
{/if}
</thead>
<tbody>
{section name=lst loop=$dataList}
<tr>
{if $droits.bassinGestion == 1}
<td>
<a href="index.php?module=repartitionChange&repartition_id={$dataList[lst].repartition_id}">
<div class="center"><img src="display/images/edit.gif" height="20"></div>
</a>
</td>
{/if}
<td>{$dataList[lst].categorie_libelle}</td>
<td>{$dataList[lst].repartition_name}</td>
<td>{$dataList[lst].date_debut_periode}</td>
<td>{$dataList[lst].date_fin_periode}</td>
{if $droits.bassinGestion == 1}
<td class="center">
<a href="index.php?module=repartitionResteChange&repartition_id={$dataList[lst].repartition_id}" title="Saisir les restes pour la période considérée">
<img src="display/images/bin.png" height="20">
</a>
<td>
<a href="index.php?module=repartitionDuplicate&repartition_id={$dataList[lst].repartition_id}" title="Créer une nouvelle répartition à partir de celle-ci">
<div class="center"><img src="display/images/copy.png" height="20"></div>
</a>
</td>
{/if}
</tr>
{/section}
</tbody>
</table>
</td>
</tr>
</table>
{/if}
</td>
<td>
{if $isSearch == 1 && $droits.bassinGestion == 1}
<h3>Créer une nouvelle répartition vierge</h3>
{include file="aliment/repartitionCreate.tpl"}
{/if}
</td>
</tr>
</table>
