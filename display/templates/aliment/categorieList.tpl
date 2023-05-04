<h2{t}Catégories d'aliments (types de poissons nourris){/t}</h2>
{if $droits["bassinAdmin"] == 1}
<a href="index.php?module=categorieChange&categorie_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("ccategorieList");
</script>
<table class="table table-bordered table-hover datatable" id="ccategorieList" class="tableliste">
<thead>
<tr>
<th>Catégorie</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["bassinAdmin"] == 1}
<a href="index.php?module=categorieChange&categorie_id={$data[lst].categorie_id}">
{$data[lst].categorie_libelle}
</a>
{else}
{$data[lst].categorie_libelle}
{/if}
</td>
</tr>
{/section}
</tbody>
</table>