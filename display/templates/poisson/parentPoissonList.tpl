<script>
setDataTables("cparentList");
</script>
<table id="cparentList" class="tableaffichage">
<thead>
<tr>
<th>Parent</th>
<th>Sexe</th>
<th>Cohorte</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataParent}
<tr>
<td>
<a href="index.php?module=poissonDisplay&poisson_id={$dataParent[lst].poisson_id}">
{$dataParent[lst].matricule}
{if strlen($dataParent[lst].matricule) == 0}
{$dataParent[lst].pittag_valeur}
{if strlen($dataParent[lst].pittag_valeur) == 0 }
{$dataParent[lst].prenom}
{/if}
{/if}
</a>
</td>
<td>{$dataParent[lst].sexe_libelle}</td>
<td>{$dataParent[lst].cohorte}</td>
</tr>
{/section}
</tdata>
</table>