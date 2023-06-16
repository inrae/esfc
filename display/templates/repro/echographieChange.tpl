<a href="index.php?module={$poissonDetailParent}&sequence_id={$sequence_id}">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des poissons{/t}
</a>
<a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    <img src="display/images/fish.svg" height="25">
    {t}Retour au reproducteur{/t}
</a>
<h2>{t}Modification d'une échographie{/t} {$dataPoisson.matricule} {$dataPoisson.prenom} {$dataPoisson.pittag_valeur} -
    {$dataPoisson.sexe_libelle}
    {if $dataPoisson.poisson_statut_id != 1}- {$dataPoisson.poisson_statut_libelle}{/if}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="echographieForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="echographie">
            <input type="hidden" name="echographie_id" value="{$data.echographie_id}">
            <input type="hidden" name="poisson_id" value="{$data.poisson_id}"
            <input type="hidden" name="poisson_campagne_id" value="{$dataPoisson.poisson_campagne_id}">
            <div class="form-group">
                <label for="echographie_date" class="control-label col-md-4">
                    {t}Date de l'échographie :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="echographie_date" class="form-control datepicker" name="echographie_date" required
                        value="{$data.echographie_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Commentaires :{/t}
                </label>
                <div class="col-md-8">
                    <input id="echographie_commentaire" class="form-control" name="echographie_commentaire"
                        value="{$data.echographie_commentaire}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Stade des gonades :{/t}
                </label>
                <div class="col-md-8">
                    <select id="stade_gonade_id" class="form-control" name="stade_gonade_id">
                        <option value="" {if $data.stade_gonade_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
                            {section name=lst loop=$gonades}
                        <option value="{$gonades[lst].stade_gonade_id}" {if
                            $data.stade_gonade_id==$gonades[lst].stade_gonade_id}selected{/if}>
                            {$gonades[lst].stade_gonade_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="stade_oeuf_id" class="control-label col-md-4">
                    {t}Stade des œufs :{/t}
                </label>
                <div class="col-md-8">
                    <select id="stade_oeuf_id" class="form-control" name="stade_oeuf_id">
                        <option value="" {if $data.stade_oeuf_id=="" }selected{/if}>{t}Sélectionnez...{/t}</option>
                        {section name=lst loop=$oeufs}
                        <option value="{$oeufs[lst].stade_oeuf_id}" {if
                            $data.stade_oeuf_id==$oeufs[lst].stade_oeuf_id}selected{/if}>
                            {$oeufs[lst].stade_oeuf_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="cliche_nb" class="control-label col-md-4">
                    {t}Nombre de clichés :{/t}
                </label>
                <div class="col-md-8">
                    <input id="cliche_nb" class="form-control nombre" name="cliche_nb" value="{$data.cliche_nb}">
                </div>
            </div>
            <div class="form-group">
                <label for="cliche_ref" class="control-label col-md-4">
                    {t}Référence des clichés :{/t}
                </label>
                <div class="col-md-8">
                    <input id="cliche_ref" class="form-control" class="commentaire" name="cliche_ref"
                        value="{$data.cliche_ref}">
                </div>
            </div>
            <div class="form-group">
                <label for="documentName" class="control-label col-md-4">
                    {t}Images(s) à importer :{/t}
                    <br>(doc, jpg, png, pdf, xls, xlsx, docx, odt, ods, csv)
                </label>
                <div class="col-md-8">
                    <input type="file" class="form-control" name="documentName[]" multiple>
                </div>
            </div>
            <div class="form-group">
                <label for="document_description" class="control-label col-md-4">{t}Description
                    des images :{/t}</label>
                <div class="col-md-8">
                    <input id="document_description" class="form-control" type="text"
                        name="document_description" value="">
                </div>
            </div>
            <div class="form-group">
                <label for="document_date_creation" class="control-label col-md-4">
                    {t}Date de création (ou de prise de vue) :{/t}
                </label>
                <div class="col-md-8">
                    <input id="document_date_creation" class="form-control datepicker"
                        name="document_date_creation" value="{$data.document_date_creation}">
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.echographie_id > 0 &&$droits["reproAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>

