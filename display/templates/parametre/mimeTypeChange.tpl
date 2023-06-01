<h2>{t}Modification d'un type de fichier importable{/t}</h2>

<a href="index.php?module=mimeTypeList">{t}Retour à la liste{/t}</a>
<table class="tablesaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="mimeTypeForm" method="post" action="index.php?module=mimeTypeWrite">
<input type="hidden" name="mime_type_id" value="{$data.mime_type_id}">
<div class="form-group">
                <label for="" class="control-label col-md-4">{t}
Extension du fichier <span class="red">*</span> :{/t}</label>
                <div class="col-md-8">
<input id="cextension" name="extension" type="text" value="{$data.extension}" required autofocus/>
</div>
</div>
<div class="form-group">
                <label for="" class="control-label col-md-4">{t}
Type de contenu (mime-Type) <span class="red">*</span> :{/t}</label>
                <div class="col-md-8">
<input id="ccontent_type" name="content_type" type="text" value="{$data.content_type}" required />
</div>
</div>
<tr>
<td colspan="2"><div align="center">
<input class="submit" type="submit" value="Enregistrer">
<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
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
<button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
{/if}
</div>
</div>
</div>
</table>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>