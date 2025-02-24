<h2>{t}Modification d'une nageoire (prélèvements génétiques){/t}</h2>

<a href="nageoireList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="nageoireForm" method="post" action="nageoireWrite">

            <input type="hidden" name="moduleBase" value="nageoire">
            <input type="hidden" name="nageoire_id" value="{$data.nageoire_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Nom de la nageoire :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="nageoire_libelle" type="text"
                        value="{$data.nageoire_libelle}" required autofocus />

                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.nageoire_id > 0 &&($rights["paramAdmin"] == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>