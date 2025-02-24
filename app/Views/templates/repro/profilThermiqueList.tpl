<table class="table table-bordered table-hover datatable display" id="cprofilThermiqueList" class="tableliste">
<thead>
<tr>
<th>{t}Date/heure{/t}</th>
<th>{t}Température{/t}</th>
<th>{t}Type{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$profilThermiques}
<tr>
<td>
{if $rights.reproGestion == 1}
<a href="profilThermiqueChange?profil_thermique_id={$profilThermiques[lst].profil_thermique_id}&bassin_campagne_id={$profilThermiques[lst].bassin_campagne_id}">
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
</tbody>
</table>