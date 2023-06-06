<h2>{t}Modification d'un conservateur de sperme{/t}</h2>

<a href="index.php?module=spermeConservateurList">{t}Retour à la liste{/t}</a>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="conservateurForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="spermeConservateur">
            <input type="hidden" name="sperme_conservateur_id" value="{$data.sperme_conservateur_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Nom du conservateur :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="sperme_conservateur_libelle" type="text"
                        value="{$data.sperme_conservateur_libelle}" required autofocus />

                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sperme_conservateur_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>