<h2>{t}Liste des sites{/t}</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=siteChange&site_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable" id="csiteList" class="tableliste">
<thead>
<tr>
<th>{t}Nom du site{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=siteChange&site_id={$data[lst].site_id}">
{$data[lst].site_name}
</a>
{else}
{$data[lst].site_name}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>