
{if $dataCongelation.sequence_id > 0}
<a href="index.php?module={$poissonDetailParent}&sequence_id={$dataCongelation.sequence_id}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>&nbsp;
{/if}
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
&nbsp;
<a
    href="index.php?module=spermeChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$dataCongelation.sperme_id}">
    <img src="display/images/eprouvette.png" height="25">
    {t}Retour au sperme prélevé{/t}
</a>
<a
    href="index.php?module=spermeCongelationChange&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$dataCongelation.sperme_id}&sperme_congelation_id={$dataCongelation.sperme_congelation_id}">
    <img src="display/images/congelation.svg" height="25">
    {t}Retour à la congélation{/t}
</a>
<h2>{t}Modification d'un emplacement de stockage du sperme congelé{/t}
    {$dataPoisson.matricule}
    {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})
</h2>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="spermeFreezingPlaceForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="spermeFreezingPlace">
            <input type="hidden" name="sperme_congelation_id" value="{$data.sperme_congelation_id}">
            <input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
            <input type="hidden" name="sperme_id" value="{$dataCongelation.sperme_id}">
            <input type="hidden" name="sperme_freezing_place_id" value="{$data.sperme_freezing_place_id}">
            <div class="form-group">
                <label for="cuve_libelle" class="control-label col-md-4">
                    {t}Nom de la cuve :{/t}
                </label>
                <div class="col-md-8">
                    <input id="cuve_libelle" class="form-control" name="cuve_libelle" value="{$data.cuve_libelle}">
                </div>
            </div>
            <div class="form-group">
                <label for="nb_visotube" class="control-label col-md-4">
                    {t}Nombre de visotubes :{/t}
                </label>
                <div class="col-md-8">
                    <input id="nb_visotube" class="form-control nombre" name="nb_visotube"
                        value="{$data.nb_visotube}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Numéro de canister :{/t}
                </label>
                <div class="col-md-8">
                    <input id="canister_numero" class="form-control" name="canister_numero"
                        value="{$data.canister_numero}">
                </div>
            </div>
            <div class="form-group">
                <label for="position_canister" class="control-label col-md-4">
                    {t}Position du canister :{/t}
                </label>
                <div class="col-md-8">
                    <select id="position_canister" class="form-control" name="position_canister">
                        <option value="" {if $data.position_canister=="" }selected{/if}{t}Sélectionnez...{/t}/option>
                        <option value="1" {if $data.position_canister=="1" }selected{/if}>{t}Bas{/t}</option>
                        <option value="2" {if $data.position_canister=="2" }selected{/if}>{t}Haut{/t}</option>
                    </select>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sperme_freezing_place_id > 0 &&$droits["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>