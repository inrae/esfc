<script>
$(document).ready(function() { 
	$("select").change(function () {
		$("#search").submit();
	} );
} ) ;
setDataTables("csequenceList");
</script>
<form method="get" action="index.php" id="search">
<input type="hidden" name="module" value="sequenceList">
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
<a href="index.php?module=sequenceChange&sequence_id=0">Nouvelle séquence pour l'année</a>
<table id="csequenceList" class="tableaffichage">
<thead>
<tr>
<th>Nom de la séquence</th>
<th>Date de début</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=sequenceDisplay&sequence_id={$data[lst].sequence_id}">
{$data[lst].sequence_nom}
</a>
</td>
<td>{$data[lst].sequence_date_debut}</td>
</tr>
{/section}
</tdata>
</table>