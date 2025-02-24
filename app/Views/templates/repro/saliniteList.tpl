<table class="table table-bordered table-hover datatable display" id="csaliniteList" class="tableliste">
<thead>
<tr>
<th>{t}Date/heure{/t}</th>
<th>{t}Salinité{/t}</th>
<th>{t}Type{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$salinites}
<tr>
<td>
{if $rights.reproGestion == 1}
<a href="saliniteChange?salinite_id={$salinites[lst].salinite_id}&bassin_campagne_id={$salinites[lst].bassin_campagne_id}">
{$salinites[lst].salinite_datetime}
</a>
{else}
{$salinites[lst].salinite_datetime}
{/if}
</td>
<td class="right">
{$salinites[lst].salinite_tx}
</td>
<td>
{$salinites[lst].profil_thermique_type_libelle}
</td>
</tr>
{/section}
</tbody>
</table>