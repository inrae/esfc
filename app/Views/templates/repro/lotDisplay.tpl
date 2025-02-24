<a href="lotList">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des lots{/t}
</a>
<h2>{t}Détail du lot{/t} {$dataLot.lot_nom} {$dataLot.eclosion_date}</h2>

{if $rights.reproGestion == 1}
<a href="lotChange?lot_id={$dataLot.lot_id}">
    {t}Modifier le lot...{/t}
</a>
{/if}
<div class="row">
    <div class="col-md-6">
        {include file="repro/lotDetail.tpl"}
        <fieldset>
            <legend>{t}Lots dérivés{/t}</legend>
            {include file="repro/sublotList.tpl"}
        </fieldset>
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Devenir du lot{/t}</legend>
            {if $rights["reproGestion"] == 1}
            <a
                href="devenir{$devenirOrigine}Change?devenir_id=0{if $dataLot.lot_id > 0}&lot_id={$dataLot.lot_id}{else}&lot_id=0{/if}&devenirOrigine={$devenirOrigine}">
                {t}Nouvelle destination (lâcher, entrée dans le stock captif, etc.){/t}
            </a>
            {/if}
            {include file="repro/devenirList.tpl"}
        </fieldset>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Comptages et mesures{/t}</legend>
            {include file="repro/lotMesureList.tpl"}
        </fieldset>
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Bassins utilisés{/t}</legend>
            {include file="repro/bassinLotList.tpl"}
        </fieldset>
    </div>
</div>