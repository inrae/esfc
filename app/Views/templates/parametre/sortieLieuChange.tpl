<h2>{t}Modification d'un lieu de lâcher/destination{/t}</h2>

<a href="sortieLieuList">{t}Retour à la liste{/t}</a>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="sortieLieuForm" method="post" action="sortieLieuWrite">
            
            <input type="hidden" name="moduleBase" value="sortieLieu">
            <input type="hidden" name="sortie_lieu_id" value="{$data.sortie_lieu_id}">
            <div class="form-group">
                <label for="localisation" class="control-label col-md-4">
                    {t}Nom du lieu :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input id="localisation" class="form-control" name="localisation" value="{$data.localisation}"
                        autofocus>
                </div>
            </div>
            <div class="form-group">
                <label for="longitude_dd" class="control-label col-md-4">
                    {t}Longitude (coord. décimales, WGS84) :{/t}</label>
                <div class="col-md-8">
                    <input id="longitude_dd" class="form-control taux" name="longitude_dd" value="{$data.longitude_dd}"
                        title="Nombre décimal">
                </div>
            </div>
            <div class="form-group">
                <label for="latitude_dd" class="control-label col-md-4">
                    {t}Latitude (coord. décimales, WGS84) :{/t}</label>
                <div class="col-md-8">
                    <input id="latitude_dd" class="form-control" name="latitude_dd taux" value="{$data.latitude_dd}"
                        title="Nombre décimal">
                </div>
            </div>
            <div class="form-group">
                <label for="poisson_statut_id" class="control-label col-md-4">
                    {t}Statut pris par le poisson :{/t}
                </label>
                <div class="col-md-8">
                    <select id="poisson_statut_id" class="form-control" name="poisson_statut_id">
                        {section name=lst loop=$poissonStatut}
                        <option value={$poissonStatut[lst].poisson_statut_id} {if
                            $poissonStatut[lst].poisson_statut_id==$data.poisson_statut_id} selected {/if}>
                            {$poissonStatut[lst].poisson_statut_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">
                    {t}Lieu actuellement utilisé ?{/t}
                </label>
                <div class="col-md-8">
                    <label class="label-inline">
                        <input id="actif0" type="radio" name="actif" value="0" {if
                            $data.actif==0}checked{/if}>
                        {t}non{/t}
                    </label>
                    <label class="label-inline">
                        <input id="actif1" type="radio" name="actif" value="1" {if $data.actif==1}checked{/if}>
                        {t}oui{/t}
                    </label>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.sortie_lieu_id > 0 &&$rights["paramAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        {$csrf}</form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>