<script>
$(document).ready(function() { 
	setDataTables("crepartTemplateList",true, true, true, 50);
}
</script>
<h2{t}Modèles de répartion des aliments{/t}</h2>
{include file="aliment/repartTemplateSearch.tpl"}
{if $isSearch == 1}
{if $droits.bassinAdmin == 1}
<a href="index.php?module=repartTemplateChange&repart_template_id=0">Nouvelle répartition...</a>
{/if}
<table class="table table-bordered table-hover datatable" id="crepartTemplateList" class="tableliste">
<thead>
<tr>
{if $droits.bassinAdmin == 1}
<th>{t}Modif{/t}<th>
{/if}
<th>{t}Date de création{/t}<th>
<th>{t}Catégorie{/t}<th>
<th>{t}Description{/t}<th>
<th>{t}Actif ?{/t}<th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
{if $droits.bassinAdmin == 1}
<td>
<a href="index.php?module=repartTemplateChange&repart_template_id={$data[lst].repart_template_id}">
<div class="center"><img src="display/images/edit.gif" height="20"></div>
</a>
</td>
{/if}
<td>{$data[lst].repart_template_date}</td>
<td>{$data[lst].categorie_libelle}</td>
<td>{$data[lst].repart_template_libelle}</td>
<td>{if $data[lst].actif == 1}oui{else}non{/if}</td>
</tr>
{/section}
</tbody>
</table>
{/if}