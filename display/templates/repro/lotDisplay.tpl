<a href="index.php?module=lotList">
    <img src="display/images/list.png" height="25">
    {t}Retour à la liste des lots{/t}
</a>
<h2>{t}Détail du lot{/t} {$dataLot.lot_nom} {$dataLot.eclosion_date}</h2>

{if $droits.reproGestion == 1}
<a href="index.php?module=lotChange&lot_id={$dataLot.lot_id}">
    {t}Modifier le lot...{/t}
</a>
{/if}
<div class="row">
    <div class="col-md-6">
        {include file="repro/lotDetail.tpl"}
    </div>
    <div class="col-md-6">
        <fieldset>
            <legend>{t}Devenir du lot{/t}</legend>
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