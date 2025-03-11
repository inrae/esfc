<h2>{t}Modification d'un type de fichier importable{/t}</h2>

<a href="mimeTypeList">{t}Retour à la liste{/t}</a>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="mimeTypeForm" method="post" action="mimeTypeWrite">

            <input type="hidden" name="moduleBase" value="mimeType">
            <input type="hidden" name="mime_type_id" value="{$data.mime_type_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Extension du fichier :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="cextension" class="form-control" name="extension" type="text" value="{$data.extension}" required autofocus />
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Type de contenu (mime-Type) :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="ccontent_type" class="form-control" name="content_type" type="text" value="{$data.content_type}" required />
                </div>
            </div>
            <div align="center">
                <div class="form-group center">
                    <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>

                    {if $data.mime_type_id > 0 &&$rights["paramAdmin"] == 1}
                    <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                    {/if}
                </div>
            </div>
            {$csrf}
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>