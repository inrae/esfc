{if $devenirOrigine == "lot"}
<a href="lotList">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des lots{/t}
</a>&nbsp;
<a href="lotDisplay?lot_id={$data.lot_id}">
    <img src="display/images/fishlot.svg" height="25">
    {t}Retour au lot{/t}
    {$dataLot.lot_nom} {$dataLot.annee}/{$dataLot.site_name}
    {$dataLot.sequence_nom} {$dataLot.croisement_nom}
</a>
{else}
<a href="devenirList">
    <img src="display/images/right-arrow.png" height="25">
    {t}Retour à la liste des lâchers et entrées dans le stock{/t}
</a>
{/if}
<h2>{t}Saisie de la destination d'une reproduction{/t}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="devenirForm" method="post" action="devenir{$devenirOrigine}Write"
            enctype="multipart/form-data">
            <input type="hidden" name="moduleBase" value="devenir{$devenirOrigine}">
            <input type="hidden" name="devenir_id" value="{$data.devenir_id}">
            <input type="hidden" name="lot_id" value="{$data.lot_id}">
            <input type="hidden" name="devenirOrigine" value="{$devenirOrigine}">
            <div class="form-group">
                <label for="devenir_date" class="control-label col-md-4">
                    {t}Date :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="devenir_date" class="form-control datepicker" name="devenir_date" required
                        value="{$data.devenir_date}">
                </div>
            </div>
            <div class="form-group">
                <label for="parent_devenir_id" class="control-label col-md-4">
                    {t}Destination parente :{/t}
                </label>
                <div class="col-md-8">
                    <select id="parent_devenir_id" class="form-control" name="parent_devenir_id">
                        <option value="" {if $data.parent_devenir_id="" }selected{/if}{t}Sélectionnez...{/t}/option>
                            {section name=lst loop=$devenirParent}
                        <option value="{$devenirParent[lst].devenir_id}" {if
                            $devenirParent[lst].devenir_id==$data.devenir_id}selected{/if}>
                            {$devenirParent[lst].devenir_date} {$devenirParent[lst].devenir_type_libelle}
                            {$devenirParent[lst].categorie_libelle}
                            {$devenirParent[lst].localisation} {$devenirParent[lst].poisson_nombre}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="devenir_type_id" class="control-label col-md-4">
                    {t}Nature:{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="devenir_type_id" class="form-control" name="devenir_type_id">
                        {section name=lst loop=$devenirType}
                        <option value="{$devenirType[lst].devenir_type_id}" {if
                            $devenirType[lst].devenir_type_id==$data.devenir_type_id}selected{/if}>
                            {$devenirType[lst].devenir_type_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="categorie_id" class="control-label col-md-4">
                    {t}Stade biologique :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <select id="categorie_id" class="form-control" name="categorie_id">
                        {section name=lst loop=$categories}
                        <option value="{$categories[lst].categorie_id}" {if
                            $categories[lst].categorie_id==$data.categorie_id}selected{/if}>
                            {$categories[lst].categorie_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="sortie_lieu_id" class="control-label col-md-4">
                    {t}Lieu de lâcher :{/t}
                </label>
                <div class="col-md-8">
                    <select id="sortie_lieu_id" class="form-control" name="sortie_lieu_id">
                        <option value="" {if $data.sortie_lieu_id=="" }selected{/if}>
                            {section name=lst loop=$sorties}
                        <option value="{$sorties[lst].sortie_lieu_id}" {if
                            $sorties[lst].sortie_lieu_id==$data.sortie_lieu_id}selected{/if}>
                            {$sorties[lst].localisation}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="poisson_nombre" class="control-label col-md-4">
                    {t}Nombre de poissons concernés :{/t}
                </label>
                <div class="col-md-8">
                    <input id="poisson_nombre" class="form-control nombre" name="poisson_nombre"
                        value="{$data.poisson_nombre}">
                </div>
            </div>
            <fieldset>
                <legend>{t}Création des poissons à partir d'une liste CSV{/t}</legend>
                <div class="form-group">
                    <label for="poissonListe" class="control-label col-md-4">
                        {t}Fichier CSV contenant les poissons à créer :{/t}
                    </label>
                    <div class="col-md-8">
                        <input type="file" id="poissonListe" name="poissons" accept=".csv, .txt" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label for="separator" class="control-label col-md-4">{t}Séparateur utilisé :{/t}</label>
                    <div class="col-md-8">
                        <select id="separator" name="separator" class="form-control">
                            <option value=",">{t}Virgule{/t}</option>
                            <option value=";">{t}Point-virgule{/t}</option>
                            <option value="tab">{t}Tabulation{/t}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="utf8_encode" class="control-label col-md-4">{t}Encodage du fichier :{/t}</label>
                    <div class="col-md-8">
                        <select class="form-control" id="utf8_encode" name="utf8_encode">
                            <option value="0" {if $utf8_encode==0}selected{/if}>UTF-8</option>
                            <option value="1" {if $utf8_encode==1}selected{/if}>ISO-8859-x</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="bassin_destination" class="control-label col-md-4">
                        {t}Bassin de destination (le cas échéant) :{/t}
                    </label>
                    <div class="col-md-8">
                        <select id="bassin_destination" name="bassin_destination" class="form-control">
                            <option value="" selected></option>
                            {foreach $bassins as $bassin}
                            <option value="{$bassin.bassin_id}">
                                {$bassin.bassin_nom}
                            </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </fieldset>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.devenir_id > 0 &&$rights["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>

</div>
<div class="row">
    <div class="col-md-6 bg-info">
        <b>{t}Contenu du fichier contenant les poissons à créer :{/t}</b>
        <ul>
            <li>{t}pittag : pittag principal du poisson, utilisé pour l'identifier (obligatoire){/t}</li>
            <li>{t}pittag_type_id : identifiant du type de pittag (consultez la table de paramètres correspondante){/t}
            </li>
            <li>{t}tag : second pittag posé (acoustique par exemple){/t}</li>
            <li>{t}tag_type_id : identifiant du type du second pittag posé{/t}</li>
            <li>{t}longueur_totale : longueur totale du poisson, en cm{/t}</li>
            <li>{t}longueur_fourche : longueur à la fourche du poisson, en cm{/t}</li>
            <li>{t}masse : poids du poisson, en grammes{/t}</li>
            <li>{t}commentaire : texte libre{/t}</li>
        </ul>
        <u>{t}Le fichier ne doit être fourni qu'une seule fois, sinon vous créerez des doublons !{/t}</u>
        <br>
        {t}Si le fichier est fourni, le programme va créer les poissons et les événements correspondants (morphologie,
        sortie, transfert, etc.){/t}
    </div>
</div>

<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>