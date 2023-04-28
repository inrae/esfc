<script>
setDataTables("canomalieList");
</script>
<form method="get" action="index.php">
<input type="hidden" name="isSearch" value="1">
<input type="hidden" name="module" value="anomalieList">
<table class="tableaffichage">
<tr><td>
Anomalies traitées ? 
<input type="radio" name="statut" value="0" {if $anomalieSearch.statut == 0}checked{/if}>non
<input type="radio" name="statut" value="1" {if $anomalieSearch.statut == 1}checked{/if}>oui
<input type="radio" name="statut" value="-1" {if $anomalieSearch.statut == -1}checked{/if}>Indifférent
<br>
Type d'anomalie :
<select name="type">
<option value="" {if $anomalieSearch.type == ""}selected{/if}>Sélectionnez le type d'anomalie...</option>
{section name=lst loop=$anomalieType}
<option value="{$anomalieType[lst].anomalie_db_type_id}" {if $anomalieType[lst].anomalie_db_type_id == $anomalieSearch.type}selected{/if}>
{$anomalieType[lst].anomalie_db_type_libelle}
</option>
{/section}
</select>

</td></tr>
<tr>
<td>
<div class="center">
<input type="submit" value="Rechercher">
</div>
</td>
</tr>
</table>
</form>


{if $isSearch == 1}
<table id="canomalieList" class="tableliste">
<thead>
<tr>
{if $droits["poissonAdmin"] == 1}
<th>Modif</th>
{/if}
<th>Poisson</th>
<th>Événement associé</th>
<th>Type d'anomalie</th>
<th>Date</th>
<th>Commentaire</th>
<th>Date de<br>traitement</th>
<th>État</th>
</tr>
</thead>
<tdata>
{section name=lst loop=$dataAnomalie}
<tr>
{if $droits["poissonAdmin"] == 1}
<td>
<div class="center">
<a href="index.php?module=anomalieChange&anomalie_db_id={$dataAnomalie[lst].anomalie_db_id}">
<img src="display/images/edit.gif" height="20">
</a>
</div>
</td>
{/if}
<td>
{if $dataAnomalie[lst].poisson_id > 0}
<a href="index.php?module=poissonDisplay&poisson_id={$dataAnomalie[lst].poisson_id}">
{$dataAnomalie[lst].matricule}
{if strlen($dataAnomalie[lst].matricule) == 0}
{$dataAnomalie[lst].prenom}
{if strlen($dataAnomalie[lst].prenom) == 0}
{$dataAnomalie[lst].pittag_valeur}
{/if}
{/if}
</a>
{/if}
<td>
{if $dataAnomalie[lst].evenement_id > 0 && $droits["poissonGestion"] == 1}
<a href="index.php?module=evenementChange&poisson_id={$dataAnomalie[lst].poisson_id}&evenement_id={$dataAnomalie[lst].evenement_id}">
{$dataAnomalie[lst].evenement_type_libelle}
</a>
{else}
{$dataAnomalie[lst].evenement_type_libelle}
{/if}
</td>
<td>{$dataAnomalie[lst].anomalie_db_type_libelle}</td>
<td>{$dataAnomalie[lst].anomalie_db_date}</td>
<td>{$dataAnomalie[lst].anomalie_db_commentaire}</td>
<td>{$dataAnomalie[lst].anomalie_db_date_traitement}</td>
<td>
<div class="center">
{if $dataAnomalie[lst].anomalie_db_statut == 1}
<img src="display/images/ok_icon.png" height="20">
{else}
<img src="display/images/warning_icon.png" height="20">
{/if}
</div>
</td>
</tr>
{/section}
</tdata>
</table>
{/if}