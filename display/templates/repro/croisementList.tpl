
{if $droits["reproGestion"] == 1}
<a href="index.php?module=croisementChange&croisement_id=0">
Nouveau croisement...
</a>
{/if}

<table id="exampleListe" class="tableliste">
<thead>
<tr>
<th>Date</th>
<th>Comments</th>
<th>Origine</th>
</tr>
</thead><tdata>
{section name=lst loop=$data}
<tr>
<td>
{if $droits["gestion"] == 1}
<a href="index.php?module=exampleModif&idExample={$data[lst].idExample}">
{$data[lst].dateExample}
</a>
{else}
{$data[lst].dateExamplee}
{/if}
</td>
<td>{$data[lst].comment}</td>
</tr>
{/section}
</tdata>
</table>
{/if}
