<h2>{t}Types de bassins{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="bassinTypeChange?bassin_type_id=0">
    {t}Nouveau...{/t}
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="cbassinTypeList" class="tableliste">
    <thead>
        <tr>
            <th>{t}libellé{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td>
                {if $rights["paramAdmin"] == 1}
                <a href="bassinTypeChange?bassin_type_id={$data[lst].bassin_type_id}">
                    {$data[lst].bassin_type_libelle}
                </a>
                {else}
                {$data[lst].bassin_type_libelle}
                {/if}
            </td>
        </tr>
        {/section}
    </tbody>
</table>