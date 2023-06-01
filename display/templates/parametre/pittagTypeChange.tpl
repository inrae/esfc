<h2>{t}Modification d'un type de pittag{/t}</h2>

<a href="index.php?module=pittagTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="pittagTypeForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="pittagType">
            <input type="hidden" name="pittag_type_id" value="{$data.pittag_type_id}">
            <div class="form-group">
                <label for="cpittag_type_libelle" class="control-label col-md-4">
                    {t}Nom du type de pittag :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="cpittag_type_libelle" class="form-control" name="pittag_type_libelle" type="text"
                        value="{$data.pittag_type_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.pittag_type_id > 0 &&$droits["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">Champ obligatoire</span>