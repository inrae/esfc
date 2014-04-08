<link rel="stylesheet" href="display/javascript/magnific-popup/magnific-popup.css"> 
<script src="display/javascript/magnific-popup/jquery.magnific-popup.js"></script> 
<script>
$(document).ready(function() { 
	setDataTables("documentList");
	$('.imageLink').magnificPopup(
			{ type:'image' }
			);
} ) ;
</script>
{if $droits["bassinGestion"] == 1 || $droits["poissonGestion"] == 1}
{include file="document/documentChange.tpl"}
{/if}
<table id="documentList">
<thead>
<tr>
<th>Vignette</th>
<th>Nom du document</th>
<th>Description</th>
<th>Taille<br>en Ko</th>
<th>Date<br>d'import</th>
{if $droits["bassinAdmin"] == 1 || $droits["poissonAdmin"] == 1}
<th>Supprimer</th>
{/if}
</tr>
</thead>
<tdata>
{section name=lst loop=$dataDoc}
<tr>
<td>
{if strlen($dataDoc[lst].photo_name) > 0 }
<a href="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}">
<img class="imageLink" src="{$dataDoc[lst].photo_name}" height="30">
</a>
{/if}
<td>
<a href="index.php?module=documentGet&document_id={$dataDoc[lst].document_id}">
{$dataDoc[lst].document_nom}
</a>
</td>
<td>{$dataDoc[lst].document_description}</td>
<td>{$dataDoc[lst].size}</td>
<td>{$dataDoc[lst].document_date_import}</td>
{if $droits["bassinAdmin"] == 1 || $droits["poissonAdmin"] == 1}
<td>
<div class="center">
<a href="index.php?module=documentSuppr&document_id={$dataDoc[lst].document_id}&moduleParent={$moduleParent}&parentIdName={$parentIdName}&parent_id={$parent_id}&parentType={$parentType}">
<img src="display/images/corbeille.png" height="20">
</a>
</div>
</td>
{/if}
</tr>
{/section}
</tdata>
</table>