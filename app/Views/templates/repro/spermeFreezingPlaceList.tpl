{if $rights["reproGestion"] == 1}
<a
    href="spermeFreezingPlaceChange?sperme_freezing_place_id=0&sperme_congelation_id={$data.sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    {t}Nouvel emplacement de congélation...{/t}
</a>
{/if}
<table class="table table-bordered table-hover datatable-nopaging-nosearching display" id="emplacementCongelationId">
    <thead>
        <tr>
            <th>{t}Cuve{/t}</th>
            <th>{t}Numéro canister{/t}</th>
            <th>{t}Position canister{/t}</th>
            <th>{t}Nb visotubes{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$place}
        <tr>
            <td>
                {if $rights["reproGestion"] == 1}
                <a
                    href="spermeFreezingPlaceChange?sperme_freezing_place_id={$place[lst].sperme_freezing_place_id}&sperme_congelation_id={$data.sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
                    {$place[lst].cuve_libelle}
                </a>
                {else}
                {$place[lst].cuve_libelle}
                {/if}
            </td>
            <td class="center">
                {$place[lst].canister_numero}
            </td>
            <td class="center">{if $place[lst].position_canister == 1}{t}bas{/t}{/if}
                {if $place[lst].position_canister == 2}{t}haut{/t}{/if}
            </td>
            <td class="center">
                {$place[lst].nb_visotube}
            </td>
        </tr>
        {/section}
    </tbody>
</table>