<h2>Lieux de lâchers/destination des poissons</h2>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=sortieLieuChange&sortie_lieu_id=0">
Nouveau...
</a>
{/if}
<script>
setDataTables("csortieLieuList");
</script>
<table id="csortieLieuList" class="tableliste">
<thead>
<tr>
<th>Lieu</th>
<th>Longitude</th>
<th>Latitude</th>
<th>Statut<br>correspondant</th>
<th>Actif ?</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["paramAdmin"] == 1}
<a href="index.php?module=sortieLieuChange&sortie_lieu_id={$data[lst].sortie_lieu_id}">
{$data[lst].localisation}
</a>
{else}
{$data[lst].localisation}
{/if}
</td>
<td>{$data[lst].longitude_dd}</td>
<td>{$data[lst].latitude_dd}</td>
<td>{$data[lst].poisson_statut_libelle}</td>
<td>
{if $data[lst].actif == 1}oui
{elseif $data[lst].actif == 0}non
{/if}
</tr>
{/section}
</tdata>
</table>