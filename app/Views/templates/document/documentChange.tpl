<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="documentForm" method="post" action="index.php" enctype="multipart/form-data">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="document">
            <input type="hidden" name="document_id" value="0">
            <input type="hidden" name="parent_id" value="{$parent_id}">
            <input type="hidden" name="parentIdName" value="{$parentIdName}">
            <input type="hidden" name="moduleParent" value="{$moduleParent}">
            <input type="hidden" name="parentType" value="{$parentType}">
            <div class="form-group">
                <label for="documents" class="control-label col-md-4">
                    {t}Fichier(s) à importer : (doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv){/t}
                </label>
                <div class="col-md-8">
                    <input id="" class="form-control" type="file" name="documentName[]" multiple>
                </div>
            </div>
            <div class="form-group">
                <label for="document_description" class="control-label col-md-4">{t}Description :{/t}</label>
                <div class="col-md-8">
                    <input id="document_description" class="form-control" type="text" name="document_description"
                        value="">
                </div>
                <div class="form-group center">
                    <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                </div>
            </div>
        </form>
    </div>
</div>