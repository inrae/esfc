<h2>{t}Laboratoires d'analyse{/t}</h2>
{if $rights["paramAdmin"] == 1}
<a href="laboratoireAnalyseChange?laboratoire_analyse_id=0">
Nouveau...
</a>
{/if}

<table class="table table-bordered table-hover datatable display" id="claboratoireAnalyseList" class="tableliste">
<thead>
<tr>
<th>{t}libellé{/t}</th>
<th>{t}Actif ?{/t}</th>
</tr>
</thead>
<tbody>
{section name=lst loop=$data}
<tr>
<td>
{if $rights["paramAdmin"] == 1}
<a href="laboratoireAnalyseChange?laboratoire_analyse_id={$data[lst].laboratoire_analyse_id}">
{$data[lst].laboratoire_analyse_libelle}
</a>
{else}
{$data[lst].laboratoire_analyse_libelle}
{/if}
</td>
<td>
{if $data[lst].laboratoire_analyse_actif == 1}oui{else}non{/if}
</tr>
{/section}
</tbody>
</table>