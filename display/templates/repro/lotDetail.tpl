<div class="form-display">
    <dl class="dl-horizontal">
        <dt>{t}Lot :{/t}</dt>
        <dd>{$dataLot.lot_nom}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>{t}Séquence de reproduction :{/t}</dt>
        <dd>{$dataLot.annee}/{$dataLot.site_name}
            {$dataLot.sequence_nom} {$dataLot.croisement_nom}</dd>
    </dl>
    {if $dataLot.vie_modele_id > 0}
    <dl class="dl-horizontal">
        <dt>{t}Marquage VIE le{/t}</dt>
        <dd>{$dataLot.vie_date_marquage}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>{t}modèle :{/t}</dt>
        <dd>{$dataLot.couleur}, {$dataLot.vie_implantation_libelle}, {$dataLot.vie_implantation_libelle2}</dd>
    </dl>
    {/if}
    <dl class="dl-horizontal">
        <dt>{t}Reproducteurs :{/t}</dt>
        <dd>{$dataLot.parents}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>{t}Date d'éclosion :{/t}</dt>
        <dd>{$dataLot.eclosion_date}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>{t}Nbre de larves estimé / compté :{/t}</dt>
        <dd>{$dataLot.nb_larve_initial} / {$dataLot.nb_larve_compte}</dd>
    </dl>
</div>