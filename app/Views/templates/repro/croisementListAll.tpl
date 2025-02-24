<script>
    $(document).ready (function() { 
        $("#annee").change(function() { 
            Cookies.set( 'annee', $(this).val(), { expires: 180, secure: true } );
        });
    });
</script>
<form method="get" action="croisementList" id="search">
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
{$csrf}</form>
<div class="row">
    <div class="col-lg-10">
        <table class="datatable-export table table-bordered" data-order='[[0,"desc"],[1,"asc"],[2,"asc"]]'>
            <thead>
                <tr>
                    <th>{t}Date{/t}</th>
                    <th>{t}Séquence{/t}</th>
                    <th>{t}Croisement{/t}</th>
                    <th>{t}Qualité{/t}</th>
                    <th>{t}Parents{/t}</th>
                </tr>
            </thead>
            <tbody>
                {foreach $croisements as $cross}
                <tr>
                    <td>{$cross.croisement_date}</td>
                    <td>
                        <a href="sequenceDisplay?sequence_id={$cross.sequence_id}">
                            {$cross.sequence_nom}
                        </a>
                    </td>
                    <td>
                        <a
                            href="croisementDisplay?croisement_id={$cross.croisement_id}&sequence_id={$cross.sequence_id}">
                            {$cross.croisement_nom}
                        </a>
                    </td>
                    <td>
                        {$cross.croisement_qualite_libelle}
                    </td>
                    <td>{$cross.parents}</td>
                </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
</div>