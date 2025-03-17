<h2>{t}Modèles de répartition des aliments{/t}</h2>
{include file="aliment/repartTemplateSearch.tpl"}
<div class="col-lg-8">
	{if $isSearch == 1}
	{if $rights.bassinAdmin == 1}
	<div class="row">
		<a href="repartTemplateChange?repart_template_id=0">{t}Nouvelle répartition...{/t}</a>
	</div>
	{/if}

	<table class="table table-bordered table-hover datatable display" id="crepartTemplateList">
		<thead>
			<tr>
				{if $rights.bassinAdmin == 1}
				<th>{t}Modif{/t}</th>
				{/if}
				<th>{t}Date de création{/t}</th>
				<th>{t}Catégorie{/t}</th>
				<th>{t}Description{/t}</th>
				<th>{t}Actif ?{/t}</th>
			</tr>
		</thead>
		<tbody>
			{section name=lst loop=$data}
			<tr>
				{if $rights.bassinAdmin == 1}
				<td>
					<a href="repartTemplateChange?repart_template_id={$data[lst].repart_template_id}">
						<div class="center"><img src="display/images/edit.gif" height="20"></div>
					</a>
				</td>
				{/if}
				<td>{$data[lst].repart_template_date}</td>
				<td>{$data[lst].categorie_libelle}</td>
				<td>{$data[lst].repart_template_libelle}</td>
				<td class="center">{if $data[lst].actif == 1}{t}oui{/t}{else}{t}non{/t}{/if}</td>
			</tr>
			{/section}
		</tbody>
	</table>
	{/if}
</div>