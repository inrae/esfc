<h2>{t}Modification d'un statut de poisson{/t}</h2>

<a href="index.php?module=poissonStatutList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="poissonStatutForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="poissonStatut">
            <input type="hidden" name="poisson_statut_id" value="{$data.poisson_statut_id}">
            <div class="form-group">
                <label for="cpoisson_statut_libelle" class="control-label col-md-4">
                    {t}Nom du statut :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input class="form-control" id="cpoisson_statut_libelle" name="poisson_statut_libelle" type="text" value="{$data.poisson_statut_libelle}"
                        required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.poisson_statut_id > 0 &&$droits["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>