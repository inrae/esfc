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
		$("#module").val("requeteWriteExec");
		$("#requeteForm").submit();
	});
	$(".modif").change(function() { 
		$("#exec").prop("disabled", true);
	});
	
});
</script>

<a href="index.php?module=requeteList">Retour à la liste</a>
<div class="formSaisie">
<div>

<form class="cmxform" id="requeteForm" method="post" action="index.php">
<input type="hidden" id="module" name="module" value="requeteWrite">
<input type="hidden" name="requete_id" value="{$data.requete_id}">
<dl>
<dt>
Description de la requête <span class="red">*</span> :
</dt>
<dd>
<input name="title" class="commentaire modif" type="text" value="{$data.title}" required autofocus/>
</dd>
</dl>
<dl>
<dt>Code SQL <span class="red">*</span> : <b>SELECT</b></dt>
<dd>
<textarea class="modif" name="body" cols="70" rows="10" wrap="soft" required>{$data.body}</textarea>
</dd>
</dl>
<dl>
<dt>Champs dates de la requête (séparés par une virgule) :</dt>
<dd>
<input class="modif" name="datefields" value="{$data.datefields}" placeholder="evenement_date,morphologie_date">
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
<input name="last_exec" value="{$data.last_exec}" readonly>
</dd>
</dl>

<dl></dl>
<div class="formBouton">
{if $droits.requeteAdmin == 1}
<input id="save" class="submit" type="submit" value="Enregistrer">
{if $data.requete_id > 0}
<input id="saveExec" class="submit" type="button" value="Enregistrer et exécuter">
{/if}
{/if}
{if $data.requete_id > 0}
<input id="exec" class="submit" type="button" value="Exécuter">
{if $droits.requeteAdmin == 1 }
<input id="suppr" class="submit" type="button" value="Supprimer">
{/if}
{/if}
</div>
</form>
</div>
</div>
<script>
setDataTablesFull("crequeteList", true, true, true, 50);
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
