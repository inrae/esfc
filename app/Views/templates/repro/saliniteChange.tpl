<a href="{$bassinParentModule}">Retour à la liste des bassins</a>
> <a href="bassinCampagneDisplay?bassin_campagne_id={$data.bassin_campagne_id}">Retour au bassin</a>
{include file="bassin/bassinDetail.tpl"}
<h2>{t}profil thermique du bassin{/t}</h2>

<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal" id="saliniteForm" method="post" action="saliniteWrite">
            <input type="hidden" name="moduleBase" value="salinite">
            <input type="hidden" name="salinite_id" value="{$data.salinite_id}">
            <input type="hidden" name="bassin_campagne_id" value="{$data.bassin_campagne_id}">
            <input type="hidden" name="bassin_id" value="{$dataBassin.bassin_id}">
            <input type="hidden" name="circuit_eau_id" value="{$dataBassin.circuit_eau_id}">
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Date/heure :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="" class="form-control" class="datetimepicker" name="salinite_datetime" required
                        value="{$data.salinite_datetime}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Taux de salinité :{/t}<span class="red">*</span></label>
                <div class="col-md-8">
                    <input id="" class="form-control" class="taux" name="salinite_tx" required
                        value="{$data.salinite_tx}">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="control-label col-md-4">{t}Type :{/t}</label>
                <dd>prévu
                    <input type="radio" {if $data.profil_thermique_type_id==2 || $data.profil_thermique_type_id==""
                        }checked{/if} name="profil_thermique_type_id" value="2">
                    &nbsp;constaté
                    <input type="radio" disabled {if $data.profil_thermique_type_id==1}checked{/if}
                        name="profil_thermique_type_id" value="1">
            </div>
            <div class="form-group center">
                <button type="submit" class="btn btn-primary button-valid">{t}Valider{/t}</button>
                {if $data.salinite_id > 0 &&$rights["reproGestion"] == 1}
                <button class="btn btn-danger button-delete">{t}Supprimer{/t}</button>
                {/if}
            </div>
            {$csrf}
        </form>
    </div>
</div>
<span class="red">*</span><span class="messagebas">{t}Champ obligatoire{/t}</span>
<br>

<a href="saliniteNew&bassin_campagne_id={$data.bassin_campagne_id}">
    Nouvelle donnée...
</a>
<br>

{include file="repro/saliniteList.tpl"}