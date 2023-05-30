<h2>{t}Importation des résultats d'analyse des circuits d'eau à partir des fichiers de sonde{/t}</h2>

<div class="formSaisie">
<form id="documentForm" method="post" action="index.php"  enctype="multipart/form-data">
<input type="hidden" name="module" value="sondeExec">
<dl>
<dt>Modèle d'importation : </dt>
<dd>
<select name="sonde_id">
{foreach $sondes as $sonde}
<option value="{$sonde.sonde_id}" {if $sonde.sonde_id == $sonde_id}selected{/if}>
{$sonde.sonde_name}
</option>
{/foreach}
</select>
</dd>
</dl>
<dl>
<dt>Fichier(s) à importer :
<br>(xlsx, csv)
</dt>
<dd><input type="file" name="sondeFileName[]" size="40" multiple required></dd>
</dl>
<dl>
<div class="formBouton">
<input class="submit" type="submit" value="Importer les données de sonde">
</div>
</dl>
</form>
</div>