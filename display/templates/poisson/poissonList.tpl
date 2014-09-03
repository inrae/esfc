{include file="poisson/poissonSearch.tpl"}
{if $isSearch == 1}
{if $droits.poissonGestion == 1}
<a href="index.php?module=poissonChange&poisson_id=0">Nouveau poisson...</a>
{/if}
<script>
setDataTables("cpoissonList",true, true, true, 50);
</script>
<table id="cpoissonList" class="tableliste">
<thead>
<tr>
<th>(Pit)tag</th>
<th>Matricule</th>
<th>Prénom</th>
<th>Sexe</th>
<th>Statut</th>
<th>Cohorte</th>
<th>Date de capture<br>/naissance</th>
<th>Date de<br>mortalité</th>
<th>Bassin</th>
<th>Masse</th>
<th>Long<br>fourche</th>
<th>Long<br>totale</th>
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
<td>{$data[lst].categorie_libelle} {$data[lst].poisson_statut_libelle}</td>
<td>{$data[lst].cohorte}</td>
<td>{$data[lst].capture_date}{$data[lst].date_naissance}</td>
<td>{$data[lst].mortalite_date}</td>
<td>
{if $data[lst].bassin_id > 0}
<a href=index.php?module=bassinDisplay&bassin_id={$data[lst].bassin_id}>
{$data[lst].bassin_nom}
</a>
{/if}
</td>
<td>{$data[lst].masse}</td>
<td>{$data[lst].longueur_fourche}</td>
<td>{$data[lst].longueur_totale}</td>
</tr>
{/section}
</tdata>
</table>
<br>
{/if}