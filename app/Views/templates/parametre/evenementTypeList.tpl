<h2>{t}Types d'événements{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="evenementTypeChange?evenement_type_id=0">
    Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cevenementTypeList" class="tableliste">
    <thead>
        <tr>
            <th>{t}libellé{/t}</th>
            <th>{t}Actif ?{/t}</th>
            <th>{t}Statut du poisson après l'événement{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td>
                {if $rights["paramAdmin"] == 1}
                <a href="evenementTypeChange?evenement_type_id={$data[lst].evenement_type_id}">
                    {$data[lst].evenement_type_libelle}
                </a>
                {else}
                {$data[lst].evenement_type_libelle}
                {/if}
            </td>
            <td>
                {if $data[lst].evenement_type_actif == 1}{t}oui{/t}
                {elseif $data[lst].evenement_type_actif == 0}{t}non{/t}
                {/if}
            </td>
            <td>
                {$data[lst].poisson_statut_libelle}
            </td>
        </tr>
        {/section}
    </tbody>
</table>