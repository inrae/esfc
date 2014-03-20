<script>
$(document).ready(function() { 
	setDataTables("crepartTemplateList",true, true, true, 50);
}
</script>
<h2>Modèles de répartion des aliments</h2>
{include file="aliment/repartTemplateSearch.tpl"}
{if $isSearch == 1}
{if $droits.bassinAdmin == 1}
<a href="index.php?module=repartTemplateChange&repart_template_id=0">Nouvelle répartition...</a>
{/if}
<table id="crepartTemplateList" class="tableaffichage">
<thead>
<tr>
{if $droits.bassinAdmin == 1}
<th>Modif</th>
{/if}
<th>Date de création</th>
<th>Catégorie</th>
<th>Description</th>
<th>Actif ?</th>
</tr>
</thead>
<tdata>
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
</tdata>
</table>
{/if}