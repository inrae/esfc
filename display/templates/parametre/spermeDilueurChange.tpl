<h2>{t}Modification d'un dilueur de sperme{/t}</h2>

<a href="index.php?module=spermeDilueurList">{t}Retour à la liste{/t}</a>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="dilueurForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="spermeDilueur">
            <input type="hidden" name="sperme_dilueur_id" value="{$data.sperme_dilueur_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Nom du dilueur :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="sperme_dilueur_libelle" class="form-control" name="sperme_dilueur_libelle" type="text"
                        value="{$data.sperme_dilueur_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sperme_dilueur_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>