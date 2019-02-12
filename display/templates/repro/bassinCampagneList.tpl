<script>
$(document).ready(function() { 
	
	$(".confirmation").on('click', function () {
        return confirm("Confirmez-vous la suppression du bassin pour l'année considérée ?");
    } );
} ) ;	
</script>
<table id="cBassinCampagne" class="tableliste">
<thead>
<tr>
<th>Données<br>générales</th>
<th>Site</th>
<th>Nom</th>
<th>Utilisation</th>
<th>Suppr.</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$bassins}
<tr>
<td class="center">
<a href="index.php?module=bassinDisplay&bassin_id={$bassins[lst].bassin_id}">
<img src="display/images/bassin.jpg" height="25" title="Données générales du bassin">
</a>
</td>
<td>{$bassins[lst].site_name}</td>
<td>
<a href="index.php?module=bassinCampagneDisplay&bassin_campagne_id={$bassins[lst].bassin_campagne_id}">
{$bassins[lst].bassin_nom}
</a>
</td>
<td>{$bassins[lst].bassin_utilisation}</td>
<td class="center">
<a class="confirmation" href="index.php?module=bassinCampagneDelete&bassin_campagne_id={$bassins[lst].bassin_campagne_id}">
<img src="display/images/cross.png" height="25">
</a>
</td>
</tr>
{/section}
</tbody>
</table>