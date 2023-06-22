{if $devenirOrigine == "lot"}
<a href="index.php?module=lotList">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des lots{/t}
</a>&nbsp;
<a href="index.php?module=lotDisplay&lot_id={$data.lot_id}">
    <img src="display/images/fishlot.svg" height="25">
    {t}Retour au lot{/t}
    {$dataLot.lot_nom} {$dataLot.annee}/{$dataLot.site_name}
    {$dataLot.sequence_nom} {$dataLot.croisement_nom}
</a>
{else}
<a href="index.php?module=devenirList">
    <img src="display/images/right-arrow.png" height="25">
    {t}Retour à la liste des lâchers et entrées dans le stock{/t}
</a>
{/if}
<h2>{t}Saisie de la destination d'une reproduction{/t}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="devenirForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="devenir{$devenirOrigine}">
            <input type="hidden" name="devenir_id" value="{$data.devenir_id}">
            <input type="hidden" name="lot_id" value="{$data.lot_id}">
            <input type="hidden" name="devenirOrigine" value="{$devenirOrigine}">
            <div class="form-group">
                <label for="devenir_date" class="control-label col-md-4">
                    {t}Date :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="devenir_date" class="form-control datepicker" name="devenir_date" required
                        value="{$data.devenir_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="parent_devenir_id" class="control-label col-md-4">
                    {t}Destination parente :{/t}
                </label>
                <div class="col-md-8">
                    <select id="parent_devenir_id" class="form-control" name="parent_devenir_id">
                        <option value="" {if $data.parent_devenir_id="" }selected{/if}{t}Sélectionnez...{/t}/option>
                            {section name=lst loop=$devenirParent}
                        <option value="{$devenirParent[lst].devenir_id}" {if
                            $devenirParent[lst].devenir_id==$data.devenir_id}selected{/if}>
                            {$devenirParent[lst].devenir_date} {$devenirParent[lst].devenir_type_libelle}
                            {$devenirParent[lst].categorie_libelle}
                            {$devenirParent[lst].localisation} {$devenirParent[lst].poisson_nombre}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="devenir_type_id" class="control-label col-md-4">
                    {t}Nature:{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="devenir_type_id" class="form-control" name="devenir_type_id">
                        {section name=lst loop=$devenirType}
                        <option value="{$devenirType[lst].devenir_type_id}" {if
                            $devenirType[lst].devenir_type_id==$data.devenir_type_id}selected{/if}>
                            {$devenirType[lst].devenir_type_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="categorie_id" class="control-label col-md-4">
                    {t}Stade biologique :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="categorie_id" class="form-control" name="categorie_id">
                        {section name=lst loop=$categories}
                        <option value="{$categories[lst].categorie_id}" {if
                            $categories[lst].categorie_id==$data.categorie_id}selected{/if}>
                            {$categories[lst].categorie_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="sortie_lieu_id" class="control-label col-md-4">
                    {t}Lieu de lâcher :{/t}
                </label>
                <div class="col-md-8">
                    <select id="sortie_lieu_id" class="form-control" name="sortie_lieu_id">
                        <option value="" {if $data.sortie_lieu_id=="" }selected{/if}>
                            {section name=lst loop=$sorties}
                        <option value="{$sorties[lst].sortie_lieu_id}" {if
                            $sorties[lst].sortie_lieu_id==$data.sortie_lieu_id}selected{/if}>
                            {$sorties[lst].localisation}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="poisson_nombre" class="control-label col-md-4">
                    {t}Nombre de poissons concernés :{/t}
                </label>
                <div class="col-md-8">
                    <input id="poisson_nombre" class="form-control nombre" name="poisson_nombre"
                        value="{$data.poisson_nombre}">
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.devenir_id > 0 &&$droits["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>