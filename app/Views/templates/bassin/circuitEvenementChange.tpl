<a href="circuitEauList">Retour à la liste des circuits d'eau</a>
> <a href="circuitEauDisplay?circuit_eau_id={$data.circuit_eau_id}">Retour au circuit d'eau</a>
<h2>{t}Modification d'un événement survenu dans le circuit d'eau {$dataCircuit.circuit_eau_libelle}{/t}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="circuitEvenementForm" method="post" action="circuitEvenementWrite">
            <input type="hidden" name="moduleBase" value="circuitEvenement">
            <input type="hidden" name="circuit_evenement_id" value="{$data.circuit_evenement_id}">
            <input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Type d'événement :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <select id="" class="form-control" name="circuit_evenement_type_id">
                        {section name=lst loop=$dataEvntType}
                        <option value="{$dataEvntType[lst].circuit_evenement_type_id}" {if
                            $dataEvntType[lst].circuit_evenement_type_id==$data.circuit_evenement_type_id}selected{/if}>
                            {$dataEvntType[lst].circuit_evenement_type_libelle}
                        </option>
                        {/section}
                    </select>

                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Date :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="" class="form-control" class="date" name="circuit_evenement_date"
                        value="{$data.circuit_evenement_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Commentaires :{/t}</label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="circuit_evenement_commentaire"
                        value="{$data.circuit_evenement_commentaire}" style="size:40;">
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.circuit_evenement_id > 0 &&$rights["bassinAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>