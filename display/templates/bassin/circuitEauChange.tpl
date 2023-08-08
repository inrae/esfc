<h2>{t}Modification du nom d'un circuit d'eau{/t}</h2>

<a href="index.php?module=circuitEauList">{t}Retour à la liste des circuits d'eau{/t}</a>
{if $data.circuit_eau_id > 0 }
> <a href="index.php?module=circuitEauDisplay&circuit_eau_id={$data.circuit_eau_id}">
    {t}Retour au détail du circuit d'eau{/t}
</a>
{/if}

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="cmxform" method="post" action="index.php">
            <input type="hidden" name="action" value="Write">
            <input type="hidden" name="moduleBase" value="circuitEau">
            <input type="hidden" name="circuit_eau_id" value="{$data.circuit_eau_id}">
            <div class="form-group">
                <label for="site_id" class="control-label col-md-4">
                    {t}Nom du circuit d'eau :{/t}<span class="red">*</span>
                </label>
                <div class="col-md-8">
                    <input class="form-control" id="ccircuit_eau_libelle" name="circuit_eau_libelle" type="text"
                        value="{$data.circuit_eau_libelle}" required autofocus />
                </div>
            </div>

            <div class="form-group">
                <label for="site_id" class="control-label col-md-4">{t}Site d'implantation :{/t}</label>
                <div class="col-md-8">
                    <select class="form-control" name="site_id">
                        <option value="" {if $data.site_id=="" }selected{/if}>
                            {t}Sélectionnez le site...{/t}
                        </option>
                        {section name=lst loop=$site}
                        <option value="{$site[lst].site_id}" {if $data.site_id==$site[lst].site_id}selected{/if}>
                            {$site[lst].site_name}
                        </option>
                        {/section}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="actif1" class="control-label col-md-4">
                    {t}Circuit d'eau en service ?{/t}
                </label>
                <div class="col-md-8">
                    <input id="actif1" type="radio" name="circuit_eau_actif" value="1" {if $data.circuit_eau_actif==1
                        ||$data.circuit_eau_actif=="" }checked{/if}>
                    {t}oui{/t}
                    <input id="actif0" type="radio" name="circuit_eau_actif" value="0" {if
                        $data.circuit_eau_actif==0}checked{/if}>
                    {t}non{/t}
                </div>
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.circuit_eau_id > 0 &&$droits["bassinAdmin"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
        </form>
    </div>
</div>


<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>