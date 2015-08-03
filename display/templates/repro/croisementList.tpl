
{if $droits["reproGestion"] == 1}
<a href="index.php?module=croisementChange&croisement_id=0&sequence_id={$dataSequence.sequence_id}">
Nouveau croisement...
</a>
{/if}

<table id="ccroisement" class="tableliste">
<thead>
<tr>
<th>Nom du croisement</th>
<th>Date/heure de<br>fécondation</th>
<th>Poissons</th>
<th>Masse des<br>ovocytes</th>
<th>Nbre d'ovocytes<br>par gramme</th>
<th>Nbre total<br>d'ovocytes</th>
<th>Taux de<br>fécondation</th>
<th>Nbre d'oeufs<br>calculé</th>
<th>Taux de survie<br>estimé</th>
<th>Nbre de larves<br>théorique</th>
<th>Nbre de larves<br>compté</th>
<th>Qualité génétique<br>du croisement</th>
</tr>
</thead>
<tdata>
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
<a href="index.php?module=croisementChange&croisement_id={$croisements[lst].croisement_id}">
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
</tdata>
</table>

