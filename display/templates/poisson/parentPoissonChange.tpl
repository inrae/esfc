<script>
$(document).ready(function() { 
	$("#recherche").keyup(function() {
		/*
		* Traitement de la recherche d'un poisson
		*/
		var texte = $(this).val();
		if (texte.length > 2) {
			/*
			* declenchement de la recherche
			*/
			var url = "index.php?module=poissonSearchAjax";
			$.getJSON ( url, { "libelle": texte } , function( data ) {
				var options = '';
				 for (var i = 0; i < data.length; i++) {
				        options += '<option value="' + data[i].id + '">' + data[i].val + '</option>';
				      };

/*				$.each( data, function( key, val ) {
					options += '<option value="' + key + '">' + val + '</option>' ;
				} );*/
				
				$("#parent_id").html(options);
			} ) ;
		};
	} );

} ) ;
</script>

<h2>Attribution d'un parent au poisson</h2>
<a href="index.php?module=poissonList">Retour à la liste des poissons</a>
>
<a href="index.php?module=poissonDisplay&poisson_id={$dataPoisson.poisson_id}">Retour au poisson</a>
{include file="poisson/poissonDetail.tpl"}
<div class="formSaisie">
<div>
<form id="parentForm" method="post" action="index.php?module=parentPoissonWrite">
<input type="hidden" name="parent_poisson_id" value="{$data.parent_poisson_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<dl>
<dt>Parent :</dt>
<dd>
<input id="recherche" placeholder="texte à rechercher" size="20" autofocus>
<select id="parent_id" name="parent_id">
{if $data.parent_id > 0}
<option value="{$data.parent_id}">
{$data.matricule}
{if strlen($data.pittag_valeur) > 0}
 {$data.pittag_valeur}
{if strlen($data.prenom) > 0}
 {$data.prenom}
{/if}
{/if}
</option>
{/if}
</select>
</dl>

<div class="formBouton">
<input class="submit" type="submit" value="Enregistrer">
</div>
</form>


{if $data.parent_poisson_id > 0 &&$droits["poissonAdmin"] == 1}
<div class="formBouton">
<form action="index.php" method="post" onSubmit='return confirmSuppression("Confirmez-vous la suppression ?")'>
<input type="hidden" name="parent_poisson_id" value="{$data.parent_poisson_id}">
<input type="hidden" name="poisson_id" value="{$data.poisson_id}">
<input type="hidden" name="module" value="parentPoissonDelete">
<input class="submit" type="submit" value="Supprimer">
</form>
</div>
{/if}
</div>
</div>
<span class="red">*</span><span class="messagebas">Champ obligatoire</span>