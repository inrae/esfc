<h2>{t}Modification d'un type d'aliment{/t}</h2>

<a href="alimentTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="alimentTypeForm" method="post" action="alimentTypeWrite">
            <input type="hidden" name="moduleBase" value="alimentType">
            <input type="hidden" name="aliment_type_id" value="{$data.aliment_type_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4"><span class="red">*</span>{t}Type d'aliment :{/t}</label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="aliment_type_libelle" size="40"
                        value="{$data.aliment_type_libelle}" autofocus>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.aliment_type_id > 0 && $rights["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>



<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>