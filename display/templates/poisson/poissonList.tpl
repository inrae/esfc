{include file="poisson/poissonSearch.tpl"}
{if $isSearch == 1}
{if $droits.poissonGestion == 1}
<div class="row">
    <a href="index.php?module=poissonChange&poisson_id=0">{t}Nouveau poisson...{/t}</a>
</div>
{/if}
<div class="row">
    <a href="index.php?module=evenementGetAllCSV">
        {t}Liste de tous les événements pour les poissons sélectionnés au format CSV{/t}
    </a>
</div>

<table class="table table-bordered table-hover datatable-export-paging" id="cpoissonList" class="tableliste">
    <thead>
        <tr>
            <th>{t}Id{/t}</th>
            <th>{t}(Pit)tag{/t}</th>
            <th>{t}Matricule{/t}</th>
            <th>{t}Prénom{/t}</th>
            <th>{t}Sexe{/t}</th>
            <th>{t}Statut{/t}</th>
            <th>{t}Cohorte{/t}</th>
            <th>{t}Date de capture /naissance{/t}</th>
            <th>{t}Date de mortalité{/t}</th>
            {if $poissonSearch.displayBassin == 1}
            <th>{t}Bassin{/t}</th>
            {/if}
            {if $poissonSearch.displayMorpho == 1}
            <th>{t}Masse{/t}</th>
            <th>{t}Long fourche{/t}</th>
            <th>{t}Long totale{/t}</th>
            {/if}
            {if $poissonSearch.displayCumulTemp == 1}
            <th>{t}Température cumulée (bassin){/t}</th>
            {/if}
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td><a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].poisson_id}
                </a>
            </td>
            <td>
                <a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].pittag_valeur}
                </a>
            </td>
            <td>
                <a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].matricule}
                </a>
            </td>
            <td>
                <a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].prenom}
                </a>
            </td>
            <td class="center">{$data[lst].sexe_libelle_court}</td>
            <td>{$data[lst].categorie_libelle} {$data[lst].poisson_statut_libelle}</td>
            <td class="center">{$data[lst].cohorte}</td>
            <td class="center">{$data[lst].capture_date}{$data[lst].date_naissance}</td>
            <td class="center">{$data[lst].mortalite_date}</td>
            {if $poissonSearch.displayBassin == 1}
            <td>
                {if $data[lst].bassin_id > 0}
                <a href=index.php?module=bassinDisplay&bassin_id={$data[lst].bassin_id}>
                    {$data[lst].bassin_nom}
                </a>
                {/if}
            </td>
            {/if}
            {if $poissonSearch.displayMorpho == 1}
            <td class="right">{$data[lst].masse}</td>
            <td class="right">{$data[lst].longueur_fourche}</td>
            <td class="right">{$data[lst].longueur_totale}</td>
            {/if}
            {if $poissonSearch.displayCumulTemp == 1}
            <td class="right">{$data[lst].temperature}</td>
            {/if}
        </tr>
        {/section}
    </tbody>
</table>
{/if}