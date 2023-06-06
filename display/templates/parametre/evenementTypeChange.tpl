<h2>{t}Modification d'un type d'événement{/t}</h2>

<a href="index.php?module=evenementTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="evenementTypeForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="evenementType">
            <input type="hidden" name="evenement_type_id" value="{$data.evenement_type_id}">
            <div class="form-group">
                <label for="cevenement_type_libelle" class="control-label col-md-4">
                    {t}Nom du type d'événement :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="cevenement_type_libelle" name="evenement_type_libelle" class="form-control" type="text"
                        value="{$data.evenement_type_libelle}" required autofocus />
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Actif dans les sélections ?{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <label class="radio-inline">
                        <input id="actif0" type="radio" name="evenement_type_actif" value="0" {if
                            $data.evenement_type_actif==0}checked{/if}> {t}non{/t}
                    </label>
                    <label class="radio-inline">
                        <input id="actif1" type="radio" name="evenement_type_actif" value="1" {if
                            $data.evenement_type_actif==1}checked{/if}> {t}oui{/t}
                    </label>
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.evenement_type_id > 0 &&$droits["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>