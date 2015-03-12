<fieldset>
<legend>Croisements effectués</legend>
{if $droits["reproGestion"] == 1}
<a href="index.php?module=croisementChange&croisement_id=0&sequence_id={$dataSequence.sequence_id}">
Nouveau croisement...
</a>
{/if}

<table id="ccroisement" class="tableliste">
<thead>
<tr>
<th>Date</th>
<th>Poissons</th>
<th>Masse des<br>ovocytes</th>
<th>Densité des<br>ovocytes</th>
<th>Taux de<br>fécondation</th>
<th>Taux de survie<br>estimé</th>
<th>Qualité du<br>croisement</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$croisements}
<tr>
<td>
{if $droits["reproGestion"] == 1}
<a href="index.php?module=croisementChange&croisement_id={$croisements[lst].croisement_id}">
{$croisements[lst].croisement_date}
</a>
{else}
{$croisements[lst].croisement_date}
{/if}
</td>
<td>{$croisements[lst].parents}</td>
<td>{$croisements[lst].ovocyte_masse}</td>
<td>{$croisements[lst].ovocyte_densite}</td>
<td>{$croisements[lst].tx_fecondation}</td>
<td>{$croisements[lst].tx_survie_estime}</td>
<td>{$croisements[lst].croisement_qualite_libelle}</td>
</tr>
{/section}
</tdata>
</table>
</fieldset>
