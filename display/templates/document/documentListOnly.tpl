<script>
	$(document).ready(function () {

		$('.image-popup-no-margins').magnificPopup({
			type: 'image',
			closeOnContentClick: true,
			closeBtnInside: false,
			fixedContentPos: true,
			mainClass: 'mfp-no-margins mfp-with-zoom', // class to remove default margin from left and right side
			image: {
				verticalFit: false
			},
			zoom: {
				enabled: true,
				duration: 300 // don't foget to change the duration also in CSS
			}
		});
	});
</script>

<div class="col-lg-12">
	<div class="row">
		<table class="table table-bordered table-hover datatable ok" id="documentList" data-order='[[4,"desc"]]'  data-tabicon="okdocument">
			<thead>
				<tr>
					<th>{t}Vignette{/t}</th>
					<th>{t}Nom du document{/t}</th>
					<th>{t}Description{/t}</th>
					<th>{t}Taille{/t}</th>
					<th>{t}Date d'import{/t}</th>
				</tr>
			</thead>
			<tbody>
				{section name=lst loop=$dataDoc}
				<tr>
					<td class="center">
						{if in_array($dataDoc[lst].mime_type_id, array(4, 5, 6)) }
						<a class="image-popup-no-margins"
							href="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&document_name={$dataDoc[lst].photo_preview}&attached=0&phototype=1"
							title="aperçu de la photo : {substr($dataDoc[lst].photo_name, strrpos($dataDoc[lst].photo_name, '/') + 1)}">
							<img src="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&document_name={$dataDoc[lst].thumbnail_name}&attached=0&phototype=2"
								height="30">
						</a>
						{elseif $dataDoc[lst].mime_type_id == 1}
						<a class="image-popup-no-margins"
							href="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&&document_name={$dataDoc[lst].thumbnail_name}&attached=0&phototype=2"
							title="aperçu du document : {substr($dataDoc[lst].thumbnail_name, strrpos($dataDoc[lst].thumbnail_name, '/') + 1)}">
							<img src="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&document_name={$dataDoc[lst].thumbnail_name}&attached=0&phototype=2"
								height="30">
						</a>
						{/if}
					<td>
						<a href="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}&filename={$dataDoc[lst].photo_name}&attached=1"
							title="document original">
							{$dataDoc[lst].document_nom}
						</a>
					</td>
					<td>{$dataDoc[lst].document_description}</td>
					<td>{$dataDoc[lst].size}</td>
					<td>{$dataDoc[lst].document_date_import}</td>
				</tr>
				{/section}
			</tbody>
		</table>
	</div>
</div>