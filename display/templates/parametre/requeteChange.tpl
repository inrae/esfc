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
&nbsp;
<a href="index.php?module=getStructureDatabase" target="_blank">Structure de la base de données (fichier PDF)</a>
<div class="formSaisie">
<div>

<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> class="cmxform" id="requeteForm" method="post" action="index.php">
<input type="hidden" id="module" name="module" value="requeteWrite">
<input type="hidden" name="requete_id" value="{$data.requete_id}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}
Description de la requête <span class="red">*</span> :
{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="title" class="commentaire modif" type="text" value="{$data.title}" required autofocus/>
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Code SQL <span class="red">*</span> : <b>SELECT</b>{/t}</label>
<dd>
<textarea class="modif" name="body" cols="70" rows="10" wrap="soft" required>{$data.body}</textarea>
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Champs dates de la requête (séparés par une virgule) :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" class="modif" name="datefields" value="{$data.datefields}" placeholder="evenement_date,morphologie_date">
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}date de création :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="creation_date" value="{$data.creation_date}" readonly>
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}par :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="login" value="{$data.login}" readonly>
</dd>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Date de dernière exécution :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" name="last_exec" value="{$data.last_exec}" readonly>
</dd>
</div>

<div class="form-group"></div>
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
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
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
