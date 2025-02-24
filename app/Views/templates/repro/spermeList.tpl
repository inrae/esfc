<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="csperme" data-tabicon="oksperme">
    <thead>
        <tr>
            <th>{t}Date/heure du prélèvement{/t}</th>
            <th>{t}Séquence{/t}</th>
            <th>{t}Aspect / Qualité estimée{/t}</th>
            <th>{t}Motilité initiale{/t}</th>
            <th>{t}Tx survie initial{/t}</th>
            <th>{t}Motilité 60"{/t}</th>
            <th>{t}Tx survie 60"{/t}</th>
            <th>{t}Temps survie à 5% (en sec.){/t}</th>
            <th>{t}pH{/t}</th>
            <th>{t}Date mesure{/t}</th>
            <th>{t}Date congélation{/t}</th>
            <th>{t}Remarque{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$spermes}
        <tr>
            <td>
                {if $rights["reproGestion"] == 1}
                <a
                    href="spermeChange?sperme_id={$spermes[lst].sperme_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
                    {$spermes[lst].sperme_date}
                </a>
                {else}
                {$spermes[lst].sperme_date}
                {/if}
            </td>
            <td>{$spermes[lst].sequence_nom}</td>
            <td>
                {$spermes[lst].sperme_aspect_libelle} /
                {$spermes[lst].sperme_qualite_libelle}</td>
            <td class="center">{$spermes[lst].motilite_initiale}</td>
            <td class="right">{$spermes[lst].tx_survie_initial}</td>
            <td class="center">{$spermes[lst].motilite_60}</td>
            <td class="right">{$spermes[lst].tx_survie_60}</td>
            <td class="right">{$spermes[lst].temps_survie}</td>
            <td class="right">{$spermes[lst].sperme_ph}</td>
            <td>{$spermes[lst].sperme_mesure_date}</td>
            <td>{$spermes[lst].congelation_dates}</td>
            <td>{$spermes[lst].sperme_commentaire}</td>
        </tr>
        {/section}
    </tbody>
</table>