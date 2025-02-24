<h2>{t}Zones d'implantation des bassins{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="bassinZoneChange?bassin_zone_id=0">
    Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cbassinZoneList" class="tableliste">
    <thead>
        <tr>
            <th>{t}libellé{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td>
                {if $rights["paramAdmin"] == 1}
                <a href="bassinZoneChange?bassin_zone_id={$data[lst].bassin_zone_id}">
                    {$data[lst].bassin_zone_libelle}
                </a>
                {else}
                {$data[lst].bassin_zone_libelle}
                {/if}
            </td>
        </tr>
        {/section}
    </tbody>
</table>