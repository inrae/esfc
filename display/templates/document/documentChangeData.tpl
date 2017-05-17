<div class="formSaisie">
<form id="documentForm" method="post" action="index.php" >
<input type="hidden" name="module" value="documentWriteData">
<input type="hidden" name="document_id" value="{$data.document_id}">
<input type="hidden" name="parent_id" value="{$parent_id}">
<input type="hidden" name="parentIdName" value="{$parentIdName}">
<input type="hidden" name="moduleParent" value="{$moduleParent}">
<input type="hidden" name="parentType" value="{$parentType}">
<input type="hidden" name="poisson_id" value="{$poisson_id}">
<input type="hidden" name="bassin_id" value="{$bassin_id}">
<input type="hidden" name="echographie_id" value="{$echographie_id}">
<input type="hidden" name="mime_type_id" value="{$data.mime_type_id}">
<input type="hidden" name="document_date_import" value="{$data.document_date_import}">
<dl>
<dt>Nom du document :</dt>
<dd>
<input type="text" name="document_nom" value="{$data.document_nom}" size="40" required>
</dd>
</dl>
<dl>
<dt>Description :</dt>
<dd>
<input type="text" name="document_description" value="{$data.document_description}" size="40">
</dd>
</dl>
<dl>
<dt>Date de création (ou de prise de vue) :</dt>
<dd>
<input name="document_date_creation" class="date" value="{$data.document_date_creation}">
</dd>
</dl>
<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>
</div>