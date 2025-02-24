<h2>{t}Modification d'un type de bassin{/t}</h2>

<a href="bassinTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="bassinTypeForm" method="post" action="bassinTypeWrite">            
            <input type="hidden" name="moduleBase" value="bassinType">
            <input type="hidden" name="bassin_type_id" value="{$data.bassin_type_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Type de bassin :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="cbassin_type_libelle" class="form-control" name="bassin_type_libelle" type="text"
                        value="{$data.bassin_type_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.bassin_type_id > 0 &&$rights["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>