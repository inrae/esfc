<h2>{t}Catégories d'aliments (types de poissons nourris){/t}</h2>
{if $rights["bassinAdmin"] == 1}
<a href="categorieChange?categorie_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="ccategorieList" class="tableliste">
<thead>
<tr>
<th>{t}Catégorie{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["bassinAdmin"] == 1}
<a href="categorieChange?categorie_id={$data[lst].categorie_id}">
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