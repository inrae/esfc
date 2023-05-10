
{if $droits["reproGestion"] == 1}
<a href="index.php?module=croisementChange&croisement_id=0&sequence_id={$dataSequence.sequence_id}">
Nouveau croisement...
</a>
{/if}

<table class="table table-bordered table-hover datatable" id="ccroisement" class="tableliste">
<thead>
<tr>
<th>{t}Nom du croisement{/t}<th>
<th>{t}Date/heure de<br>fécondation{/t}<th>
<th>{t}Poissons{/t}<th>
<th>{t}Masse des<br>ovocytes{/t}<th>
<th>{t}Nbre d'ovocytes<br>par gramme{/t}<th>
<th>{t}Nbre total<br>d'ovocytes{/t}<th>
<th>{t}Taux de<br>fécondation{/t}<th>
<th>{t}Nbre d'oeufs<br>calculé{/t}<th>
<th>{t}Taux de survie<br>estimé{/t}<th>
<th>{t}Nbre de larves<br>théorique{/t}<th>
<th>{t}Nbre de larves<br>compté{/t}<th>
<th>{t}Qualité génétique<br>du croisement{/t}<th>
</tr>
</thead>
<tbody>
{section name=lst loop=$croisements}
<!-- calculs -->
{assign var="ovocyte" value=intval($croisements[lst].ovocyte_masse * $croisements[lst].ovocyte_densite)}
{if $croisements[lst].tx_fecondation > 1}
{assign var="oeuf" value=intval($croisements[lst].tx_fecondation * $ovocyte / 100)}
{else}
{assign var="oeuf" value=intval($croisements[lst].tx_fecondation * $ovocyte)}
{/if}
{if $croisements[lst].tx_survie_estime > 1}
{assign var="larve" value=intval($oeuf * $croisements[lst].tx_survie_estime / 100)}
{else}
{assign var="larve" value=intval($oeuf * $croisements[lst].tx_survie_estime)}
{/if}
<tr>
<td>
{if $droits["reproGestion"] == 1}
<a href="index.php?module=croisementDisplay&croisement_id={$croisements[lst].croisement_id}">
{$croisements[lst].sequence_nom} {$croisements[lst].croisement_nom}
</a>
{else}
{$croisements[lst].sequence_nom} {$croisements[lst].croisement_nom}
{/if}
</td>
<td>{$croisements[lst].croisement_date}</td>

<td>{$croisements[lst].parents}</td>
<td class="right">{$croisements[lst].ovocyte_masse}</td>
<td class="right">{$croisements[lst].ovocyte_densite}</td>
<td class="right">{$ovocyte}</td>
<td class="right">{$croisements[lst].tx_fecondation}</td>
<td class="right">{$oeuf}
<td class="right">{$croisements[lst].tx_survie_estime}</td>
<td class="right">{$larve}</td>
<td class="right">{$croisements[lst].total_larve_compte}</td>
<td>{$croisements[lst].croisement_qualite_libelle}</td>
</tr>
{/section}
</tbody>
</table>

