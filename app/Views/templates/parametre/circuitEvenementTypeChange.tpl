<h2>{t}Modification d'un type d'événement survenant dans les circuits d'eau{/t}</h2>

<a href="circuitEvenementTypeList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="" method="post" action="circuitEvenementTypeWrite">

            <input type="hidden" name="moduleBase" value="circuitEvenementType">
            <input type="hidden" name="circuit_evenement_type_id" value="{$data.circuit_evenement_type_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Type d'événement :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="circuit_evenement_type_libelle"
                        value="{$data.circuit_evenement_type_libelle}" autofocus>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.circuit_evenement_type_id > 0 &&$rights["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>