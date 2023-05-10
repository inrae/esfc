<H2>Modèles d'implantation de marques VIE</H2>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="vieModeleList">
<table class="table table-bordered table-hover datatable" class="tableaffichage">
<tr><td>Année : 
<select name="annee">
{section name=lst loop=$annees}
<option value="{$annees[lst].annee}" {if $annees[lst].annee == $annee}selected{/if}>
{$annees[lst].annee}
</option>
{/section}
</select>
<input type="submit" value="Rechercher">
</td>
</tr>
</table>
</form>

{if $droits.reproGestion == 1}
<a href="index.php?module=vieModeleChange&vie_modele_id=0">Nouveau modèle d'implantation VIE...</a>
{/if}
<table class="table table-bordered table-hover datatable" id="cvieModelelist" class="tableliste">
<thead>
<tr>
<th>{t}Couleur{/t}</th>
<th>{t}Marque 1{/t}</th>
<th>{t}Marque 2{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=vieModeleChange&vie_modele_id={$data[lst].vie_modele_id}">
{$data[lst].couleur}
</a>
{else}
{$data[lst].couleur}
{/if}
</td>
<td>{$data[lst].vie_implantation_libelle}</td>
<td>{$data[lst].vie_implantation_libelle2}</td>
</tr>
{/section}
</tbody>
</table>
