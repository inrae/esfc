<h2>{t}Modification d'un type de mortalite{/t}</h2>

<a href="mortaliteTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="mortaliteTypeForm" method="post" action="mortaliteTypeWrite">

            <input type="hidden" name="moduleBase" value="mortaliteType">
            <input type="hidden" name="mortalite_type_id" value="{$data.mortalite_type_id}">
            <div class="form-group">
                <label for="cmortalite_type_libelle" class="control-label col-md-4">
                    {t}Type de mortalite :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="cmortalite_type_libelle" class="form-control" name="mortalite_type_libelle" type="text"
                        value="{$data.mortalite_type_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.mortalite_type_id > 0}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>