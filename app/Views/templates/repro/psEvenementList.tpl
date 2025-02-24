<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="cpsEvenement" data-tabicon="okevent">
    <thead>
        <tr>
            <th>{t}Séquence{/t}</th>
            <th>{t}Date{/t}</th>
            <th>{t}Libellé{/t}</th>
            <th>{t}Commentaire{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataPsEvenement}
        <tr>
            <td>
                <a
                    href="poissonSequenceChange?poisson_sequence_id={$dataPsEvenement[lst].poisson_sequence_id}&sequence_id={$dataSequence[lst].sequence_id}&poisson_campagne_id={$dataSequence[lst].poisson_campagne_id}">
                    {$dataPsEvenement[lst].sequence_nom}
                </a>
            </td>
            <td>{$dataPsEvenement[lst].ps_datetime}</td>
            <td>{$dataPsEvenement[lst].ps_libelle}</td>
            <td>{$dataPsEvenement[lst].ps_commentaire}</td>
        </tr>
        {/section}
    </tbody>
</table>