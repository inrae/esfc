<script>
setDataTables("cbassinPoissonList");
</script>
<table id="cbassinPoissonList" class="tableaffichage">
<thead>
<tr>
<th>matricule</th>
<th>prénom</th>
<th>Sexe</th>
<th>Date d'arrivée</th>


</tr>
</thead>
<tdata>
{section name=lst loop=$dataPoisson}
<tr>
<td>

{$dataPoisson[lst].matricule}

</td>
<td>
{$dataPoisson[lst].prenom}
</td>
<td>{$dataPoisson[lst].sexe_libelle_court}</td>
<td>{$dataPoisson[lst].bassin_date_arrivee}</td>
</tr>
{/section}
</tdata>
</table>