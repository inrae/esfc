<a href="index.php?module={$poissonDetailParent}">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>
&nbsp;
{if isset($poisson_campagne_id)}
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
{else}
<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
    <img src="display/images/sturio.png" height="25">
    {t}Retour au poisson{/t}
</a>
{/if}
<h2>{t}Modification/saisie d'une mesure du nombre de battements de ventilation{/t}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="ventilationForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase"
                value="{if isset($poisson_campagne_id)}ventilationCampagne{else}ventilation{/if}">
            <input type="hidden" name="poisson_campagne_id" value="{$poisson_campagne_id}">
            <input type="hidden" name="biopsie_id" value="{$data.biopsie_id}">
            <input type="hidden" name="poisson_id" value="{$data.poisson_id}">
            <input type="hidden" name="ventilation_id" value="{$data.ventilation_id}">
            <div class="form-group">
                <label for="ventilation_date" class="control-label col-md-4">
                    {t}Date de la mesure :{/t}
                    <span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="ventilation_date" class="form-control datetimepicker" name="ventilation_date" required
                        value="{$data.ventilation_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="battement_nb" class="control-label col-md-4">
                    {t}Nb de battements/seconde :{/t}
                    <span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="battement_nb" class="form-control taux" name="battement_nb" value="{$data.battement_nb}">
                </div>
            </div>
            <div class="form-group">
                <label for="ventilation_commentaire" class="control-label col-md-4">{t}Commentaire :{/t}</label>
                <div class="col-md-8">
                    <input id="ventilation_commentaire" class="form-control" name="ventilation_commentaire"
                        value="{$data.ventilation_commentaire}">
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.ventilation_id > 0 && ($droits.poissonGestion == 1 || $droits.reproGestion == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span>
<span class="messagebas">{t}Champ obligatoire{/t}</span>