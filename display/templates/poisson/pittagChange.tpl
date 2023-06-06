<a href="index.php?module={$poissonDetailParent}">
    <img src="display/images/display.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>

<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au poisson{/t}
</a>
<h2>{t}Modification d'un (pit)tag pour le poisson{/t} {$dataPoisson.matricule} {$dataPoisson.categorie_libelle}
    {$dataPoisson.sexe_libelle}
    {$dataPoisson.poisson_statut_libelle} (id:{$dataPoisson.poisson_id})</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="pittagForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="pittag">
            <input type="hidden" name="pittag_id" value="{$data.pittag_id}">
            <input type="hidden" name="poisson_id" value="{$data.poisson_id}">
            <div class="form-group">
                <label for="cpittag_valeur" class="control-label col-md-4">
                    {t}Valeur de la marque :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input class="form-control" name="pittag_valeur" id="cpittag_valeur" value="{$data.pittag_valeur}"
                        pattern="(([A-F0-9][A-F0-9])+|[0-9]+)" placeholder="01AB2C ou 12345"
                        title="{t}Nombre hexadécimal ou numérique{/t}" autofocus>
                </div>
            </div>
            <div class="form-group">
                <label for="pittag_type_id" class="control-label col-md-4">
                    {t}Type de marque :{/t}
                </label>
                <div class="col-md-8">
                    <select class="form-control" name="pittag_type_id" id="pittag_type_id">
                        <option value="" {if $pittagType.pittag_type_id=="" }selected{/if}>
                            Sélectionnez le type de marque...
                        </option>
                        {section name=lst loop=$pittagType}
                        <option value="{$pittagType[lst].pittag_type_id}" {if
                            $pittagType[lst].pittag_type_id==$data.pittag_type_id}selected{/if}>
                            {$pittagType[lst].pittag_type_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="cpittag_date_pose" class="control-label col-md-4">{t}Date de pose :{/t}</label>
                <div class="col-md-8">
                    <input name="pittag_date_pose" id="cpittag_date_pose" class="form-control datepicker"
                        value="{$data.pittag_date_pose}">
                </div>
            </div>

            <div class="form-group">
                <label for="pittag_commentaire" class="control-label col-md-4">
                    {t}Commentaire :{/t}
                </label>
                <div class="col-md-8">
                    <input class="form-control" id="pittag_commentaire" name="pittag_commentaire"
                        value="{$data.pittag_commentaire}">
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.pittag_id > 0 &&$droits["poissonGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>