{if $droits["reproGestion"] == 1}
<a
    href="index.php?module=spermeCongelationChange&sperme_congelation_id=0&sperme_id={$data.sperme_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
    {t}Nouvelle congélation de sperme...{/t}
</a>
{/if}
<table class="table table-bordered table-hover datatable-nopaging-nosearching" id="csperme">
    <thead>
        <tr>
            <th>{t}Date de congélation{/t}</th>
            <th>{t}Volume total (ml){/t}</th>
            <th>{t}Volume sperme (ml){/t}</th>
            <th>{t}Nb paillettes{/t}</th>
            <th>{t}Nb visotubes{/t}</th>
            <th>{t}Dilueur{/t}</th>
            <th>{t}Conservateur{/t}</th>
            <th>{t}Nb paillettes utilisées{/t}</th>
            <th>{t}Volume par paillette{/t}</th>
            <th>{t}Opérateur{/t}</th>
            <th>{t}Remarque{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$congelation}
        <tr>
            <td class="nowrap">
                {if $droits["reproGestion"] == 1}
                <a
                    href="index.php?module=spermeCongelationChange&sperme_congelation_id={$congelation[lst].sperme_congelation_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}&sperme_id={$congelation[lst].sperme_id}">
                    {$congelation[lst].congelation_date}
                </a>
                {else}
                {$congelation[lst].congelation_date}
                {/if}
            </td>
            <td class="center">
                {$congelation[lst].congelation_volume}</td>
            <td class="center">{$congelation[lst].volume_sperme}</td>
            <td class="center">{$congelation[lst].nb_paillette}</td>
            <td class="center">{$congelation[lst].nb_visotube}</td>
            <td>{$congelation[lst].sperme_dilueur_libelle} : {$congelation[lst].volume_dilueur} ml</td>
            <td>{$congelation[lst].sperme_conservateur_libelle} : {$congelation[lst].volume_conservateur} ml</td>
            <td>{$congelation[lst].nb_paillettes_utilisees}</td>
            <td class="center">{$congelation[lst].paillette_volume}</td>
            <td>{$congelation[lst].operateur}</td>
            <td>{$congelation[lst].sperme_congelation_commentaire}</td>
        </tr>
        {/section}
    </tbody>
</table>