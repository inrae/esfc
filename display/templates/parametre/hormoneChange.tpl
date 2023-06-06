<h2>{t}Modification d'une hormone{/t}</h2>

<a href="index.php?module=hormoneList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="hormoneForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="hormone">
            <input type="hidden" name="hormone_id" value="{$data.hormone_id}">
            <div class="form-group">
                <label for="hormone_nom" class="control-label col-md-4">
                    {t}Nom de l'hormone :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="hormone_nom" class="form-control" name="hormone_nom" type="text"
                        value="{$data.hormone_nom}" required autofocus />
                </div>
            </div>
            <div class="form-group">
                <label for="hormone_unite" class="control-label col-md-4">
                    {t}Unité utilisée pour quantifier les injections :{/t}
                </label>
                <div class="col-md-8">
                    <input id="hormone_unite" class="form-control" name="" type="text" value="{$data.hormone_unite}">

                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.hormone_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>