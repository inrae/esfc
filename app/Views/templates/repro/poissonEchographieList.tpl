<table class="table table-bordered table-hover datatable-nopaging-nosearching ok" id="cechographie"
    data-tabicon="okechographie">
    <thead>
        <tr>
            <th>{t}Date{/t}</th>
            <th>{t}Commentaire{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$echographies}
        <tr>
            <td>
                <a
                    href="echographieChange?echographie_id={$echographies[lst].echographie_id}&poisson_campagne_id={$dataPoisson.poisson_campagne_id}">
                    {$echographies[lst].echographie_date}
                </a>
            </td>
            <td>{$echographies[lst].echographie_commentaire}</td>
        </tr>
        {/section}
    </tbody>
</table>