<H2>Modèles d'implantation de marques VIE</H2>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="vieModeleList">
<table class="tableaffichage">
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
<table id="cvieModelelist" class="tableliste">
<thead>
<tr>
<th>Couleur</th>
<th>Marque 1</th>
<th>Marque 2</th>
</tr>
</thead>
<tdata>
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
</tdata>
</table>
