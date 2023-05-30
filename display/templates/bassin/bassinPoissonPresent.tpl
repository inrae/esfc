
<table id="cbassinPoissonList" class="table table-bordered table-hover datatable-nopaging">
<thead>
<tr>
<th>{t}matricule{/t}</th>
<th>{t}tag(s){/t}</th>
<th>{t}prénom{/t}</th>
<th>{t}Sexe{/t}</th>
<th>{t}Cohorte{/t}</th>
<th>{t}Date d'arrivée{/t}</th>
<th>{t}Masse{/t}</th>
</tr>
</thead>
<tbody>
{assign var=mt value=0}
{section name=lst loop=$dataPoisson}
<tr>
<td>
<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson[lst].poisson_id}">
{$dataPoisson[lst].matricule}
</a>
</td>
<td>{$dataPoisson[lst].pittag_valeur}</td>
<td>
{$dataPoisson[lst].prenom}
</td>
<td>{$dataPoisson[lst].sexe_libelle_court}</td>
<td>{$dataPoisson[lst].cohorte}</td>
<td>{$dataPoisson[lst].transfert_date}</td>
<td>{$dataPoisson[lst].masse}</td>
{if $dataPoisson[lst].masse > 0}
{assign var=mt value=$mt + $dataPoisson[lst].masse}
{/if}
</tr>
{/section}
</tbody>
<tfoot>
    <td colspan="6">Masse totale des poissons dans le bassin :</td>
    <td>{$mt}</td>
</tfoot>
</table>
