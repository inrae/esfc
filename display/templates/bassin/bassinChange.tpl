<h2>{t}Modification d'un bassin{/t}</h2>
<a href="index.php?module={$bassinParentModule}">
    {t}Retour à la liste des bassins{/t}
</a>
{if $data.bassin_id > 0}
>
<a href="index.php?module=bassinDisplay&bassin_id={$data.bassin_id}">{t}Retour au bassin{/t}</a>
{/if}
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="bassinform" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="bassin">
            <input type="hidden" name="bassin_id" value="{$data.bassin_id}">
            <div class="form-group">
                <label for="cbassin_nom" class="control-label col-md-4"><span class="red">*</span>
                    {t}Nom du bassin :{/t}</label>
                <div class="col-md-8">
                    <input id="cbassin_nom" class="form-control" name="bassin_nom" value="{$data.bassin_nom}" size="20"
                        required>
                </div>
            </div>
            <div class="form-group">
                <label for="cbassin_description" class="control-label col-md-4">{t}Description :{/t}</label>
                <div class="col-md-8">
                    <input id="cbassin_description" class="form-control" name="bassin_description"
                        value="{$data.bassin_description}" size="20">
                </div>
            </div>

            <div class="form-group">
                <label for="cbassin_type_id" class="control-label col-md-4">{t}Type de bassin :{/t}</label>
                <div class="col-md-8">
                    <select class="form-control" id="cbassin_type_id" name="bassin_type_id">
                        <option value="" {if $bassinType[lst].bassin_type_id=="" }selected{/if}>
                            {t}Sélectionnez le type de bassin...{/t}
                        </option>
                        {section name=lst loop=$bassin_type}
                        <option value="{$bassin_type[lst].bassin_type_id}" {if
                            $bassin_type[lst].bassin_type_id==$data.bassin_type_id}selected{/if}>
                            {$bassin_type[lst].bassin_type_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="site_id" class="control-label col-md-4">{t}Site d'implantation :{/t}</label>
                <div class="col-md-8">
                    <select class="form-control" name="site_id">
                        <option value="" {if $data.site_id=="" }selected{/if}>{t}Sélectionnez le site...{/t}</option>
                        {section name=lst loop=$site}
                        <option value="{$site[lst].site_id}" {if $data.site_id==$site[lst].site_id}selected{/if}>
                            {$site[lst].site_name}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="cbassin_usage_id" class="control-label col-md-4">{t}Utilisation du bassin :{/t}</label>
                <div class="col-md-8">
                    <select class="form-control" id="cbassin_usage_id" name="bassin_usage_id">
                        <option value="" {if $bassin_usage[lst].bassin_usage_id=="" }selected{/if}>
                            {t}Sélectionnez l'utilisation du bassin...{/t}
                        </option>
                        {section name=lst loop=$bassin_usage}
                        <option value="{$bassin_usage[lst].bassin_usage_id}" {if
                            $bassin_usage[lst].bassin_usage_id==$data.bassin_usage_id}selected{/if}>
                            {$bassin_usage[lst].bassin_usage_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="cbassin_zone_id" class="control-label col-md-4">
                    {t}Zone d'implantation du bassin :{/t}
                </label>
                <div class="col-md-8">
                    <select class="form-control" id="cbassin_zone_id" name="bassin_zone_id">
                        <option value="" {if $bassin_zone[lst].bassin_zone_id=="" }selected{/if}>
                            {t}Sélectionnez la zone d'implantation du bassin...{/t}
                        </option>
                        {section name=lst loop=$bassin_zone}
                        <option value="{$bassin_zone[lst].bassin_zone_id}" {if
                            $bassin_zone[lst].bassin_zone_id==$data.bassin_zone_id}selected{/if}>
                            {$bassin_zone[lst].bassin_zone_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="ccircuit_eau_id" class="control-label col-md-4">{t}Circuit d'eau :{/t}</label>
                <div class="col-md-8">
                    <select class="form-control" id="ccircuit_eau_id" name="circuit_eau_id">
                        <option value="" {if $circuit_eau[lst].circuit_eau_id=="" }selected{/if}>
                            {t}Sélectionnez le circuit d'eau...{/t}
                        </option>
                        {section name=lst loop=$circuit_eau}
                        <option value="{$circuit_eau[lst].circuit_eau_id}" {if
                            $circuit_eau[lst].circuit_eau_id==$data.circuit_eau_id}selected{/if}>
                            {$circuit_eau[lst].circuit_eau_libelle}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="longueur" class="control-label col-md-4">{t}Longueur (en cm) :{/t}</label>
                <div class="col-md-8">
                    <input id="longueur" class="form-control taux" name="longueur" value="{$data.longueur}" />
                </div>
            </div>

            <div class="form-group">
                <label for="clargeur_diametre" class="control-label col-md-4">
                    {t}Largeur ou diamètre (en cm):{/t}
                </label>
                <div class="col-md-8">
                    <input id="clargeur_diametre" class="form-control nombre" name="largeur_diametre"
                        value="{$data.largeur_diametre}">
                </div>
            </div>

            <div class="form-group">
                <label for="csurface" class="control-label col-md-4">
                    {t}Surface (en cm2) :{/t}
                </label>
                <div class="col-md-8">
                    <input class="form-control nombre" id="csurface" name="surface" value="{$data.surface}">
                </div>
            </div>

            <div class="form-group">
                <label for="chauteur_eau" class="control-label col-md-4">{t}Hauteur d'eau (en cm) :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control nombre" id="chauteur_eau" name="hauteur_eau" value="{$data.hauteur_eau}">
                </div>
            </div>

            <div class="form-group">
                <label for="cvolume" class="control-label col-md-4">{t}Volume (en litres) :{/t}</label>
                <div class="col-md-8">
                    <input class="form-control nombre" id="cvolume" name="volume" value="{$data.volume}">
                </div>
            </div>

            <div class="form-group">
                <label for="cactif_0" class="control-label col-md-4">{t}Bassin en activité :{/t}</label>
                <div class="col-md-8">
                    <label class="radio-inline">
                        <input type="radio" id="cactif_0" name="actif" value="1" {if $data.actif==1}
                            checked{/if}>{t}oui{/t}
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="cactif_1" name="actif" value="0" {if $data.actif==0}
                            checked{/if}>{t}non{/t}
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label for="cmode" class="control-label col-md-4">{t}Mode de calcul de la masse :{/t}</label>
                <div class="col-md-8">
                    <label class="radio-inline">
                        <input type="radio" id="cmode_0" name="mode_calcul_masse" value="0" {if $data.mode_calcul_masse==0}
                            checked{/if}>{t}Calcul global{/t}
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="cmode_1" name="mode_calcul_masse" value="1" {if $data.mode_calcul_masse==1}
                            checked{/if}>{t}Calcul par échantillonnage{/t}
                    </label>
                </div>
            </div>

            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.bassin_id > 0 &&$droits["bassinAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>