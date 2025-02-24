<a href="{$poissonDetailParent}&sequence_id={$data.sequence_id}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>&nbsp;
<a href="poissonCampagneDisplay?poisson_campagne_id={$data.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
<h2>{t}Modification d'un prélèvement de sperme{/t} {$dataPoisson.matricule}
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</h2>


<div class="row">
    <div class="col-lg-4 col-md-12">
        <form class="form-horizontal" id="spermeForm" method="post" action="spermeWrite">            
            <input type="hidden" name="moduleBase" value="sperme">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Séquence de reproduction :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="" class="form-control" name="sequence_id">
                        {section name=lst loop=$sequences}
                        <option value="{$sequences[lst].sequence_id}" {if
                            $data.sequence_id==$sequences[lst].sequence_id}selected{/if}>
                            {$sequences[lst].sequence_nom}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            {include file="repro/spermeChangeCorps.tpl"}

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sperme_id > 0 &&$rights["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>


    <div class="col-lg-8 col-md-12">
        <h3>
            <img src="display/images/analyse.png" height="25">
            {t}Analyses réalisées{/t}
        </h3>
        {include file="repro/spermeMesureList.tpl"}

        <!-- Ajout de l'affichage des congelations -->
        {if $data.sperme_id > 0}
        <h3>
            <img src="display/images/congelation.svg" height="25">
            {t}Congélations{/t}
        </h3>
        {include file="repro/spermeCongelationList.tpl"}
        {/if}
    </div>
</div>