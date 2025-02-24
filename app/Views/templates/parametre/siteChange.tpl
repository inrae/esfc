<h2>{t}Modification d'un site{/t}</h2>

<a href="siteList">Retour à la liste des sites</a>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="site" method="post" action="siteWrite">

            <input type="hidden" name="moduleBase" value="site">
            <input type="hidden" name="site_id" value="{$data.site_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Nom du site :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="site_name" type="text" value="{$data.site_name}" required
                        autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.site_id > 0 &&($rights["paramAdmin"] == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>