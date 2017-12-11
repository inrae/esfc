<script>
$(document).ready(function() {
	$("#suppr").bind("click keyup", function (event) {
		if (confirm("Confirmez la suppression de la requête") == true) {
			$("#module").val("requeteDelete");
			$("#requeteForm").submit();
		}
	});
	$("#exec").bind("click keyup", function (event) { 
		$("#module").val("requeteExec");
		$("#requeteForm").submit();
	});
	$("#saveExec").bind("click keyup", function (event) { 
		$("#module").val("requeteSaveExec");
		$("#requeteForm").submit();
	});
	
});
</script>

<a href="index.php?module=requeteList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="requeteForm" method="post" action="index.php">
<input id="module" name="module" value="requeteWrite">
<input type="hidden" name="requete_id" value="{$data.requete_id}">
<dl>
<dt>
Description de la requête <span class="red">*</span> :
</dt>
<dd>
<input name="title" type="text" value="{$data.title}" required autofocus/>
</dd>
</dl>
<dl>
<dt>Code SQL <span class="red">*</span> :</dt>
<dd>SELECT
<textarea name="body" cols="40" rows="10" wrap="soft">{$data.body} required</textarea>
</dd>
</dl>
<dl>
<dt>Champs dates de la requête (séparés par une virgule) :</dt>
<dd>
<input name="datefields" value="{$data.datefields}" placeholder="evenement_date,morphologie_date">
</dl>
<dl>
<dt>date de création :</dt>
<dd>
<input name="creation_date" value="{$data.creation_date}" readonly>
</dd>
</dl>
<dl>
<dt>par :</dt>
<dd>
<input name="login" value="{$data.login}" readonly>
</dd>
</dl>
<dl>
<dt>Date de dernière exécution :</dt>
<dd>
<input name="creation_date" value="{$data.creation_date}" readonly>
</dd>
</dl>

<dl></dl>
<div class="formBouton">
{if droits.paramAdmin == 1}
<input id="save" class="submit" type="submit" value="Enregistrer">
<input id="saveExec" class="submit" type="button" value="Enregistrer et exécuter">
{/if}
<input id="exec" class="submit" type="button" value="Exécuter">
{if droits.paramAdmin == 1 && $data.requete_id > 0}
<input id="suppr" class="submit" type="button" value="Supprimer">
</div>
</form>
</div>
</div>
<script>
setDataTables("crequeteList");
</script>

{if count($result) > 0}
<table id="crequeteList" class="tableliste">
<thead>
<tr>
{foreach $result[0] as $key=>$value}
<th>{$key}</th>
{/foreach}
</tr>
</thead>
<tbody>
{foreach $result as $line}
<tr>
{foreach $line as $value}
<td>{$value}</td>
{/foreach}
</tr>
{/foreach}
</tbody>
</table>
{/if}
