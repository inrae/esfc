<h2>{t}Modification d'une catégorie d'aliment{/t}</h2>

<a href="index.php?module=categorieList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="categorieForm" method="post" action="index.php">
        <input type="hidden" name="action" value="Write">
        <input type="hidden" name="moduleBase" value="categorie">
        <input type="hidden" name="categorie_id" value="{$data.categorie_id}">
        <div class="form-group">
        <label for="categorie_libelle" class="control-label col-md-4"><span class="red">*</span>{t}Type de poisson nourri :{/t}</label>
        <div class="col-md-8">
        <input id="categorie_libelle" class="form-control" name="categorie_libelle" value="{$data.categorie_libelle}" autofocus>
        </div>
        </div>

        <div class="form-group center">
        <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
        {if $data.categorie_id > 0 &&$droits["paramAdmin"] == 1}
        <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
        {/if}
        </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>