<a href="index.php?module={$poissonDetailParent}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>

<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
    <img src="display/images/sturio.png" height="25">
    {t}Retour au poisson{/t}
</a>

{if $data.poisson_campagne_id > 0}
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
{/if}

<h2>{t}Sélectionner le poisson pour une campagne de reproduction{/t} {$dataPoisson.matricule}
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="poissonCampagneForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="poissonCampagne">
            <input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">
            <input type="hidden" name="poisson_id" value="{$data.poisson_id}">
            <div class="form-group">
                <label for="identification" class="control-label col-md-4">{t}Identification :{/t}</label>
                <div class="col-md-8">
                    <input id="identification" class="form-control" name="identification" readonly
                        value="{$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur}">
                </div>
            </div>
            <div class="form-group">
                <label for="annee" class="control-label col-md-4">
                    {t}Année :{/t}
                </label>
                <div class="col-md-8">
                    <select id="annee" class="form-control" name="annee">
                        {foreach $annees as $annee}
                        <option value="{$annee}" {if $annee==$data.annee}selected{/if}>
                            {$annee}
                        </option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="repro_statut_id" class="control-label col-md-4">
                    {t}Statut du poisson pour la repro :{/t}
                </label>
                <div class="col-md-8">
                    <select id="repro_statut_id" class="form-control" name="repro_statut_id">
                        {section name=lst loop=$reproStatut}
                        <option value="{$reproStatut[lst].repro_statut_id}" {if
                            $reproStatut[lst].repro_statut_id==$data.repro_statut_id}selected{/if}>
                            {$reproStatut[lst].repro_statut_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <fieldset>
                <legend>{t}Indicateurs de croissance (calculés automatiquement en cas de nouvelle sélection){/t}
                </legend>
                <div class="form-group">
                    <label for="tx_croissance_journalier" class="control-label col-md-4">
                        {t}Taux de croissance journalier :{/t}
                    </label>
                    <div class="col-md-8">
                        <input id="tx_croissance_journalier" class="form-control taux" name="tx_croissance_journalier"
                            value="{$data.tx_croissance_journalier}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="" class="control-label col-md-4">
                        {t}Taux de croissance spécifique :{/t}
                    </label>
                    <div class="col-md-8">
                        <input id="" class="form-control taux" name="specific_growth_rate"
                            value="{$data.specific_growth_rate}">
                    </div>
                </div>
            </fieldset>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.poisson_campagne_id > 0 &&$droits["reproAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>