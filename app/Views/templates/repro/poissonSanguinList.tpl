<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="csanguin" data-tabicon="oksanguin">
    <thead>
        <tr>
            <th>{t}Date{/t}</th>
            <th>{t}Taux E2{/t}</th>
            <th>{t}Taux calcium{/t}</th>
            <th>{t}Taux hématocrite{/t}</th>
            <th>{t}Commentaire{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataSanguin}
        <tr>
            <td>
                {if $rights.reproGestion == 1}
                <a href="dosageSanguinChange?dosage_sanguin_id={$dataSanguin[lst].dosage_sanguin_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
                    {$dataSanguin[lst].dosage_sanguin_date}
                </a>
                {else}
                {$dataSanguin[lst].dosage_sanguin_date}
                {/if}
            </td>
            <td class="right">{$dataSanguin[lst].tx_e2}{$dataSanguin[lst].tx_e2_texte}</td>
            <td class="right">{$dataSanguin[lst].tx_calcium}</td>
            <td class="right">{$dataSanguin[lst].tx_hematocrite}</td>
            <td>{$dataSanguin[lst].dosage_sanguin_commentaire}</td>
        </tr>
        {/section}
    </tbody>
</table>