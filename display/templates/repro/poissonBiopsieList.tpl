<fieldset>
<legend>Biopsies</legend>
{if $droits.reproGestion == 1}
<a href="index.php?module=biopsieChange&biopsie_id=0&poisson_campagne_id={$data.poisson_campagne_id}">
Nouvelle biopsie...
</a>
{/if}
<table id="cbiopsie" class="tableaffichage">
<thead>
<tr>
<th>Date</th>
<th>Diam<br>moyen</th>
<th>Taux<br>ovoide</th>
<th>Taux color<br>normale</th>
<th>Ringer<br>T50</th>
<th>Ringer<br>Tmax</th>
<th>Ringer<br>durée</th>
<th>Ringer<br>commentaire</th>
<th>Taux<br>éclatement</th>
<th>Leib<br>T50</th>
<th>Leib<br>Tmax</th>
<th>Leib<br>duréee</th>
<th>Leib<br>commentaire</th>
<th>Commentaire<br>général</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataBiopsie}
<tr>
<td>
{if $droits.reproGestion == 1}
<a href="index.php?module=biopsieChange&biopsie_id={$dataBiopsie[lst].biopsie_id}">
{$dataBiopsie[lst].biopsie_date}
</a>
{else}
{$dataBiopsie[lst].biopsie_date}
{/if}
</td>
<td class="right">{$dataBiopsie[lst].diam_moyen}</td>
<td class="right">{$dataBiopsie[lst].tx_ovoide}</td>
<td class="right">{$dataBiopsie[lst].tx_coloration_normal}</td>
<td class="center">{$dataBiopsie[lst].ringer_t50}</td>
<td class="right">{$dataBiopsie[lst].ringer_tx_max}</td>
<td class="center">{$dataBiopsie[lst].ringer_duree}</td>
<td >{$dataBiopsie[lst].ringer_commentaire}</td>
<td class="right">{$dataBiopsie[lst].tx_eclatement}</td>
<td class="center">{$dataBiopsie[lst].leibovitz_t50}</td>
<td class="right">{$dataBiopsie[lst].leibovitz_tx_max}</td>
<td class="center">{$dataBiopsie[lst].leibovitz_duree}</td>
<td >{$dataBiopsie[lst].leibovitz_commentaire}</td>
<td >{$dataBiopsie[lst].biopsie_commentaire}</td>
</tr>
{/section}
</tdata>
</fieldset>
