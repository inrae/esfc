<h2>{t}Types de pittag{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="pittagTypeChange?pittag_type_id=0">
    {t}Nouveau...{/t}
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="pittagList" class="tableliste"
    data-order='[[1,"asc"]]'>
    <thead>
        <tr>
            <th>{t}id{/t}</th>
            <th>{t}libellé{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td class="center">{$data[lst].pittag_type_id}</td>
            <td>
                {if $rights["paramAdmin"] == 1}
                <a href="pittagTypeChange?pittag_type_id={$data[lst].pittag_type_id}">
                    {$data[lst].pittag_type_libelle}
                </a>
                {else}
                {$data[lst].pittag_type_libelle}
                {/if}
            </td>
        </tr>
        {/section}
    </tbody>
</table>