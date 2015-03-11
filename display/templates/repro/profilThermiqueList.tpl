<table id="cprofilThermiqueList" class="tableaffichage">
<thead>
<tr>
<th>Date/heure</th>
<th>Température</th>
<th>Type</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$profilThermiques}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=profilThermiqueChange&profil_thermique_id={$profilThermiques[lst].profil_thermique_id}&bassin_campagne_id={$profilThermiques[lst].bassin_campagne_id}">
{$profilThermiques[lst].pf_datetime}
</a>
{else}
{$profilThermiques[lst].pf_datetime}
{/if}
</td>
<td class="right">
{$profilThermiques[lst].pf_temperature}
</td>
<td>
{$profilThermiques[lst].profil_thermique_type_libelle}
</td>
</tr>
{/section}
</tdata>
</table>