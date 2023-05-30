<div class="formSaisie">
<div class="row">
<div class="col-md-6">
<form class="form-horizontal" id="" method="post" action="index.php">
<input type="hidden" name="action" value="Write">
<input type="hidden" name="moduleBase" value=""> id="documentForm" method="post" action="index.php"  enctype="multipart/form-data">
<input type="hidden" name="module" value="documentWrite">
<input type="hidden" name="document_id" value="0">
<input type="hidden" name="parent_id" value="{$parent_id}">
<input type="hidden" name="parentIdName" value="{$parentIdName}">
<input type="hidden" name="moduleParent" value="{$moduleParent}">
<input type="hidden" name="parentType" value="{$parentType}">
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Fichier(s) à importer :
<br>(doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv)
{/t}</label>
<label for="" class="control-label col-md-4">{t}<input type="file" name="documentName[]" size="40" multiple>{/t}</label>
</div>
</div>
<div class="form-group">
<label for="" class="control-label col-md-4">{t}Description :{/t}</label>
<div class="col-md-8">
<input id="" class="form-control" type="text" name="document_description" value="" size="40">

</div>

<div class="form-group center">
<button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
<button class="btn btn-danger btn-delete">{t}Supprimer{/t}</button>
</form>
</div>
</div>
</div>