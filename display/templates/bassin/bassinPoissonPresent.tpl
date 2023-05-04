<script>
setDataTablesFull("cbassinPoissonList");
</script>
<table id="cbassinPoissonList" class="tableliste">
<thead>
<tr>
<th>matricule</th>
<th>tag(s)</th>
<th>prénom</th>
<th>Sexe</th>
<th>Cohorte</th>
<th>Date d'arrivée</th>
<th>Masse</th>
</tr>
</thead>
<tbody>
{assign var=mt value=0}
{section name=lst loop=$dataPoisson}
<tr>
<td>
<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson[lst].poisson_id}">
{$dataPoisson[lst].matricule}
</a>
</td>
<td>{$dataPoisson[lst].pittag_valeur}</td>
<td>
{$dataPoisson[lst].prenom}
</td>
<td>{$dataPoisson[lst].sexe_libelle_court}</td>
<td>{$dataPoisson[lst].cohorte}</td>
<td>{$dataPoisson[lst].transfert_date}</td>
<td>{$dataPoisson[lst].masse}</td>
{if $dataPoisson[lst].masse > 0}
{assign var=mt value=$mt + $dataPoisson[lst].masse}
{/if}
</tr>
{/section}
</tbody>
</table>
{if $mt > 0}
<br>
Masse totale des poissons dans le bassin : {$mt}
{/if}