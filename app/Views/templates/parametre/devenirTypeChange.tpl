<h2>{t}Modification d'un type de devenir d'un lot de reproduction{/t}</h2>

<a href="devenirTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="devenirTypeForm" method="post" action="devenirTypeWrite">
            <input type="hidden" name="moduleBase" value="devenirType">
            <input type="hidden" name="devenir_type_id" value="{$data.devenir_type_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Type de devenir :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="cdevenir_type_libelle" class="form-control" name="devenir_type_libelle" type="text"
                        value="{$data.devenir_type_libelle}" required autofocus />
                </div>
            </div>
            <div class="form-group">
                <label for="evenement_type_id" class="control-label col-md-4">
                    {t}Type d'événement rattaché :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="evenement_type_id" class="form-control" name="evenement_type_id">
                        {foreach $evenementTypes as $et}
                        <option value="{$et.evenement_type_id}" {if $data.evenement_type_id == $et.evenement_type_id}selected{/if}>
                        {$et.evenement_type_libelle}
                        </option>
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.devenir_type_id > 0 &&$rights["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>