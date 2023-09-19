<script>
    $(document).ready(function(){ 
        var tableList = $( '#cpoissonList' ).DataTable( {
					dom: 'Birtp',
					"language": dataTableLanguage,
					"paging": false,
					"searching": true,
					"stateSave": false,
					"stateDuration": 60 * 60 * 24 * 30,
					
				});
        $( '#cpoissonList thead th' ).each( function () {
				var title = $( this ).text();
				var size = title.trim().length;
				if ( size > 0 ) {
					$( this ).html( '<input type="text" placeholder="' + title + '" size="' + size + '" class="searchInput" title="'+title+'">' );
				}
			} );
			tableList.columns().every( function () {
				var that = this;
				if ( that.index() > 0 ) {
					$( 'input', this.header() ).on( 'keyup change clear', function () {
						if ( that.search() !== this.value ) {
							that.search( this.value ).draw();
						}
					} );
				}
			} );
			$( ".searchInput" ).hover( function () {
				$( this ).focus();
			} );
    });
</script>
{include file="poisson/poissonSearch.tpl"}
{if $isSearch == 1}
<div class="row">
    <div class="col-md-12">
        {if $droits.poissonGestion == 1}
        <a href="index.php?module=poissonChange&poisson_id=0">
            <img src="display/images/fish.png" height="25">
            {t}Nouveau poisson...{/t}
        </a>&nbsp;
        {/if}
        <a href="index.php?module=evenementGetAllCSV">
            <img src="display/images/csv.svg" height="25">
            {t}Liste de tous les événements pour les poissons sélectionnés au format CSV{/t}
        </a>
    </div>
</div>

<table class="table table-bordered table-hover " id="cpoissonList" data-order='[[2,"asc"]]'>
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
            <th>{t}Bassin{/t}</th>
            <th>{t}Masse{/t}</th>
            <th>{t}Long fourche{/t}</th>
            <th>{t}Long totale{/t}</th>
            {if strlen($poissonSearch.eventSearch)>0}
            <th>{$eventSearchs[$poissonSearch.eventSearch]}</th>
            {/if}
            {if $poissonSearch.displayCumulTemp == 1}
            <th>{t}Température cumulée (bassin){/t}</th>
            {/if}
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$data}
        <tr>
            <td>
                {if $data[lst].poisson_id!=$data[lst.index_prev].poisson_id}
                <a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].poisson_id}
                </a>
                {/if}
            </td>
            <td>
                {if $data[lst].poisson_id!=$data[lst.index_prev].poisson_id}
                <a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].pittag_valeur}
                </a>
                {/if}
            </td>
            <td>
                {if $data[lst].poisson_id!=$data[lst.index_prev].poisson_id}
                <a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].matricule}
                </a>
                {else}
                <span class="text-muted">{$data[lst].matricule}</span>
                {/if}
            </td>
            <td>
                {if $data[lst].poisson_id!=$data[lst.index_prev].poisson_id}
                <a href="index.php?module=poissonDisplay&poisson_id={$data[lst].poisson_id}">
                    {$data[lst].prenom}
                </a>
                {/if}
            </td>
            <td class="center">
                {if $data[lst].poisson_id!=$data[lst.index_prev].poisson_id}
                {$data[lst].sexe_libelle_court}
                {/if}
            </td>
            <td>
                {if $data[lst].poisson_id!=$data[lst.index_prev].poisson_id}
                {$data[lst].categorie_libelle} {$data[lst].poisson_statut_libelle}
                {/if}
            </td>
            <td class="center">
                {if $data[lst].poisson_id!=$data[lst.index_prev].poisson_id}
                {$data[lst].cohorte}
                {/if}
            </td>
            <td class="center">{$data[lst].capture_date}{$data[lst].date_naissance}</td>
            <td class="center">{$data[lst].mortalite_date}</td>
            <td>
                {if $data[lst].bassin_id > 0}
                <a href=index.php?module=bassinDisplay&bassin_id={$data[lst].bassin_id}>
                    {$data[lst].bassin_nom}
                </a>
                {/if}
            </td>
            <td class="right">{$data[lst].masse}</td>
            <td class="right">{$data[lst].longueur_fourche}</td>
            <td class="right">{$data[lst].longueur_totale}</td>
            {if strlen($poissonSearch.eventSearch)>0}
            <td>{$data[lst].event_date}</td>
            {/if}
            {if $poissonSearch.displayCumulTemp == 1}
            <td class="right">{$data[lst].temperature}</td>
            {/if}

        </tr>
        {/section}
    </tbody>
</table>
{/if}