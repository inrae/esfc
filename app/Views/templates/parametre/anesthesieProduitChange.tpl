<h2>{t}Modification d'un produit d'anesthésie{/t}</h2>

<a href="anesthesieProduitList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="anesthesieProduitForm" method="post" action="anesthesieProduitWrite">            
            <input type="hidden" name="moduleBase" value="anesthesieProduit">
            <input type="hidden" name="anesthesie_produit_id" value="{$data.anesthesie_produit_id}">
            <div class="form-group">
                <label for="anesthesie_produit_libelle" class="control-label col-md-4">
                    {t}Nom du produit d'anesthésie :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="anesthesie_produit_libelle" class="form-control" name="anesthesie_produit_libelle"
                        type="text" value="{$data.anesthesie_produit_libelle}" required autofocus />

                </div>
            </div>
            <div class="form-group">
                <label for="cactif_0" class="control-label col-md-4">{t}Actif ?{/t}</label>
                <div class="col-md-8">
                    <label class="radio-inline">
                        <input id="" type="radio" id="cactif_0" name="anesthesie_produit_actif" value="1" {if
                            $data.anesthesie_produit_actif==1} checked{/if}>{t}oui{/t}
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="cactif_1" name="anesthesie_produit_actif" value="0" {if
                            $data.anesthesie_produit_actif==0} checked{/if}>{t}non{/t}
                    </label>
                </div>
            </div>
            <div class="form-group"></div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.anesthesie_produit_id > 0 && $rights["paramAdmin"] == 1 }
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>