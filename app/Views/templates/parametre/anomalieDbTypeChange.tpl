<h2>{t}Modification d'un type d'anomalie dans la base de données{/t}</h2>

<a href="anomalieDbTypeList">{t}Retour à la liste{/t}</a>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="anomalieDbTypeForm" method="post" action="anomalieDbTypeWrite">
            <input type="hidden" name="moduleBase" value="anomalieDbType">
            <input type="hidden" name="anomalie_db_type_id" value="{$data.anomalie_db_type_id}">
            <div class="form-group">
                <label for="anomalie_db_type_libelle" class="control-label col-md-4">{t}Type d'anomalieDb :{/t}<span
                        class="red">*</span></label>
                <div class="col-md-8">
                    <input id="anomalie_db_type_libelle" class="form-control" name="anomalie_db_type_libelle" size="40"
                        value="{$data.anomalie_db_type_libelle}" autofocus>
                </div>


                <div class="form-group center">
                    <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                    {if $data.anomalie_db_type_id > 0}
                    <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                    {/if}
                </div>
                {$csrf}
        </form>
    </div>
</div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>