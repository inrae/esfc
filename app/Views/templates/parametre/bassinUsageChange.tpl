<h2>{t}Modification d'un type d'utilisation des bassins{/t}</h2>

<a href="index.php?module=bassinUsageList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="bassinUsageForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="bassinUsage">
            <input type="hidden" name="bassin_usage_id" value="{$data.bassin_usage_id}">
            <div class="form-group">
                <label for="cbassin_usage_libelle" class="control-label col-md-4">
                    {t}Utilisation :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input class="form-control" id="cbassin_usage_libelle" name="bassin_usage_libelle" type="text"
                        value="{$data.bassin_usage_libelle}" required autofocus />

                </div>
            </div>
            <div class="form-group">
                <label for="categorie_id" class="control-label col-md-4">
                    {t}Catégorie d'alimentation :{/t}
                </label>
                <div class="col-md-8">
                    <select id="categorie_id" class="form-control" name="categorie_id">
                        <option value="" {if $data.categorie_id=="" }selected{/if}>
                            {t}Sélectionnez la catégorie...{/t}
                        </option>
                        {section name=lst loop=$categorie}
                        <option value="{$categorie[lst].categorie_id}" {if
                            $categorie[lst].categorie_id==$data.categorie_id}selected{/if}>
                            {$categorie[lst].categorie_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.bassin_usage_id > 0 &&$droits["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>