<script>
    $(document).ready (function() { 
        $("#annee").change(function() { 
            Cookies.set( 'annee', $(this).val(), { expires: 180, secure: true } );
        });
        var scrolly = "2000pt";
        var tableList = $( '#listAll' ).DataTable( {
					"order": [[0,"desc"],[1,"asc"],[2,"asc"]],
					dom: 'Birtp',
					"language": dataTableLanguage,
					"paging": false,
					"searching": true,
                    "stateSave":false,
				} );
        $( '#listAll thead th' ).each( function () {
            var title = $( this ).text();
            var size = title.trim().length;
            if ( size > 0 ) {
                $( this ).html( '<input type="text" placeholder="' + title + '" size="' + size + '" class="searchInput" title="'+title+'">' );
            }
        } );
        //var tableList = $("#listAll").DataTable();
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
<form method="get" action="index.php" id="search">
    <input type="hidden" name="module" value="spermeCongelationList">
    <div class="row">
        <div class="col-md-6 col-lg-6 form-horizontal">
            <div class="form-group">
                <label for="annee" class="control-label col-md-2">
                    {t}Année :{/t}
                </label>
                <div class="col-md-3">
                    <select name="annee" id="annee" class="form-control">
                        <option value="0" {if annee==0}selected{/if}>
                            {t}Toutes les années{/t}
                        </option>
                        {foreach $annees as $year}
                        <option value="{$year}" {if $annee==$year}selected{/if}>
                            {$year}
                        </option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-2 center">
                    <input type="submit" class="btn btn-success" value="{t}Rechercher{/t}">
                </div>
            </div>
        </div>
    </div>
</form>
<div class="row">
    <div class="col-lg-10">
        <table id="listAll" class="table table-bordered table-hover" >
            <thead>
                <tr>
                    <th>{t}Date{/t}</th>
                    <th>{t}Poisson{/t}</th>
                    <th>{t}Volume congelé{/t}</th>
                    <th>{t}Volume de sperme{/t}</th>
                    <th>{t}Nombre de visotubes{/t}</th>
                    <th>{t}Nombre de paillettes{/t}</th>
                    <th>{t}Volume par paillette{/t}</th>
                    <th>{t}Nombre de paillettes utilisées{/t}</th>
                    <th>{t}Opérateur{/t}</th>
                </tr>
            </thead>
            <tbody>
                {foreach $spermes as $sperme}
                <tr>
                    <td>
                        {if $droits.reproGestion == 1}
                        <a href="index.php?module=spermeCongelationChange&sperme_id={$sperme.sperme_id}&sperme_congelation_id={$sperme.sperme_congelation_id}&poisson_campagne_id={$sperme.poisson_campagne_id}&sequence_id={$sperme.sequence_id}">
                            {$sperme.congelation_date}
                        {else}
                        {$sperme.congelation_date}
                        {/if}
                    </td>
                    <td>
                        <a href="index.php?module=poissonCampagneDisplay&poisson_campagne_id={$sperme.poisson_campagne_id}">
                            {$sperme.matricule}&nbsp;{$sperme.prenom}
                        </a>
                    </td>
                    <td>
                        {$sperme.congelation_volume}
                    </td>
                    <td>{$sperme.volume_sperme}</td>
                    <td class="center">{$sperme.nb_visotube}</td>
                    <td class="center">{$sperme.nb_paillette}</td>
                    <td class="center">{$sperme.paillette_volume}</td>
                    <td class="center">{$sperme.nb_paillettes_utilises}</td>
                    <td>{$sperme.operateur}</td>
                </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
</div>