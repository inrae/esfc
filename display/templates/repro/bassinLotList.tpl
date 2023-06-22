{if $droits["reproGestion"] == 1}
<a href="index.php?module=bassinLotChange&bassin_lot_id=0&lot_id={$dataLot.lot_id}">
    Nouvelle affectation de bassin...
</a>
{/if}

<table class="table table-bordered table-hover datatable" id="cBassinLot" class="tableliste">
    <thead>
        <tr>
            <th>{t}Date de début d'utilisation{/t}</th>
            <th>{t}Nom du bassin{/t}</th>
            <th>{t}Date de fin d'utilisation{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$bassinLot}
        <tr>
            <td class="center">
                {if $droits["reproGestion"] == 1}
                <a href="index.php?module=bassinLotChange&bassin_lot_id={$bassinLot[lst].bassin_lot_id}">
                    {$bassinLot[lst].bl_date_arrivee}
                </a>
                {else}
                {$bassinLot[lst].bl_date_arrivee}
                {/if}
            </td>
            <td>{$bassinLot[lst].bassin_nom}</td>
            <td>{$bassinLot[lst].bl_date_depart}</td>
        </tr>
        {/section}
    </tbody>
</table>