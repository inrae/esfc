<h2>{t}Modification de l'endroit d'implantation d'une marque VIE{/t}</h2>

<a href="index.php?module=vieImplantationList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="vieImplantationForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="vieImplantation">
            <input type="hidden" name="vie_implantation_id" value="{$data.vie_implantation_id}">
            <div class="form-group">
                <label for="vie_implantation_libelle" class="control-label col-md-4">
                    {t}Nom de l'endroit d'implantation :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="vie_implantation_libelle" class="form-control" name="vie_implantation_libelle"
                        type="text" value="{$data.vie_implantation_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.vie_implantation_id > 0 &&($droits["paramAdmin"] == 1 || $droits.reproAdmin == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>