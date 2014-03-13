{include file="poisson/poissonSearch.tpl"}
{if $isSearch == 1}
{if $droits.poissonGestion == 1}
<a href="index.php?module=poissonChange&poisson_id=0">Nouveau poisson...</a>
{/if}
<script>
setDataTables("cpoissonList",true, true, true, 50);
</script>
<table id="cpoissonList" class="tableaffichage">
<thead>
<tr>
<th>(Pit)tag</th>
<th>Matricule</th>
<th>Prénom</th>
<th>Sexe</th>
<th>Statut</th>
<th>Cohorte</th>
<th>Date de capture</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$data}
<tr>
<td>
<a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
{$data[lst].pittag_valeur}
</a>
</td>
<td>
<a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
{$data[lst].matricule}
</a>
</td>
<td>
<a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
{$data[lst].prenom}
</a>
</td>
<td>{$data[lst].sexe_libelle_court}</td>
<td>{$data[lst].poisson_statut_libelle}</td>
<td>{$data[lst].cohorte}</td>
<td>{$data[lst].capture_date}</td>
</tr>
{/section}
</tdata>
</table>
<br>
{/if}