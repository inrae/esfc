<script>
$(document).ready(function() { 
	$(".search").change(function () {
		$("#fsearch").submit();
	} );
	$(".date").datepicker({ dateFormat: "dd/mm/yy" });
} ) ;
</script>
<form method="get" action="index.php" id="fsearch">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="repartitionList">
<div class="tab-content col-md-6 form-horizontal" id="tableaffichage">
<div class="row">
			<div class="form-group">

Catégorie d'alimentation : 
<select class="search" name="categorie_id" id="categorie_id">
<option value="" {if $repartitionSearch.categorie_id==""}selected{/if}>Sélectionnez la catégorie...</option>
{section name=lst loop=$categorie}
<option value="{$categorie[lst].categorie_id}" {if $repartitionSearch.categorie_id == $categorie[lst].categorie_id}selected{/if}>
{$categorie[lst].categorie_libelle}
</option>
{/section}
</select>
Site : 
<select class="search" name="site_id">
<option value="0" {if $repartitionSearch.site_id == ""}selected{/if}>Sélectionnez le site...</option>
{section name=lst loop=$site}
<option value="{$site[lst].site_id}" {if $repartitionSearch.site_id == $site[lst].site_id}selected{/if}>
{$site[lst].site_name}
</option>
{/section}
</select>
<br>
Date à partir de laquelle sont affichées les répartitions : 
<input class="date search" name="date_reference" value="{$repartitionSearch.date_reference}">

</div>
<div class="row">
			<div class="form-group">

<label for "limit">Nombre d'éléments à afficher : </label>
<input class="search" id="limit" name="limit" value="{$repartitionSearch.limit}" pattern="[0-9]+" required size="5">
<label for "offset">Afficher à partir de l'enregistrement n° : </label> 
<input class="search" id="offset" name="offset" value="{$repartitionSearch.offset}" pattern="[0-9]+" required size="5">

</div>
<div class="row">
			<div class="form-group">

<div class="center">
<input type="submit" value="Rechercher">
</div>

</div>
</table>
</form>