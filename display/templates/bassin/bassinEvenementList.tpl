<script>
setDataTables("cbassinEvenementList");
</script>
{if $droits["bassinGestion"] == 1}
<a href="index.php?module=bassinEvenementChange&bassin_evenement_id=0&bassin_id={$dataBassin.bassin_id}">
Nouvel événement...
</a>
{/if}
<table id="cbassinEvenementList" class="tableaffichage">
<thead>
<tr>
<th>Évenement</th>
<th>Date</th>
<th>Commentaire</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataBassinEvnt}
<tr>
<td>
{if $droits["bassinGestion"] == 1}
<a href="index.php?module=bassinEvenementChange&bassin_evenement_id={$dataBassinEvnt[lst].bassin_evenement_id}&bassin_id={$dataBassinEvnt[lst].bassin_id}">
{$dataBassinEvnt[lst].bassin_evenement_type_libelle}
</a>
{else}
{$dataBassinEvnt[lst].bassin_evenement_type_libelle}
{/if}
</td>
<td>
{$dataBassinEvnt[lst].bassin_evenement_date}
</td>
<td>{$dataBassinEvnt[lst].bassin_evenement_commentaire}</td>
</tr>
{/section}
</tdata>
</table>