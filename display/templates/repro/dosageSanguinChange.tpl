<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>&nbsp;
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$data.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
<h2>{t}Modification d'un dosage sanguin{/t} {$dataPoisson.matricule}
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="dosageSanguinForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="dosageSanguin">
            <input type="hidden" name="dosage_sanguin_id" value="{$data.dosage_sanguin_id}">
            <input type="hidden" name="poisson_campagne_id" value="{$data.poisson_campagne_id}">

            <div class="form-group">
                <label for="dosage_sanguin_date" class="control-label col-md-4">
                    {t}Date du prélèvement :{/t}
                    <span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="dosage_sanguin_date" class="form-control" class="datepicker" name="dosage_sanguin_date"
                        required value="{$data.dosage_sanguin_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="tx_e2" class="control-label col-md-4">
                    {t}Taux E2 :{/t}
                </label>
                <div class="col-md-8">
                    <input id="tx_e2" class="form-control" class="taux" name="tx_e2" value="{$data.tx_e2}">
                </div>
            </div>
            <div class="form-group">
                <label for="tx_e2_texte" class="control-label col-md-4">
                    {t}Taux E2 (forme textuelle, pour des fourchettes ou des tendances) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="tx_e2_texte" class="form-control" name="tx_e2_texte" value="{$data.tx_e2_texte}">
                </div>
            </div>
            <div class="form-group">
                <label for="tx_calcium" class="control-label col-md-4">
                    {t}Taux de calcium :{/t}
                </label>
                <div class="col-md-8">
                    <input id="tx_calcium" class="form-control" class="taux" name="tx_calcium"
                        value="{$data.tx_calcium}">
                </div>
            </div>
            <div class="form-group">
                <label for="tx_hematocrite" class="control-label col-md-4">
                    {t}Taux d'hématocrite :{/t}
                </label>
                <div class="col-md-8">
                    <input id="tx_hematocrite" class="form-control" class="taux" name="tx_hematocrite"
                        value="{$data.tx_hematocrite}">
               </div>
            </div>
            <div class="form-group">
                <label for="dosage_sanguin_commentaire" class="control-label col-md-4">
                    {t}Commentaires :{/t}
                </label>
                <div class="col-md-8">
                    <input id="dosage_sanguin_commentaire" class="form-control" name="dosage_sanguin_commentaire"
                        value="{$data.dosage_sanguin_commentaire}">
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.dosage_sanguin_id > 0 &&$droits["reproAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>