<table class="table table-bordered table-hover datatable-nopaging-nosearch" id="csublotlist">
	<thead>
		<tr>
			<th>{t}Nom du lot{/t}</th>
			<th>{t}Bassin{/t}</th>
			<th>{t}Nbre de larves estimé{/t}</th>
			<th>{t}Nbre de larves comptées{/t}</th>
			<th>{t}Marque VIE{/t}</th>
			<th>{t}Date de marquage VIE{/t}</th>
		</tr>
	</thead>
	<tbody>
		{section name=lst loop=$lots}
		<tr>
			<td>
				<a href="lotDisplay?lot_id={$lots[lst].lot_id}&sequence_id={$lots[lst].sequence_id}">
					{$lots[lst].lot_nom}
				</a>
			</td>
			<td>
				<a href="bassinDisplay?bassin_id={$lots[lst].bassin_id}">
					{$lots[lst].bassin_nom}
				</a>
			</td>
			<td class="right">{$lots[lst].nb_larve_initial}</td>
			<td class="right">{$lots[lst].nb_larve_compte}</td>
			<td>
				{if $lots[lst].vie_modele_id > 0}
				{$lots[lst].couleur}, {$lots[lst].vie_implantation_libelle}, {$lots[lst].vie_implantation_libelle2}
				{/if}
			</td>
			<td>{$lots[lst].vie_date_marquage}</td>
		</tr>
		{/section}
	</tbody>
</table>