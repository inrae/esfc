{if $droits.reproGestion == 1}
<a
    href="index.php?module=spermeMesureChange&sperme_mesure_id=0&sperme_id={$data.sperme_id}&sperme_congelation_id={$data.sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    {t}Nouvelle analyse...{/t}
</a>
{/if}
<table class="table table-bordered table-hover datatable-nopaging-nosearching" id="spermeMesureList">
    <thead>
        <tr>
            <th>{t}Date{/t}</th>
            <th>{t}Qualité{/t}</th>
            <th>{t}Concentration (milliard/mL){/t}</th>
            <th>{t}Motilité initiale{/t}</th>
            <th>{t}Tx survie initial{/t}</th>
            <th>{t}Motilité 60"{/t}</th>
            <th>{t}Tx survie 60"{/t}</th>
            <th>{t}Temps survie{/t}</th>
            <th>{t}pH{/t}</th>
            <th>{t}Nbre paillettes utilisées{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataMesure}
        <tr>
            <td>
                {if $droits.reproGestion == 1}
                <a
                    href="index.php?module=spermeMesureChange&sperme_mesure_id={$dataMesure[lst].sperme_mesure_id}&sperme_id={$data.sperme_id}&sperme_congelation_id={$dataMesure[lst].sperme_congelation_id}&poisson_campagne_id={$data.poisson_campagne_id}">
                    {$dataMesure[lst].sperme_mesure_date}
                </a>
                {else}
                {$dataMesure[lst].sperme_mesure_date}
                {/if}
            </td>
            <td>{$dataMesure[lst].sperme_qualite_libelle}</td>
            <td class="center">{$dataMesure[lst].concentration}</td>
            <td class="center">{$dataMesure[lst].motilite_initiale}</td>
            <td class="center">{$dataMesure[lst].tx_survie_initial}</td>
            <td class="center">{$dataMesure[lst].motilite_60}</td>
            <td class="center">{$dataMesure[lst].tx_survie_60}</td>
            <td class="center">{$dataMesure[lst].temps_survie}</td>
            <td class="center">{$dataMesure[lst].sperme_ph}</td>
            <td class="center">{$dataMesure[lst].nb_paillette_utilise}</td>
        </tr>
        {/section}
    </tbody>
</table>