<h2>{t}Modification d'un laboratoire d'analyse{/t}</h2>

<a href="index.php?module=laboratoireAnalyseList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal protoform" id="laboratoireAnalyseForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="laboratoireAnalyse">
            <input type="hidden" name="laboratoire_analyse_id" value="{$data.laboratoire_analyse_id}">
            <div class="form-group">
                <label for="laboratoire_analyse_libelle" class="control-label col-md-4">{t}Nom du laboratoire :{/t}<span
                        class="red">*</span></label>
                <div class="col-md-8">
                    <input id="laboratoire_analyse_libelle" class="form-control" name="laboratoire_analyse_libelle"
                        value="{$data.laboratoire_analyse_libelle}" autofocus required>
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Sollicité actuellement ?{/t}</label>
                <div class="col-md-8">
                    <label class="label-inline">
                        <input id="actif1" type="radio" name="laboratoire_analyse_actif" value="1"
                            {if $data.laboratoire_analyse_actif==1}checked{/if}>{t}oui{/t}
                    </label>
                    <label class="label-inline">
                        <input type="radio" id="actif0" name="laboratoire_analyse_actif" value="0" {if
                            $data.laboratoire_analyse_actif==0}checked{/if}>{t}non{/t}
                    </label>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.laboratoire_analyse_id > 0 &&$droits["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">Champ obligatoire</span>