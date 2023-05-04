<h2{t}Modification d'un type de fichier importable{/t}</h2>

<a href="index.php?module=mimeTypeList">Retour à la liste</a>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="mimeTypeForm" method="post" action="index.php?module=mimeTypeWrite">
<input type="hidden" name="mime_type_id" value="{$data.mime_type_id}">
<tr>
<td class="libelleSaisie">
Extension du fichier <span class="red">*</span> :</td>
<td class="datamodif">
<input id="cextension" name="extension" type="text" value="{$data.extension}" required autofocus/>
</td>
</tr>
<tr>
<td class="libelleSaisie">
Type de contenu (mime-Type) <span class="red">*</span> :</td>
<td class="datamodif">
<input id="ccontent_type" name="content_type" type="text" value="{$data.content_type}" required />
</td>
</tr>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>

{if $data.mime_type_id > 0 &&$droits["paramAdmin"] == 1}
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="mime_type_id" value="{$data.mime_type_id}">
<input type="hidden" name="module" value="mimeTypeDelete">
<input class="submit" type="submit" value="Supprimer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{/if}
</div>
</td>
</tr>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>