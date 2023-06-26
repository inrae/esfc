<form method="get" action="index.php" id="search">
	<input type="hidden" name="module" value="devenirList">
	<div class="row">
		<div class="col-md-6 form-horizontal">
			<div class="form-group">
				<label for="annee" class="control-label col-md-4">
					{t}Année :{/t}
				</label>
				<div class="col-md-4">
					<select name="annee" id="annee" class="form-control">
						{foreach $annees as $year}
						<option value="{$year}" {if $annee==$year}selected{/if}>
							{$year}
						</option>
						{/foreach}
					</select>
				</div>
				<div class="col-md-4 center">
					<input type="submit" class="btn btn-success" value="{t}Rechercher{/t}" </div>
				</div>
			</div>
		</div>
	</div>
</form>
<h2>{t}Destination des poissons{/t}</h2>
{include file="repro/devenirList.tpl"}