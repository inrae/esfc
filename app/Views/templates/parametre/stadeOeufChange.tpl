<h2>{t}Modification d'un stade de maturation d'un œuf{/t}</h2>

<a href="stadeOeufList">{t}Retour à la liste{/t}</a>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="caracteristiqueForm" method="post" action="stadeOeufWrite">            
            <input type="hidden" name="moduleBase" value="stadeOeuf">
            <input type="hidden" name="stade_oeuf_id" value="{$data.stade_oeuf_id}">
            <div class="form-group">
                <label for="stade_oeuf_libelle" class="control-label col-md-4">
                    {t}Nom du stade de maturation de l'œuf :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="stade_oeuf_libelle" class="form-control" name="stade_oeuf_libelle"
                        value="{$data.stade_oeuf_libelle}" required autofocus />
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.stade_oeuf_id > 0 &&($rights["paramAdmin"] == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>