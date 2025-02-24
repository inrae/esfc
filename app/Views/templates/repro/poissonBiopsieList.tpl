<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="cbiopsie" data-tabicon="okbiopsie">
    <thead>
        <tr>
            <th>{t}Date{/t}</th>
            <th>{t}Diam. moyen (écart-type){/t}</th>
            <th>{t}Taux OPI{/t}</th>
            <th>{t}Taux color normale{/t}</th>
            <th>{t}Taux éclatement{/t}</th>
            <th>{t}Ringer T50 (heures){/t}</th>
            <th>{t}Ringer Tmax en heures{/t}</th>
            <th>{t}Ringer commentaire{/t}</th>
            <th>{t}Leib T50 (heures){/t}</th>
            <th>{t}Leib Tmax en heures{/t}</th>
            <th>{t}Leib commentaire{/t}</th>
            <th>{t}Commentaire général{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataBiopsie}
        <tr>
            <td>
                {if $rights.reproGestion == 1}
                <a href="biopsieChange?biopsie_id={$dataBiopsie[lst].biopsie_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
                    {$dataBiopsie[lst].biopsie_date}
                </a>
                {else}
                {$dataBiopsie[lst].biopsie_date}
                {/if}
            </td>
            <td>
                {$dataBiopsie[lst].diam_moyen}
                {if strlen($dataBiopsie[lst].diametre_ecart_type) > 0}
                ( {$dataBiopsie[lst].diametre_ecart_type})
                {/if}
                {if strlen($dataBiopsie[lst].biopsie_technique_calcul_libelle) > 0}

                {$dataBiopsie[lst].biopsie_technique_calcul_libelle}
                {/if}
            </td>
            <td class="right">{$dataBiopsie[lst].tx_opi}</td>
            <td class="right">{$dataBiopsie[lst].tx_coloration_normal}</td>
            <td class="right">{$dataBiopsie[lst].tx_eclatement}</td>
            <td class="center">{$dataBiopsie[lst].ringer_t50}</td>
            <td>
                {$dataBiopsie[lst].ringer_tx_max}
                {if strlen($dataBiopsie[lst].ringer_duree) > 0}
                {t}en{/t} {$dataBiopsie[lst].ringer_duree}
                {/if}
            </td>
            <td>{$dataBiopsie[lst].ringer_commentaire}</td>
            <td class="center">{$dataBiopsie[lst].leibovitz_t50}</td>
            <td>
                {$dataBiopsie[lst].leibovitz_tx_max}
                {if strlen($dataBiopsie[lst].leibovitz_duree) > 0}
                {t}en{/t} {$dataBiopsie[lst].leibovitz_duree}
                {/if}
            </td>
            <td>{$dataBiopsie[lst].leibovitz_commentaire}</td>
            <td>{$dataBiopsie[lst].biopsie_commentaire}</td>
        </tr>
        {/section}
    </tbody>
</table>