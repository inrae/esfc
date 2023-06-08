<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="canomalie_dbList" data-tabicon="okanomalie">
    <thead>
        <tr>
            {if $droits["poissonAdmin"] == 1}
            <th>{t}Modif{/t}</th>
            {/if}
            <th>{t}Événement associé{/t}</th>
            <th>{t}Type d'anomalie{/t}</th>
            <th>{t}Date{/t}</th>
            <th>{t}Commentaire{/t}</th>
            <th>{t}Date de traitement{/t}</th>
            <th>{t}État{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$dataAnomalie}
        <tr>
            {if $droits["poissonAdmin"] == 1}
            <td>
                <div class="center">
                    <a href="index.php?module=anomalieChange&anomalie_db_id={$dataAnomalie[lst].anomalie_db_id}&poisson_id={$dataAnomalie[lst].poisson_id}&module_origine=poissonDisplay">
                        <img src="display/images/edit.gif" height="20">
                    </a>
                </div>
            </td>
            {/if}
            <td>
                {if $dataAnomalie[lst].evenement_id > 0 && $droits["poissonGestion"] == 1}
                <a
                    href="index.php?module=evenementChange&poisson_id={$dataAnomalie[lst].poisson_id}&evenement_id={$dataAnomalie[lst].evenement_id}">
                    {$dataAnomalie[lst].evenement_type_libelle}
                </a>
                {else}
                {$dataAnomalie[lst].evenement_type_libelle}
                {/if}
            </td>
            <td>{$dataAnomalie[lst].anomalie_db_type_libelle}</td>
            <td>{$dataAnomalie[lst].anomalie_db_date}</td>
            <td>{$dataAnomalie[lst].anomalie_db_commentaire}</td>
            <td>{$dataAnomalie[lst].anomalie_db_date_traitement}</td>
            <td>
                <div class="center">
                    {if $dataAnomalie[lst].anomalie_db_statut == 1}
                    <img src="display/images/ok_icon.png" height="20">
                    {else}
                    <img src="display/images/cross.png" height="20">
                    {/if}
                </div>
            </td>
        </tr>
        {/section}
    </tbody>
</table>