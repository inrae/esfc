{if $rights["reproGestion"] == 1}
<a href="croisementChange?croisement_id=0&sequence_id={$dataSequence.sequence_id}">
    Nouveau croisement...
</a>
{/if}

<table class="table table-bordered table-hover datatable ok" id="ccroisement" data-tabicon="okcroisement" data-order='[[1,"asc"],[0,"asc"]]'>
    <thead>
        <tr>
            <th>{t}Nom du croisement{/t}</th>
            <th>{t}Date/heure de fécondation{/t}</th>
            <th>{t}Poissons{/t}</th>
            <th>{t}Masse des ovocytes{/t}</th>
            <th>{t}Nbre d'ovocytes par gramme{/t}</th>
            <th>{t}Nbre total d'ovocytes{/t}</th>
            <th>{t}Taux de fécondation{/t}</th>
            <th>{t}Nbre d'oeufs calculé{/t}</th>
            <th>{t}Taux de survie estimé{/t}</th>
            <th>{t}Nbre de larves théorique{/t}</th>
            <th>{t}Nbre de larves compté{/t}</th>
            <th>{t}Qualité génétique du croisement{/t}</th>
        </tr>
    </thead>
    <tbody>
        {section name=lst loop=$croisements}
        <!-- calculs -->
        {$ovocyte = 0}
        {$oeuf = 0}
        {$larve = 0}
        {if $croisements[lst].ovocyte_masse > 0 && $croisements[lst].ovocyte_densite > 0}
        {assign var="ovocyte" value=intval($croisements[lst].ovocyte_masse * $croisements[lst].ovocyte_densite)}
        {if !$ovocyte > 0}
        {$ovocyte = 0}
        {/if}
        {if $croisements[lst].tx_fecondation > 0}
        {if $croisements[lst].tx_fecondation > 1}
        {assign var="oeuf" value=intval($croisements[lst].tx_fecondation * $ovocyte / 100)}
        {else}
        {assign var="oeuf" value=intval($croisements[lst].tx_fecondation * $ovocyte)}
        {/if}
        {/if}
        {if $croisements[lst].tx_survie_estime > 0}
        {if $croisements[lst].tx_survie_estime > 1}
        {assign var="larve" value=intval($oeuf * $croisements[lst].tx_survie_estime / 100)}
        {else}
        {assign var="larve" value=intval($oeuf * $croisements[lst].tx_survie_estime)}
        {/if}
        {/if}
        {/if}
        <tr>
            <td>
                {if $rights["reproGestion"] == 1}
                <a href="croisementDisplay?croisement_id={$croisements[lst].croisement_id}">
                    {$croisements[lst].sequence_nom} {$croisements[lst].croisement_nom}
                </a>
                {else}
                {$croisements[lst].sequence_nom} {$croisements[lst].croisement_nom}
                {/if}
            </td>
            <td>{$croisements[lst].croisement_date}</td>
            <td>{$croisements[lst].parents}</td>
            <td class="right">{$croisements[lst].ovocyte_masse}</td>
            <td class="right">{$croisements[lst].ovocyte_densite}</td>
            <td class="right">{$ovocyte}</td>
            <td class="right">{$croisements[lst].tx_fecondation}</td>
            <td class="right">{$oeuf}
            <td class="right">{$croisements[lst].tx_survie_estime}</td>
            <td class="right">{$larve}</td>
            <td class="right">{$croisements[lst].total_larve_compte}</td>
            <td>{$croisements[lst].croisement_qualite_libelle}</td>
        </tr>
        {/section}
    </tbody>
</table>