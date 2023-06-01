<h2>{t}Modification d'un métal analysé{/t}</h2>

<a href="index.php?module=metalList">{t}Retour à la liste{/t}</a>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="metalForm" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="metal">
            <input type="hidden" name="metal_id" value="{$data.metal_id}">
            <div class="form-group">
                <label for="metal_nom" class="control-label col-md-4">
                    {t}Nom du métal :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="metal_nom" class="form-control" name="metal_nom" type="text" value="{$data.metal_nom}"
                        required autofocus />
                </div>
            </div>
            <div class="form-group">
                <label for="metal_unite" class="control-label col-md-4">
                    {t}Unité utilisée pour quantifier les analyses :{/t}
                </label>
                <div class="col-md-8">
                    <input id="metal_unite" class="form-control" name="metal_unite" type="text"
                        value="{$data.metal_unite}">

                </div>
            </div>
            <div class="form-group">
                <label for="cactif_0" class="control-label col-md-4">{t}Actif ?{/t}</label>
                <div class="col-md-8">
                    <label class="radio-inline">
                        <input type="radio" id="cactif_0" name="metal_actif" value="1" {if
                            $data.metal_actif==1} checked{/if}>{t}oui{/t}
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="cactif_1" name="metal_actif" value="0" {if $data.metal_actif==0}
                            checked{/if}>{t}non{/t}
                    </label>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.metal_id > 0 &&($droits["paramAdmin"] == 1 || $droits.bassinAdmin == 1)}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">Champ obligatoire</span>