<h2>{t}Modification d'une stadeGonade (prélèvements génétiques){/t}</h2>

<a href="stadeGonadeList">{t}Retour à la liste{/t}</a>


<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="caracteristiqueForm" method="post" action="stadeGonadeWrite">            
            <input type="hidden" name="moduleBase" value="stadeGonade">
            <input type="hidden" name="stade_gonade_id" value="{$data.stade_gonade_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Nom du stade de maturation de la gonade :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="" class="form-control" name="stade_gonade_libelle" type="text"
                        value="{$data.stade_gonade_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.stade_gonade_id > 0 &&($rights["paramAdmin"] == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>