<h2>{t}Types de devenir des lots{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="devenirTypeChange?devenir_type_id=0">
    {t}Nouveau...{/t}
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cdevenirTypeList" class="tableliste">
    <thead>
        <tr>
            <th>{t}Id{/t}</th>
            <th>{t}libellé{/t}</th>
            <th>{t}Type d'événement rattaché{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td>{$data[lst].devenir_type_id}</td>
            <td>
                {if $rights["paramAdmin"] == 1}
                <a href="devenirTypeChange?devenir_type_id={$data[lst].devenir_type_id}">
                    {$data[lst].devenir_type_libelle}
                </a>
                {else}
                {$data[lst].devenir_type_libelle}
                {/if}
            </td>
            <td>
                {$data[lst].evenement_type_libelle}
            </td>
        </tr>
        {/section}
    </tbody>
</table>