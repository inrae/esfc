<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="csequence" data-tabicon="oksequence">
    <thead>
        <tr>
            <th>{t}Données générales de reproduction{/t}</th>
            <th>{t}Nom du poisson{/t}</th>
            <th>{t}Sexe{/t}</th>
            <th>{t}Qualité semence{/t}</th>
            <th>{t}Masse totale des ovocytes{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataPoissons}
        <tr>
            <td class="center">
                <a
                    href="poissonCampagneDisplay?poisson_campagne_id={$dataPoissons[lst].poisson_campagne_id}">
                    <img src="display/images/fish.png" height="25" title="Données de reproduction pour la campagne">
                </a>
            <td>
                <a
                    href="poissonSequenceChange?poisson_sequence_id={$dataPoissons[lst].poisson_sequence_id}&sequence_id={$dataPoissons[lst].sequence_id}&poisson_campagne_id={$dataPoissons[lst].poisson_campagne_id}">
                    {$dataPoissons[lst].matricule} {$dataPoissons[lst].prenom} {$dataPoissons[lst].pittag_valeur}
                </a>
            </td>
            <td class="center">{$dataPoissons[lst].sexe_libelle_court}</td>
            <td>{$dataPoissons[lst].qualite_semence}</td>
            <td class="right">{$dataPoissons[lst].ovocyte_masse}</td>
        </tr>
        {/section}
    </tbody>
</table>