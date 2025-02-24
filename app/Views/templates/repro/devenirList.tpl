
<table class="table table-bordered table-hover datatable-nopaging-nosearching display" id="devenirList" data-order='[[1,"asc"],[2,"asc"]]'>
    <thead>
        <tr>
            {if $rights["reproGestion"] == 1}
            <th class="center">
                <img src="display/images/edit.gif" height="25">
            </th>
            {/if}
            <th>{t}N° de lot{/t}</th>
            <th>{t}Date{/t}</th>
            <th>{t}Destination{/t}</th>
            <th>{t}Nbre poissons{/t}</th>
            <th>{t}Destination parente{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataDevenir}
        <tr>
            {if $rights["reproGestion"] == 1}
            <td class="center">
                <a
                    href="devenir{$devenirOrigine}Change?devenir_id={$dataDevenir[lst].devenir_id}&devenirOrigine={$devenirOrigine}&lot_id={$dataDevenir[lst].lot_id}">
                    <img src="display/images/edit.gif" height="25">
                </a>
            </td>
            {/if}
            <td>{$dataDevenir[lst].site_name} - {$dataDevenir[lst].lot_nom}</td>
            <td>{$dataDevenir[lst].devenir_date}</td>
            <td>{$dataDevenir[lst].devenir_type_libelle}&nbsp;
                {$dataDevenir[lst].categorie_libelle}&nbsp;
                {$dataDevenir[lst].localisation}</td>
            <td class="right">{$dataDevenir[lst].poisson_nombre}</td>
            <td>
                {if strlen($dataDevenir[lst].devenir_date_parent)>0}
                {$dataDevenir[lst].devenir_date_parent}&nbsp;
                {$dataDevenir[lst].devenir_type_libelle_parent}&nbsp;
                {$dataDevenir[lst].categorie_libelle_parent}&nbsp;
                {$dataDevenir[lst].localisation_parent}&nbsp;
                ({$dataDevenir[lst].poisson_nombre_parent} poissons)
                {/if}
        </tr>
        {/section}
    </tbody>
</table>