<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="lotList">
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
<a href="index.php?module=lotChange&lot_id=0">Nouveau lot de larves...</a>
{/if}
<table id="clotlist" class="tableliste">
<thead>
<tr>
<th>Nom du lot</th>
<th>Parents</th>
<th>Séquence</th>
<th>Nbre de larves<br>initial</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$lots}
<tr>
<td>
<a href="index.php?module=lotDisplay&lot_id={$lots[lst].lot_id}">
{$lots[lst].lot_nom}
</a>
</td>
<td>{$lots[lst].parents}</td>
<td>{$lots[lst].sequence_nom}</td>
<td>{$lots[lst].nb_larve_initial}</td>
</tr>
{/section}
</tdata>
</table>
