<h2>{t}Modification d'un type de pathologie{/t}</h2>

<a href="index.php?module=pathologieTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="pathologieTypeForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="pathologieType">
            <input type="hidden" name="pathologie_type_id" value="{$data.pathologie_type_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Nom du type de pathologie :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="cpathologie_type_libelle" class="form-control" name="pathologie_type_libelle" type="text"
                        value="{$data.pathologie_type_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.pathologie_type_id > 0 &&$droits["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>